package com.king.modules.info.stockinfo;

import javax.persistence.Column;
import com.king.frame.entity.BaseEntity;
import com.king.common.annotation.MetaData;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 仓库
 * @author null
 * @date 2019-06-17 21:24:38
 */
@Entity
@Table(name = "yy_stock_info")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StockBaseEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "仓库编码")
	@Column(length = 50)
	private String code;
	
	@MetaData(value = "仓库名称")
	@Column(length = 100)
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