package com.king.modules.sys.job.schedule;

import java.util.List;

import org.quartz.SchedulerException;

/**
 * 
 * Job服务操作接口
 * 
 * @Company
 * @Team RAP
 * @author zewen.li
 * @version V1.0
 * @date 2014-2-22 下午7:51:04
 */
public interface JobScheduleService {

	/**
	 * 
	 * 查询已经添加到quartz调度器中的任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-16 下午1:55:28
	 * @return
	 * @throws SchedulerException
	 */
	List<JobSchedule> findJob() throws SchedulerException;

	/**
	 * 
	 * 根据id查询已经添加到quartz调度器中的任务
	 * 
	 * @author WangMin
	 * @date 2016-4-18
	 * @return
	 * @throws SchedulerException
	 */
	JobSchedule findJobById(String id) throws SchedulerException;

	/**
	 * 
	 * 查询运行中的任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-16 下午1:57:22
	 * @return
	 * @throws SchedulerException
	 */
	List<JobSchedule> findExecutingJob() throws SchedulerException;

	/**
	 * 
	 * 添加任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-10 下午5:24:28
	 * @param job
	 * @throws SchedulerException
	 */
	void addJob(JobSchedule job) throws SchedulerException;

	/**
	 * 
	 * 更新任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-10 下午5:24:53
	 * @param job
	 * @throws SchedulerException
	 */
	void updateJob(JobSchedule job) throws SchedulerException;

	/**
	 * 删除任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-10 下午5:27:24
	 * @param job
	 * @throws SchedulerException
	 */
	void deleteJob(JobSchedule job) throws SchedulerException;

	/**
	 * 立即执行任务, 这里的立即运行，只会运行一次，方便测试时用
	 * 
	 * @author zewen.li
	 * @date 2014-2-10 下午5:31:34
	 * @param job
	 * @throws SchedulerException
	 */
	void runNow(JobSchedule job) throws SchedulerException;

	/**
	 * TODO 暂停任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-22 下午7:59:27
	 * @throws SchedulerException
	 */
	void pauseJob(JobSchedule job) throws SchedulerException;

	/**
	 * TODO 恢复任务
	 * 
	 * @author zewen.li
	 * @date 2014-2-22 下午8:00:41
	 * @throws SchedulerException
	 */
	void resumeJob(JobSchedule job) throws SchedulerException;
}
