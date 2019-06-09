package com.king.modules.sys.alertmsg;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "Alertmsg信息")
@Entity
@Table(name = "yy_alertmsg")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class AlertmsgEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "所属模块")
	@Column
	private String mcode;

	@MetaData(value = "提示编码")
	@Column(nullable = false, unique = true)
	private String acode;

	@MetaData(value = "提示名称")
	@Column
	private String aname;

	@MetaData(value = "提示语")
	@Column(nullable = false, length = 1000)
	private String alertmsg;

	@MetaData(value = "多语提示")
	@Column
	private String alanguage;

	@MetaData(value = "备注")
	@Column
	private String remarks;

	public String getMcode() {
		return mcode;
	}

	public void setMcode(String mcode) {
		this.mcode = mcode;
	}

	public String getAcode() {
		return acode;
	}

	public void setAcode(String acode) {
		this.acode = acode;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getAlertmsg() {
		return alertmsg;
	}

	public void setAlertmsg(String alertmsg) {
		this.alertmsg = alertmsg;
	}

	public String getAlanguage() {
		return alanguage;
	}

	public void setAlanguage(String alanguage) {
		this.alanguage = alanguage;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
