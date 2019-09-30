package com.king.modules.info.projectinfo;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.king.common.annotation.MetaData;
import com.king.modules.info.material.MaterialBaseEntity;

public class ProjectSubUnOutVo {

	private String uuid;
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	
	@MetaData(value = "限制每箱数量")
	@Column(length = 10)
	private int limitCount=-1;//-1表示不限制
	
	private Long unScanCount;

	@MetaData(value = "计划数量")
	@Column()
	private Long planAmount;
	
	public ProjectSubUnOutVo() {
	}
	
	public ProjectSubUnOutVo(String uuid, MaterialBaseEntity material, int limitCount, Long unScanCount,Long planAmount) {
		this.uuid = uuid;
		this.material = material;
		this.limitCount = limitCount;
		this.unScanCount = unScanCount;
		this.planAmount = planAmount;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public MaterialBaseEntity getMaterial() {
		return material;
	}

	public void setMaterial(MaterialBaseEntity material) {
		this.material = material;
	}

	public int getLimitCount() {
		return limitCount;
	}

	public void setLimitCount(int limitCount) {
		this.limitCount = limitCount;
	}

	public Long getUnScanCount() {
		return unScanCount;
	}

	public void setUnScanCount(Long unScanCount) {
		this.unScanCount = unScanCount;
	}

	public Long getPlanAmount() {
		return planAmount;
	}

	public void setPlanAmount(Long planAmount) {
		this.planAmount = planAmount;
	}
	
	
}
