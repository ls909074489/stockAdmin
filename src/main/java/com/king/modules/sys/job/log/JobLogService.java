package com.king.modules.sys.job.log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

/**
 * 后台任务日志service
 * 
 * @ClassName: JobLogService
 * @author
 * @date 2016年37月18日 04:16:00
 */
@Service("jobLogService")
@Transactional
public class JobLogService extends BaseServiceImpl<JobLogEntity, String> {

	@Autowired
	private JobLogDao dao;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	public void deleteJobLogByJobname(String jobname) {
		List<JobLogEntity> list = dao.findByJobnameAndJobstatus(jobname, "成功");
		this.delete(list);
	}

}
