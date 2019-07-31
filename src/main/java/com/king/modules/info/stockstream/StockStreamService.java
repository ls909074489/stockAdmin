package com.king.modules.info.stockstream;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.stockdetail.StockDetailService;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Service
@Transactional(readOnly=true)
public class StockStreamService extends BaseServiceImpl<StockStreamEntity,String> {

	@Autowired
	private StockStreamDao dao;
	@Autowired
	private StockDetailService stockDetailService;

	protected IBaseDAO<StockStreamEntity, String> getDAO() {
		return dao;
	}

	public List<StockStreamEntity> findsurplusByStockAndMaterial(String stockId, String materialId) {
		return dao.findsurplusByStockAndMaterial(stockId, materialId);
	}
	
	public List<StockStreamEntity> findsurplusByProjectSubIdAndMaterial(String sourceSubId, String materialId) {
		return dao.findsurplusByProjectSubIdAndMaterial(sourceSubId, materialId);
	}

	/**
	 * 入库的流水-剩余数量大于0的
	 * @param sourceId
	 * @return
	 */
	public List<StockStreamEntity> findSurplusBySourceIdIn(String sourceId) {
		return dao.findSurplusBySourceIdAndOperType(sourceId,StockStreamEntity.IN_STOCK);
	}
	
	public List<StockStreamEntity> findSurplusAllBySourceIdsIn(List<String> sourceIdList) {
		return dao.findSurplusAllBySourceIdsIn(sourceIdList);
	}
	
	/**
	 * 入库的流水
	 * @param sourceId
	 * @return
	 */
	public List<StockStreamEntity> findBySourceIdAndOperType(String sourceId,String operType) {
		return dao.findBySourceIdAndOperType(sourceId,operType);//StockStreamEntity.IN_STOCK
	}

	@Transactional
	public void delBySourceIdAndOperType(String sourceId, String operType) {
		dao.delBySourceIdAndOperType(sourceId,operType);
	}

	public List<StockStreamEntity> findOrderByStockAndMaterial(String stockId, String materialId) {
		return dao.findOrderByStockAndMaterial(stockId, materialId,StockStreamEntity.BILLTYPE_ORDER);
	}
	
	
	@Transactional
	public ActionResultModel<StockStreamEntity> saveProjectBorrow(String fromStreamId, String toSubId,
			Long actualAmount) {
		stockDetailService.borrowProjectMaterial(fromStreamId, toSubId, actualAmount);
		return new ActionResultModel<>(true, "操作成功");
	}

	
	

}