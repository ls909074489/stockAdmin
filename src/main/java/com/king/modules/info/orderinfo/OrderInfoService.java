package com.king.modules.info.orderinfo;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.enums.BillStatus;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.SuperServiceImpl;
import com.king.modules.info.stockdetail.StockDetailService;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Service
@Transactional(readOnly=true)
public class OrderInfoService extends SuperServiceImpl<OrderInfoEntity,String> {

	private static Logger logger = LoggerFactory.getLogger(OrderInfoService.class);
	
	@Autowired
	private OrderInfoDao dao;
	@Lazy
	@Autowired
	private StockDetailService stockDetailService;
	@Autowired
	private OrderSubService orderSubService;

	protected IBaseDAO<OrderInfoEntity, String> getDAO() {
		return dao;
	}

	
	@Override
	public OrderInfoEntity doApprove(OrderInfoEntity entity, String approveRemark) throws ServiceException {
		try {
			if (BillStatus.FREE.toStatusValue() == entity.getBillstatus()
					|| BillStatus.REJECT.toStatusValue() == entity.getBillstatus()) {
				beforeApprove(entity);
				if (entity != null) {
					if (StringUtils.isEmpty(entity.getApprover())) {
						entity.setApprover(ShiroUser.getCurrentUserEntity().getUuid());
						entity.setApprovername(ShiroUser.getCurrentUserEntity().getUsername());
					}
					entity.setApprovetime(new Date());
					entity.setApproveremark(approveRemark);
				}

				// 如果没有审批流 设置单据状态未 审核中或者审批通过，则设置为审核通过。
				entity.setBillstatus(BillStatus.APPROVAL.toStatusValue());

				// 如果还有审批节点，直接返回。
				if (entity.getBillstatus() == BillStatus.INAPPROVED.toStatusValue()) {
					return this.save(entity);
				} else {
					entity = this.save(entity);
				}
				//保存审批记录
				saveMessage(entity.getBilltype(), entity.getUuid(), "审核  审核意见："+approveRemark);
				afterApprove(entity);
				return entity;
			}else{
				throw new ServiceException("自由态或退回态才能审核");
			}
		} catch (Exception e) {
			logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + getTrace(e));
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}

	}


	@Override
	public void afterApprove(OrderInfoEntity entity) throws ServiceException {
		List<OrderSubEntity>  subList = orderSubService.findByMain(entity.getUuid());
		stockDetailService.incrStockDetail(entity, subList);
		super.afterApprove(entity);
	}



	@Override
	public void beforeUnApprove(OrderInfoEntity entity) throws ServiceException {
//		super.beforeUnApprove(entity);
		List<OrderSubEntity>  subList = orderSubService.findByMain(entity.getUuid());
		stockDetailService.descStockDetail(entity,subList);
	}
	
	

}