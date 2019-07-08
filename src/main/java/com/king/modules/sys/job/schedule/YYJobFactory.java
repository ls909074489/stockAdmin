package com.king.modules.sys.job.schedule;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SchedulerException;
import org.springframework.context.ApplicationContext;

import com.king.modules.sys.job.YYJob;
import com.king.modules.sys.job.log.JobLogEntity;
import com.king.modules.sys.job.log.JobLogService;

public class YYJobFactory implements Job {
	public static final String SCHEDULE_JOB = "scheduleJob";
	public static final String APPLICATION_CONTEXT_KEY = "applicationContextKey";

	private static JobLogService jobLogService = null;// 日志服务

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		ApplicationContext applicationContext = null;
		YYJob yyJob = null;
		JobSchedule job = (JobSchedule) context.getMergedJobDataMap().get(SCHEDULE_JOB);
		try {
			applicationContext = (ApplicationContext) context.getScheduler().getContext().get(APPLICATION_CONTEXT_KEY);
			yyJob = (YYJob) applicationContext.getBean(job.getJobBeanId());

			if (jobLogService == null) {
				jobLogService = (JobLogService) applicationContext.getBean("jobLogService");
			}
			yyJob = (YYJob) applicationContext.getBean(job.getJobBeanId());

		} catch (SchedulerException e) {
			// LOG.error("RapJobFactory获取Spring应用上下文发生错误", e);
			e.printStackTrace();
		}

		JobLogEntity jobLogEntity = new JobLogEntity();
		jobLogEntity.setCreator("job");
		jobLogEntity.setCreatorname("后台任务");
		jobLogEntity.setJobname(job.getJobName());
		jobLogEntity.setJobid(job.getJobBeanId());
		jobLogEntity.setBegintime(new Date());
		jobLogEntity.setJobstatus("运行中");
		
		try {
			// 记录日志
			jobLogService.save(jobLogEntity);
			// 开始执行
			yyJob.execute(job);

			// 记录执行成功
			jobLogEntity.setJobstatus("成功");
			jobLogEntity.setModifier("job");
			jobLogEntity.setModifiername("后台任务");
			// 结束执行
		} catch (Exception e) {
			jobLogEntity.setJobstatus("错误");
			// LOG.error("RapJobFactory任务调度发生错误", e);
			JobExecutionException jobException = new JobExecutionException(e);
			// Quartz will automatically unschedule
			// all triggers associated with this job
			// so that it does not run again
			jobException.setUnscheduleAllTriggers(true);
			throw jobException;
		} finally {
			jobLogEntity.setEndtime(new Date());
			jobLogService.save(jobLogEntity);
		}

	}

}
