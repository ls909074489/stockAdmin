package com.king.modules.info.stockdetail;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.orderinfo.OrderInfoEntity;
import com.king.modules.info.orderinfo.OrderSubEntity;
import com.king.modules.info.orderinfo.OrderSubService;
import com.king.modules.info.stockinfo.StockInfoEntity;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Service
@Transactional(readOnly=true)
public class StockDetailService extends BaseServiceImpl<StockDetailEntity,String> {

	@Autowired
	private StockDetailDao dao;
	@Autowired
	private OrderSubService orderSubService;

	protected IBaseDAO<StockDetailEntity, String> getDAO() {
		return dao;
	}
	
	

	private StockInfoEntity getStockByOrderType(String orderType){
		StockInfoEntity stock = new StockInfoEntity();
		stock.setUuid(ParameterUtil.getParamValue("defaultStock"));
		return stock;
	}
	
	public StockDetailEntity findByStockAndMaterial(String stockId, String materialId) {
		return dao.findByStockAndMaterial(stockId, materialId);
	}
	
	
	@Transactional
	public void incrStockDetail(OrderInfoEntity orderInfo,List<OrderSubEntity> subList){
		StockInfoEntity stock = getStockByOrderType(orderInfo.getOrderType());
		for(OrderSubEntity sub:subList){
			StockDetailEntity detail  = findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			if(detail==null){
				detail = new StockDetailEntity();
				detail.setStock(stock);
				detail.setMaterial(sub.getMaterial());
				detail.setTotalAmount(sub.getActualAmount());
				detail.setOccupyAmount(0l);
				detail.setSurplusAmount(0l);
				super.doAdd(detail);
			}else{
				detail.setTotalAmount(detail.getTotalAmount()+sub.getActualAmount());
				detail.setSurplusAmount(detail.getSurplusAmount()+sub.getActualAmount());
				super.doUpdate(detail);
			}
		}
	}



	@Override
	public StockDetailEntity save(StockDetailEntity entity) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public Iterable<StockDetailEntity> save(Iterable<StockDetailEntity> entities) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void deleteAll() throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void delete(String pk) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void delete(String[] pks) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void delete(StockDetailEntity entity) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void delete(Iterable<StockDetailEntity> entities) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public StockDetailEntity doAdd(StockDetailEntity entity) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public Iterable<StockDetailEntity> doAdd(Iterable<StockDetailEntity> entities) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public StockDetailEntity doUpdate(StockDetailEntity entity) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public Iterable<StockDetailEntity> doUpdate(Iterable<StockDetailEntity> entities) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void doDelete(String pk) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	@Override
	public void doDelete(String[] pks) throws ServiceException {
		throw new ServiceException("不允许操作");
	}
	
}