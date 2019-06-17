package com.king.modules.info.orderinfo;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Service
@Transactional(readOnly=true)
public class OrderInfoService extends BaseServiceImpl<OrderInfoEntity,String> {

	@Autowired
	private OrderInfoDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<OrderInfoEntity, String> getDAO() {
		return dao;
	}

}