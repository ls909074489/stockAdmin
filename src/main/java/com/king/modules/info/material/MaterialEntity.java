package com.king.modules.info.material;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

/**
 * 物料
 * @author null
 * @date 2019-06-16 15:53:34
 */
@Entity
@Table(name = "yy_material")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MaterialEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	@MetaData(value = "物料编码")
	@Column(length = 50)
	private String code;
	
	@MetaData(value = "华为物料编码")
	@Column(length = 50)
	private String hwcode;

	@MetaData(value = "名称")
	@Column(length = 250)
	private String name;
	

	@MetaData(value = "物料描述")
	@Column(length = 250)
	private String memo;

	@MetaData(value = "是否风险物料")
	@Column()
	private Integer hasRisk;

	@MetaData(value = "分类描述")
	@Column(length = 250)
	private String classDesc;

	@MetaData(value = "单位")
	@Column(length = 10)
	private String unit;//单位
	
	@MetaData(value = "限制每箱数量")
	@Column(length = 10)
	private int limitCount=-1;//-1表示不限制
	
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
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

	public Integer getHasRisk() {
		return hasRisk;
	}

	public void setHasRisk(Integer hasRisk) {
		this.hasRisk = hasRisk;
	}

	public String getClassDesc() {
		return classDesc;
	}

	public void setClassDesc(String classDesc) {
		this.classDesc = classDesc;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public int getLimitCount() {
		return limitCount;
	}

	public void setLimitCount(int limitCount) {
		this.limitCount = limitCount;
	}

	public String getHwcode() {
		return hwcode;
	}

	public void setHwcode(String hwcode) {
		this.hwcode = hwcode;
	}
	

}