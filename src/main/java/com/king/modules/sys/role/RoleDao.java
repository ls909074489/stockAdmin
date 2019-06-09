package com.king.modules.sys.role;
import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;
import com.king.modules.sys.user.UserEntity;
/**
 * 角色dao
 * @ClassName: RoleDao
 * @author liusheng 
 * @date 2015年12月17日 上午11:00:14
 */
public interface RoleDao extends IBaseDAO<RoleEntity,String>{

	@Query("select u from UserEntity u, UserRoleEntity ur " +
			   "where u.uuid = ur.user.uuid and ur.role.uuid = ?1 " +
			   "order by u.modifytime")
	List<UserEntity> findUserByRoleId(String roleId);

	@Query("from RoleEntity a where  a.status = 1  and a.code=?1")
	public List<RoleEntity> findByCode(String roleCode);

}
