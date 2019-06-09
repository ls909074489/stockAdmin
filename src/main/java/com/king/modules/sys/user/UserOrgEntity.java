package com.king.modules.sys.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "用户关联的业务单元信息")
@Entity
@Table(name = "yy_user_org")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserOrgEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	

	@MetaData(value = "所属机构Id")
	@Column(length = 36)
	private String pk_corp;

	@MetaData(value = "所属用户Id")
	@Column(length = 36)
	private String user_id;

	public String getPk_corp() {
		return pk_corp;
	}

	public void setPk_corp(String pk_corp) {
		this.pk_corp = pk_corp;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

}
