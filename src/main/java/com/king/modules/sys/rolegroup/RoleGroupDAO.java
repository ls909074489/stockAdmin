package com.king.modules.sys.rolegroup;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface RoleGroupDAO extends IBaseDAO<RoleGroupEntity, String> {
	
	/*
	@Query("from RoleGroupEntity a where a.parentid = ?1  order by showorder, rolegroup_code")
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value = "true") })
	List<RoleGroupEntity> findByParentId(String parentId);*/
	
	@Query("from RoleGroupEntity a where a.parentid is null order by rolegroup_code")
	List<RoleGroupEntity> getFirstLevel();
	
	@Query("from RoleGroupEntity a where a.parentid = ?1 order by rolegroup_code")
	List<RoleGroupEntity> findByParentId(String parentId);

	List<RoleGroupEntity> findByUuidNotAndNodepathLikeOrderByNodepathAsc(String uuid, String nodePath);

	@Query("from RoleGroupEntity a where a.status=1 and a.rolegroup_code=?1")
	public List<RoleGroupEntity> getGroupByCode(String code);

}
