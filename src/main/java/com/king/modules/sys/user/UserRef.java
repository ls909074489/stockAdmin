package com.king.modules.sys.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.data.annotation.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.common.annotation.MetaData;

@MetaData(value = "用户信息")
@Entity
@Table(name = "yy_user")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserRef{
	@Id
	@Column
	private String uuid;

	@Column(nullable = false, length = 100)
	@MetaData(value = "用户名")
	private String username;
	
	@MetaData(value = "登录名")
	@Column(nullable = false,unique=true, length = 20)
	private String loginname;
	
	@Column(length = 2,columnDefinition="varchar(2) default '1'")
	@MetaData(value = "是否启用")
	private String is_use="1";
	
	@Transient
	@JsonIgnore
	private String plainpassword;
	
	public UserRef() {
		
	}
	
	public UserRef(String uuid) {
		this.uuid = uuid;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPlainpassword() {
		return plainpassword;
	}

	public void setPlainpassword(String plainpassword) {
		this.plainpassword = plainpassword;
	}

	public String getIs_use() {
		return is_use;
	}

	public void setIs_use(String is_use) {
		this.is_use = is_use;
	}
}
