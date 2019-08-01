package com.king.modules.info.orderinfo;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.SuperServiceImpl;
import com.king.modules.info.stockdetail.StockDetailService;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Service
@Transactional(readOnly=true)
public class OrderInfoService extends SuperServiceImpl<OrderInfoEntity,String> {

	@Autowired
	private OrderInfoDao dao;
	@Lazy
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private OrderSubService orderSubService;

	protected IBaseDAO<OrderInfoEntity, String> getDAO() {
		return dao;
	}

	@Override
	public void afterApprove(OrderInfoEntity entity) throws ServiceException {
		List<OrderSubEntity>  subList = orderSubService.findByMain(entity.getUuid());
		stockDetailService.incrStockDetail(entity, subList);
		super.afterApprove(entity);
	}
	
	

}