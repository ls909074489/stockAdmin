package com.king.modules.info.projectinfo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import com.king.frame.entity.BaseEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Entity
@Table(name = "yy_project_barcode")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectSubBarcodeEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private ProjectInfoBaseEntity main;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "subid")
	private ProjectSubBaseEntity sub;
	
	@Column(name = "条码",length=50)
	private String barcode="";

	@Column(name = "流水id",length=36)
	private String streamId="";

	public ProjectInfoBaseEntity getMain() {
		return main;
	}

	public void setMain(ProjectInfoBaseEntity main) {
		this.main = main;
	}

	public ProjectSubBaseEntity getSub() {
		return sub;
	}

	public void setSub(ProjectSubBaseEntity sub) {
		this.sub = sub;
	}

	public String getBarcode() {
		return barcode;
	}


	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}


	public String getStreamId() {
		return streamId;
	}


	public void setStreamId(String streamId) {
		this.streamId = streamId;
	}
	
	
}