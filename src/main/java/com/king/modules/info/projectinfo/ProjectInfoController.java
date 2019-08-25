package com.king.modules.info.projectinfo;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.common.enums.BillState;
import com.king.common.utils.Constants;
import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.SuperController;
import com.king.frame.security.ShiroUser;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.receive.ProjectReceiveService;
import com.king.modules.info.receive.ProjectReceiveVo;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.sys.enumdata.EnumDataEntity;
import com.king.modules.sys.enumdata.EnumDataService;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Controller
@RequestMapping(value = "/info/projectinfo")
public class ProjectInfoController extends SuperController<ProjectInfoEntity> {

	@Autowired
	private ProjectInfoService service;
	@Autowired
	private ProjectSubService subService;
	@Autowired
	private ProjectReceiveService receiveService;
	@Autowired
	private EnumDataService enumDataService;
	
	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-19 21:25:24
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("projectInfoImpTemplate", "/template/项目单导入模板.xlsx"));
		return "modules/info/projectinfo/projectinfo_list";
	}
	
	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
		return "modules/info/projectinfo/projectinfo_add";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectInfoEntity entity) {
		return "modules/info/projectinfo/projectinfo_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectInfoEntity entity) {
		return "modules/info/projectinfo/projectinfo_detail";
	}

	
	
	/**
	 * 收货
	 * @param model
	 * @return
	 */
	@RequestMapping("/receiveList")
	public String receiveList(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("projectInfoImpTemplate", "/template/项目单导入模板.xlsx"));
		return "modules/info/projectinfo/projectinfo_receive_list";
	}
	
	/**
	 * 收货-编辑
	 * @param model
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value = "/onReceiveEdit", method = RequestMethod.GET)
	public String onReceiveEdit(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		UserEntity userEntity = ShiroUser.getCurrentUserEntity();
		OrgEntity orgEntity = ShiroUser.getCurrentOrgEntity();
		model.addAttribute("user", userEntity);// 用户
		model.addAttribute("org", orgEntity);// 组织
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_EDIT);
		ProjectInfoEntity entity = baseService.getOne(uuid);
		model.addAttribute(ENTITY, entity);
		
		if(entity.getReceiveType()!=null&&entity.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
			return "modules/info/projectinfo/projectinfo_receive_append";
		}
		return "modules/info/projectinfo/projectinfo_receive_edit";
	}
	
	/**
	 * 收货-查看
	 * @param model
	 * @param request
	 * @param uuid
	 * @return
	 */
	@RequestMapping(value = "/onReceiveDetail", method = RequestMethod.GET)
	public String onReceiveDetail(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_DETAIL);
		ProjectInfoEntity entity = baseService.getOne(uuid);
		model.addAttribute(ENTITY, entity);
		return "modules/info/projectinfo/projectinfo_receive_detail";
	}
	
	
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request, Model model, @Valid ProjectInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		List<ProjectSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = service.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		}catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updatewithsub")
	@ResponseBody
	public ActionResultModel update(ServletRequest request, Model model, @Valid @ModelAttribute("preloadEntity") ProjectInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		List<ProjectSubEntity> subList = this.convertToEntities(subArrs);
		try {
			StockBaseEntity stock = new StockBaseEntity();
			stock.setUuid(entity.getStockId());
			entity.setStock(stock);
			arm = service.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}
	
	
	/**
	 * 暂存收货
	 * @param request
	 * @param model
	 * @param entity
	 * @param subArrs
	 * @return
	 */
	@RequestMapping(value = "/tempReceive")
	@ResponseBody
	public ActionResultModel<ProjectInfoEntity> tempReceive(ServletRequest request, Model model, ProjectInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		List<ProjectReceiveVo> subList = this.convertToEntitieVos(subArrs);
		try {
			arm = receiveService.tempReceive(entity, subList);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}
	
	
	/**
	 * 确定收货
	 * @param request
	 * @param model
	 * @param entity
	 * @param subArrs
	 * @return
	 */
//	@RequestMapping(value = "/confirmReceive")
//	@ResponseBody
//	public ActionResultModel<ProjectInfoEntity> confirmReceive(ServletRequest request, Model model, ProjectInfoEntity entity,
//			@RequestParam(value = "subList[]", required = false) String[] subArrs) {
//		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
//		arm.setSuccess(true);
//		List<ProjectReceiveVo> subList = this.convertToEntitieVos(subArrs);
//		try {
//			arm = receiveService.confirmReceive(entity, subList);
//		} catch (DataIntegrityViolationException e) {
//			e.printStackTrace();
//			arm.setSuccess(false);
//			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
//		} catch (Exception e) {
//			arm.setSuccess(false);
//			arm.setMsg(e.getMessage());
//			e.printStackTrace();
//		}
//		return arm;
//	}
	
//	@RequestMapping(value = "/saveSubReceive")
//	@ResponseBody
//	public ActionResultModel<ProjectInfoEntity> saveSubReceive(ServletRequest request,ProjectReceiveVo vo) {
//		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
//		arm.setSuccess(true);
//		return receiveService.saveSubReceive(vo);
//	}
	
	/**
	 * 取消收货
	 * @param request
	 * @param model
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/cancelReceive")
	@ResponseBody
	public ActionResultModel<ProjectInfoEntity> cancelReceive(ServletRequest request, Model model, ProjectInfoEntity entity) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		try {
			arm = receiveService.cancelReceive(entity);
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
	 * 条码解析配置页面
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toBarcodeConfig", method = RequestMethod.GET)
	public String toBarcodeConfig(Model model, ServletRequest request) {
		EnumDataEntity enumData = enumDataService.getByGroupcode("barCodeExtract");
		model.addAttribute(ENTITY, enumData);
		return "modules/info/barcode/projectinfo_barcode_config";
	}
	

	private List<ProjectSubEntity> convertToEntities(String[] paramArr) {
		List<ProjectSubEntity> returnList = new ArrayList<ProjectSubEntity>();
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
			JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[] {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"}));
			ProjectSubEntity obj = (ProjectSubEntity) JSONObject.toBean(jsonObject,	ProjectSubEntity.class);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(obj.getMaterialId());
			obj.setMaterial(material);
			returnList.add(obj);
		}
		return returnList;
	}
	
	
	private List<ProjectReceiveVo> convertToEntitieVos(String[] paramArr) {
		List<ProjectReceiveVo> returnList = new ArrayList<ProjectReceiveVo>();
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
			//需要注册日期，否则日期不准确
			JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(new String[] {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"}));
			ProjectReceiveVo obj = (ProjectReceiveVo) JSONObject.toBean(jsonObject,	ProjectReceiveVo.class);
			returnList.add(obj);
		}
		return returnList;
	}
	
	

	/**
	 * 跳到导入页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/toImport")
	public String toImport(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("projectInfoImpTemplate", "/template/项目单导入模板.xlsx"));
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
		return "modules/info/projectinfo/projectinfo_import_page";
	}



	@ResponseBody
	@RequestMapping(value = "/import")
	public ActionResultModel<ProjectInfoEntity> importExcel(MultipartHttpServletRequest request,ProjectInfoEntity projectInfo,
			HttpServletResponse response) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		try {
			response.setCharacterEncoding("UTF-8");
			MultipartFile file = request.getFile("attachment");
			arm = service.importExcel(file, projectInfo);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		}  catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}
	
	/**
	 * 查询项目
	 * @param codeOrName
	 * @return
	 */
	@RequestMapping(value = "/select2Query")
	@ResponseBody
	public ActionResultModel<ProjectInfoVo> select2Query(String codeOrName) {
		return service.select2Query(codeOrName);
	}
	
	
	/**
	 * 查询箱号
	 * @param codeOrName
	 * @return
	 */
	@RequestMapping(value = "/select2BoxNumQuery")
	@ResponseBody
	public ActionResultModel<ProjectInfoVo> select2BoxNumQuery(String projectId,String boxNum) {
		return service.select2BoxNumQueryselect2BoxNumQuery(projectId,boxNum);
	}
	
	
	
	
	@RequestMapping(value = "/exportCsByIds")
	public void exportCsByIds(HttpServletResponse response, ServletRequest request) {
		String ids = request.getParameter("pks");
		String[] pks = ids.split(",");
		List<ProjectInfoEntity> mainList = (List<ProjectInfoEntity>) service.findAll(pks);
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流
			setExportResponse(response, request, "项目单"+DateUtil.getDateTimeZone());// 设置导出excel的response

			wb = new SXSSFWorkbook(100);
			if (mainList != null && mainList.size() > 0) {
				subService.changeToSheet(mainList, wb);
			}
			wb.write(os);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (wb != null) {
					wb.close();
				}
				if (os != null) {
					os.close();// 关闭流
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}