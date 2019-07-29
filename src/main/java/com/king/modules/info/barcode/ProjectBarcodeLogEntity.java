package com.king.modules.info.barcode;

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
 * 
 * @author ls2008
 * @date 2019-07-29 11:04:14
 */
@Entity
@Table(name = "yy_project_barcode_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectBarcodeLogEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "项目id")
	@Column(length = 36)
	private String projectId;

	@MetaData(value = "项目子id")
	@Column(length = 36)
	private String projectSubId;

	@MetaData(value = "条形码")
	@Column(length = 100)
	private String barcode;

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectSubId() {
		return projectSubId;
	}

	public void setProjectSubId(String projectSubId) {
		this.projectSubId = projectSubId;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

}