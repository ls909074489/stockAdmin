package com.king.modules.info.isolateMaterial;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.king.frame.dao.IBaseDAO;

@Repository
public interface MateialIsolateDao extends IBaseDAO<MateialIsolateEntity,String> {

	@Query("from MateialIsolateEntity where barcode=?1")
	List<MateialIsolateEntity> findByBarcode(String barcode);


}