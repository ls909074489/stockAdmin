package com.king.modules.info.projectinfo;

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

import com.king.common.annotation.MetaData;
import com.king.frame.entity.SuperEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Entity
@Table(name = "yy_project_info")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectInfoEntity extends SuperEntity {

	private static final long serialVersionUID = 1L;
	
	public static final String receiveType_no="0";
	public static final String receiveType_yes="1";

	@ManyToOne(optional = false)
	@JoinColumn(name = "stockid")
	private StockBaseEntity stock;
	
	@Column(length = 50)
	private String code;
	
	@MetaData(value = "项目名称")
	@Column(length = 100)
	private String name;

	@MetaData(value = "备注")
	@Column(length = 250)
	private String memo;
	
	@MetaData(value = "收货类型 0：未收 1：已收")
	@Column(length = 2)
	private String receiveType="0";
	
	@Transient
	private String stockId;
	

	public StockBaseEntity getStock() {
		return stock;
	}

	public void setStock(StockBaseEntity stock) {
		this.stock = stock;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getStockId() {
		return stockId;
	}

	public void setStockId(String stockId) {
		this.stockId = stockId;
	}

	public String getReceiveType() {
		return receiveType;
	}

	public void setReceiveType(String receiveType) {
		this.receiveType = receiveType;
	}
}