package com.king.modules.info.projectinfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * OrderSubService
 * 
 * @author liusheng
 *
 */
@Service
@Transactional(readOnly = true)
public class ProjectSubBarcodeService extends BaseServiceImpl<ProjectSubBarcodeEntity, String> {

	@Autowired
	private ProjectSubBarcodeDao dao;
	@Lazy
	@Autowired
	private ProjectInfoService mainService;
	@Lazy
	@Autowired
	private ProjectSubService subService;


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	
	@Transactional(readOnly = true)
	public List<ProjectSubBarcodeEntity> findBySubId(String subId) {
		return dao.findBySubId(subId);
	}


	public List<ProjectSubBarcodeEntity> findByProjectIds(List<String> projectIds) {
		return dao.findByProjectIds(projectIds);
	}


	public List<ProjectSubBarcodeEntity> findLikeBarcode(String barcode,String barCodeNull) {
		if(StringUtils.isEmpty(barCodeNull)){
			return dao.findLikeBarcode("%"+barcode+"%");
		}else if(barCodeNull.equals("1")){
			return dao.findLikeBarcodeNotNull();
		}else if(barCodeNull.equals("0")){
			return dao.findLikeBarcodeNull();
		}else{
			return dao.findLikeBarcode("%"+barcode+"%");
		}
	}
}
