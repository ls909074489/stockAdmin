package com.king.modules.sys.documents;


import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 单据号生成策略dao
 * @ClassName: DocumentsDao
 * @author  dsp
 * @date 2016年08月22日 04:16:12
 */
public interface DocumentsDao extends IBaseDAO<DocumentsEntity, String> {
	@Query("from DocumentsEntity a where a.documentType = ?1")
	List<DocumentsEntity> findByDocumentType(String documentType);
	
	@Query("from DocumentsEntity a where a.documentType = ?1")
	DocumentsEntity findByDocuType(String documentType);
	
}
