package com.king.modules.info.stockdetail;

import com.king.frame.dao.IBaseDAO;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Repository
public interface StockDetailDao extends IBaseDAO<StockDetailEntity,String> {

	@Query("from StockDetailEntity ur where ur.stock.uuid = ?1 and ur.material.uuid = ?2 and ur.status=1")
	StockDetailEntity findByStockAndMaterial(String stockId, String materialId);

	@Query("from StockDetailEntity ur where ur.status=1 and updateType='1'")
	List<StockDetailEntity> listUpdateDetail();

}