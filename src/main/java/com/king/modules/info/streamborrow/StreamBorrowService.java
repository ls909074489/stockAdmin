package com.king.modules.info.streamborrow;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

/**
 * 挪料
 * @author ls2008
 * @date 2019-07-30 16:02:33
 */
@Service
@Transactional(readOnly=true)
public class StreamBorrowService extends BaseServiceImpl<StreamBorrowEntity,String> {

	@Autowired
	private StreamBorrowDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<StreamBorrowEntity, String> getDAO() {
		return dao;
	}
	

	public List<StreamBorrowEntity> findBorrowByToProject(String projectToId) {
		return dao.findBorrowByToProject(projectToId,StreamBorrowEntity.BILLSTATE_NOT_RETURN);
	}

}