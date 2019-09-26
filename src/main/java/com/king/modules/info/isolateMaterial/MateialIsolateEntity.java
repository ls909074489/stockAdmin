package com.king.modules.info.isolateMaterial;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

/**
 * 隔离物料
 * @author lenovo
 *
 */
@Entity
@Table(name = "yy_material_isolate")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MateialIsolateEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	@MetaData(value = "条码")
	@Column(length = 50)
	private String barcode;

	@Transient
	private String exitType="0";//是否存在项目
	@Transient
	private String projectCode;
	@Transient
	private String projectBoxNum;
	@Transient
	private String projectMaterial;
	
	
	
	public String getBarcode() {
		return barcode;
	}


	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}


	public String getExitType() {
		return exitType;
	}


	public void setExitType(String exitType) {
		this.exitType = exitType;
	}


	public String getProjectCode() {
		return projectCode;
	}


	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}


	public String getProjectBoxNum() {
		return projectBoxNum;
	}


	public void setProjectBoxNum(String projectBoxNum) {
		this.projectBoxNum = projectBoxNum;
	}


	public String getProjectMaterial() {
		return projectMaterial;
	}


	public void setProjectMaterial(String projectMaterial) {
		this.projectMaterial = projectMaterial;
	}


}