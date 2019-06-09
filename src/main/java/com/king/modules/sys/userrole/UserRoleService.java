package com.king.modules.sys.userrole;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.role.RoleEntity;
import com.king.modules.sys.user.UserEntity;
@Service
@Transactional
public class UserRoleService extends BaseServiceImpl<UserRoleEntity, String> {

	@Autowired
	private UserRoleDAO dao;

	@Override
	protected IBaseDAO<UserRoleEntity, String> getDAO() {
		return dao;
	}
	
	public void deleteByRoleId(String roleId) throws ServiceException{
		dao.deleteByRoleId(roleId);
	}
	
	public void deleteByUserId(String[] userIds) throws ServiceException{
		for(String userId : userIds){
			dao.deleteByUserId(userId);
		}
	}
	/**
	 * 删除用户角色
	 * @author lrk
	 * @param userIds
	 * @param roleIds
	 * @throws ServiceException
	 */
	public void deleteByUserIdAndByRoleId(String[] userIds,String [] roleIds) throws ServiceException{
		for(String userId : userIds){
			for(String roleId : roleIds){
				dao.deleteByUserIdAndByRoleId(userId,roleId);
			}
		}
	}
	
	/**
	 * 
	 * @param roleId
	 * @param uuids
	 * @throws ServiceException
	 */
	public void update(String roleId, String[] uuids) throws ServiceException{
		for(String uuid : uuids){
			UserRoleEntity entity = new UserRoleEntity();
			UserEntity user = new UserEntity();
			user.setUuid(uuid);
			RoleEntity role = new RoleEntity();
			role.setUuid(roleId);
			
			entity.setRole(role);
			entity.setUser(user);
			
			dao.save(entity);
		}
	}
	
	
	/**
	 * 修改用户角色
	 * @author lrk 
	 * @param userIds
	 * @param roleIds
	 * @throws ServiceException
	 */
	public void updateByUserIdAndRoleId(String[] userIds, String [] roleIds) throws ServiceException{
		
		for(String uuid : userIds){
			UserRoleEntity entity = new UserRoleEntity();
			UserEntity user = new UserEntity();
			user.setUuid(uuid);
			for(String roleId:roleIds){
				RoleEntity role = new RoleEntity();
				role.setUuid(roleId);
				entity.setRole(role);
				entity.setUser(user);
				dao.save(entity);
			}
		}
	}
	/**
	 * 增加用户角色
	 * @author lrk 
	 * @param userId
	 * @param roleId
	 * @return 
	 * @throws ServiceException
	 */
	public void onSave(String userId, String roleId) throws ServiceException{
		
		UserRoleEntity entity = new UserRoleEntity();
		UserEntity user = new UserEntity();
		user.setUuid(userId);
		RoleEntity role = new RoleEntity();
		role.setUuid(roleId);
		
		entity.setRole(role);
		entity.setUser(user);
		
		dao.save(entity);
	}
	
	public UserRoleEntity findByUserIdAndRoleId(String userId, String roleId) throws ServiceException{
		UserRoleEntity ur = dao.findByUserIdAndByRoleId(userId, roleId);
		return ur;
	}

	/**
	 * 选择角色下的用户
	 * @Title: selecRoleUser 
	 * @author liusheng
	 * @date 2015年12月25日 上午10:46:09 
	 * @param @param roleId
	 * @param @param userId
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<UserRoleEntity> selecRoleUser(String roleId, String userId) {
		ActionResultModel<UserRoleEntity> result=new ActionResultModel<UserRoleEntity>();
		UserRoleEntity userRole=dao.findByUserIdAndByRoleId(userId, roleId);
		if(userRole!=null&&userRole.getUuid()!=null){
			result.setMsg("该用户已选入");
			result.setSuccess(false);
		}else{
			try {
				onSave(userId, roleId);
				result.setMsg("操作成功");
				result.setSuccess(true);
			} catch (Exception e) {
				result.setMsg("操作失败");
				result.setSuccess(false);
				e.printStackTrace();
			}
		}
		return result;
	}

	
	/**
	 * 移除用户
	 * @Title: delRoleUser 
	 * @author liusheng
	 * @date 2015年12月25日 上午11:09:55 
	 * @param @param roleId
	 * @param @param userId
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<UserRoleEntity> delRoleUser(String roleId,
			String userId) {
		ActionResultModel<UserRoleEntity> result=new ActionResultModel<UserRoleEntity>();
		try {
			dao.deleteByUserIdAndByRoleId(userId, roleId);
			result.setMsg("操作成功");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 根据id删除
	 * @Title: delByUrid 
	 * @author LiuSheng
	 * @date 2016年3月8日 上午9:08:56 
	 * @param @param urUuid
	 * @param @return 设定文件 
	 * @return ActionResultModel<UserRoleEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<UserRoleEntity> delByUrid(String urUuid) {
		ActionResultModel<UserRoleEntity> result=new ActionResultModel<UserRoleEntity>();
		try {
			dao.delete(urUuid);
			result.setMsg("操作成功");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}
	
}
