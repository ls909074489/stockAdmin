package com.king.modules.sys.data;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SimplePropertyPreFilter;
import com.king.common.bean.TreeBaseBean;
import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.security.ShiroUser;
import com.king.frame.tree.TreeNode;
import com.king.frame.tree.TreeUtils;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.org.OrgService;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.user.UserService;

@Controller
@RequestMapping(value = "/sys/data")
public class DataController {

	@Autowired
	private OrgService orgService;// 业务单元service
	@Autowired
	private DataService dataService;
	@Autowired
	private UserService userService;// 用户service

	public OrgService getOrgService() {
		return orgService;
	}

	public void setOrgService(OrgService orgService) {
		this.orgService = orgService;
	}

	/**
	 * 选择单位 @Title: selectOrg @author liusheng @date 2016年1月20日 上午11:31:34 @param @return 设定文件 @return String
	 * 返回类型 @throws
	 */
	@RequestMapping(value = "/selectOrg")
	public String selectOrg(Model model, String callBackMethod) {
		model.addAttribute("callBackMethod", callBackMethod);
		return "modules/sys/data/org_select";
	}

	/**
	 * 返回单位数据 
	 * @param pid
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/dataOrg")
	@ResponseBody
	private ActionResultModel dataOrg(@RequestParam(value = "node", defaultValue = "") String pid) {
		ActionResultModel<TreeNode> arm = new ActionResultModel<TreeNode>();
		try {
			List<OrgEntity> list = orgService.findByParentId(pid);// <OrgEntity>
			List allList = (List) orgService.findAll(new Sort(Sort.Direction.ASC, "nodepath"));
			TreeNode tree = TreeUtils.getTreeNode(list.get(0), allList);
			arm.setRecords(tree);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 获取业务单元树列表 @Title: dataOrgList @author liusheng @date 2016年5月12日 下午2:33:32 @param @param request @param @param
	 * pid @param @return 设定文件 @return List<TreeBaseBean> 返回类型 @throws
	 */
	@RequestMapping(value = "/dataOrgList")
	@ResponseBody
	private List<TreeBaseBean> dataOrgList() {
		List<TreeBaseBean> treeList = new ArrayList<TreeBaseBean>();
		TreeBaseBean bean = null;
		List<OrgEntity> orgList = (List<OrgEntity>) getOrgService().findAll(new Sort(Sort.Direction.ASC, "org_code"));
		if (orgList != null && orgList.size() > 0) {
			for (OrgEntity d : orgList) {
				bean = new TreeBaseBean(d.getUuid(), d.getName(), d.getParentId(), false, false, d);
				treeList.add(bean);
			}
		}
		return treeList;
	}
	

	/**
	 * 跳转到选择机构树页面
	 * 
	 * @param model
	 * @param callBackMethod
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/toOrgTree")
	public String toOrgTree(Model model, String callBackMethod, String userId) {
		model.addAttribute("callBackMethod", callBackMethod);
		model.addAttribute("userId", userId);
		return "modules/sys/data/ref_org_tree";
	}

	/**
	 * 获取机构树数据
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/dataOrgTree")
	public List<TreeBaseBean> dataOrgTree(HttpServletRequest request) throws Exception {
		List<OrgEntity> allList = (List<OrgEntity>) orgService.findAll(new Sort(Sort.Direction.ASC, "org_code"));

		List<TreeBaseBean> treeList = new ArrayList<TreeBaseBean>();
		TreeBaseBean treeBean = null;
		boolean checked = false;
		boolean open = false;
		for (OrgEntity o : allList) {
			checked = false;
			open = false;
			// for (UserOrgEntity rf : rfList) {
			// if (rf.getPk_corp().equals(o.getUuid())) {
			// checked = true;
			// open = true;
			// break;
			// }
			// }
			treeBean = new TreeBaseBean(o.getUuid(), o.getName(), o.getParentId(), checked, open);
			treeBean.setNodeData(o);
			treeList.add(treeBean);
		}
		return treeList;
	}

	/**
	 * 选择部门 @Title: selectDept @author liusheng @date 2016年1月20日 上午11:32:06 @param @param model @param @param
	 * callBackMethod @param @param pk_corp 部门所在的单元 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/selectDept")
	public String selectDept(Model model, String callBackMethod, String pk_corp) {
		model.addAttribute("callBackMethod", callBackMethod);
		model.addAttribute("pk_corp", pk_corp);
		return "modules/sys/data/dept_select";
	}


	@ResponseBody
	@RequestMapping(value = "/dataAdmin")
	public List<TreeBaseBean> dataAdmin(ServletRequest request) {
		return dataService.dataAllAdmin();
	}

	/**
	 * 获取国家 @Title: dataCountry @author liusheng @date 2016年1月26日 下午2:42:43 @param @param pId @param @param
	 * request @param @return 设定文件 @return List<TreeBaseBean> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataCountry")
	public List<TreeBaseBean> dataCountry(@RequestParam String pId, ServletRequest request) {
		List<TreeBaseBean> list = dataService.dataCountry(pId);
		return list;
	}

	/**
	 * 获取省 @Title: dataProvince @author liusheng @date 2016年1月26日 下午2:42:30 @param @param pId @param @param
	 * request @param @return 设定文件 @return List<TreeBaseBean> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataProvince")
	public List<TreeBaseBean> dataProvince(@RequestParam String pId, ServletRequest request) {
		return dataService.dataProvince(pId);
	}

	/**
	 * 获取市 @Title: dataCity @author liusheng @date 2016年1月27日 下午7:18:43 @param @param pId @param @param
	 * request @param @return 设定文件 @return List<TreeBaseBean> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataCity")
	public List<TreeBaseBean> dataCity(@RequestParam String pId, ServletRequest request) {
		return dataService.dataCity(pId);
	}

	/**
	 * 获取区 @Title: dataDistrict @author liusheng @date 2016年1月26日 下午2:42:05 @param @param pId @param @param
	 * request @param @return 设定文件 @return List<TreeBaseBean> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataDistrict")
	public List<TreeBaseBean> dataDistrict(@RequestParam String pId, ServletRequest request) {
		return dataService.dataDistrict(pId);
	}

	@ResponseBody
	@RequestMapping(value = "/dataCouAndPro")
	public List<TreeBaseBean> dataCouAndPro(ServletRequest request) {
		List<TreeBaseBean> list = dataService.dataProvince(Constants.DEFAULT_CHINA_ID);
		TreeBaseBean bean = new TreeBaseBean();
		bean.setId(Constants.DEFAULT_CHINA_ID);
		bean.setName(Constants.DEFAULT_CHINA_NAME);
		bean.setpId("0");
		list.add(bean);
		return list;
	}

	/**
	 * 组织列表按where语句查询
	 * 
	 * @param model
	 * @param callBackMethod
	 * @param where
	 * @return
	 */
	@RequestMapping(value = "/listCorp")
	public String listCorp(Model model, String callBackMethod, String where) {
		model.addAttribute("callBackMethod", callBackMethod);
		model.addAttribute("where", where);
		return "modules/sys/data/ref_corplist";
	}


	/**
	 * 选择流程用户组页面
	 * 
	 * @param model
	 * @param callBackMethod
	 * @return
	 */
	@RequestMapping(value = "/listProcessUserGroup")
	public String listProcessUserGroup(Model model, String callBackMethod) {
		model.addAttribute("callBackMethod", callBackMethod);

		return "modules/sys/data/ref_process_usergroup_main";
	}

	

	/**
	 * 选择用户列表页面 @Title: listUser @author liusheng @date 2016年5月18日 上午11:08:59 @param @param model @param @param
	 * callBackMethod @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/listUser")
	public String listUser(Model model, String callBackMethod) {
		model.addAttribute("callBackMethod", callBackMethod);
		return "modules/sys/data/ref_user_main";
	}

	/**
	 * 获取用户数据 @Title: dataUser @author liusheng @date 2016年5月18日 上午11:10:18 @param @return 设定文件 @return
	 * ActionResultModel<UserEntity> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataUser")
	public ActionResultModel<UserEntity> dataUser() {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			List<UserEntity> result = (List<UserEntity>) userService.getUserBySql();
			arm.setRecords(result);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 获取业务单元列表信息 @Title: dataOrgList @author liusheng @date 2016年5月12日 下午2:38:59 @param @param request @param @param
	 * pid @param @return 设定文件 @return ActionResultModel<OrgEntity> 返回类型 @throws
	 */
	@RequestMapping(value = "/dataOrgLists")
	@ResponseBody
	private String dataOrgLists() {
		ActionResultModel<OrgEntity> arm = new ActionResultModel<OrgEntity>();
		String jsonStr = "";
		try {
			List<OrgEntity> list = (List<OrgEntity>) orgService.findAll(new Sort(Sort.Direction.ASC, "org_code"));
			arm.setRecords(list);
			arm.setSuccess(true);

		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		SimplePropertyPreFilter filter = new SimplePropertyPreFilter(OrgEntity.class, "uuid", "org_name", "org_code");
		jsonStr = JSON.toJSONString(arm, filter);
		return jsonStr;
	}

}