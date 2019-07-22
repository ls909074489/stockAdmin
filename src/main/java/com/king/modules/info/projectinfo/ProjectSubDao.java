package com.king.modules.info.projectinfo;


import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 
 * @author liusheng
 *
 */
public interface ProjectSubDao extends IBaseDAO<ProjectSubEntity, String> {

	
	@Query("from ProjectSubEntity ur where ur.main.uuid = ?1")
	List<ProjectSubEntity> findByMain(String mainId);

	
	@Query("from ProjectSubEntity ur where ur.barcode = ?1")
	List<ProjectSubEntity> findByBarcode(String newBarcode);

}
