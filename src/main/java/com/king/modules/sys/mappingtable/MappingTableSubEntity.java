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
	
	public class EleType {
		public static final String TEXT = "text";//
		public static final String DATE = "date";//
		public static final String DATETIME = "datetime";//
		public static final String SELECT = "select";//
		public static final String TEXTAREA = "textarea";//
		public static final String REF = "ref";//
	}
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private MappingTableEntity main;
	
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
	private Integer colLength;
	
	
	private boolean isSearch=false;//是否列表查询
	@Column(length = 100)
	private boolean isListVisiable=true;//列表是否显示
	@Column(length = 100)
	private boolean isDetailVisiable=true;//明细是否显示
	@Column(length = 100)
	private boolean isMain=true;//是否主表
	
	private boolean isRequired=false;//是否必填
	private String enumGroup="BooleanType";//枚举类型
	
	private Integer colWidth=100;//列表显示长度
	private Integer colCount=1;//列数
	private boolean isRow=false;//是否单独占一行
	

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

	public Integer getColLength() {
		return colLength;
	}

	public void setColLength(Integer colLength) {
		this.colLength = colLength;
	}

	public boolean isSearch() {
		return isSearch;
	}

	public void setSearch(boolean isSearch) {
		this.isSearch = isSearch;
	}

	public boolean isListVisiable() {
		return isListVisiable;
	}

	public void setListVisiable(boolean isListVisiable) {
		this.isListVisiable = isListVisiable;
	}

	public boolean isDetailVisiable() {
		return isDetailVisiable;
	}

	public void setDetailVisiable(boolean isDetailVisiable) {
		this.isDetailVisiable = isDetailVisiable;
	}

	public boolean isMain() {
		return isMain;
	}

	public void setMain(boolean isMain) {
		this.isMain = isMain;
	}

	public Integer getColWidth() {
		return colWidth;
	}

	public void setColWidth(Integer colWidth) {
		this.colWidth = colWidth;
	}

	public boolean isRequired() {
		return isRequired;
	}

	public void setRequired(boolean isRequired) {
		this.isRequired = isRequired;
	}

	public String getEnumGroup() {
		return enumGroup;
	}

	public void setEnumGroup(String enumGroup) {
		this.enumGroup = enumGroup;
	}

	public Integer getColCount() {
		return colCount;
	}

	public void setColCount(Integer colCount) {
		this.colCount = colCount;
	}

	public boolean isRow() {
		return isRow;
	}

	public void setRow(boolean isRow) {
		this.isRow = isRow;
	}


}
