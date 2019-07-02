package com.king.frame.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.ParameterizedType;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.king.common.enums.BillState;
import com.king.common.utils.Constants;
import com.king.common.utils.DateUtil;
import com.king.frame.security.PermissionList;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.IService;
import com.king.frame.specifications.DateConvertEditor;
import com.king.frame.specifications.DynamicSpecifications;
import com.king.frame.utils.RequestUtil;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.user.UserEntity;

import net.sf.json.JSONObject;

public class BaseController<T> {
	private Class<T> persistentClass;

	public static final int DEFAULT_PARAM_PAGESIZE = 20;

	public static String PARAM_NAME_PAGESIZE = "length";
	public static String PARAM_NAME_STARTINDEX = "start";
	public static String PARAM_NAME_PAGEINDEX = "sEcho,pageindex";
	public static String PARAM_PREFIX_SEARCHFIELD = "search_";
	public static String PARAM_PREFIX_SORT = "orderby";

	public static String ENTITY = "entity";
	public static String OPENSTATE = "openstate";

	private static String excelTemplatePath = BaseController.class.getResource("/").getPath()
			+ "BaseController/excelTemplate/";

	@Autowired
	protected IService<T, String> baseService;

	protected PermissionList permissionList = null;

	public BaseController() {
		init();
	}

	/**
	 * getClass().getGenericSuperclass()返回表示此 Class 所表示的实体（类、接口、基本类型或 void） 的直接超类的 Type(Class
	 * <T>泛型中的类型)，然后将其转换ParameterizedType。。 getActualTypeArguments()返回表示此类型实际类型参数的 Type 对象的数组。 [0]就是这个数组中第一个了。。
	 * 简而言之就是获得超类的泛型参数的实际类型。。
	 */
	public void init() {
		persistentClass = (Class<T>) ((ParameterizedType) this.getClass().getGenericSuperclass())
				.getActualTypeArguments()[0];
	}

	/**
	 * 权限前缀：如sys:user 则生成的新增权限为 sys:user:create
	 */
	protected void setResourceIdentity(String resourceIdentity) {
		if (!StringUtils.isEmpty(resourceIdentity)) {
			permissionList = PermissionList.newPermissionList(resourceIdentity);
		}
	}

	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/query")
	@ResponseBody
	public ActionResultModel<T> query(ServletRequest request, Model model) {
		return doQuery(request);
	}

	/**
	 * 执行查询，子类可以重写
	 * 
	 * @param request
	 * @param service
	 * @return
	 */
	protected ActionResultModel<T> doQuery(ServletRequest request) {
		QueryRequest<T> qr = getQueryRequest(request, addSearchParam(request));
		return execQuery(qr, baseService);
	}

	/**
	 * 此处添加查询参数,用Map替代null,格式：LIKE_loginName=aa key和value都是String类型的。 addParam.put("LIKE_loginName", "aa");
	 * addParam.put("EQ_validDate", "2014-10-01");
	 * 
	 * @return
	 */
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		return addParam;
	}

	/**
	 * 通用查询响应方法
	 * 
	 * @param qr
	 * @param service
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected ActionResultModel<T> execQuery(QueryRequest<T> qr, IService service) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			if (qr.getPageRequest() != null) {
				Page<T> data = service.findAll(qr.getSpecification(), qr.getPageRequest());
				arm.setRecords(data.getContent());
				arm.setTotal(data.getTotalElements());
				arm.setTotalPages(data.getTotalPages());
				arm.setPageNumber(data.getNumber());
			} else {
				List<T> list = service.findAll(qr.getSpecification(), qr.getSort());
				arm.setRecords(list);
				arm.setTotal(list.size());
				arm.setTotalPages(1);
			}
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}

		return arm;
	}

	/**
	 * 进入新增页面，给子类重写用
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/onAdd", method = RequestMethod.GET)
	public String onAdd(Model model, ServletRequest request) {
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_ADD);
		UserEntity userEntity = ShiroUser.getCurrentUserEntity();
		OrgEntity orgEntity = ShiroUser.getCurrentOrgEntity();
		model.addAttribute("user", userEntity);// 用户
		model.addAttribute("org", orgEntity);// 组织
		model.addAttribute("billdate", DateUtil.getDate());// 日期
		return addView(model, request);
	}

	/**
	 * 新增视图-用于之类重写
	 * 
	 * @param model
	 * @return
	 */
	public String addView(Model model, ServletRequest request) {
		return "";
	}

	/**
	 * 新增
	 * 
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/add")
	@ResponseBody
	public ActionResultModel<T> add(ServletRequest request, Model model, @Valid T entity) {

		return doAdd(request, model, entity);
	}

	// 子类可重写此方法
	protected ActionResultModel<T> doAdd(ServletRequest request, Model model, T entity) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			entity = baseService.doAdd(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 编辑视图-用于之类重写
	 * 
	 * @param model
	 * @return
	 */
	public String editView(Model model, ServletRequest request, T entity) {
		return "";
	}

	/**
	 * 编辑视图-用于之类重写
	 * 
	 * @param model
	 * @return
	 */
	public String editView() {
		return "";
	}

	/**
	 * 进入更新页面，给子类重写用
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/onEdit", method = RequestMethod.GET)
	public String onEdit(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		UserEntity userEntity = ShiroUser.getCurrentUserEntity();
		OrgEntity orgEntity = ShiroUser.getCurrentOrgEntity();
		model.addAttribute("user", userEntity);// 用户
		model.addAttribute("org", orgEntity);// 组织
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_EDIT);
		T entity = baseService.getOne(uuid);
		model.addAttribute(ENTITY, entity);
		return editView(model, request, entity);
	}

	/**
	 * 更新
	 * 
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/update")
	@ResponseBody
	public ActionResultModel<T> update(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") T entity) {
		// T oldEntity = baseService.findById(entity.getUUid)
		return doUpdate(request, model, entity);
	}

	/**
	 * 使用@ModelAttribute, 实现Struts2 Preparable二次部分绑定的效果,先根据form的id从数据库查出对象,再把Form提交的内容绑定到该对象上。
	 * 因为仅update()方法的form中有id属性，因此本方法在该方法中执行.
	 */
	@ModelAttribute("preloadEntity")
	protected T getEntity(@RequestParam(value = "uuid", required = false) String id) {
		if (id != null && !"".equals(id)) {
			try {
				return baseService.getOne(id);
			} catch (ServiceException e) {
			}
		}
		return null;
	}

	protected ActionResultModel<T> doUpdate(ServletRequest request, Model model, T entity) {
		ActionResultModel<T> arm = new ActionResultModel<T>();
		try {
			entity = baseService.doUpdate(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			String msg = e.getMessage();
			if (msg.contains("constraint")) {
				arm.setMsg(e.getMessage());
			} else {
				arm.setMsg(e.getMessage());
			}
			e.printStackTrace();
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 进入查看页面，给子类重写用
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/onDetail", method = RequestMethod.GET)
	public String onDetail(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_DETAIL);
		T entity = baseService.getOne(uuid);
		model.addAttribute(ENTITY, entity);
		return detailView(model, request, entity);
	}

	/**
	 * 明细视图- 用于子类重新
	 * 
	 * @param model
	 * @return
	 */
	public String detailView(Model model, ServletRequest request, T entity) {
		return "";
	}

	/**
	 * 删除
	 * 
	 * @param pks
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/delete")
	@ResponseBody
	public ActionResultModel delete(ServletRequest request, Model model, String[] pks) {
		return doDelete(request, model, pks);
	}

	protected ActionResultModel doDelete(ServletRequest request, Model model, String[] pks) {
		ActionResultModel arm = new ActionResultModel();
		try {
			baseService.doDelete(pks);
			arm.setSuccess(true);
		} catch (DataIntegrityViolationException e) {// edit by ls2008
			arm.setSuccess(false);
			arm.setMsg("存在关联不能删除");
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw, true));
			String strs = sw.toString();
			try {
				if (!strs.contains("constraint")) {
					strs = e.getMessage();
				}
				sw.close();
				arm.setSuccess(false);
				arm.setMsg(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
				arm.setSuccess(false);
				arm.setMsg("存在关联不能删除");
				throw new ServiceException(e.getMessage());
			}
			// throw new ServiceException(strs);
			// e.printStackTrace();
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 获取查询对象
	 * 
	 * @param request
	 * @param addmap
	 *            附加查询条件Map对象
	 * @return
	 */
	protected QueryRequest<T> getQueryRequest(ServletRequest request, Map<String, Object> addmap) {
		QueryRequest<T> qr = new QueryRequest<T>();
		// 查询条件
		Map<String, Object> searchMap = WebUtils.getParametersStartingWith(request, PARAM_PREFIX_SEARCHFIELD);
		if (searchMap != null && addmap != null)
			searchMap.putAll(addmap);
		// 排序
		Sort sort = getSortRequest(request);
		// 分页信息（针对jquery datatable）
		if (RequestUtil.hasParameter(request, PARAM_NAME_PAGESIZE)) {
			int pageIndex = 0;
			int pageSize = RequestUtil.getIntParameter(request, PARAM_NAME_PAGESIZE, DEFAULT_PARAM_PAGESIZE);
			// 并且pageSize>0
			if (pageSize > 0) {
				int startIdx = RequestUtil.getIntParameter(request, PARAM_NAME_STARTINDEX, 0);
				pageIndex = startIdx / pageSize;
				PageRequest pr = new PageRequest(pageIndex, pageSize, sort);
				qr.setPageRequest(pr);
			}
		}

		qr.setSpecification(DynamicSpecifications.buildSpecification(searchMap, persistentClass));
		qr.setSort(sort);

		return qr;
	}

	/**
	 * 获取分页对象
	 * 
	 * @param request
	 * @return
	 */
	public static Sort getSortRequest(ServletRequest request) {
		List<Sort.Order> orders = new ArrayList<Sort.Order>();
		String sortstr = RequestUtil.getParameter(request, PARAM_PREFIX_SORT);
		if (StringUtils.isEmpty(sortstr))
			return null;

		String[] sortfields = sortstr.split(";");
		for (String field : sortfields) {
			String[] fs = field.split("@");
			String property = fs[0];
			Sort.Direction dir = Sort.Direction.ASC;
			if (fs.length > 1) {
				String dirstr = fs[1];
				if (dirstr.toLowerCase().startsWith("d")) {
					dir = Sort.Direction.DESC;
				}
			}
			Sort.Order order = new Sort.Order(dir, property);
			orders.add(order);
		}
		Sort sort = new Sort(orders);
		return sort;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		/*
		 * binder.registerCustomEditor(String.class, new PropertyEditorSupport() {
		 * 
		 * @Override public void setAsText(String text) { setValue(text == null ? null : StringEscapeUtils
		 * .escapeHtml4(text.trim())); }
		 * 
		 * @Override public String getAsText() { Object value = getValue(); return value != null ? value.toString() :
		 * ""; } });
		 */
		binder.setAutoGrowCollectionLimit(50000);
		// binder.initBeanPropertyAccess();
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new DateConvertEditor());
	}

	/**
	 * 判断是否有权限
	 * 
	 * @param permission
	 *            操作代码
	 */
	public void assertHasPermission(String permission) {
		if (permissionList != null) {
			this.permissionList.assertHasPermission(permission);
		}
	}

	public void assertHasViewPermission() {
		if (permissionList != null) {
			this.permissionList.assertHasViewPermission();
		}
	}

	public void assertHasCreatePermission() {
		if (permissionList != null) {
			this.permissionList.assertHasCreatePermission();
		}
	}

	public void assertHasUpdatePermission() {
		if (permissionList != null) {
			this.permissionList.assertHasUpdatePermission();
		}
	}

	public void assertHasDeletePermission() {
		if (permissionList != null) {
			this.permissionList.assertHasDeletePermission();
		}
	}

	public void assertHasEditPermission() {
		if (permissionList != null) {
			this.permissionList.assertHasEditPermission();
		}
	}

	/**
	 * 禁用
	 * 
	 * @param pks
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/rowDisabled")
	@ResponseBody
	public ActionResultModel rowDisabled(ServletRequest request, Model model, String[] pks) {
		return doDisabled(request, model, pks);
	}

	
	
	protected ActionResultModel doDisabled(ServletRequest request, Model model, String[] pks) {
		ActionResultModel arm = new ActionResultModel();
		try {
			baseService.doDisabled(pks);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 启用
	 * 
	 * @param pks
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/rowEnabled")
	@ResponseBody
	public ActionResultModel rowEnabled(ServletRequest request, Model model, String[] pks) {
		return doEnabled(request, model, pks);
	}

	
	
	protected ActionResultModel doEnabled(ServletRequest request, Model model, String[] pks) {
		ActionResultModel arm = new ActionResultModel();
		try {
			baseService.doEnabled(pks);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}


	/**
	 * 设置默认的值，学年度、学期
	 * 
	 * @param model
	 */
	public void getDefaultModel(Model model) {
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		List<EnumDataSubEntity> enumList = EnumDataUtils.getEnumSubList("StudyTimes");
//		for (EnumDataSubEntity sub : enumList) {
//			if (sub.getEnumdataname().startsWith(year + "")) {
//				model.addAttribute("currentYears", sub.getEnumdatakey());
//			}
//		}
		if (month >= 3 && month < 9) {
			model.addAttribute("currentSemester", 2);
			for (EnumDataSubEntity sub : enumList) {
				if (sub.getEnumdataname().startsWith((year-1) + "")) {
					model.addAttribute("currentYears", sub.getEnumdatakey());
					break;
				}
			}
		} else {
			model.addAttribute("currentSemester", 1);
			if(month>=9){
				for (EnumDataSubEntity sub : enumList) {
					if (sub.getEnumdataname().startsWith(year + "")) {
						model.addAttribute("currentYears", sub.getEnumdatakey());
						break;
					}
				}
			}else{
				for (EnumDataSubEntity sub : enumList) {
					if (sub.getEnumdataname().startsWith((year-1) + "")) {
						model.addAttribute("currentYears", sub.getEnumdatakey());
						break;
					}
				}
			}
		}
	}
	
	public void setExportResponse(HttpServletResponse response,ServletRequest request,
			String fileName) throws UnsupportedEncodingException{
		response.reset();// 清空输出流   
        response.setContentType("application/octet-stream; charset=utf-8");
		String explorerType = RequestUtil.getExplorerType((HttpServletRequest)request);
		if (explorerType == null || explorerType.contains("IE")) {// IE
			response.setHeader("Content-Disposition",
			"attachment; filename=\"" + RequestUtil.encode((fileName),"utf-8")+".xlsx" + "\"");
		} else {// fireFox/Chrome
			response.setHeader("Content-Disposition",
					"attachment; filename=" + new String((fileName).getBytes("utf-8"), "ISO8859-1")+".xlsx");
		}
        response.setContentType("application/msexcel");// 定义输出类型 
	}
	
	
	public <T> List<T> convertToEntities(Class<T> t,String[] paramArr) {
		List<T> returnList = new ArrayList<T>();
		if (paramArr == null || paramArr.length == 0)
			return returnList;
		for (String data : paramArr) {
			JSONObject jsonObject = new JSONObject();
			String[] properties = data.split("&");
			for (String property : properties) {
				String[] nameAndValue = property.split("=");
				if (nameAndValue.length == 2) {
					try {
						nameAndValue[0] = URLDecoder.decode(nameAndValue[0], "UTF-8");
						nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					jsonObject.put(nameAndValue[0], nameAndValue[1]);
				}
			}
			T obj = (T) JSONObject.toBean(jsonObject,t);
			returnList.add(obj);
		}
		return returnList;
	} 
}
