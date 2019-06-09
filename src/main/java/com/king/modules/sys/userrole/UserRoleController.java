package com.king.modules.sys.userrole;

import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

@Controller
@RequestMapping(value = "/sys/userrole")
public class UserRoleController  extends BaseController<UserRoleEntity> {

	private UserRoleService getService() {
		return (UserRoleService) super.baseService;
	}
//	@Autowired
//	private UserRoleService service;
	


	/**
	 * 
	 * 更新角色的关联用户
	 *@date  2013-11-28 下午1:53:19
	 *@param entities
	 *@return
	 */
	@RequestMapping(value = "/assUser")
	@ResponseBody
	public ActionResultModel<UserRoleEntity> update(String roleId, String[] userIds){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			getService().deleteByRoleId(roleId);
			getService().update(roleId, userIds);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		
		return arm;
	}
	
	/**
	 * 更新用户角色功能
	 * @date 2014-01-15 下午21:57:19
	 * @param roleId
	 * @param uuids
	 * @return
	 */
	@RequestMapping(value = "/updateByUserIds")
	@ResponseBody
	public ActionResultModel<UserRoleEntity> updateByUserIds(String [] userIds,String [] roleIds){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			for(String userId:userIds){
				for(String roleId:roleIds){
					UserRoleEntity urs=getService().findByUserIdAndRoleId(userId, roleId);
					if(urs == null){
						getService().onSave(userId, roleId);
					}
				}
			}
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return arm;
	}
	
	@RequestMapping(value = "/deleteByUserId")
	@ResponseBody
	public ActionResultModel<UserRoleEntity> deleteByUserId(String[] userIds){
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
	
	
	/**
	 * 删除角色下面绑定的用户
	 * @Title: deleteByUsersIdAndRoleIds 
	 * @author liusheng
	 * @date 2015年12月24日 下午1:12:51 
	 * @param @param userIds
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/deleteByUserIdsAndRoleIds")
	@ResponseBody
	public ActionResultModel<UserRoleEntity> deleteByUsersIdAndRoleIds(String[] userIds,String roleId){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			getService().deleteByUserIdAndByRoleId(userIds, new String[]{roleId});
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	
	
	/**
	 * 添加角色下的用户
	 * @Title: selecRoleUser 
	 * @author liusheng
	 * @date 2015年12月25日 上午10:41:21 
	 * @param @param roleId
	 * @param @param userIds
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/selecRoleUser")
	public ActionResultModel<UserRoleEntity> selecRoleUser(String roleId, String userId){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			arm=getService().selecRoleUser(roleId,userId);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg("操作失败");
		}
		return arm;
	}
	
	
	
	/**
	 * 移除用户
	 * @Title: delRoleUser 
	 * @author liusheng
	 * @date 2015年12月25日 上午11:09:22 
	 * @param @param roleId
	 * @param @param userId
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delRoleUser")
	public ActionResultModel<UserRoleEntity> delRoleUser(String roleId, String userId){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			arm=getService().delRoleUser(roleId,userId);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg("操作失败");
		}
		return arm;
	}
	
	/**
	 * 根据userRole中间表的id删除
	 * @Title: delByUrid 
	 * @author LiuSheng
	 * @date 2016年3月8日 上午9:08:25 
	 * @param @param urUuid
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/delByUrid")
	public ActionResultModel<UserRoleEntity> delByUrid(@RequestParam("urUuid")String urUuid){
		ActionResultModel<UserRoleEntity> arm = new ActionResultModel<UserRoleEntity>();
		try {
			arm=getService().delByUrid(urUuid);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg("操作失败");
		}
		return arm;
	}
}
