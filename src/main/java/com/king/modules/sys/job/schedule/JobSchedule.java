package com.king.modules.sys.job.schedule;

import java.io.Serializable;

/**
 * 定时任务 Job
 * 
 * @author
 */
public class JobSchedule implements Serializable {

	/**
	 * 序列化id 不要改变
	 */
	private static final long serialVersionUID = 8872187788799451517L;

	/** Job唯一标准, 通过jobName_jobGroup组合而成 **/
	private String uuid;

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

	/** 立即执行的时候传入的参数 为了方便扩展 Json格式 **/
	private String parameterJson;

	/** 执行方式 按天、按月、按星期、自定义 **/
	private String cronType;

	/** 立即执行是否加入日期约束 0不加入 1 加入 **/
	private Integer isDateConstraints;

	/** 参考日期,解决编辑问题 **/
	private String cronDate;// 参照日期

	public JobSchedule() {
	}

	public JobSchedule(String uuid) {
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

	public String getParameterJson() {
		return parameterJson;
	}

	public void setParameterJson(String parameterJson) {
		this.parameterJson = parameterJson;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCronType() {
		return cronType;
	}

	public void setCronType(String cronType) {
		this.cronType = cronType;
	}

	public Integer getIsDateConstraints() {
		return isDateConstraints;
	}

	public void setIsDateConstraints(Integer isDateConstraints) {
		this.isDateConstraints = isDateConstraints;
	}

	public String getCronDate() {
		return cronDate;
	}

	public void setCronDate(String cronDate) {
		this.cronDate = cronDate;
	}

}
