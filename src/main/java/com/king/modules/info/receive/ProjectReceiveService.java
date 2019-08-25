package com.king.modules.info.receive;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.enums.BillStatus;
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
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;

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
	@Autowired
	private StockStreamService streamService;
	

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

	public List<ProjectReceiveEntity> findBySubId(String subId){
		return dao.findBySubId(subId);
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
//		ProjectInfoEntity obj = mainService.getOne(entity.getUuid());
//		if(obj.getReceiveType()!=null&&obj.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
//			arm.setSuccess(false);
//			arm.setMsg("已确认收货，不能保存，请单独添加物料收货明细");
//			return arm;
//		}
		ProjectSubEntity subEntity = null;
		for(ProjectReceiveVo sub:subList){
			subEntity = subService.getOne(sub.getUuid());
			if(subEntity.getSubReceiveType()!=null&&subEntity.getSubReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
				//已收货
				continue;
			}
			subEntity.setActualAmount(sub.getActualAmount());
			subEntity.setReceiveTime(sub.getReceiveTime());
			subEntity.setWarningTime(sub.getWarningTime());
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
//	@Deprecated
//	@Transactional
//	public ActionResultModel<ProjectInfoEntity> confirmReceive(ProjectInfoEntity entity,
//			List<ProjectReceiveVo> subList) {
//		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
//		ProjectInfoEntity obj = mainService.getOne(entity.getUuid());
////		if(obj.getReceiveType()!=null&&obj.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
////			arm.setSuccess(false);
////			arm.setMsg("已确认收货，不能保存，请单独添加物料收货明细");
////			return arm;
////		}
//		obj.setReceiveType(ProjectInfoEntity.receiveType_yes);
//		ProjectSubEntity subEntity = null;
//		ProjectReceiveEntity receive = null;
//		ProjectSubBaseEntity subBase = null;
//		List<ProjectReceiveEntity> receiveList = new ArrayList<>();
//		for(ProjectReceiveVo sub:subList){
//			subEntity = subService.getOne(sub.getUuid());
//			if(subEntity.getSubReceiveType()!=null&&subEntity.getSubReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
//				//已收货
//				continue;
//			}
//			
//			subEntity.setActualAmount(sub.getActualAmount());
//			subEntity.setReceiveTime(sub.getReceiveTime());
//			subEntity.setReceiveMemo(sub.getMemo());
//			subEntity.setWarningTime(sub.getWarningTime());
//		
//			receive = new ProjectReceiveEntity();
//			receive.setMain(obj);
//			subBase = new ProjectSubBaseEntity();
//			subBase.setUuid(sub.getUuid());
//			receive.setSub(subBase);
//			receive.setMaterial(subEntity.getMaterial());
//			receive.setReceiveAmount(subEntity.getActualAmount());
//			receive.setReceiveType(ProjectReceiveEntity.receiveType_add);
//			receive.setReceiveTime(sub.getReceiveTime());
//			receive.setMemo(sub.getMemo());
//			receive.setWarningTime(sub.getWarningTime());
//			receiveList.add(doAdd(receive));
//		}
//		stockDetailService.incrStockDetail(obj, receiveList,true);
//		arm.setSuccess(true);
//		arm.setMsg("操作成功");
//		return arm;
//	}
	
	
//	@Transactional
//	public ActionResultModel<ProjectInfoEntity> saveSubReceive(ProjectReceiveVo sub) {
//		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
//		ProjectSubEntity subEntity = subService.getOne(sub.getUuid());
//		if(subEntity.getSubReceiveType()!=null&&subEntity.getSubReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
//			arm.setSuccess(false);
//			arm.setMsg("已确认收货，不能保存，请单独添加物料收货明细");
//			return arm;
//		}
//
//		List<ProjectReceiveEntity>  receiveList = findBySubId(sub.getUuid());
//		if(CollectionUtils.isEmpty(receiveList)){
//			receiveList = new ArrayList<>();
//			ProjectSubBaseEntity subBase = null;
//			subEntity.setActualAmount(sub.getActualAmount());
//			subEntity.setReceiveTime(sub.getReceiveTime());
//			subEntity.setReceiveMemo(sub.getMemo());
//			subEntity.setWarningTime(sub.getWarningTime());
//		
//			ProjectReceiveEntity receive = new ProjectReceiveEntity();
//			receive.setMain(subEntity.getMain());
//			subBase = new ProjectSubBaseEntity();
//			subBase.setUuid(sub.getUuid());
//			receive.setSub(subBase);
//			receive.setMaterial(subEntity.getMaterial());
//			receive.setReceiveAmount(subEntity.getActualAmount());
//			receive.setReceiveType(ProjectReceiveEntity.receiveType_add);
//			receive.setReceiveTime(sub.getReceiveTime());
//			receive.setMemo(sub.getMemo());
//			receive.setWarningTime(sub.getWarningTime());
//			
//			receiveList.add(doAdd(receive));
//			
//			if(subEntity.getActualAmount()>=subEntity.getPlanAmount()){
//				subEntity.setSubReceiveType(ProjectInfoEntity.receiveType_yes);
//			}
//			
//			stockDetailService.incrStockDetail(subEntity.getMain(), receiveList,true);
//		}else if(receiveList.size()==1){
//			subEntity.setActualAmount(sub.getActualAmount());
//			subEntity.setReceiveTime(sub.getReceiveTime());
//			subEntity.setReceiveMemo(sub.getMemo());
//			subEntity.setWarningTime(sub.getWarningTime());
//			if(subEntity.getActualAmount()>=subEntity.getPlanAmount()){
//				subEntity.setSubReceiveType(ProjectInfoEntity.receiveType_yes);
//			}
//			
//			ProjectReceiveEntity receiveEntity = receiveList.get(0);
//			List<String> subIdList = new ArrayList<>();
//			subIdList.add(sub.getUuid());
//			List<StockStreamEntity> streamList = streamService.findReceiveByProjectSubIds(subIdList);
//			long diffVal = sub.getActualAmount()-receiveEntity.getReceiveAmount();
//			if(CollectionUtils.isNotEmpty(streamList)){
//				if(diffVal>0){
//					StockStreamEntity stream = streamList.get(0);
//					stream.setTotalAmount(stream.getTotalAmount()+diffVal);
//					stream.setSurplusAmount(stream.getSurplusAmount()+diffVal);
//					stream.setOccupyAmount(stream.getOccupyAmount()+diffVal);
//					stream.setActualAmount(0l);
//				}else if(diffVal==0){
//					//相等不改
//				}else{
//					StockStreamEntity stream = streamList.get(0);
//					if(stream.getSurplusAmount()>=sub.getActualAmount()){
//						stream.setTotalAmount(stream.getTotalAmount()+diffVal);
//						stream.setSurplusAmount(stream.getSurplusAmount()+diffVal);
//						stream.setOccupyAmount(stream.getOccupyAmount()+diffVal);
//						stream.setActualAmount(0l);
//					}else{
//						throw new ServiceException("收货流水剩余数量不足");
//					}
//				}
//			}
//			receiveEntity.setReceiveAmount(sub.getActualAmount());
//			receiveEntity.setReceiveTime(sub.getReceiveTime());
//			receiveEntity.setMemo(sub.getMemo());
//			receiveEntity.setWarningTime(sub.getWarningTime());
//		}else{
//			arm.setSuccess(false);
//			arm.setMsg("已有多条收货记录，请单独添加物料收货明细");
//			return arm;
//		}
//		arm.setSuccess(true);
//		arm.setMsg("操作成功");
//		return arm;
//	}
	
	@Deprecated
	@Transactional
	public ActionResultModel<ProjectInfoEntity> cancelReceive(ProjectInfoEntity vo) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		ProjectInfoEntity entity = mainService.getOne(vo.getUuid());
		if(entity.getBillstatus()==BillStatus.APPROVAL.toStatusValue()){
			arm.setSuccess(false);
			arm.setMsg("审核通过不能撤销收货");
			return arm;
		}
		if(!entity.getReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
			arm.setSuccess(false);
			arm.setMsg("未收货不能撤销收货");
			return arm;
		}
		List<ProjectSubEntity> subList = subService.findByMain(entity.getUuid());
		if(CollectionUtils.isEmpty(subList)){
			arm.setSuccess(false);
			arm.setMsg("项目明细为空，不能撤销收货");
			return arm;
		}
		List<String> subIdList = new ArrayList<>();
		for(ProjectSubEntity sub:subList){
			subIdList.add(sub.getUuid());
		}
		List<StockStreamEntity> streamList = streamService.findByProjectSubIds(subIdList);
		if(CollectionUtils.isNotEmpty(streamList)){
			for(StockStreamEntity stream:streamList){
				if(stream.getSurplusAmount()<stream.getTotalAmount()){
					throw new ServiceException("物料编码："+stream.getMaterial().getCode()+
							",华为编码："+stream.getMaterial().getHwcode()+" 已使用(剩余数量小于总数量)，不能撤销收货");
				}
			}
			streamService.delete(streamList);
		}
		dao.delByProjectId(entity.getUuid());//删除收货记录
		entity.setReceiveType(ProjectInfoEntity.receiveType_no);
		arm.setSuccess(true);
		arm.setMsg("操作成功");
		return arm;
	}
	
	@Transactional
	public ActionResultModel<ProjectReceiveEntity> saveReceiveLog(ProjectReceiveEntity entity) {
//		ActionResultModel<ProjectReceiveEntity> arm = new ActionResultModel<ProjectReceiveEntity>();
		ProjectSubEntity sub = subService.getOne(entity.getSubId());
		ProjectSubBaseEntity subBase = new ProjectSubBaseEntity();
		subBase.setUuid(sub.getUuid());
		entity.setSub(subBase);
		entity.setMain(sub.getMain());
		entity.setMaterial(sub.getMaterial());
		if(entity.getReceiveTime()==null){
			entity.setReceiveTime(new Date());
		}
//		if(sub.getSubReceiveType()==null||!sub.getSubReceiveType().equals(ProjectInfoEntity.receiveType_yes)){
//			arm.setSuccess(false);
//			arm.setMsg("未确认收货，不能追加收货记录");
//			return arm;
//		}
		entity = doAdd(entity);
		List<ProjectReceiveEntity> receiveList = new ArrayList<>();
		if(entity.getReceiveType().equals(ProjectReceiveEntity.receiveType_add)){
			sub.setActualAmount(sub.getActualAmount()+entity.getReceiveAmount());
			entity.setReceiveAmount(Math.abs(entity.getReceiveAmount()));
			receiveList.add(entity);
			stockDetailService.incrStockDetail(sub.getMain(), receiveList,false);
		}else{
			sub.setActualAmount(sub.getActualAmount()-Math.abs(entity.getReceiveAmount()));
			entity.setReceiveAmount(Math.abs(entity.getReceiveAmount())*-1);
			receiveList.add(entity);
			stockDetailService.descStockDetailOnReceive(sub.getMain(), receiveList);
		}
		Long receiveCount = getReceiveCount(sub.getUuid());
		if(receiveCount>=sub.getPlanAmount()){
			sub.setSubReceiveType(ProjectInfoEntity.receiveType_yes);
		}else{
			sub.setSubReceiveType(ProjectInfoEntity.receiveType_no);
		}
		return new ActionResultModel<>(true, "保存成功");
	}

	private Long getReceiveCount(String subId){
		List<ProjectReceiveEntity> hasReceiveList = findBySubId(subId);
		Long receiveCount = 0l;
		for(ProjectReceiveEntity re:hasReceiveList){
			receiveCount=receiveCount+re.getReceiveAmount();
		}
		return receiveCount;
	}
	
	public ActionResultModel<ProjectReceiveEntity> checkReceiveCount(String subId, Long receiveAmount) {
		ActionResultModel<ProjectReceiveEntity> arm = new ActionResultModel<ProjectReceiveEntity>();
		Long receiveCount = getReceiveCount(subId);
		ProjectSubEntity sub = subService.getOne(subId);
		receiveCount = receiveCount+receiveAmount;
		arm.setSuccess(true);
		if(receiveCount>sub.getPlanAmount()){
			arm.setSuccess(false);
		}		
		return arm;
	}

	
}