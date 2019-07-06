package com.king.modules.info.projectinfo;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.SuperServiceImpl;
import com.king.modules.info.stockdetail.StockDetailService;

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
	public void afterApprove(ProjectInfoEntity entity) throws ServiceException {
		List<ProjectSubEntity> subList = projectSubService.findByMain(entity.getUuid());
		stockDetailService.descStockDetail(entity, subList);
		super.afterApprove(entity);
	}
	
	

}