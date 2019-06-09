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

@MetaData(value = "系统日志信息")
@Entity
@Table(name = "yy_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class LogEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "访问IP")
	@Column(length = 50)
	private String ip;

	@MetaData(value = "访问Url")
	@Column(length = 500)
	private String url;

	@MetaData(value = "用户id")
	@Column(length = 36)
	private String userid;

	@MetaData(value = "用户名")
	@Column(length = 100)
	private String username;

	@MetaData(value = "操作内容")
	@Column(length = 2000)
	private String contents;

	@MetaData(value = "功能节点")
	@Column(length = 256)
	private String func;

	@MetaData(value = "操作方法")
	@Column(length = 200)
	private String method;

	@MetaData(value = "参数")
	@Column(length = 1000)
	private String params;

	@Column(length = 200)
	private String useragent;

	@MetaData(value = "异常信息")
	@Column(length = 2000)
	private String exdetail;

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getFunc() {
		return func;
	}

	public void setFunc(String func) {
		this.func = func;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getExdetail() {
		return exdetail;
	}

	public void setExdetail(String exdetail) {
		this.exdetail = exdetail;
	}

	public String getUseragent() {
		return useragent;
	}

	public void setUseragent(String useragent) {
		this.useragent = useragent;
	}

}
