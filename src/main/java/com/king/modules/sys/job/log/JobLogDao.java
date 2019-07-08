package com.king.modules.sys.job.log;

import java.util.List;

import com.king.frame.dao.IBaseDAO;

/**
 * 后台任务日志dao
 * 
 * @ClassName: JobLogDao
 * @author
 * @date 2016年37月18日 04:16:00
 */
public interface JobLogDao extends IBaseDAO<JobLogEntity, String> {

	List<JobLogEntity> findByJobnameAndJobstatus(String jobname, String jobstatus);

}
