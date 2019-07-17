package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.SuperServiceImpl;
import com.king.modules.info.apply.ProjectApplyEntity;
import com.king.modules.info.apply.ProjectApplyService;
import com.king.modules.info.stockdetail.StockDetailEntity;
import com.king.modules.info.stockdetail.StockDetailService;
import com.king.modules.info.stockinfo.StockInfoEntity;

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
	@Autowired
	private ProjectSubService projectSubService;
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private DbUtilsDAO dbDao;
	
	@Autowired
	private ProjectApplyService projectApplyService;

	protected IBaseDAO<ProjectInfoEntity, String> getDAO() {
		return dao;
	}

	
	
	@Override
	public void beforeSubmit(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		StockInfoEntity stock = stockDetailService.getStockByOrderType(entity.getBilltype());
		for(ProjectSubEntity sub:subList){
			StockDetailEntity detail  = stockDetailService.findByStockAndMaterial(stock.getUuid(),sub.getMaterial().getUuid());
			if(detail==null){
				throw new ServiceException("库存不存在物料"+sub.getMaterial().getCode());
			}else{
				if(detail.getSurplusAmount()<sub.getPlanAmount()){
					throw new ServiceException("物料"+sub.getMaterial().getCode()+"库存不足");
				}
			}
		}
		super.beforeSubmit(entity);
	}

	@Override
	public void afterSubmit(ProjectInfoEntity entity) throws ServiceException {
		ProjectApplyEntity apply = new ProjectApplyEntity();
		apply.setApplyType(ProjectApplyEntity.APPLYING);
		apply.setContent("提交项目单");
		apply.setSourceBillId(entity.getUuid());
		apply.setSourceBillCode(entity.getBillcode());
		projectApplyService.doAdd(apply);
		super.afterSubmit(entity);
	}



	@Override
	public void afterApprove(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		stockDetailService.descStockDetail(entity, subList);
		super.afterApprove(entity);
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