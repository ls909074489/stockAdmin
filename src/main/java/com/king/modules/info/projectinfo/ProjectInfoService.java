package com.king.modules.info.projectinfo;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Service
@Transactional(readOnly=true)
public class ProjectInfoService extends BaseServiceImpl<ProjectInfoEntity,String> {

	@Autowired
	private ProjectInfoDao dao;
	//@Autowired
	//private DbUtilsDAO dbDao;

	protected IBaseDAO<ProjectInfoEntity, String> getDAO() {
		return dao;
	}

}