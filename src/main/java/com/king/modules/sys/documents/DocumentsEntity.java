package com.king.modules.sys.documents;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Version;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "Documents信息")
@Entity
@Table(name = "yy_documents")
@DynamicInsert
@DynamicUpdate
public class DocumentsEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@Version
	@MetaData(value = "版本")
	@Column(nullable = false, length = 11, columnDefinition = "INT default 0")
	private int version;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@MetaData(value = "流水号上次归零创建时间")
	@Column
	private Date creationTime;

	@MetaData(value = "单据类型")
	@Column
	private String documentType;

	@MetaData(value = "最新流水号")
	@Column
	private Integer newSerialNumber;

	@MetaData(value = "单据")
	@Column
	private String documents;

	@MetaData(value = "前缀")
	@Column
	private String prefix;

	@MetaData(value = "归零标志（y年、m月、d日）")
	@Column
	private String zeroMark;

	@MetaData(value = "流水号位数")
	@Column
	private Integer serialNumber;

	@MetaData(value = "是否加年 y n")
	@Column
	private String isAadYears;

	@MetaData(value = "是否加月y n")
	@Column
	private String isAddMonth;

	@MetaData(value = "是否加日y  n")
	@Column
	private String isAddDay;

	public String getDocuments() {
		return documents;
	}

	public void setDocuments(String documents) {
		this.documents = documents;
	}

	public Date getCreationTime() {
		return creationTime;
	}

	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}

	public String getDocumentType() {
		return documentType;
	}

	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public String getZeroMark() {
		return zeroMark;
	}

	public void setZeroMark(String zeroMark) {
		this.zeroMark = zeroMark;
	}

	public Integer getNewSerialNumber() {
		return newSerialNumber;
	}

	public void setNewSerialNumber(Integer newSerialNumber) {
		this.newSerialNumber = newSerialNumber;
	}

	public Integer getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(Integer serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getIsAadYears() {
		return isAadYears;
	}

	public void setIsAadYears(String isAadYears) {
		this.isAadYears = isAadYears;
	}

	public String getIsAddMonth() {
		return isAddMonth;
	}

	public void setIsAddMonth(String isAddMonth) {
		this.isAddMonth = isAddMonth;
	}

	public String getIsAddDay() {
		return isAddDay;
	}

	public void setIsAddDay(String isAddDay) {
		this.isAddDay = isAddDay;
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

}
