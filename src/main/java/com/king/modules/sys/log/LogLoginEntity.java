package com.king.modules.sys.log;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "登录日志")
@Entity
@Table(name = "yy_log_login")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class LogLoginEntity extends BaseEntity {

	private static final long serialVersionUID = -4239728668369989180L;

	@MetaData(value = "登录是否成功")
	@Column(name = "is_suc", length = 2)
	private String isSuc;
	@MetaData(value = "登录IP")
	@Column(name = "request_ip", length = 50)
	private String requestIp;

	@MetaData(value = "登录浏览器")
	@Column(name = "user_agent", length = 500)
	private String userAgent;

	@MetaData(value = "登录名")
	@Column(name = "loginname", length = 50)
	private String loginname;

	@MetaData(value = "用户名")
	@Column(name = "user_name", length = 50)
	private String userName;

	@MetaData(value = "登录是否有效")
	@Column(name = "is_valid", length = 2)
	private String isValid = "1";

	@MetaData(value = "登录用户id")
	@Column(name = "user_id", length = 50)
	private String userId;

	@MetaData(value = "机构id")
	@Column(name = "orgid", length = 50)
	private String orgid;

	@MetaData(value = "部门id")
	@Column(name = "deptid", length = 50)
	private String deptid;
	@MetaData(value = "人员id")
	@Column(name = "personid", length = 50)
	private String personid;

	public String getIsSuc() {
		return isSuc;
	}

	public void setIsSuc(String isSuc) {
		this.isSuc = isSuc;
	}

	public String getRequestIp() {
		return requestIp;
	}

	public void setRequestIp(String requestIp) {
		this.requestIp = requestIp;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getPersonid() {
		return personid;
	}

	public void setPersonid(String personid) {
		this.personid = personid;
	}

}
