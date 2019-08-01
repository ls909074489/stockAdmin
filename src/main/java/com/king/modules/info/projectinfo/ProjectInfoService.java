package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.TextMessage;

import com.alibaba.fastjson.JSON;
import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.SuperServiceImpl;
import com.king.frame.websocket.YyWebSocketHandler;
import com.king.modules.info.apply.ProjectApplyEntity;
import com.king.modules.info.apply.ProjectApplyService;
import com.king.modules.info.approve.ApproveUserEntity;
import com.king.modules.info.approve.ApproveUserService;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.stockdetail.StockDetailEntity;
import com.king.modules.info.stockdetail.StockDetailService;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.info.stockstream.StockStreamEntity;
import com.king.modules.info.stockstream.StockStreamService;
import com.king.modules.sys.user.UserEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Service
@Transactional(readOnly=true)
public class ProjectInfoService extends SuperServiceImpl<ProjectInfoEntity,String> {

	@Autowired
	private ProjectInfoDao dao;
	@Lazy
	@Autowired
	private ProjectSubService projectSubService;
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private YyWebSocketHandler webSocketHandler;
	@Autowired
	private ProjectApplyService projectApplyService;
	@Autowired
	private ApproveUserService approveUserService;
	@Autowired
	private StockStreamService streamService;
	
	
	
	protected IBaseDAO<ProjectInfoEntity, String> getDAO() {
		return dao;
	}
	
	@Override
	public void beforeSave(ProjectInfoEntity entity) throws ServiceException {
		entity.setBillcode(entity.getCode());
		super.beforeSave(entity);
	}
	
	/**
	 * 保存
	 * @param entity
	 * @param subList
	 * @param deletePKs
	 * @return
	 */
	@Transactional
	public ActionResultModel<ProjectInfoEntity> saveSelfAndSubList(ProjectInfoEntity entity,
			List<ProjectSubEntity> subList, String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		try {
			// 删除子表一数据
			if (deletePKs != null && deletePKs.length > 0) {
				projectSubService.delete(deletePKs);
				List<StockStreamEntity> streamList = streamService.findByProjectSubIds(deletePKs);
				if(CollectionUtils.isNotEmpty(streamList)){
					stockDetailService.delStockDetail(streamList);
					streamService.delete(streamList);
				}
			}
			ProjectInfoEntity savedEntity = null;
			// 保存自身数据
			savedEntity = save(entity);

			UserEntity user = ShiroUser.getCurrentUserEntity();	
			
			List<ProjectSubEntity> addList = new ArrayList<>();
			List<ProjectSubEntity> updateList = new ArrayList<>();
			// 保存子表数据
			if (subList != null && subList.size() > 0) {
				Map<String,String> codeMap = new HashMap<>();
				for (ProjectSubEntity sub : subList) {
					if (StringUtils.isEmpty(sub.getUuid())) {
						sub.setCreator(user.getUuid());
						sub.setCreatorname(user.getUsername());
						sub.setCreatetime(new Date());
						sub.setLimitCount(sub.getMaterial().getLimitCount());
						sub.setActualAmount(sub.getPlanAmount());
						addList.add(sub);
					}else{
						updateList.add(sub);
					}
					sub.setMain(savedEntity);
					sub.setMid(savedEntity.getUuid());
					sub.setModifier(user.getUuid());
					sub.setModifiername(user.getUsername());
					sub.setModifytime(new Date());
					
					
					if(codeMap.containsKey(sub.getBoxNum()+"_"+sub.getMaterialHwCode())){
						throw new ServiceException("第"+sub.getBoxNum()+"箱华为料号"+sub.getMaterialHwCode()+"不能重复");
					}
					codeMap.put(sub.getBoxNum()+"_"+sub.getMaterialHwCode(), "第"+sub.getBoxNum()+"箱料号"+sub.getMaterialHwCode());
					
					//设置条形码
					setBarcodeJson(sub);
				}
//				save(subList);
				if(CollectionUtils.isNotEmpty(addList)){
					projectSubService.doAdd(addList);
				}
				if(CollectionUtils.isNotEmpty(updateList)){
					ProjectSubEntity subEntity = null;
					for(ProjectSubEntity sub :updateList){
						subEntity = projectSubService.getOne(sub.getUuid());
						subEntity.setBoxNum(sub.getBoxNum());
						subEntity.setMaterial(sub.getMaterial());
						subEntity.setLimitCount(sub.getLimitCount());
						subEntity.setPlanAmount(sub.getPlanAmount());
						if(entity.getReceiveType().equals(ProjectInfoEntity.receiveType_no)){
							subEntity.setActualAmount(subEntity.getPlanAmount());
						}
						subEntity.setMemo(sub.getMemo());
						subEntity.setWarningTime(sub.getWarningTime());
					}
				}
			}
			arm.setRecords(savedEntity);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}
	
	
	private ProjectSubEntity setBarcodeJson(ProjectSubEntity sub){
		if (StringUtils.isEmpty(sub.getUuid())) {
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
//				List<String> list = new ArrayList<>();
//				for(int i=0;i<sub.getPlanAmount();i++){
//					list.add("");
//				}
//				sub.setBarcodejson(JSON.toJSONString(list));
				sub.setBarcodejson(JSON.toJSONString(new String[sub.getPlanAmount().intValue()]));
			}else{
				sub.setBarcodejson("[]");
			}
		}else{
			if(sub.getLimitCount()==MaterialBaseEntity.limitCount_unique&&sub.getPlanAmount()>1){//唯一
				String barcodeJson = sub.getBarcodejson();
				if(StringUtils.isEmpty(barcodeJson)){
//					List<String> list = new ArrayList<>();
//					for(int i=0;i<sub.getPlanAmount();i++){
//						list.add("");
//					}
//					sub.setBarcodejson(JSON.toJSONString(list));
					sub.setBarcodejson(JSON.toJSONString(new String[sub.getPlanAmount().intValue()]));
				}else{
					List<String> blist = JSON.parseArray(barcodeJson, String.class);
					if(sub.getPlanAmount()>blist.size()){//增加了数量
						for(int i=0;i<(sub.getPlanAmount()-blist.size());i++){
							blist.add("");
						}
					}else if(blist.size()>sub.getPlanAmount()){//减少了数量
						blist = blist.subList(0, sub.getPlanAmount().intValue());
					}
					sub.setBarcodejson(JSON.toJSONString(blist));
				}
			}else{
				sub.setBarcodejson("[]");
			}
		}
		return sub;
	}

	@Override
	public void beforeSubmit(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		StockBaseEntity stock = entity.getStock();
		for(ProjectSubEntity sub:subList){
			StockDetailEntity detail  = stockDetailService.findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			if(detail==null){
				throw new ServiceException("仓库"+stock.getName()+"不存在物料"+sub.getMaterial().getCode());
			}else{
				if(detail.getSurplusAmount()<sub.getPlanAmount()){
					throw new ServiceException("仓库"+stock.getName()+"物料"+sub.getMaterial().getCode()+"库存不足");
				}
			}
		}
		super.beforeSubmit(entity);
	}

	@Override
	public void afterSubmit(ProjectInfoEntity entity) throws ServiceException {
		ProjectApplyEntity apply = new ProjectApplyEntity();
		apply.setApplyType(ProjectApplyEntity.APPLYING);
		apply.setContent("提交项目单"+entity.getCode());
		apply.setSourceBillId(entity.getUuid());
		apply.setSourceBillCode(entity.getCode());
		projectApplyService.doAdd(apply);
		
		
		List<ApproveUserEntity> userList = approveUserService.findByAppplyType(ApproveUserEntity.PROJECTINFO_TYPE);
		if(CollectionUtils.isNotEmpty(userList)){
			for(ApproveUserEntity u:userList){
				webSocketHandler.sendMessageToUser(u.getUser().getUuid(), new TextMessage(apply.getCreatorname()+" "+apply.getContent()+",请及时处理。"));
			}
		}
		super.afterSubmit(entity);
	}


	@Override
	public void beforeApprove(ProjectInfoEntity entity) throws ServiceException {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		boolean hasPri = approveUserService.checkIsApproveUser(user, ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			throw new ServiceException("您不是审核用户，不能进行审核.");
		}
		super.beforeApprove(entity);
	}

	@Override
	public void afterApprove(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		stockDetailService.descStockDetail(entity, subList);
		//将申请标志为已处理
		projectApplyService.handleApply(entity.getUuid());
		super.afterApprove(entity);
	}



	@Override
	public void afterUnApprove(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		stockDetailService.unApproveStockDetail(entity, subList);
		super.afterUnApprove(entity);
	}

	public ActionResultModel<ProjectInfoVo> select2Query(String codeOrName) {
		ActionResultModel<ProjectInfoVo> arm = new ActionResultModel<ProjectInfoVo>();
		List<ProjectInfoVo> voList = new ArrayList<ProjectInfoVo>();
		if(StringUtils.isEmpty(codeOrName)){
			try {
				voList =  dbDao.find(ProjectInfoVo.class, "select uuid,name,code from yy_project_info order by createtime desc");
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}else{
			Object [] params  = {"%"+codeOrName+"%","%"+codeOrName+"%"};
			try {
				voList =  dbDao.find(ProjectInfoVo.class, "select uuid,name,code from yy_project_info where code like ? or name like ? order by createtime desc", params);
				arm.setSuccess(true);
			} catch (DAOException e) {
				arm.setSuccess(false);
				e.printStackTrace();
			}
		}
		arm.setRecords(voList);
		return arm;
	}
	
	

}