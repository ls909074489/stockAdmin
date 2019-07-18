package com.king.modules.info.apply;

import com.king.frame.dao.IBaseDAO;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * 申请消息
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Repository
public interface ProjectApplyDao extends IBaseDAO<ProjectApplyEntity,String> {

	@Modifying
	@Query("update ProjectApplyEntity u set u.applyType=?1 where u.sourceBillId=?2 and u.applyType in(?3,?4)")
	void handleApply(String newApplyType,String sourceBillId,String oldApplyType1,String oldApplyType2);

}