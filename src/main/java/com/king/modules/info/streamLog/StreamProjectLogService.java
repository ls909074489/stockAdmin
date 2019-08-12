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
public class StreamProjectLogService extends BaseServiceImpl<StreamProjectLogEntity,String> {

	@Autowired
	private StreamProjectLogDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<StreamProjectLogEntity, String> getDAO() {
		return dao;
	}

	public List<StreamProjectLogEntity> findByProjectIdAndBillType(String projectId,String billType) {
		return dao.findByProjectId(projectId,billType);
	}

	public List<StreamProjectLogEntity> findByDestStreamId(String destStreamId) {
		return dao.findByDestStreamId(destStreamId);
	}

}