package com.king.modules.sys.role;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.bean.JsonBaseBean;
import com.king.common.bean.TreeBaseBean;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.rolegroup.RoleGroupEntity;
import com.king.modules.sys.rolegroup.RoleGroupService;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.userrole.UserRoleEntity;

/**
 * 角色管理controller
 * @ClassName: RoleController
 * @author liusheng 
 * @date 2015年12月17日 上午11:02:40
 */
@Controller
@RequestMapping(value = "/sys/role")
public class RoleController extends BaseController<RoleEntity> {

	private RoleService getService() {
		return (RoleService) super.baseService;
	}
	
	@Autowired
	protected RoleGroupService roleGroupService;
	
	
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/role/role_main";
	}

	/**
	 * 跳转到选择权限功能页面
	 * @Title: selectFunc 
	 * @author liusheng
	 * @date 2015年12月24日 下午4:30:26 
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/selectFunc")
	public String selectFunc() {
		return "modules/sys/role/role_func_select";
	}
	
	/**
	 * 跳转到选择用户功能页面
	 * @Title: selectUser 
	 * @author liusheng
	 * @date 2015年12月24日 下午4:30:40 
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/selectUser")
	public String selectUser(String roleId,Model model) {
		model.addAttribute("roleId", roleId);
		return "modules/sys/role/role_user_select";
	}
	
	
	/**
	 * 获取角色能选择的权限
	 * @Title: dataOrg 
	 * @author liusheng
	 * @date 2015年12月17日 下午4:56:18 
	 * @param @return
	 * @param @throws Exception 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value="/getRoleFuncs")
	public List<TreeBaseBean> getRoleFuncs(String roleId) throws Exception{
		return getService().getRoleFuncs(roleId);
	}
	
	
	/**
	 * 保存角色的权限
	 * @Title: selectFunc 
	 * @author liusheng
	 * @date 2015年12月17日 下午1:53:03 
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/save_permission")
	public JsonBaseBean savePermission(String roleId,String checkedIds) {
		return getService().savePermission(roleId,checkedIds);
	}
	
	
	/**
	 * 获取角色组
	 * @Title: getRoleGroup 
	 * @author liusheng
	 * @date 2015年12月21日 下午5:59:36 
	 * @param @param roleId
	 * @param @return
	 * @param @throws Exception 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value="/getRoleGroup")
	public List<TreeBaseBean> getRoleGroup(String roleId) throws Exception{
		List<RoleGroupEntity> allList = (List<RoleGroupEntity>) roleGroupService.findAll(new Sort(Sort.Direction.ASC, "nodepath"));
		TreeBaseBean treeBean=null;
		List<TreeBaseBean> treeList=new ArrayList<TreeBaseBean>();
		for(RoleGroupEntity o:allList){
			treeBean=new TreeBaseBean(o.getUuid(), o.getName(), o.getParentId(),false,false,o);
			 treeList.add(treeBean);
		}
		return treeList;
	}
	
	
	/**
	 * 获取角色组下面的角色
	 * @Title: search 
	 * @author liusheng
	 * @date 2015年12月22日 下午4:22:31 
	 * @param @param request
	 * @param @return 设定文件 
	 * @return ActionResultModel<RoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/searchGroupRoles")
	protected ActionResultModel<RoleEntity> search(String groupId,ServletRequest request) {
		ActionResultModel<RoleEntity> arm = new ActionResultModel<RoleEntity>();
		try {
			// 查询条件
			List<RoleEntity> list = new ArrayList<RoleEntity>();//getService().searchGroupRoles(groupId);
			ActionResultModel<RoleEntity>  result=doQuery(request);
			if(result!=null&&result.getRecords()!=null){
				list=result.getRecords();
			}
			arm.setRecords(list);
			arm.setTotal(list.size());
			arm.setTotalPages(1);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	
	/**
	 * 此处添加查询参数,用Map替代null,格式：LIKE_loginName=aa key和value都是String类型的。 addParam.put("LIKE_loginName", "aa");
	 * addParam.put("EQ_validDate", "2014-10-01");
	 * 
	 * @return
	 */
//	@Override
//	public Map<String, Object> addSearchParam(ServletRequest request) {
//		Map<String, Object> addParam = new HashMap<String, Object>();
//		String groupId=request.getParameter("groupId");
//		String name=request.getParameter("search_LIKE_name");
//		if(!StringUtils.isEmpty(groupId)){
//			addParam.put("search_rolegroupId", groupId);
//		}
//		if(!StringUtils.isEmpty(name)){
//			addParam.put("search_LIKE_name", name);
//		}
//		return addParam;
//	}
	
	/**
	 * 
	 *TODO 查询某个角色关联的所有用户
	 *@date  2013-11-25 下午4:48:47
	 *@param roleId
	 *@return
	 */
	@RequestMapping(value = "/findUserByRoleId")
	@ResponseBody
	private ActionResultModel<UserEntity> findUserByRoleId(@RequestParam(value = "roleId")String roleId,UserEntity user){
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			List<UserEntity> users = getService().findUserByRoleId(roleId,user);
			arm.setRecords(users);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	/**
	 * 获取可选中的用户列表
	 * @Title: findAllUserByRoleId 
	 * @author liusheng
	 * @date 2016年1月13日 下午3:52:44 
	 * @param @param roleId
	 * @param @param user
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserEntity> 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/findAllUserByRoleId")
	@ResponseBody
	private ActionResultModel<UserEntity> findAllUserByRoleId(@RequestParam(value = "roleId")String roleId,
			UserEntity user){
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			List<UserEntity> users = getService().findAllUserByRoleId(roleId,user);
			arm.setRecords(users);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	/**
	 * 查询角色关联的权限
	 * @Title: findFuncByRoleId 
	 * @author liusheng
	 * @date 2015年12月24日 下午1:35:44 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return ActionResultModel<FuncEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/findFuncByRoleId")
	public ActionResultModel<FuncEntity> findFuncByRoleId(@RequestParam(value = "roleId")String roleId){
		ActionResultModel<FuncEntity> arm = new ActionResultModel<FuncEntity>();
		try {
			List<FuncEntity> funcs = getService().findFuncByRoleId(roleId);
			arm.setRecords(funcs);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		
		return arm;
	}
	
	/**
	 * 删除角色
	 * @Title: delRole 
	 * @author liusheng
	 * @date 2015年12月29日 上午9:30:41 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return ActionResultModel<RoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delRole")
	public ActionResultModel<RoleEntity> delRole(@RequestParam(value = "pks")String pks) {
		ActionResultModel<RoleEntity> arm = new ActionResultModel<RoleEntity>();
		try {
			getService().delRole(pks);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
	@RequestMapping(value = "/deleteByUserId")
	@ResponseBody
	private ActionResultModel<UserRoleEntity> deleteByUserId(String[] userIds){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			getService().deleteByUserId(userIds);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchByGroupCode")
	protected ActionResultModel<RoleEntity> searchByGroupCode(@RequestParam("groupCode")String groupCode,ServletRequest request) {
		ActionResultModel<RoleEntity> arm = new ActionResultModel<RoleEntity>();
		try {
			// 查询条件
			List<RoleEntity> list = getService().findRoleByGroupCode(groupCode);
			arm.setRecords(list);
			arm.setTotal(list.size());
			arm.setTotalPages(1);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	
	/**
	 * 已选入的角色
	 * @Title: dataSelRoles 
	 * @author liusheng
	 * @date 2016年3月18日 下午6:18:55 
	 * @param @param obj
	 * @param @param selUserId
	 * @param @param request
	 * @param @return 设定文件 
	 * @return ActionResultModel<RoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataSelRoles")
	public ActionResultModel<RoleEntity> dataSelRoles(@RequestParam("selUserId")String selUserId,ServletRequest request) {
		ActionResultModel<RoleEntity> arm = new ActionResultModel<RoleEntity>();
		try {
			List<RoleEntity> objList=getService().findSelRole(selUserId);
			arm.setRecords(objList);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage()); 
			e.printStackTrace();
		}
		return arm;
	}
	
	/**
	 * 为选入的角色
	 * @Title: dataUnSelRoles 
	 * @author liusheng
	 * @date 2016年3月18日 下午6:21:02 
	 * @param @param selUserId
	 * @param @param request
	 * @param @return 设定文件 
	 * @return ActionResultModel<RoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/dataUnSelRoles")
	public ActionResultModel<RoleEntity> dataUnSelRoles(@RequestParam("selUserId")String selUserId,ServletRequest request) {
		ActionResultModel<RoleEntity> arm = new ActionResultModel<RoleEntity>();
		try {
			List<RoleEntity> objList=getService().findUnSelRole(selUserId);
			arm.setRecords(objList);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage()); 
			e.printStackTrace();
		}
		return arm;
	}

	@Override
	public ActionResultModel<RoleEntity> add(ServletRequest request, Model model, RoleEntity entity) {
		List<RoleEntity> result = (List<RoleEntity>) getService().searchGroupRoles(entity.getRolegroup().getUuid());
		if(result!=null&&result.size()>0){
			for (RoleEntity a : result) {
				if(a.getName().equals(entity.getName())){
					ActionResultModel<RoleEntity> arm=new ActionResultModel<RoleEntity>();
					arm.setSuccess(false);
					arm.setMsg("同级下已添加"+entity.getName());
					return arm;
				}
			}
		}
		return super.add(request, model, entity);
	}

	@Override
	public ActionResultModel<RoleEntity> update(ServletRequest request, Model model, RoleEntity entity) {
		List<RoleEntity> result = (List<RoleEntity>) getService().searchGroupRoles(entity.getRolegroup().getUuid());
		if(result!=null&&result.size()>0){
			for (RoleEntity a : result) {
				if(a.getName().equals(entity.getName())&&!a.getUuid().equals(entity.getUuid())){
					ActionResultModel<RoleEntity> arm=new ActionResultModel<RoleEntity>();
					arm.setSuccess(false);
					arm.setMsg("同级下已添加"+entity.getName());
					return arm;
				}
			}
		}
		return super.update(request, model, entity);
	}
	
	
	
}
