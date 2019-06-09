package com.king.modules.sys.usermenu;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "UserMenu信息")
@Entity
@Table(name = "yy_usermenu")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserMenuEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "用户id")
	@Column
	private String userid;

	@MetaData(value = "功能注册id")
	@Column
	private String funcid;

	@MetaData(value = "url")
	@Column
	private String funcurl;

	@MetaData(value = "别名")
	@Column
	private String funcname;

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getFuncid() {
		return funcid;
	}

	public void setFuncid(String funcid) {
		this.funcid = funcid;
	}

	public String getFuncname() {
		return funcname;
	}

	public void setFuncname(String funcname) {
		this.funcname = funcname;
	}

	public String getFuncurl() {
		return funcurl;
	}

	public void setFuncurl(String funcurl) {
		this.funcurl = funcurl;
	}

}
