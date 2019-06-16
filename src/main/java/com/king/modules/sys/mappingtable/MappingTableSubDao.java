package com.king.modules.sys.mappingtable;


import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 
 * @ClassName: AuditColsSubDao
 * @author liusheng
 * @date 2017年11月21日 下午5:49:48
 */
public interface MappingTableSubDao extends IBaseDAO<MappingTableSubEntity, String> {

	
	@Query("from MappingTableSubEntity ur where ur.main.uuid = ?1")
	List<MappingTableSubEntity> findByMain(String mainId);

}
