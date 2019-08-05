package com.king.modules.info.receive;

import com.king.frame.dao.IBaseDAO;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 收货
 * @author ls2008
 * @date 2019-07-23 16:59:39
 */
@Repository
public interface ProjectReceiveDao extends IBaseDAO<ProjectReceiveEntity,String> {

	
	@Modifying
	@Query("delete from ProjectReceiveEntity where main.uuid = ?1")
	void delByProjectId(String projectInfoId);

}