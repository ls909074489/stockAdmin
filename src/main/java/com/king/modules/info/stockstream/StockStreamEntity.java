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
	
	public static final String IN_STOCK="0";//增加库存
	public static final String OUT_STOCK="1";//减少库存

	//0不需预警 1：要预警 2:以用完不需预警
	public static final String WARNINGTYPE_NO_NEED="0";
	public static final String WARNINGTYPE_BE_NEED="1";
	public static final String WARNINGTYPE_HAS_USE="2";
	
	public static final String BILLTYPE_ORDER="10";
	public static final String BILLTYPE_RECEIVE="20";
	public static final String BILLTYPE_PROJECT="30";
	public static final String BILLTYPE_BORROW="40";
	
	@MetaData(value = "仓库")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "stock_id",nullable=true)
	private StockBaseEntity stock;
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	
//	@MetaData(value = "项目")
//	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
//	@JoinColumn(name = "project_id",nullable=true)
//	private ProjectInfoBaseEntity project;
	
	@MetaData(value = "库存明细id")
	@Column(length = 36)
	private String stockDetailId;//项目单id
	
	@MetaData(value = "源id")
	@Column(length = 50)
	private String sourceId;//项目单id

	@MetaData(value = "源单号")
	@Column(length = 50)
	private String sourceBillCode;
	
	@MetaData(value = "源子表id")
	@Column(length = 36)
	private String sourceSubId;
	
	@MetaData(value = "项目子表id")
	@Column(length = 36)
	private String projectSubId;

	@MetaData(value = "操作类型0：增加库存  1：减少库存")
	@Column(length = 1)
	private String operType;
	
	@MetaData(value = "单据类型 StockStreamEntity.BILLTYPE_XXX")
	@Column(length = 2)
	private String billType;
	
	@MetaData(value = "计划数量")
	@Column()
	private Date warningTime;
	
	private String warningType="0";//0不需预警 1：要预警 2:以用完不需预警
	

	@MetaData(value = "总数量")
	@Column()
	private Long totalAmount;
	
	@MetaData(value = "剩余数量")
	@Column()
	private Long surplusAmount;
	
	@MetaData(value = "预占数量")
	@Column()
	private Long occupyAmount;

	@MetaData(value = "实际数量/可用数量")
	@Column()
	private Long actualAmount;
	
	
	@MetaData(value = "备注")
	@Column(length = 250)
	private String memo;
	
	
//	@MetaData(value = "总数量")
//	@Column()
//	private Long totalBefore;
//
//	@MetaData(value = "预占数量")
//	@Column()
//	private Long occupyBefore;
//
//	@MetaData(value = "剩余数量")
//	@Column()
//	private Long surplusBefore;
//	
//	@MetaData(value = "总数量")
//	@Column()
//	private Long totalAfter;
//
//	@MetaData(value = "预占数量")
//	@Column()
//	private Long occupyAfter;
//
//	@MetaData(value = "剩余数量")
//	@Column()
//	private Long surplusAfter;
	
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
		return warningTime;
	}

	public void setWarningTime(Date warningTime) {
		this.warningTime = warningTime;
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

	public String getSourceSubId() {
		return sourceSubId;
	}

	public void setSourceSubId(String sourceSubId) {
		this.sourceSubId = sourceSubId;
	}


	public Long getTotalAmount() {
		return totalAmount;
	}


	public void setTotalAmount(Long totalAmount) {
		this.totalAmount = totalAmount;
	}


	public Long getOccupyAmount() {
		return occupyAmount;
	}


	public void setOccupyAmount(Long occupyAmount) {
		this.occupyAmount = occupyAmount;
	}


	public String getBillType() {
		return billType;
	}


	public void setBillType(String billType) {
		this.billType = billType;
	}


	public String getProjectSubId() {
		return projectSubId;
	}


	public void setProjectSubId(String projectSubId) {
		this.projectSubId = projectSubId;
	}


	public String getMemo() {
		return memo;
	}


	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getStockDetailId() {
		return stockDetailId;
	}

	public void setStockDetailId(String stockDetailId) {
		this.stockDetailId = stockDetailId;
	}
	

}