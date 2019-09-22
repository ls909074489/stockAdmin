package com.king.modules.info.isolateMaterial;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 隔离物料
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Service
@Transactional(readOnly=true)
public class MateialIsolateService extends BaseServiceImpl<MateialIsolateEntity,String> {

	@Autowired
	private MateialIsolateDao dao;

	protected IBaseDAO<MateialIsolateEntity, String> getDAO() {
		return dao;
	}

	public List<MateialIsolateEntity> findByMaterialAndBarcode(String materialId, String barcode) {
		return dao.findByMaterialAndBarcode(materialId,barcode);
	}


}