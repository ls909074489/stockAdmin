package com.king.modules.info.approve;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 审批用户
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Service
@Transactional(readOnly=true)
public class ApproveUserService extends BaseServiceImpl<ApproveUserEntity,String> {

	@Autowired
	private ApproveUserDao dao;

	protected IBaseDAO<ApproveUserEntity, String> getDAO() {
		return dao;
	}

	@Override
	public void beforeSave(ApproveUserEntity entity) throws ServiceException {
		List<ApproveUserEntity> list = findByAppplyTypeAndUserId(entity.getApplyType(), entity.getUser().getUuid());
		if(CollectionUtils.isNotEmpty(list)){
			throw new ServiceException("用户已添加,不能重复添加");
		}
		super.beforeSave(entity);
	}

	
	public List<ApproveUserEntity> findByAppplyType(String applyType){
		return dao.findByApplyType(applyType);
	}
	
	
	public List<ApproveUserEntity> findByAppplyTypeAndUserId(String applyType,String userId){
		return dao.findByApplyTypeAndUserId(applyType,userId);
	}
}