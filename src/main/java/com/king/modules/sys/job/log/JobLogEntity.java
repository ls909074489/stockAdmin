package com.king.modules.sys.job.log;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "JobLog信息")
@Entity
@Table(name = "yy_job_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class JobLogEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "任务名称")
	@Column
	private String jobname;

	@MetaData(value = "任务实例ID")
	@Column
	private String jobid;

	@MetaData(value = "开始执行时间")
	@Column
	private Date begintime;

	@MetaData(value = "结束执行时间")
	@Column
	private Date endtime;

	@MetaData(value = "执行耗费时间")
	@Column
	private String costtime;

	@MetaData(value = "执行结果", comments = "1：成功，2：运行中，3：出错")
	@Column
	private String jobstatus;;

	public String getJobname() {
		return jobname;
	}

	public void setJobname(String jobname) {
		this.jobname = jobname;
	}

	public String getJobid() {
		return jobid;
	}

	public void setJobid(String jobid) {
		this.jobid = jobid;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getBegintime() {
		return begintime;
	}

	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	/**
	 * 返回两个时间相差的秒数
	 * 
	 * @return
	 */
	public String getCosttime() {
		if (this.endtime != null && begintime != null) {
			return String.valueOf(((endtime.getTime() - begintime.getTime()) / 1000));
		} else {
			return costtime;
		}
	}

	public void setCosttime(String costtime) {
		this.costtime = costtime;
	}

	public String getJobstatus() {
		return jobstatus;
	}

	public void setJobstatus(String jobstatus) {
		this.jobstatus = jobstatus;
	}

}
