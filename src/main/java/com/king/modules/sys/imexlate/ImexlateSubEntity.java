package com.king.modules.sys.imexlate;

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

@MetaData(value = "ImplateSub信息")
@Entity
@Table(name = "yy_imexlate_sub")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ImexlateSubEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "模板id")
	@ManyToOne(targetEntity = ImexlateEntity.class)
	@JoinColumn(name = "templateId", referencedColumnName = "uuid")
	private ImexlateEntity implate;

	@MetaData(value = "字段名")
	@Column
	private String fieldName;

	@MetaData(value = "字段中文名")
	@Column
	private String chineseField;

	@MetaData(value = "是否主表字段")
	@Column
	private Boolean isMainField = false;//

	@MetaData(value = "导出列号")
	@Column
	private String exportCellNum;//

	@MetaData(value = "是否可为空")
	@Column
	private Boolean isnotempty = false;//

	@MetaData(value = "枚举编码")
	@Column
	private String enumdata;

	@MetaData(value = "数据类型，0或者null代表普通，1代表int，2代表数字（两位小数）")
	@Column
	private String datatype;

	@MetaData(value = "限定值")
	@Column
	private String qualifiedValue;

	@MetaData(value = "列宽度")
	@Column
	private Integer columnWidth;
	
	public String getEnumdata() {
		return enumdata;
	}

	public void setEnumdata(String enumdata) {
		this.enumdata = enumdata;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getChineseField() {
		return chineseField;
	}

	public void setChineseField(String chineseField) {
		this.chineseField = chineseField;
	}

	public ImexlateEntity getImplate() {
		return implate;
	}

	public void setImplate(ImexlateEntity implate) {
		this.implate = implate;
	}

	public Boolean getIsMainField() {
		return isMainField;
	}

	public void setIsMainField(Boolean isMainField) {
		this.isMainField = isMainField;
	}

	public String getExportCellNum() {
		return exportCellNum;
	}

	public void setExportCellNum(String exportCellNum) {
		this.exportCellNum = exportCellNum;
	}

	public Boolean getIsnotempty() {
		return isnotempty;
	}

	public void setIsnotempty(Boolean isnotempty) {
		this.isnotempty = isnotempty;
	}

	public String getQualifiedValue() {
		return qualifiedValue;
	}

	public void setQualifiedValue(String qualifiedValue) {
		this.qualifiedValue = qualifiedValue;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public Integer getColumnWidth() {
		return columnWidth;
	}

	public void setColumnWidth(Integer columnWidth) {
		this.columnWidth = columnWidth;
	}

}
