package com.king.modules.sys.func;

import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.king.frame.dao.IBaseDAO;

public interface FuncDAO extends IBaseDAO<FuncEntity, String> {
	@Query("from FuncEntity a where a.parentid is null and a.status = 1 order by showorder, func_code")
	List<FuncEntity> getFirstLevel();

	@Query("from FuncEntity a where a.parentid = ?1 and a.status = 1 order by showorder, func_code")
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value = "true") })
	List<FuncEntity> findByParentId(String parentId);

	List<FuncEntity> findByUuidNotAndNodepathLikeOrderByNodepathAsc(String uuid, String nodePath);
}