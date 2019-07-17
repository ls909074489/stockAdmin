package com.king.modules.info.stockinfo;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 仓库
 * @author null
 * @date 2019-06-17 21:24:38
 */
@Service
@Transactional(readOnly=true)
public class StockInfoService extends BaseServiceImpl<StockInfoEntity,String> {

	@Autowired
	private StockInfoDao dao;
	@Autowired
	private DbUtilsDAO dbDao;

	protected IBaseDAO<StockInfoEntity, String> getDAO() {
		return dao;
	}

	@Override
	public void beforeDelete(StockInfoEntity entity) throws ServiceException {
		Long count=0l;
		try {
			count = dbDao.count("select count(uuid) from yy_order_info where stockid=?", entity.getUuid());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		if(count>0){
			throw new ServiceException("订单已关联仓库，不能删除");
		}
		try {
			count = dbDao.count("select count(uuid) from yy_project_info where stockid=?", entity.getUuid());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		if(count>0){
			throw new ServiceException("项目单已关联仓库，不能删除");
		}
		try {
			count = dbDao.count("select count(uuid) from yy_stock_detail where stock_id=?", entity.getUuid());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		if(count>0){
			throw new ServiceException("库存已关联仓库，不能删除");
		}
		super.beforeDelete(entity);
	}
	
	

}