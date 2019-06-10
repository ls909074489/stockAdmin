package com.king.modules.info.supplier;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

/**
 * 供应商信息
 * @author ls2008
 * @date 2017-11-18 21:06:10
 */
@Entity
@Table(name = "yy_supplier")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SupplierEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "名称")
	@Column(length = 250)
	private String name;

	@MetaData(value = "地址")
	@Column(length = 36)
	private String address;

	@MetaData(value = "联系人")
	@Column(length = 36)
	private String contracts;

	@MetaData(value = "电话")
	@Column(length = 30)
	private String phone;

	@MetaData(value = "邮箱")
	@Column(length = 30)
	private String email;

	@MetaData(value = "网址")
	@Column(length = 250)
	private String website;

	@MetaData(value = "备注")
	@Column(length = 250)
	private String memo;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContracts() {
		return contracts;
	}

	public void setContracts(String contracts) {
		this.contracts = contracts;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

}