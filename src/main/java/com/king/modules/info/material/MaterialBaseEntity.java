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
public class MaterialBaseEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	@MetaData(value = "物料编码")
	@Column(length = 50)
	private String code;

	@MetaData(value = "名称")
	@Column(length = 250)
	private String name;

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
	

	

}