package com.king.modules.info.stockstream;

import com.king.frame.dao.IBaseDAO;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Repository
public interface StockStreamDao extends IBaseDAO<StockStreamEntity,String> {

	@Query("from StockStreamEntity where stock.uuid=? and material.uuid=? and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findsurplusByStockAndMaterial(String stockId, String materialId);

	@Query("from StockStreamEntity where sourceSubId=? and material.uuid=? and surplusAmount>0 order by createtime")
	List<StockStreamEntity> findsurplusBySourceSubIdAndMaterial(String sourceSubId, String materialId);

	@Query("from StockStreamEntity where sourceId=? surplusAmount>0 order by createtime")
	List<StockStreamEntity> findsurplusBySourceId(String sourceId);
}