package com.king.modules.info.stockdetail;

import com.king.frame.dao.IBaseDAO;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Repository
public interface StockDetailDao extends IBaseDAO<StockDetailEntity,String> {

	@Query("from StockDetailEntity ur where ur.stock.uuid = ?1 and ur.material.uuid = ?2")
	StockDetailEntity findByStockAndMaterial(String stockId, String materialId);

}