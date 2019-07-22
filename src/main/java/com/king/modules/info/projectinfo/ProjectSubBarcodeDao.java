package com.king.modules.info.projectinfo;


import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 
 * @author liusheng
 *
 */
public interface ProjectSubBarcodeDao extends IBaseDAO<ProjectSubBarcodeEntity, String> {

	
	@Query("from ProjectSubBarcodeEntity ur where ur.sub.uuid = ?1")
	List<ProjectSubBarcodeEntity> findBySubId(String subId);

	
}
