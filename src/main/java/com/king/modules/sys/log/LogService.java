package com.king.modules.sys.log;

import java.util.Date;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.utils.DateUtil;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

@Service
@Transactional
public class LogService extends BaseServiceImpl<LogEntity, String> {
	@Autowired
	private LogDAO dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	/**
	 * 
	 */
	@Override
	public LogEntity save(LogEntity entity) throws ServiceException {
		return super.save(entity);
	}

	@Override
	public Iterable<LogEntity> save(Iterable<LogEntity> entities) throws ServiceException {
		return super.save(entities);
	}

	/**
	 * 删除 n 天前日志
	 */
	public void deleteLog(int nday) {
		Date date = DateUtil.getDateBefore(new Date(), nday);
		dao.deleteByTime(date);
	}

}
