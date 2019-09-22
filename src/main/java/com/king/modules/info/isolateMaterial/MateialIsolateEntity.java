package com.king.modules.info.isolateMaterial;

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
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.material.MaterialEntity;

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
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "materialid")
	private MaterialEntity material;
	
	@Transient
	private String materialId;


	public String getBarcode() {
		return barcode;
	}


	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}


	public MaterialEntity getMaterial() {
		return material;
	}


	public void setMaterial(MaterialEntity material) {
		this.material = material;
	}


	public String getMaterialId() {
		return materialId;
	}


	public void setMaterialId(String materialId) {
		this.materialId = materialId;
	}

}