package com.king.modules.info.streamLog;

import com.king.frame.dao.IBaseDAO;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-25 17:48:29
 */
@Repository
public interface StreamOrderLogDao extends IBaseDAO<StreamOrderLogEntity,String> {

	@Query("from StreamOrderLogEntity where orderId=? and status=1")
	List<StreamOrderLogEntity> findByOrderId(String orderId);

}