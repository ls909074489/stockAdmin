package com.king.modules.sys.mappingtable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "映射表")
@Entity
@Table(name = "yy_mapping_table_sub")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MappingTableSubEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private MappingTableEntity main;
	
//	@MetaData(value = "键")
//	@Column(length = 100)
//	private String mapkey;
//
//	@MetaData(value = "值")
//	@Column(length = 100)
//	private String mapval;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String colName;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String colNameDb;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String colDesc;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String eleType;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String colType;
	
	@MetaData(value = "")
	@Column(length = 100)
	private String colLength;
	

	public MappingTableEntity getMain() {
		return main;
	}

	public void setMain(MappingTableEntity main) {
		this.main = main;
	}

	public String getColName() {
		return colName;
	}

	public void setColName(String colName) {
		this.colName = colName;
	}

	public String getColNameDb() {
		return colNameDb;
	}

	public void setColNameDb(String colNameDb) {
		this.colNameDb = colNameDb;
	}

	public String getColDesc() {
		return colDesc;
	}

	public void setColDesc(String colDesc) {
		this.colDesc = colDesc;
	}

	public String getEleType() {
		return eleType;
	}

	public void setEleType(String eleType) {
		this.eleType = eleType;
	}

	public String getColType() {
		return colType;
	}

	public void setColType(String colType) {
		this.colType = colType;
	}

	public String getColLength() {
		return colLength;
	}

	public void setColLength(String colLength) {
		this.colLength = colLength;
	}



}
