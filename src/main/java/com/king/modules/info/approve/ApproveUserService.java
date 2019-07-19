package com.king.modules.info.approve;

import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.user.UserEntity;

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
	
	
	public boolean checkIsApproveUser(UserEntity user,String applyType){
		List<ApproveUserEntity> userList = findByAppplyType(applyType);
		boolean hasPri = false;//是否有权限
		if(CollectionUtils.isNotEmpty(userList)){
			for(ApproveUserEntity u:userList){
				if(user.getUuid().equals(u.getUuid())){
					hasPri = true;
					break;
				}
			}
		}
		return hasPri;
		
	}
}