package com.king.modules.sys.log;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 登录日志
 * 
 * @ClassName: LogLoginDAO
 * @author liusheng
 * @date 2016年3月29日 上午9:14:08
 */
public interface LogLoginDAO extends IBaseDAO<LogLoginEntity, String> {

	@Query("from LogLoginEntity u where u.status=1 and u.userName=?1")
	List<LogLoginEntity> findByUserName(String userName);

	@Modifying
	@Query("delete from LogLoginEntity log where log.createtime < ?1")
	void deleteByTime(Date date);
}
