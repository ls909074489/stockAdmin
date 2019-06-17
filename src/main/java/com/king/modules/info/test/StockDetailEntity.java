package com.king.modules.info.test;

import com.king.modules.info.material.MaterialEntity;
import com.king.modules.info.stockinfo.StockInfoEntity;

public class StockDetailEntity {

	private StockInfoEntity stock;
	
	private MaterialEntity material;
	
	private Long totalAmount;//总数量
	
	private Long occupyAmount;//预占数量
	
	private Long surplusAmount;//剩余数量
	
}
