package com.king.modules.info.receive;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.info.projectinfo.ProjectInfoEntity;
import com.king.modules.info.projectinfo.ProjectInfoService;
import com.king.modules.info.projectinfo.ProjectSubBaseEntity;
import com.king.modules.info.projectinfo.ProjectSubEntity;
import com.king.modules.info.projectinfo.ProjectSubService;
import com.king.modules.info.stockdetail.StockDetailService;

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
	@Lazy
	@Autowired
	private ProjectSubService subService;
	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private ProjectInfoService mainService;
	@Autowired
	private StockDetailService stockDetailService;
	

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

	
	
	/**
	 * 暂存收货
	 * @param entity
	 * @param subList
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectInfoEntity> tempReceive(ProjectInfoEntity entity, List<ProjectReceiveVo> subList) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		ProjectInfoEntity obj = mainService.getOne(entity.getUuid());
		if(obj.getReceiveType()!=null&&obj.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
			arm.setSuccess(false);
			arm.setMsg("已确认收货，不能保存，请单独添加物料收货明细");
			return arm;
		}
		ProjectSubEntity subEntity = null;
		for(ProjectReceiveVo sub:subList){
			subEntity = subService.getOne(sub.getUuid());
			subEntity.setActualAmount(sub.getActualAmount());
			subEntity.setReceiveTime(sub.getReceiveTime());
			subEntity.setReceiveMemo(sub.getMemo());
		}
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}


	/**
	 * 确认收货
	 * @param entity
	 * @param subList
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectInfoEntity> confirmReceive(ProjectInfoEntity entity,
			List<ProjectReceiveVo> subList) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		ProjectInfoEntity obj = mainService.getOne(entity.getUuid());
		if(obj.getReceiveType()!=null&&obj.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
			arm.setSuccess(false);
			arm.setMsg("已确认收货，不能保存，请单独添加物料收货明细");
			return arm;
		}
		obj.setReceiveType(ProjectInfoEntity.receiveType_yes);
		ProjectSubEntity subEntity = null;
		ProjectReceiveEntity receive = null;
		ProjectSubBaseEntity subBase = null;
		List<ProjectReceiveEntity> receiveList = new ArrayList<>();
		for(ProjectReceiveVo sub:subList){
			subEntity = subService.getOne(sub.getUuid());
			subEntity.setActualAmount(sub.getActualAmount());
			subEntity.setReceiveTime(sub.getReceiveTime());
			subEntity.setReceiveMemo(sub.getMemo());
		
			receive = new ProjectReceiveEntity();
			receive.setMain(obj);
			subBase = new ProjectSubBaseEntity();
			subBase.setUuid(sub.getUuid());
			receive.setSub(subBase);
			receive.setMaterial(subEntity.getMaterial());
			receive.setReceiveAmount(subEntity.getActualAmount());
			receive.setReceiveType(ProjectReceiveEntity.receiveType_add);
			receive.setReceiveTime(sub.getReceiveTime());
			receive.setMemo(sub.getMemo());
			receiveList.add(doAdd(receive));
		}
		stockDetailService.incrStockDetail(obj, receiveList);
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}
	
	
	@Transactional
	public ActionResultModel<ProjectReceiveEntity> saveReceiveLog(ProjectReceiveEntity entity) {
		ProjectSubEntity sub = subService.getOne(entity.getSubId());
		ProjectSubBaseEntity subBase = new ProjectSubBaseEntity();
		subBase.setUuid(sub.getUuid());
		entity.setSub(subBase);
		entity.setMain(sub.getMain());
		entity.setMaterial(sub.getMaterial());
		if(entity.getReceiveTime()==null){
			entity.setReceiveTime(new Date());
		}
		entity = doAdd(entity);
		List<ProjectReceiveEntity> receiveList = new ArrayList<>();
		if(entity.getReceiveType().equals(ProjectReceiveEntity.receiveType_add)){
			sub.setActualAmount(sub.getActualAmount()+entity.getReceiveAmount());
			entity.setReceiveAmount(Math.abs(entity.getReceiveAmount()));
			receiveList.add(entity);
			stockDetailService.incrStockDetail(sub.getMain(), receiveList);
		}else{
			sub.setActualAmount(sub.getActualAmount()-Math.abs(entity.getReceiveAmount()));
			entity.setReceiveAmount(Math.abs(entity.getReceiveAmount())*-1);
			receiveList.add(entity);
			stockDetailService.descStockDetailOnReceive(sub.getMain(), receiveList);
		}
		return new ActionResultModel<>(true, "保存成功");
	}
	
}