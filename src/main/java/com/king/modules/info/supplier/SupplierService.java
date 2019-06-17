package com.king.modules.info.supplier;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 供应商
 * @author null
 * @date 2019-06-17 21:31:03
 */
@Service
@Transactional(readOnly=true)
public class SupplierService extends BaseServiceImpl<SupplierEntity,String> {

	@Autowired
	private SupplierDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<SupplierEntity, String> getDAO() {
		return dao;
	}

}