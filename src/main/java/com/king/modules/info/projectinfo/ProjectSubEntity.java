package com.king.modules.info.projectinfo;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.material.MaterialBaseEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Entity
@Table(name = "yy_project_sub")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectSubEntity extends BaseEntity {

	
	public static final String checkStatus_init="10";
	public static final String checkStatus_pass="20";
	public static final String checkStatus_error="30";
	
	public static final String BARCODE_STATUS_INIT="10";
	public static final String BARCODE_STATUS_LENGTH_WRONG="30";
	
	private static final long serialVersionUID = 1L;

	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private ProjectInfoEntity main;
	
	@Column(name = "mid",nullable=false,length=36)
	private String mid;
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	
	
	@MetaData(value = "计划数量")
	@Column()
	private Long planAmount;
	
	@MetaData(value = "收货数量")
	@Column()
	private Long actualAmount;//只是收货的数量
	@MetaData(value = "剩余数量")
	@Column()
	private Long surplusAmount=0l;//项目单剩下的数量，包括收货和挪料的数量

	@MetaData(value = "备注")
	@Column()
	private String memo;
	
	@Column(length=50)
	private String boxNum;
	
	@Column(name = "barcode",length=50)
	private String barcode="";//条码
	
//	@MetaData(value = "条码验证状态")
//	@Column(length=2000)
//	private String barcodejson="[]";//条码json ProjectBarcodeVo
	
	@MetaData(value = "条码验证状态")
	@Column(length=2)
	private String checkStatus="10";//条码验证状态
	
	@MetaData(value = "限制每箱数量")
	@Column(length = 10)
	private int limitCount=-1;//-1表示不限制
	
	@Column()
	private Date receiveTime;
	
	@Column(length = 250)
	private String receiveMemo;
	
	@MetaData(value = "预警时间")
	@Column()
	private Date warningTime;

	@MetaData(value = "收货类型 0：未完成  1：已完成")
	@Column(length = 2)
	private String subReceiveType="0";
	
	@Transient
	private String materialId;

	@Transient
	private String newBarcode="";
	@Transient
	private String newUuid="";
	@Transient
	private String receiveLog="";
	@Transient
	private String barcodeStatus="10";
	@Transient
	private String firstRow="0";//唯一条码多行，是否第一行
	
	
	@Transient
	@JsonIgnore
	private String materialCode="";
	@Transient
	@JsonIgnore
	private String materialHwCode="";
	@Transient
	@JsonIgnore
	private String materialDesc="";
	@Transient
	@JsonIgnore
	private String materialUnit="";
	@Transient
	@JsonIgnore
	private String materialPurchaseType="";//采购模式
	@Transient
	@JsonIgnore
	private String barcodeUuid="";
	@Transient
	private Long receiveAmount=0l;//收货数量
	
	
	public ProjectInfoEntity getMain() {
		return main;
	}

	public void setMain(ProjectInfoEntity main) {
		this.main = main;
	}

	public Long getPlanAmount() {
		return planAmount;
	}

	public void setPlanAmount(Long planAmount) {
		this.planAmount = planAmount;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public MaterialBaseEntity getMaterial() {
		return material;
	}

	public void setMaterial(MaterialBaseEntity material) {
		this.material = material;
	}

	public String getMaterialId() {
		return materialId;
	}

	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}

	public String getBoxNum() {
		return boxNum;
	}

	public void setBoxNum(String boxNum) {
		this.boxNum = boxNum;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public String getNewBarcode() {
		return newBarcode;
	}

	public void setNewBarcode(String newBarcode) {
		this.newBarcode = newBarcode;
	}

	public String getMaterialCode() {
		return materialCode;
	}

	public void setMaterialCode(String materialCode) {
		this.materialCode = materialCode;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getMaterialDesc() {
		return materialDesc;
	}

	public void setMaterialDesc(String materialDesc) {
		this.materialDesc = materialDesc;
	}

	public String getMaterialUnit() {
		return materialUnit;
	}

	public void setMaterialUnit(String materialUnit) {
		this.materialUnit = materialUnit;
	}

	public String getMaterialHwCode() {
		return materialHwCode;
	}

	public void setMaterialHwCode(String materialHwCode) {
		this.materialHwCode = materialHwCode;
	}

	public String getMaterialPurchaseType() {
		return materialPurchaseType;
	}

	public void setMaterialPurchaseType(String materialPurchaseType) {
		this.materialPurchaseType = materialPurchaseType;
	}

//	public String getBarcodejson() {
//		return barcodejson;
//	}
//
//	public void setBarcodejson(String barcodejson) {
//		this.barcodejson = barcodejson;
//	}

	public int getLimitCount() {
		return limitCount;
	}

	public void setLimitCount(int limitCount) {
		this.limitCount = limitCount;
	}

	public String getNewUuid() {
		return newUuid;
	}

	public void setNewUuid(String newUuid) {
		this.newUuid = newUuid;
	}

	public String getReceiveLog() {
		return receiveLog;
	}

	public void setReceiveLog(String receiveLog) {
		this.receiveLog = receiveLog;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(Date receiveTime) {
		this.receiveTime = receiveTime;
	}

	public String getReceiveMemo() {
		return receiveMemo;
	}

	public void setReceiveMemo(String receiveMemo) {
		this.receiveMemo = receiveMemo;
	}

	public String getBarcodeStatus() {
		return barcodeStatus;
	}

	public void setBarcodeStatus(String barcodeStatus) {
		this.barcodeStatus = barcodeStatus;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getWarningTime() {
		return warningTime;
	}

	public void setWarningTime(Date warningTime) {
		this.warningTime = warningTime;
	}

	public Long getSurplusAmount() {
		return surplusAmount;
	}

	public void setSurplusAmount(Long surplusAmount) {
		this.surplusAmount = surplusAmount;
	}

	public String getFirstRow() {
		return firstRow;
	}

	public void setFirstRow(String firstRow) {
		this.firstRow = firstRow;
	}

	public String getBarcodeUuid() {
		return barcodeUuid;
	}

	public void setBarcodeUuid(String barcodeUuid) {
		this.barcodeUuid = barcodeUuid;
	}

	public String getSubReceiveType() {
		return subReceiveType;
	}

	public void setSubReceiveType(String subReceiveType) {
		this.subReceiveType = subReceiveType;
	}

	public Long getReceiveAmount() {
		return receiveAmount;
	}

	public void setReceiveAmount(Long receiveAmount) {
		this.receiveAmount = receiveAmount;
	}
	
}