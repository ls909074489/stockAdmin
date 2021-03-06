package com.king.modules.info.stockstream;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.king.frame.dao.IBaseDAO;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Repository
public interface StockStreamDao extends IBaseDAO<StockStreamEntity,String> {

	@Query("from StockStreamEntity where stock.uuid=? and material.uuid=? and status=1 and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findsurplusByStockAndMaterial(String stockId, String materialId);

	@Query("from StockStreamEntity where projectSubId=? and material.uuid=? and status=1 and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findsurplusByProjectSubIdAndMaterial(String sourceSubId, String materialId);

	@Query("from StockStreamEntity where sourceId=? and operType=? and status=1 and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findSurplusBySourceIdAndOperType(String sourceId,String operType);
	
	@Query("from StockStreamEntity where projectSubId=? and operType=? and status=1 and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findSurplusBySubIdIn(String subId,String operType);
	
	@Query("from StockStreamEntity where sourceId in ?1 and operType=?2 and status=1 and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findSurplusAllBySourceIdsIn(List<String> sourceIdList,String operType);
	
//	@Query("from StockStreamEntity where sourceId=? and operType=? and status=1 order by createtime")
//	List<StockStreamEntity> findBySourceIdAndOperType(String sourceId,String operType);

	@Modifying
	@Query("update StockStreamEntity u set u.status=0 where u.sourceId=? and u.operType=?")
	void delBySourceIdAndOperType(String sourceId, String operType);

	
//	@Query("from StockStreamEntity where stock.uuid=? and material.uuid=? and status=1 and billType=? and surplusAmount>0 order by createtime")
	@Query("from StockStreamEntity where stock.uuid=? and material.uuid=? and status=1 and showType='1' and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findOrderByStockAndMaterial(String stockId, String materialId);

	
	@Query("from StockStreamEntity where projectSubId in ?1 and status=1")
	List<StockStreamEntity> findByProjectSubIds(List<String> subIdList);

	@Modifying
	@Query("update StockStreamEntity u set u.sourceBillCode=?1 where u.sourceId=?2")
	void updateSourceBillCode(String sourceBillCode,String sourceBillId);

	
	@Query("from StockStreamEntity where stockDetailId in ?1 and surplusAmount>0 and showType='1' and status=1")
	List<StockStreamEntity> findSurplusByDetailIds(List<String> detailIdList);
	
	@Query("from StockStreamEntity where sourceId=? and status=1 order by createtime")
	List<StockStreamEntity> findBySourceId(String sourceId);

	@Query("from StockStreamEntity where projectSubId in ?1 and billType=?2 and status=1")
	List<StockStreamEntity> findReceiveByProjectSubIds(List<String> subIdList, String billtypeReceive);

}