package com.king.modules.info.stockstream;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

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
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<StockStreamEntity, String> getDAO() {
		return dao;
	}

	public List<StockStreamEntity> findsurplusByStockAndMaterial(String stockId, String materialId) {
		return dao.findsurplusByStockAndMaterial(stockId, materialId);
	}
	
	public List<StockStreamEntity> findsurplusBySourceSubIdAndMaterial(String sourceSubId, String materialId) {
		return dao.findsurplusBySourceSubIdAndMaterial(sourceSubId, materialId);
	}

}