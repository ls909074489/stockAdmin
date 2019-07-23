package com.king.modules.info.receive;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 收货
 * @author ls2008
 * @date 2019-07-23 16:59:39
 */
@Service
@Transactional(readOnly=true)
public class ProjectReceiveService extends BaseServiceImpl<ProjectReceiveEntity,String> {

	@Autowired
	private ProjectReceiveDao dao;
	@Autowired
	private DbUtilsDAO dbDao;

	protected IBaseDAO<ProjectReceiveEntity, String> getDAO() {
		return dao;
	}

	
	public List<ProjectReceiveEntity> findByMainSql(String mainId){
		Object [] params  = {mainId};
		try {
			StringBuilder sql = new StringBuilder("select uuid,creator,creatorname,createtime,mainid mainId,subid subId,");
			sql.append("receive_amount receiveAmount,receive_type receiveType from yy_project_receive where mainid=? order by subid,createtime");
			return dbDao.find(ProjectReceiveEntity.class,sql.toString(), params);
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return new ArrayList<ProjectReceiveEntity>();
	}
	
	public List<ProjectReceiveEntity> findBySubSql(String subId){
		Object [] params  = {subId};
		try {
			StringBuilder sql = new StringBuilder("select uuid,creator,creatorname,createtime,mainid mainId,subid subId,");
			sql.append("receive_amount receiveAmount,receive_type receiveType from yy_project_receive where subid=? order by createtime");
			return dbDao.find(ProjectReceiveEntity.class,sql.toString(), params);
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return new ArrayList<ProjectReceiveEntity>();
	}
	
}