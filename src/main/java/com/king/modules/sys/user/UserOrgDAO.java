package com.king.modules.sys.user;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 用户关联的业务单元
 * @ClassName: UserOrgDAO
 * @author liusheng 
 * @date 2016年2月18日 下午8:15:08
 */
public interface UserOrgDAO extends IBaseDAO<UserOrgEntity, String> {
	@Modifying
	@Query("delete from UserOrgEntity rf where rf.user_id = ?1")
	public void deleteByUserId(String userId);
}
