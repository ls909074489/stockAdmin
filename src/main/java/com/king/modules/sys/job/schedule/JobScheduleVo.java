package com.king.modules.sys.job.schedule;

import javax.persistence.MappedSuperclass;

import com.king.frame.entity.BaseEntity;

/**
 * 定时任务VO
 * 
 * @author WangMin extends JobSchedule
 * 
 * @MetaData(value = "定时任务界面展示")
 * @Entity
 * @Table(name = "yy_jobSchedule_vo")
 * @DynamicInsert
 * @DynamicUpdate
 * @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
 */
@MappedSuperclass
public class JobScheduleVo extends BaseEntity {

	private static final long serialVersionUID = 1L;

	/** 加入自定义的一些参数 **/
	private String cronType;// 按照年、月、日、自定义。。等

	private String cronDate;// 参照日期

	private String week;// 星期几

	private String minute;// 分钟

	/**
	 * Job唯一标准, 通过jobName_jobGroup组合而成 private String uuid;
	 **/

	/** 任务名称 */
	private String jobName;

	/** 任务分组 */
	private String jobGroup;

	/**
	 ** None：Trigger已经完成，且不会在执行，或者找不到该触发器，或者Trigger已经被删除 NORMAL:正常状态 PAUSED：暂停状态 COMPLETE：触发器完成，但是任务可能还正在执行中
	 * BLOCKED：线程阻塞状态 ERROR：出现错误
	 */
	private String jobStatus;

	/**
	 * 任务运行时间表达式 Cron 表达式包括以下 7 个字段： 秒 分 小时 月内日期 月 周内日期 年（可选字段） 1.反斜线（/）字符表示增量值。例如，在秒字段中“5/15”代表从第 5 秒开始，每 15 秒一次。
	 * 
	 * 2.问号（?）字符和字母 L 字符只有在月内日期和周内日期字段中可用。问号表示这个字段不包含具体值。 所以，如果指定月内日期，可以在周内日期字段中插入“?”，表示周内日期值无关紧要。字母 L 字符是 last 的缩写。
	 * 放在月内日期字段中，表示安排在当月最后一天执行。在周内日期字段中，如果“L”单独存在，就等于“7”，否则代表当月内周内日期的最后一个实例。 所以“0L”表示安排在当月的最后一个星期日执行。
	 * 
	 * 3.在月内日期字段中的字母（W）字符把执行安排在最靠近指定值的工作日。把“1W”放在月内日期字段中，表示把执行安排在当月的第一个工作日内。
	 * 
	 * 4.井号（#）字符为给定月份指定具体的工作日实例。把“MON#2”放在周内日期字段中，表示把任务安排在当月的第二个星期一。
	 * 
	 * 秒 0-59 , - * / 分 0-59 , - * / 小时 0-23 , - * / 日期 1-31 , - * ? / L W C 月份 1-12 或者 JAN-DEC , - * / 星期 1-7 或者
	 * SUN-SAT , - * ? / L C # 年（可选） 留空, 1970-2099 , - * /
	 */
	private String cronExpression;

	/** 加载到Spring容器中的bean ID **/
	private String jobBeanId;

	/** 任务描述 */
	private String desc;

	/** 立即执行是否加入日期约束 0不加入 1 加入 **/
	private Integer isDateConstraints;

	public JobScheduleVo() {
	}

	public JobScheduleVo(String uuid) {
		String values[] = uuid.split("_");
		this.jobName = values[0];
		this.jobGroup = values[1];
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String jobName, String jobGroup) {
		this.uuid = jobName + "_" + jobGroup;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getJobGroup() {
		return jobGroup;
	}

	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}

	public String getJobStatus() {
		return jobStatus;
	}

	public void setJobStatus(String jobStatus) {
		this.jobStatus = jobStatus;
	}

	public String getCronExpression() {
		return cronExpression;
	}

	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}

	public String getJobBeanId() {
		return jobBeanId;
	}

	public void setJobBeanId(String jobBeanId) {
		this.jobBeanId = jobBeanId;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getCronType() {
		return cronType;
	}

	public void setCronType(String cronType) {
		this.cronType = cronType;
	}

	public String getCronDate() {
		return cronDate;
	}

	public void setCronDate(String cronDate) {
		this.cronDate = cronDate;
	}

	public String getWeek() {
		return week;
	}

	public void setWeek(String week) {
		this.week = week;
	}

	public String getMinute() {
		return minute;
	}

	public void setMinute(String minute) {
		this.minute = minute;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getIsDateConstraints() {
		return isDateConstraints;
	}

	public void setIsDateConstraints(Integer isDateConstraints) {
		this.isDateConstraints = isDateConstraints;
	}

}
