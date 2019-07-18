package com.king.modules.info.approve;

import com.king.frame.dao.IBaseDAO;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 审批用户
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Repository
public interface ApproveUserDao extends IBaseDAO<ApproveUserEntity,String> {

	@Query("from ApproveUserEntity where applyType=?")
	List<ApproveUserEntity> findByApplyType(String applyType);

	
	@Query("from ApproveUserEntity where applyType=? and user.uuid=?")
	List<ApproveUserEntity> findByApplyTypeAndUserId(String applyType, String userId);

}