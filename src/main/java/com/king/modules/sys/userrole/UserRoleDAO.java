package com.king.modules.sys.userrole;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;


public interface UserRoleDAO extends IBaseDAO<UserRoleEntity, String> {
	@Modifying
	@Query("delete from UserRoleEntity ur where ur.role.uuid = ?1")
	void deleteByRoleId(String roleId);
	
	@Modifying
	@Query("delete from UserRoleEntity ur where ur.user.uuid = ?1")
	void deleteByUserId(String userId);
	
	@Modifying
	@Query("delete from UserRoleEntity ur where ur.user.uuid = ?1 and ur.role.uuid=?2")
	void deleteByUserIdAndByRoleId(String userId,String roleId);
	
	@Query("from UserRoleEntity ur where ur.user.uuid = ?1 and ur.role.uuid=?2")
	UserRoleEntity findByUserIdAndByRoleId(String userId,String roleId);
	
}
