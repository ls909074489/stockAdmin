package com.king.modules.sys.job.ctrl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.king.common.exception.base.CustomException;
import com.king.common.exception.base.impl.NullParameterException;
import com.king.common.utils.DateUtil;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.job.schedule.JobSchedule;
import com.king.modules.sys.job.schedule.JobScheduleService;
import com.king.modules.sys.job.schedule.JobScheduleVo;

/**   
* 后台任务业务层
* @author xuechen 
* @date 2016年1月4日 下午4:51:27 
*/
@Service
public class JobService extends BaseServiceImpl<JobScheduleVo,String>{

	@Autowired
	private JobScheduleService scheduleService;
	
	public List<JobSchedule> findJob() throws SchedulerException {
		return scheduleService.findJob();
	}
	
	public List<JobSchedule> findExecutingJob() throws SchedulerException {
		return scheduleService.findExecutingJob();
	}
	
	/**
	 * 将JobScheduleVo 转换为 JobSchedule
	 * @param job
	 * @return
	 */
	public JobSchedule voToBean(JobScheduleVo job){
		JobSchedule jobSchedule = new JobSchedule();
		jobSchedule.setDesc(job.getDesc());
		jobSchedule.setJobBeanId(job.getJobBeanId().trim());
		jobSchedule.setJobGroup(job.getJobGroup());
		jobSchedule.setJobName(job.getJobName().trim());
		jobSchedule.setJobStatus(job.getJobStatus());
		jobSchedule.setCronType(job.getCronType());
		jobSchedule.setCronDate(job.getCronDate());//参考日期
		jobSchedule.setIsDateConstraints(job.getIsDateConstraints());//立即执行的时候是否弹出日期框
		return jobSchedule;
	}
	
	/**
	 * 转换成 Cron　表达式
	 * @throws CustomException 
	 */
	public String processCronExpression(String cronType,String cronDateParam,String week) throws CustomException{
		
		// ss mm HH dd MM ? yyyy
		// 11 05 11 *  *  ?
		// 11 05 11 ? * *
		// "0 15 10 ? * *"  每天10:15运行
		if("day".equals(cronType)){
			Date cronDate = DateUtil.strToDate(cronDateParam,"HH:mm:ss");
			String cronDateStr = DateUtil.toCronDateStr(cronDate);
			return cronDateStr.substring(0, 9)+" * * ? *";
		}else if("month".equals(cronType)){
			//ss mm HH dd MM ? yyyy
			//例如：每月1号凌晨1点执行一次：0 0 1 1 * ?
			String day = cronDateParam.substring(3, 5);
			String time = cronDateParam.substring(7,16);
			Date cronDate = DateUtil.strToDate(day+" "+time,"dd HH:mm:ss");
			String cronDateStr = DateUtil.toCronDateStr(cronDate);
			return cronDateStr.substring(0, 12) +"*" +" ? * *";
		}else if("year".equals(cronType)){
			Date cronDate = DateUtil.strToDate(cronDateParam,"MM-dd HH:mm:ss");
			String cronDateStr = DateUtil.toCronDateStr(cronDate);
			return cronDateStr.substring(0, 14) +" ? * ";
		}else if("week".equals(cronType)){
			//例如：每周星期天凌晨1点实行一次：
			//ss mm HH dd MM ? yyyy
			//00 40 10 ?  ?  6 ? 
			//00 15 10 ?  * MON   周一上午10:15触发 
			Date cronDate = DateUtil.strToDate(cronDateParam,"HH:mm:ss");
			String cronDateStr = DateUtil.toCronDateStr(cronDate); 
			switch(week){
				case "sunday": week = "1";break;
				case "monday": week = "2";break;
				case "tuesday": week = "3";break;
				case "wednesday": week = "4";break;
				case "thursday": week = "5";break;
				case "friday": week = "6";break;
				case "saturday": week = "7";break;
			}
			return cronDateStr.substring(0, 8) +" ? * "+ week ;
		}else if("once".equals(cronType)){
			Date cronDate = DateUtil.strToDate(cronDateParam,"yyyy-MM-dd HH:mm:ss");
			//如果配置的时间在现在时间之前（已经过时）抛出异常
			if(cronDate==null||cronDate.getTime()<new Date().getTime()){
				throw new CustomException("已过时的日期");
			}
			String cronDateStr = DateUtil.toCronDateStr(cronDate); 
			return cronDateStr;
		}else if("hour".equals(cronType)){// 分钟
			Date cronDate = DateUtil.strToDate(cronDateParam,"mm:ss");
			String cronDateStr = DateUtil.toCronDateStr(cronDate);
			return cronDateStr.substring(0,5)+" * * * ? *";
		}else if("minute".equals(cronType)){
			return "0 */"+cronDateParam+" * * * ?";
		}else{
			throw new CustomException("没有匹配的格式");
		}
	}
	
	
	/**
	 * 新增
	 * @param job
	 * @throws SchedulerException
	 * @throws CustomException
	 */
	public void addJob(JobScheduleVo job) throws SchedulerException,CustomException {
		//判空
		if(job==null||StringUtils.isBlank(job.getJobBeanId())){
			throw new NullParameterException("beanId为空");
		}
		if(StringUtils.isBlank(job.getJobGroup())){
			throw new NullParameterException("JobGroup为空");
		}
		/**
		 * 这里验证是否继承了定时器的类
		 */
		JobSchedule jobSchedule = voToBean(job); //将VO转换为JobSchedule
		String cronType = job.getCronType();
		if("custom".equals(cronType)){// 自定义
			jobSchedule.setCronExpression(job.getCronExpression());
			scheduleService.addJob(jobSchedule);
		}else{
			if(StringUtils.isBlank(job.getCronDate())){
				throw new CustomException("参考日期为空");
			}
			String cronExpression = processCronExpression(cronType,job.getCronDate(),job.getWeek());
			jobSchedule.setCronExpression(cronExpression);
		}
		scheduleService.addJob(jobSchedule);
		jobSchedule.setDesc(job.getDesc());//保存描述信息
		scheduleService.updateJob(jobSchedule);
	}
	
	/**
	 * 更新Job
	 * 将 Job 改成  JobScheduleVo
	 * @param job
	 * @throws SchedulerException
	 * @throws CustomException
	 */
	public void updateJob(JobScheduleVo job) throws SchedulerException, CustomException  {
		if(job==null){
			throw new NullParameterException("更新时参数为空");
		}
		JobSchedule jobSchedule = voToBean(job);//Vo 转换为jobSchedule
		String cronType = job.getCronType();
		String cronExpression = processCronExpression(cronType,job.getCronDate(),job.getWeek());
		jobSchedule.setCronExpression(cronExpression);
		scheduleService.updateJob(jobSchedule);
	}
	
	/**
	 * 删除job
	 * @param job
	 * @throws SchedulerException
	 */
	public void deleteJob(JobSchedule job) throws SchedulerException {
		scheduleService.deleteJob(job);
	}
	
	/**
	 * 批量删除
	 * @param pks
	 * @throws SchedulerException
	 */
	public void deleteJob(String[] pks) throws SchedulerException {
		for(String pk : pks) {
			JobSchedule job = new JobSchedule(pk);
			scheduleService.deleteJob(job);
		}
	}
	
	//暂停
	public void pauseJob(JobSchedule job) throws SchedulerException {
		scheduleService.pauseJob(job);
	}
	
	//恢复
	public void resumeJob(JobSchedule job) throws SchedulerException {
		scheduleService.resumeJob(job);
	}

    /**
    * @Title: pauseJob  
    * @Description: 批量暂停
    * @param @param pks
    * @param @throws CustomException
    * @param @throws SchedulerException    设定文件  
    * @return void    返回类型  
    * @throws
     */
    public void pauseJob(String[] pks) throws CustomException, SchedulerException {
        if(pks==null){
            throw new NullParameterException("暂停时主键id为空");
        }
        for(String pk : pks) {
            JobSchedule job = new JobSchedule(pk);
            scheduleService.pauseJob(job);
        }
    }

    /**
     * @throws SchedulerException 
     * @throws CustomException 
    * @Title: resumeJob  
    * @Description: 
    * @param @param pks    设定文件  
    * @return void    返回类型  
    * @throws
     */
    public void resumeJob(String[] pks) throws CustomException, SchedulerException {
        if(pks==null){
            throw new NullParameterException("恢复时主键id为空");
        }
        for(String pk : pks) {
            JobSchedule job = new JobSchedule(pk);
            scheduleService.resumeJob(job);
        }
        
    }

    /**
     * 立即执行
     * @param uuid
     * @param parameterJson
     * @throws SchedulerException 
     * @throws CustomException 
     */
	public void runNow(String jobId, String parameterJson) throws SchedulerException, CustomException {
		JobSchedule job = scheduleService.findJobById(jobId);
		if(job==null){
			throw new NullParameterException("找不到对应的定时器");
		}
		if(StringUtils.isNotBlank(parameterJson)){
			job.setParameterJson(parameterJson);
			scheduleService.updateJob(job);
		}
		scheduleService.runNow(job);
	}
	
	/**
	 * 原生立即执行(不带参数)
	 * @param job
	 * @throws SchedulerException
	 * @throws CustomException
	 */
	public void runNow(JobSchedule job) throws SchedulerException, CustomException {
        scheduleService.runNow(job);
	}

	@Override
	protected IBaseDAO<JobScheduleVo, String> getDAO() {
		return null;
	}
	
	
}





