package com.king.modules.info.streamLog;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-25 17:48:29
 */
@Service
@Transactional(readOnly=true)
public class StreamOrderLogService extends BaseServiceImpl<StreamOrderLogEntity,String> {

	@Autowired
	private StreamOrderLogDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<StreamOrderLogEntity, String> getDAO() {
		return dao;
	}


	public List<StreamOrderLogEntity> findByOrderId(String orderId) {
		return dao.findByOrderId(orderId);
	}

}