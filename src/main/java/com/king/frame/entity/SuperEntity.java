package com.king.frame.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.poi.ss.formula.functions.T;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;

/**
 * 实体类基类-超级
 * 
 * 
 * @author zhangcb
 *
 */
@MappedSuperclass
public class SuperEntity extends BaseEntity implements ISuperEntity<T> {
	private static final long serialVersionUID = 1L;

	@MetaData(value = "审批状态", comments = "1：自由态，2：提交态，3：审批态，4：退回态，5：通过态")
	@Column(nullable = false)
	protected Integer billstatus = 1;

	@MetaData(value = "单据号")
	@Column(length = 100)
	protected String billcode;

	@MetaData(value = "单据类型")
	@Column(length = 100)
	protected String billtype;

	@MetaData(value = "单据日期")
	@Temporal(TemporalType.DATE)
	protected Date billdate;

	@MetaData(value = "提交时间")
	@Temporal(TemporalType.DATE)
	protected Date submittime;
	
	@MetaData(value = "最后审批人id")
	@Column(length = 36)
	protected String approver;

	@MetaData(value = "最后审批人")
	@Column(length = 200)
	protected String approvername;

	@MetaData(value = "最后审批时间")
	protected Date approvetime;

	@MetaData(value = "审核意见")
	@Column(length = 2000)
	protected String approveremark;


	public Integer getBillstatus() {
		return billstatus;
	}

	public void setBillstatus(Integer billstatus) {
		this.billstatus = billstatus;
	}

	public String getBillcode() {
		return billcode;
	}

	public void setBillcode(String billcode) {
		this.billcode = billcode;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getBilldate() {
		return billdate;
	}

	public void setBilldate(Date billdate) {
		this.billdate = billdate;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getApprovername() {
		return approvername;
	}

	public void setApprovername(String approvername) {
		this.approvername = approvername;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getApprovetime() {
		return approvetime;
	}

	public void setApprovetime(Date approvetime) {
		this.approvetime = approvetime;
	}

	public String getBilltype() {
		return billtype;
	}

	public void setBilltype(String billtype) {
		this.billtype = billtype;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getSubmittime() {
		return submittime;
	}

	public void setSubmittime(Date submittime) {
		this.submittime = submittime;
	}

	public String getApproveremark() {
		return approveremark;
	}

	public void setApproveremark(String approveremark) {
		this.approveremark = approveremark;
	}

}
