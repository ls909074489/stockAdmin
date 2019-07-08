package com.king.modules.sys.job.schedule;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 定时任务service层
 */
@Service("scheduleService")
@Transactional(rollbackFor = { Exception.class })
public class JobScheduleServiceImpl implements JobScheduleService {

	@Autowired
	private Scheduler scheduler;

	/**
	 * 根据 id 查询
	 */
	@Override
	public JobSchedule findJobById(String id) throws SchedulerException {
		GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();
		Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
		for (JobKey jobKey : jobKeys) {
			List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
			for (Trigger trigger : triggers) {
				JobSchedule job = new JobSchedule();
				job.setJobName(jobKey.getName());
				job.setJobGroup(jobKey.getGroup());
				job.setUuid(jobKey.getName(), jobKey.getGroup());

				// 获取JobDetail
				JobDetail jobDetail = scheduler.getJobDetail(jobKey);
				JobSchedule jobData = (JobSchedule) jobDetail.getJobDataMap().get(YYJobFactory.SCHEDULE_JOB);
				job.setJobBeanId(jobData.getJobBeanId());
				job.setDesc(jobData.getDesc());
				job.setCronType(jobData.getCronType());
				job.setCronDate(jobData.getCronDate());
				job.setIsDateConstraints(jobData.getIsDateConstraints());

				Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
				job.setJobStatus(triggerState.name());
				if (trigger instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger) trigger;
					String cronExpression = cronTrigger.getCronExpression();
					job.setCronExpression(cronExpression);
				}
				// id 相同
				if (job.getUuid().equals(id)) {
					return job;
				}
			}
		}
		return null;
	}

	/**
	 * 查询所有job
	 */
	@Override
	public List<JobSchedule> findJob() throws SchedulerException {
		GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();
		Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
		List<JobSchedule> jobList = new ArrayList<JobSchedule>();
		for (JobKey jobKey : jobKeys) {
			List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
			for (Trigger trigger : triggers) {
				JobSchedule job = new JobSchedule();
				job.setJobName(jobKey.getName());
				job.setJobGroup(jobKey.getGroup());
				job.setUuid(jobKey.getName(), jobKey.getGroup());

				// 获取JobDetail
				JobDetail jobDetail = scheduler.getJobDetail(jobKey);
				JobSchedule jobData = (JobSchedule) jobDetail.getJobDataMap().get(YYJobFactory.SCHEDULE_JOB);
				job.setJobBeanId(jobData.getJobBeanId());
				job.setDesc(jobData.getDesc());
				job.setCronType(jobData.getCronType());
				job.setIsDateConstraints(jobData.getIsDateConstraints());// 立即运行时，是否弹选择日期窗
				job.setCronDate(jobData.getCronDate());

				Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
				job.setJobStatus(triggerState.name());
				if (trigger instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger) trigger;
					String cronExpression = cronTrigger.getCronExpression();
					job.setCronExpression(cronExpression);
				}
				jobList.add(job);
			}
		}
		return jobList;
	}

	@Override
	public List<JobSchedule> findExecutingJob() throws SchedulerException {
		List<JobExecutionContext> executingJobs = scheduler.getCurrentlyExecutingJobs();

		List<JobSchedule> jobList = new ArrayList<JobSchedule>(executingJobs.size());
		for (JobExecutionContext executingJob : executingJobs) {
			JobSchedule job = new JobSchedule();
			JobDetail jobDetail = executingJob.getJobDetail();
			JobKey jobKey = jobDetail.getKey();

			Trigger trigger = executingJob.getTrigger();
			job.setJobName(jobKey.getName());
			job.setJobGroup(jobKey.getGroup());

			JobSchedule jobData = (JobSchedule) jobDetail.getJobDataMap().get(YYJobFactory.SCHEDULE_JOB);
			job.setJobBeanId(jobData.getJobBeanId());
			// job.setDesc("触发器:" + trigger.getKey());
			Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
			job.setJobStatus(triggerState.name());
			if (trigger instanceof CronTrigger) {
				CronTrigger cronTrigger = (CronTrigger) trigger;
				String cronExpression = cronTrigger.getCronExpression();
				job.setCronExpression(cronExpression);
			}
			jobList.add(job);
		}
		return jobList;
	}

	@Override
	public void addJob(JobSchedule job) throws SchedulerException {
		//job.setc
		TriggerKey triggerKey = TriggerKey.triggerKey(job.getJobName(), job.getJobGroup());
		CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);// 获取trigger
		// 不存在，创建一个
		if (null == trigger) {
			JobDetail jobDetail = JobBuilder.newJob(YYJobFactory.class)
					.withIdentity(job.getJobName(), job.getJobGroup()).storeDurably().build();
			//jobDetail.getJobClass()job.getc
			jobDetail.getJobDataMap().put(YYJobFactory.SCHEDULE_JOB, job);
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
			// 按新的cronExpression表达式构建一个新的trigger
			trigger = TriggerBuilder.newTrigger().withIdentity(job.getJobName(), job.getJobGroup()).startNow()
					.withSchedule(scheduleBuilder).build();
			//trigger.get
			scheduler.scheduleJob(jobDetail, trigger);
		} else {
			// Trigger已存在，那么更新相应的定时设置
			// 表达式调度构建器
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			// 按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
		}
	}

	/**
	 * 更新Job
	 */
	@Override
	public void updateJob(JobSchedule job) throws SchedulerException {
		updateJobDetail(job);
		updateTrigger(job);
	}

	/**
	 * 删除Job
	 */
	@Override
	public void deleteJob(JobSchedule job) throws SchedulerException {
		JobKey jobKey = JobKey.jobKey(job.getJobName(), job.getJobGroup());
		scheduler.deleteJob(jobKey);
	}

	// 立即执行
	@Override
	public void runNow(JobSchedule job) throws SchedulerException {
		JobKey jobKey = JobKey.jobKey(job.getJobName(), job.getJobGroup());
		scheduler.triggerJob(jobKey);
	}

	/**
	 * 
	 * @param job
	 * @throws SchedulerException
	 */
	public void updateTrigger(JobSchedule job) throws SchedulerException {
		TriggerKey triggerKey = TriggerKey.triggerKey(job.getJobName(), job.getJobGroup());
		// 获取trigger
		CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
		if (trigger == null) {
			throw new SchedulerException(
					"Trigger不存在, job name: " + job.getJobName() + " job group: " + job.getJobGroup());
		}
		// 表达式调度构建器
		try {
			CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
			// 按新的cronExpression表达式重新构建trigger
			trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
			// 按新的trigger重新设置job执行
			scheduler.rescheduleJob(triggerKey, trigger);
		} catch (Exception e) {
			throw new SchedulerException("表达式格式不正确");
		}
	}

	/**
	 * 更新job
	 * 
	 * @param job
	 * @throws SchedulerException
	 */
	public void updateJobDetail(JobSchedule job) throws SchedulerException {
		JobDetail jobDetail = JobBuilder.newJob(YYJobFactory.class).withIdentity(job.getJobName(), job.getJobGroup())
				.storeDurably().build();
		jobDetail.getJobDataMap().put(YYJobFactory.SCHEDULE_JOB, job);
		// store, and set overwrite flag to 'true'
		scheduler.addJob(jobDetail, true);
	}

	/**
	 * 暂停Job
	 */
	@Override
	public void pauseJob(JobSchedule job) throws SchedulerException {
		JobKey jobKey = JobKey.jobKey(job.getJobName(), job.getJobGroup());
		scheduler.pauseJob(jobKey);
	}

	/**
	 * 恢复Job
	 */
	@Override
	public void resumeJob(JobSchedule job) throws SchedulerException {
		JobKey jobKey = JobKey.jobKey(job.getJobName(), job.getJobGroup());
		scheduler.resumeJob(jobKey);
	}

}
