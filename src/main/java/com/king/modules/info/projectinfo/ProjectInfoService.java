package com.king.modules.info.projectinfo;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.SuperServiceImpl;
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
	public void afterApprove(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		stockDetailService.descStockDetail(entity, subList);
		super.afterApprove(entity);
	}
	
	

}