package com.king.modules.sys.log;

import java.util.Date;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface LogDAO extends IBaseDAO<LogEntity, String> {

	@Modifying
	@Query("delete from LogEntity log where log.createtime < ?1")
	void deleteByTime(Date date);

}
