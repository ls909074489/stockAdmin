package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * OrderSubService
 * 
 * @author liusheng
 *
 */
@Service
@Transactional(readOnly = true)
public class ProjectSubBarcodeService extends BaseServiceImpl<ProjectSubBarcodeEntity, String> {
	
	private static Logger logger = LoggerFactory.getLogger(ProjectSubBarcodeService.class);


	@Autowired
	private ProjectSubBarcodeDao dao;
	@Lazy
	@Autowired
	private ProjectInfoService mainService;
	@Lazy
	@Autowired
	private ProjectSubService subService;
	@Autowired
	private DbUtilsDAO dbDao;


	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	
	@Transactional(readOnly = true)
	public List<ProjectSubBarcodeEntity> findBySubId(String subId) {
		return dao.findBySubId(subId);
	}


	public List<ProjectSubBarcodeEntity> findByProjectIds(List<String> projectIds) {
		return dao.findByProjectIds(projectIds);
	}


	public List<ProjectSubBarcodeEntity> findLikeBarcode(String projectId,String barcode) {
		
		if(StringUtils.isEmpty(projectId)){
			return dao.findLikeBarcode("%"+barcode+"%");
		}else{
			return dao.findProjectLikeBarcode(projectId, "%"+barcode+"%");
		}
	}
	
	/**
	 * 查询条码为空
	 * @param projectId
	 * @return
	 */
	public List<ProjectSubBarcodeEntity> findBarcodeNull(String projectId){
		List<ProjectSubBarcodeEntity> voList = new ArrayList<ProjectSubBarcodeEntity>();
		StringBuilder sql = new StringBuilder();
		Object [] params = {projectId};
		sql.append("select uuid,barcode,subid subId,stream_id streamId from yy_project_barcode where mainid=? and status=1 and barcode is null order by createtime desc ");
		try {
			voList =  dbDao.find(ProjectSubBarcodeEntity.class, sql.toString(),params);
		} catch (DAOException e) {
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + getTrace(e));
			e.printStackTrace();
		}
		return voList;
	}


	/**
	 * 查询条码重复
	 * @return
	 */
	public List<ProjectSubBarcodeEntity> findBarcodeRepeat() {
		List<ProjectSubBarcodeEntity> voList = new ArrayList<ProjectSubBarcodeEntity>();
		StringBuilder sql = new StringBuilder();
		sql.append("select uuid,barcode,mainid mainId,subid subId,stream_id streamId from yy_project_barcode where barcode in(");
		sql.append("select barcode from yy_project_barcode where status=1 and barcode is not null group by barcode having count(barcode)>1)");
		try {
			voList =  dbDao.find(ProjectSubBarcodeEntity.class, sql.toString());
		} catch (DAOException e) {
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + getTrace(e));
			e.printStackTrace();
		}
		return voList;
	}


	public List<ProjectSubBarcodeEntity> findBySubIdAndBarcode(String subId, String newBarcode) {
		return dao.findBySubIdAndBarcode(subId,newBarcode);
	}
}
