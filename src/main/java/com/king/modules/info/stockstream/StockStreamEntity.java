package com.king.modules.info.stockstream;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-05 14:02:18
 */
@Entity
@Table(name = "yy_stock_stream")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StockStreamEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	public static String IN_STOCK="0";//增加库存
	public static String OUT_STOCK="1";//减少库存

	//0不需预警 1：要预警 2:以用完不需预警
	public static String WARNINGTYPE_NO_NEED="0";
	public static String WARNINGTYPE_BE_NEED="1";
	public static String WARNINGTYPE_HAS_USE="2";
	
	@MetaData(value = "仓库")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "stock_id",nullable=true)
	private StockBaseEntity stock;
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	
	
	@MetaData(value = "源id")
	@Column(length = 50)
	private String sourceId;

	@MetaData(value = "源单号")
	@Column(length = 50)
	private String sourceBillCode;

	@MetaData(value = "总数量")
	@Column()
	private Long totalBefore;

	@MetaData(value = "预占数量")
	@Column()
	private Long occupyBefore;

	@MetaData(value = "剩余数量")
	@Column()
	private Long surplusBefore;
	
	@MetaData(value = "总数量")
	@Column()
	private Long totalAfter;

	@MetaData(value = "预占数量")
	@Column()
	private Long occupyAfter;

	@MetaData(value = "剩余数量")
	@Column()
	private Long surplusAfter;
	
	
	@MetaData(value = "实际数量")
	@Column()
	private Long actualAmount;
	

	@MetaData(value = "操作类型0：增加库存  1：减少库存")
	@Column(length = 1)
	private String operType;
	
	@MetaData(value = "计划数量")
	@Column()
	private Date WarningTime;
	
	private String warningType="0";//0不需预警 1：要预警 2:以用完不需预警
	
	@MetaData(value = "剩余数量")
	@Column()
	private Long surplusAmount;

	public StockBaseEntity getStock() {
		return stock;
	}


	public void setStock(StockBaseEntity stock) {
		this.stock = stock;
	}


	public MaterialBaseEntity getMaterial() {
		return material;
	}


	public void setMaterial(MaterialBaseEntity material) {
		this.material = material;
	}


	public String getSourceId() {
		return sourceId;
	}


	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}


	public String getSourceBillCode() {
		return sourceBillCode;
	}


	public void setSourceBillCode(String sourceBillCode) {
		this.sourceBillCode = sourceBillCode;
	}


	public Long getTotalBefore() {
		return totalBefore;
	}


	public void setTotalBefore(Long totalBefore) {
		this.totalBefore = totalBefore;
	}


	public Long getOccupyBefore() {
		return occupyBefore;
	}


	public void setOccupyBefore(Long occupyBefore) {
		this.occupyBefore = occupyBefore;
	}


	public Long getSurplusBefore() {
		return surplusBefore;
	}


	public void setSurplusBefore(Long surplusBefore) {
		this.surplusBefore = surplusBefore;
	}


	public Long getTotalAfter() {
		return totalAfter;
	}


	public void setTotalAfter(Long totalAfter) {
		this.totalAfter = totalAfter;
	}


	public Long getOccupyAfter() {
		return occupyAfter;
	}


	public void setOccupyAfter(Long occupyAfter) {
		this.occupyAfter = occupyAfter;
	}


	public Long getSurplusAfter() {
		return surplusAfter;
	}


	public void setSurplusAfter(Long surplusAfter) {
		this.surplusAfter = surplusAfter;
	}


	public Long getActualAmount() {
		return actualAmount;
	}


	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}


	public String getOperType() {
		return operType;
	}


	public void setOperType(String operType) {
		this.operType = operType;
	}

	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	public Date getWarningTime() {
		return WarningTime;
	}


	public void setWarningTime(Date warningTime) {
		WarningTime = warningTime;
	}


	public String getWarningType() {
		return warningType;
	}


	public void setWarningType(String warningType) {
		this.warningType = warningType;
	}


	public Long getSurplusAmount() {
		return surplusAmount;
	}


	public void setSurplusAmount(Long surplusAmount) {
		this.surplusAmount = surplusAmount;
	}

}