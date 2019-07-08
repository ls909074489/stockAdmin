package com.king.modules.sys.job;

import org.quartz.JobExecutionException;

import com.king.modules.sys.job.schedule.JobSchedule;

public interface YYJob {
	void execute(JobSchedule schedule) throws JobExecutionException;

	// void triggerJob(JobKey jobKey, JobDataMap data) throws JobExecutionException;

	// abstract void execute(JobExecutionContext schedule)
	// throws JobExecutionException;

}
