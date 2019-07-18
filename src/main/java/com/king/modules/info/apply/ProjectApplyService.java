package com.king.modules.info.apply;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 申请消息
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Service
@Transactional(readOnly=true)
public class ProjectApplyService extends BaseServiceImpl<ProjectApplyEntity,String> {

	@Autowired
	private ProjectApplyDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<ProjectApplyEntity, String> getDAO() {
		return dao;
	}

	
	@Transactional
	public void handleApply(String sourceBillId) {
		dao.handleApply(ProjectApplyEntity.HANDLED,sourceBillId, ProjectApplyEntity.APPLYING,ProjectApplyEntity.DEALING);
	}

}