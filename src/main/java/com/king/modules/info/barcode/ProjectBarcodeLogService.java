package com.king.modules.info.barcode;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-29 11:04:14
 */
@Service
@Transactional(readOnly=true)
public class ProjectBarcodeLogService extends BaseServiceImpl<ProjectBarcodeLogEntity,String> {

	@Autowired
	private ProjectBarcodeLogDao dao;

	protected IBaseDAO<ProjectBarcodeLogEntity, String> getDAO() {
		return dao;
	}

}