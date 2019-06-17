package com.king.modules.info.stockinfo;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 仓库
 * @author null
 * @date 2019-06-17 21:24:38
 */
@Service
@Transactional(readOnly=true)
public class StockInfoService extends BaseServiceImpl<StockInfoEntity,String> {

	@Autowired
	private StockInfoDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<StockInfoEntity, String> getDAO() {
		return dao;
	}

}