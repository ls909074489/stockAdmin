package com.king.modules.info.stockdetail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.orderinfo.OrderInfoEntity;
import com.king.modules.info.orderinfo.OrderSubEntity;
import com.king.modules.info.projectinfo.ProjectInfoEntity;
import com.king.modules.info.projectinfo.ProjectSubEntity;
import com.king.modules.info.receive.ProjectReceiveEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;
import com.king.modules.info.streamLog.StreamLogEntity;
import com.king.modules.info.streamLog.StreamLogService;

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
	@Lazy
	@Autowired
	private StockStreamService stockStreamService;
	@Autowired
	private StreamLogService streamLogService;
	
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
		
		StockBaseEntity stockBase = orderInfo.getStock();
		for(OrderSubEntity sub:subList){
			StockDetailEntity detail  = findByStockAndMaterial(stockBase.getUuid(),sub.getMaterial().getUuid());
			
			stream = new StockStreamEntity();
			stream.setBillType(StockStreamEntity.BILLTYPE_ORDER);
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
				detail.setActualAmount(detail.getSurplusAmount()-detail.getOccupyAmount());
				
				stream.setTotalAmount(sub.getActualAmount());
				stream.setSurplusAmount(sub.getActualAmount());
				stream.setOccupyAmount(sub.getActualAmount());
				stream.setActualAmount(sub.getActualAmount());
				
				super.doAdd(detail);
			}else{
				
				detail.setTotalAmount(detail.getTotalAmount()+sub.getActualAmount());
				detail.setSurplusAmount(detail.getSurplusAmount()+sub.getActualAmount());
				detail.setOccupyAmount(detail.getOccupyAmount()+sub.getActualAmount());
				detail.setActualAmount(detail.getSurplusAmount()-detail.getOccupyAmount());
				

				stream.setTotalAmount(sub.getActualAmount());
				stream.setSurplusAmount(sub.getActualAmount());
				stream.setOccupyAmount(sub.getActualAmount());
				stream.setActualAmount(sub.getActualAmount());
				
				super.doUpdate(detail);
			}
			stream.setOperType(StockStreamEntity.IN_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
	}
	
	
	@Transactional
	public void incrStockDetail(ProjectInfoEntity projectInfo,List<ProjectReceiveEntity> receiveList){
		StockStreamEntity stream = new StockStreamEntity();
		
		StockBaseEntity stockBase = projectInfo.getStock();
		for(ProjectReceiveEntity sub:receiveList){
			StockDetailEntity detail  = findByStockAndMaterial(stockBase.getUuid(),sub.getMaterial().getUuid());
			
			stream = new StockStreamEntity();
			stream.setBillType(StockStreamEntity.BILLTYPE_RECEIVE);
			stream.setSourceId(projectInfo.getUuid());
			stream.setSourceBillCode(projectInfo.getCode());
			stream.setSourceSubId(sub.getUuid());
			stream.setProjectSubId(sub.getSub().getUuid());
			stream.setStock(stockBase);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(sub.getMaterial().getUuid());
			stream.setMaterial(material);
			stream.setWarningTime(sub.getWarningTime());
			stream.setWarningType(StockStreamEntity.WARNINGTYPE_NO_NEED);
			stream.setSurplusAmount(sub.getReceiveAmount());
			
			if(detail==null){
				detail = new StockDetailEntity();
				detail.setStock(stockBase);
				detail.setMaterial(sub.getMaterial());
				detail.setTotalAmount(sub.getReceiveAmount());
				detail.setSurplusAmount(sub.getReceiveAmount());
				detail.setOccupyAmount(sub.getReceiveAmount());
				detail.setActualAmount(0l);//可用为0
				
				super.doAdd(detail);
			}else{
				detail.setTotalAmount(detail.getTotalAmount()+sub.getReceiveAmount());
				detail.setSurplusAmount(detail.getSurplusAmount()+sub.getReceiveAmount());
				detail.setOccupyAmount(detail.getOccupyAmount()+sub.getReceiveAmount());
				detail.setActualAmount(detail.getSurplusAmount()-detail.getOccupyAmount());
				super.doUpdate(detail);
			}
			stream.setTotalAmount(sub.getReceiveAmount());
			stream.setSurplusAmount(sub.getReceiveAmount());
			stream.setOccupyAmount(sub.getReceiveAmount());
			stream.setActualAmount(0l);
			stream.setOperType(StockStreamEntity.IN_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
	}
	
	

	@Transactional
	public void descStockDetail(ProjectInfoEntity projectInfo,List<ProjectSubEntity> subList){
		StockBaseEntity stock = projectInfo.getStock();//getStockByOrderType(projectInfo.getBilltype());
		StockStreamEntity stream = null;
		
		//减少流水
		List<StockStreamEntity> streamList = stockStreamService.findSurplusBySourceIdIn(projectInfo.getUuid());
		Map<String,List<StockStreamEntity>> streamMap = changeToMap(streamList);
		List<StockStreamEntity> subStreamList = null;
		List<StreamLogEntity> logList = new ArrayList<>();
		StreamLogEntity log = null;
		for(ProjectSubEntity sub:subList){
			StockDetailEntity detail  = findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			
			Long subAmount = Math.abs(sub.getActualAmount());
			
			stream = new StockStreamEntity();
			stream.setSourceId(projectInfo.getUuid());
			stream.setSourceBillCode(projectInfo.getCode());
			stream.setSourceSubId(sub.getUuid());
			stream.setProjectSubId(sub.getUuid());
			stream.setBillType(StockStreamEntity.BILLTYPE_PROJECT);
			stream.setStock(stock);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(sub.getMaterial().getUuid());
			stream.setMaterial(material);
			stream.setSourceSubId(sub.getUuid());
			
			if(detail==null){
				throw new ServiceException("库存不存在物料"+sub.getMaterial().getCode());
			}else{
				subStreamList = streamMap.get(sub.getUuid());
				if(CollectionUtils.isEmpty(subStreamList)){
					throw new ServiceException("库存物料"+sub.getMaterial().getCode()+"流水不存在");
				}
				if(detail.getSurplusAmount()<sub.getActualAmount()){
					throw new ServiceException("物料"+sub.getMaterial().getCode()+"库存不足");
				}
				
				detail.setTotalAmount(detail.getTotalAmount()-subAmount);
				detail.setSurplusAmount(detail.getSurplusAmount()-subAmount);
				detail.setOccupyAmount(detail.getOccupyAmount()-subAmount);
				detail.setActualAmount(detail.getSurplusAmount()-detail.getOccupyAmount());
				super.doUpdate(detail);
				for(StockStreamEntity ss:subStreamList){
					log = new StreamLogEntity();
					log.setProjectId(projectInfo.getUuid());
					log.setProjectSubId(sub.getUuid());
					log.setStreamId(ss.getUuid());
					if(ss.getSurplusAmount()>=subAmount){
						//计算流水剩余的数量
						ss.setSurplusAmount(ss.getSurplusAmount()-subAmount);
						ss.setOccupyAmount(ss.getOccupyAmount()-subAmount);
						ss.setActualAmount(ss.getSurplusAmount()-ss.getOccupyAmount());
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)
								&&ss.getSurplusAmount()==0){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						log.setActualAmount(subAmount);
						logList.add(log);
						subAmount = 0l;
						break;
					}else{
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						subAmount =subAmount - ss.getSurplusAmount();
						log.setActualAmount(ss.getSurplusAmount());
						logList.add(log);
						ss.setSurplusAmount(0l);
						ss.setOccupyAmount(0l);
						ss.setActualAmount(0l);
					}
				}
				if(subAmount>0){
					throw new ServiceException("物料"+sub.getMaterial().getCode()+"流水不足");
				}
			}
			Long subAmountOut = Math.abs(sub.getActualAmount())*-1;
			stream.setTotalAmount(subAmountOut);
			stream.setSurplusAmount(subAmountOut);
			stream.setOccupyAmount(subAmountOut);
			stream.setActualAmount(0l);
			stream.setOperType(StockStreamEntity.OUT_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
		streamLogService.doAdd(logList);
	}
	
	
	private Map<String, List<StockStreamEntity>> changeToMap(List<StockStreamEntity> streamList) {
		Map<String,List<StockStreamEntity>> map = new HashMap<String, List<StockStreamEntity>>();
		if(CollectionUtils.isNotEmpty(streamList)){
			List<StockStreamEntity> list = null;
			for(StockStreamEntity s:streamList){
				list = map.get(s.getProjectSubId());
				if(list==null){
					list = new ArrayList<StockStreamEntity>();
				}
				list.add(s);
				map.put(s.getProjectSubId(), list);
			}
		}
		return map;
	}


	@Transactional
	public void descStockDetailOnReceive(ProjectInfoEntity projectInfo,List<ProjectReceiveEntity> receiveList){
		StockBaseEntity stock = projectInfo.getStock();//getStockByOrderType(projectInfo.getBilltype());
		StockStreamEntity stream = null;
		
		for(ProjectReceiveEntity sub:receiveList){
			StockDetailEntity detail  = findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			
			stream = new StockStreamEntity();
			stream.setBillType(StockStreamEntity.BILLTYPE_RECEIVE);
			stream.setSourceId(projectInfo.getUuid());
			stream.setSourceBillCode(projectInfo.getCode());
			stream.setSourceSubId(sub.getUuid());
			stream.setProjectSubId(sub.getSub().getUuid());
			stream.setStock(stock);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(sub.getMaterial().getUuid());
			stream.setMaterial(material);
			
			if(detail==null){
				throw new ServiceException("库存不存在物料"+sub.getMaterial().getCode());
			}else{
				//减少流水
				List<StockStreamEntity> streamList = stockStreamService.findsurplusByProjectSubIdAndMaterial
						(sub.getSub().getUuid(),sub.getMaterial().getUuid());
				
				if(CollectionUtils.isEmpty(streamList)){
					throw new ServiceException("库存物料"+sub.getMaterial().getCode()+"流水不存在");
				}
				
				Long subAmount = Math.abs(sub.getReceiveAmount());
				detail.setTotalAmount(detail.getTotalAmount()-subAmount);
				detail.setSurplusAmount(detail.getSurplusAmount()-subAmount);
				detail.setOccupyAmount(detail.getOccupyAmount()-subAmount);
				detail.setActualAmount(detail.getSurplusAmount()-detail.getOccupyAmount());
				super.doUpdate(detail);
				
				stream.setTotalAmount(subAmount*-1);
				stream.setSurplusAmount(subAmount*-1);
				stream.setOccupyAmount(subAmount*-1);
				stream.setActualAmount(0l);
				for(StockStreamEntity ss:streamList){
					if(ss.getSurplusAmount()>= subAmount ){
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)
								&&ss.getSurplusAmount()==0){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						//计算流水剩余的数量
						ss.setSurplusAmount(ss.getSurplusAmount()-subAmount);
						ss.setOccupyAmount(ss.getOccupyAmount()-subAmount);
						ss.setActualAmount(ss.getSurplusAmount()-ss.getOccupyAmount());
						subAmount = 0l;
						break;
					}else{
						if(ss.getWarningType().equals(StockStreamEntity.WARNINGTYPE_BE_NEED)){
							ss.setWarningType(StockStreamEntity.WARNINGTYPE_HAS_USE);
						}
						ss.setSurplusAmount(0l);
						ss.setOccupyAmount(0l);
						ss.setActualAmount(0l);
						subAmount =subAmount - ss.getSurplusAmount();
					}
				}
				if(subAmount>0){
					throw new ServiceException("物料"+sub.getMaterial().getCode()+"流水不足");
				}
			}
			stream.setOperType(StockStreamEntity.OUT_STOCK);
			stockStreamService.doAdd(stream);//添加库存流水
		}
	}
	
	@Transactional
	public void unApproveStockDetail(ProjectInfoEntity entity, List<ProjectSubEntity> subList) {
		List<StreamLogEntity> logList = streamLogService.findByProjectId(entity.getUuid());
		if(CollectionUtils.isNotEmpty(logList)){
			List<StockStreamEntity> streamList = stockStreamService.findBySourceIdAndOperType(entity.getUuid(),StockStreamEntity.IN_STOCK);
			boolean hasStream =false;
			for(StreamLogEntity log:logList){
				hasStream =false;
				for(StockStreamEntity stream:streamList){
					if(stream.getUuid().equals(log.getStreamId())){
						StockDetailEntity detail  = findByStockAndMaterial(stream.getStock().getUuid(),stream.getMaterial().getUuid());
						detail.setTotalAmount(detail.getTotalAmount()+log.getActualAmount());
						detail.setSurplusAmount(detail.getSurplusAmount()+log.getActualAmount());
 						detail.setOccupyAmount(detail.getOccupyAmount()+log.getActualAmount());
						
// 						stream.setTotalAmount(stream.getTotalAmount()+log.getActualAmount());
						stream.setSurplusAmount(stream.getSurplusAmount()+log.getActualAmount());
						stream.setOccupyAmount(stream.getOccupyAmount()+log.getActualAmount());
						stream.setActualAmount(stream.getSurplusAmount()-stream.getOccupyAmount());
						
//						stockStreamService.delete(stream);
						hasStream =true;
						break;
					}
				}
				if(hasStream){
					log.setStatus(0);//标志删除
				}
			}
			stockStreamService.delBySourceIdAndOperType(entity.getUuid(),StockStreamEntity.OUT_STOCK);
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