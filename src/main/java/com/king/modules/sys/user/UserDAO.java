package com.king.modules.sys.user;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.role.RoleEntity;

public interface UserDAO extends IBaseDAO<UserEntity, String> {
	// and u.is_use=1 shiro判断是否锁定 edit by liusheng
	@Query("from UserEntity u where u.status=1 and u.loginname=?1")
	UserEntity findByLoginname(String loginname);

	@Transactional
	@Modifying
	@Query("update UserEntity u set u.is_use=?2 where u.status=1 and u.loginname=?1")
	public void setUseByName(String loginname, String is_use);

	@Query("select ur.role from UserRoleEntity ur where ur.user.uuid = ?1 and ur.role.status=1 ")
	List<RoleEntity> findRoleByUserId(String userUuid);

	@Query("SELECT func from FuncEntity func " + "WHERE  func.usestatus='1' and func.uuid IN "
			+ "(SELECT DISTINCT(rf.func.uuid) FROM RoleFuncEntity rf " + // 查询所有角色所关联的功能
			"WHERE rf.status=1 and rf.role.uuid IN "
			+ "(SELECT ur.role.uuid FROM UserRoleEntity ur WHERE ur.user.uuid = ?1 and ur.role.status=1 )) and func.status=1 order by func_code") // 查询用户关联的所有角色
	List<FuncEntity> findFuncByUserId(String userUuid);

	@Query("from UserEntity a where  a.status = 1  and a.orgid=?1")
	List<UserEntity> findByOrgId(String pkCorp);

	@Query("from UserEntity a where  a.status = 1 ")
	List<UserEntity> queryUserAll();

}
