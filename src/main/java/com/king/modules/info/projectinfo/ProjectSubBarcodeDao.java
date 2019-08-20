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

	
	@Query("from ProjectSubBarcodeEntity where main.uuid in ?1 and status=1 order by main.uuid,createtime")
	List<ProjectSubBarcodeEntity> findByProjectIds(List<String> projectIds);

	@Query("from ProjectSubBarcodeEntity ur where ur.barcode like ?1 and status=1")
	List<ProjectSubBarcodeEntity> findLikeBarcode(String barcode);
	
	@Query("from ProjectSubBarcodeEntity ur where ur.main.uuid=?1 and ur.barcode like ?2 and status=1")
	List<ProjectSubBarcodeEntity> findProjectLikeBarcode(String projectId,String barcode);
	
//
//	@Query("from ProjectSubBarcodeEntity ur where status=1 and barcode is null")
//	List<ProjectSubBarcodeEntity> findLikeBarcodeNotNull();
//
//
//	@Query("from ProjectSubBarcodeEntity ur where status=1 and barcode not null")
//	List<ProjectSubBarcodeEntity> findLikeBarcodeNull();

	
}
