package com.king.modules.sys.org;

import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.king.frame.dao.IBaseDAO;

public interface OrgDAO extends IBaseDAO<OrgEntity, String> {

	@Query("from OrgEntity a where ( a.parentid is null or a.parentid='') and a.status = 1 order by createdDate, org_code")
	List<OrgEntity> getFirstLevel();

	@Query("from OrgEntity a where a.parentid = ?1 and a.status = 1 order by createdDate, org_code")
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value = "true") })
	List<OrgEntity> findByParentId(String parentId);

	List<OrgEntity> findByUuidNotAndNodepathLikeOrderByNodepathAsc(String sysId, String nodepath);

	@Query("from OrgEntity a where a.orgtype > ?1 order by nodepath asc")
	List<OrgEntity> findByOrgtypeGt(String orgtype);

	@Query("from OrgEntity a where a.orgtype = ?1 order by nodepath asc")
	List<OrgEntity> findByOrgtype(String orgtype);

	@Query("from OrgEntity a where a.status = 1 and a.org_code=?1")
	public List<OrgEntity> findByOrgCode(String orgCode);

	@Query("from OrgEntity a where a.status = 1")
	public List<OrgEntity> findAllByStatus();

}