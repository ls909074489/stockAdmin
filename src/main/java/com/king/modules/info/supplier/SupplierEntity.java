package com.king.modules.info.supplier;

import javax.persistence.Column;
import com.king.frame.entity.BaseEntity;
import com.king.common.annotation.MetaData;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 供应商
 * @author null
 * @date 2019-06-17 21:31:03
 */
@Entity
@Table(name = "yy_supplier")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class SupplierEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "供应商编码")
	@Column(length = 50)
	private String code;
	
	@MetaData(value = "供应商名称")
	@Column(length = 100)
	private String name;

	@MetaData(value = "联系人")
	@Column(length = 50)
	private String contacts;
	
	@MetaData(value = "联系电话")
	@Column(length = 50)
	private String phone;

	@MetaData(value = "邮箱")
	@Column(length = 50)
	private String email;

	@MetaData(value = "地址")
	@Column(length = 200)
	private String address;

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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

}