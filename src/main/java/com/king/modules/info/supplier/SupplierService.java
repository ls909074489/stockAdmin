package com.king.modules.info.supplier;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 供应商信息
 * @author ls2008
 * @date 2017-11-18 21:06:10
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