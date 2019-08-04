package com.king.modules.info.stockdetail;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;

/**
 * 库存明细
 * @author null
 * @date 2019-06-18 11:50:47
 */
@Entity
@Table(name = "yy_stock_detail")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StockDetailEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	@MetaData(value = "仓库")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "stock_id",nullable=true)
	private StockBaseEntity stock;
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	

	@MetaData(value = "总数量")
	@Transient
	private Long totalAmount=0l;

	@MetaData(value = "剩余数量")
	@Transient
	private Long surplusAmount=0l;

	@MetaData(value = "预占数量")
	@Transient
	private Long occupyAmount=0l;

	@MetaData(value = "实际数量/可用数量")
	@Transient
	private Long actualAmount=0l;

	
	public MaterialBaseEntity getMaterial() {
		return material;
	}

	public void setMaterial(MaterialBaseEntity material) {
		this.material = material;
	}

	public StockBaseEntity getStock() {
		return stock;
	}

	public void setStock(StockBaseEntity stock) {
		this.stock = stock;
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

	public Long getSurplusAmount() {
		return surplusAmount;
	}

	public void setSurplusAmount(Long surplusAmount) {
		this.surplusAmount = surplusAmount;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

}