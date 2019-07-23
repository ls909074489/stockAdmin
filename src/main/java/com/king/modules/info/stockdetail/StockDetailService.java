package com.king.modules.info.stockdetail;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.orderinfo.OrderInfoEntity;
import com.king.modules.info.orderinfo.OrderSubEntity;
import com.king.modules.info.projectinfo.ProjectInfoEntity;
import com.king.modules.info.projectinfo.ProjectSubEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;

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
//	@Autowired
//	private OrderSubService orderSubService;
	@Autowired
	private StockStreamService stockStreamService;
	
	
	protected IBaseDAO<StockDetailEntity, String> getDAO() {
		return dao;
	}
	
	
//	public StockInfoEntity getStockByOrderType(String orderType){
//		StockInfoEntity stock = new StockInfoEntity();
//		stock.setUuid(ParameterUtil.getParamValue("defaultStock"));
//		return stock;
//	}
	
	public StockDetailEntity findByStockAndMaterial(String stockId, String materialId) {
		return dao.findByStockAndMaterial(stockId, materialId);
	}
	
	
	@Transactional
	public void incrStockDetail(OrderInfoEntity orderInfo,List<OrderSubEntity> subList){
		StockStreamEntity stream = new StockStreamEntity();
		
		Long totalBefore = 0l;
		Long occupyBefore = 0l;
		Long surplusBefore = 0l; 
		StockBaseEntity stockBase = orderInfo.getStock();
		for(OrderSubEntity sub:subList){
			StockDetailEntity detail  = findByStockAndMaterial(stockBase.getUuid(),sub.getMaterial().getUuid());
			
			stream = new StockStreamEntity();
			stream.setSourceId(orderInfo.getUuid());
			stream.setSourceBillCode(orderInfo.getCode());
			stream.setSourceSubId(sub.getUuid());
			stream.setStock(stockBase);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(sub.getMaterial().getUuid());
			stream.setMaterial(material);
			stream.setWarningTime(sub.getWarningTime());
			stream.setWarningType(sub.getWarningType());
			stream.setSurplusAmount(sub.getActualAmount());
			
			if(detail==null){
				detail = new StockDetailEntity();
				detail.setStock(stockBase);
				detail.setMaterial(sub.getMaterial());
				detail.setTotalAmount(sub.getActualAmount());
				detail.setOccupyAmount(0l);
				detail.setSurplusAmount(sub.getActualAmount());
				
				stream.setTotalBefore(0l);
				stream.setOccupyBefore(0l);
				stream.setSurplusBefore(0l);
				stream.setTotalAfter(detail.getTotalAmount());
				stream.setOccupyAfter(detail.getOccupyAmount());
				stream.setSurplusAfter(detail.getSurplusAmount());
				stream.setActualAmount(sub.getActualAmount());
				
				super.doAdd(detail);
			}else{
				totalBefore = detail.getTotalAmount();
				occupyBefore = detail.getOccupyAmount();
				surplusBefore = detail.getSurplusAmount(); 
				
				detail.setTotalAmount(detail.getTotalAmount()+sub.getActualAmount());
				detail.setSurplusAmount(detail.getSurplusAmount()+sub.getActualAmount());
				
				stream.setTotalBefore(totalBefore);
				stream.setOccupyBefore(occupyBefore);
				stream.setSurplusBefore(surplusBefore);
				stream.setTotalAfter(detail.getTotalAmount());
				stream.setOccupyAfter(detail.getOccupyAmount());
				stream.setSurplusAfter(detail.getSurplusAmount());
				stream.setActualAmount(sub.getActualAmount());
				
				super.doUpdate(detail);
			}
			stream.setOperType(StockStreamEntity.IN_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
	}

	@Transactional
	public void descStockDetail(ProjectInfoEntity projectInfo,List<ProjectSubEntity> subList){
		StockBaseEntity stock = projectInfo.getStock();//getStockByOrderType(projectInfo.getBilltype());
		StockStreamEntity stream = new StockStreamEntity();
		stream.setSourceId(projectInfo.getUuid());
		stream.setSourceBillCode(projectInfo.getCode());
		
		Long totalBefore = 0l;
		Long occupyBefore = 0l;
		Long surplusBefore = 0l; 
		
		long actualAmount = 0l;
		for(ProjectSubEntity sub:subList){
			StockDetailEntity detail  = findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			
			stream.setStock(stock);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(sub.getMaterial().getUuid());
			stream.setMaterial(material);
			stream.setSourceSubId(sub.getUuid());
			
			if(detail==null){
				throw new ServiceException("库存不存在物料"+sub.getMaterial().getCode());
			}else{
				totalBefore = detail.getTotalAmount();
				occupyBefore = detail.getOccupyAmount();
				surplusBefore = detail.getSurplusAmount(); 
				
				actualAmount = sub.getActualAmount();
				
				if(surplusBefore<actualAmount){
					throw new ServiceException("物料"+sub.getMaterial().getCode()+"库存不足");
				}
				detail.setTotalAmount(detail.getTotalAmount()-actualAmount);
				detail.setSurplusAmount(detail.getSurplusAmount()-actualAmount);
				
				stream.setTotalBefore(totalBefore);
				stream.setOccupyBefore(occupyBefore);
				stream.setSurplusBefore(surplusBefore);
				stream.setTotalAfter(detail.getTotalAmount());
				stream.setOccupyAfter(detail.getOccupyAmount());
				stream.setSurplusAfter(detail.getSurplusAmount());
				stream.setActualAmount(actualAmount);
				
				super.doUpdate(detail);
				
				//减少流水
				List<StockStreamEntity> streamList = stockStreamService.findsurplusByStockAndMaterial
						(stock.getUuid(),sub.getMaterial().getUuid());
				for(StockStreamEntity ss:streamList){
					if(ss.getSurplusAmount()>=actualAmount){
						//计算流水剩余的数量
						ss.setSurplusAmount(ss.getSurplusAmount()-actualAmount);
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)
								&&ss.getSurplusAmount()==0){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						break;
					}else{
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						ss.setSurplusAmount(0l);
						actualAmount =actualAmount - ss.getSurplusAmount();
					}
				}
			}
			stream.setOperType(StockStreamEntity.OUT_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
	}
	

	@Override
	public StockDetailEntity save(StockDetailEntity entity) throws ServiceException {
//		throw new ServiceException("不允许操作");
		return super.save(entity);
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