package com.king.modules.info.streamborrow;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.projectinfo.ProjectInfoBaseEntity;
import com.king.common.annotation.MetaData;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 挪料
 * @author ls2008
 * @date 2019-07-30 16:02:33
 */
@Entity
@Table(name = "yy_stream_borrow")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StreamBorrowEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	public static final String BILLSTATE_NOT_RETURN="0";
	public static final String BILLSTATE_HAS_RETURN="1";
	
	@MetaData(value = "物料")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "material_id",nullable=true)
	private MaterialBaseEntity material;
	
	@MetaData(value = "项目")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "project_from_id",nullable=true)
	private ProjectInfoBaseEntity projectFrom;
	
	@MetaData(value = "项目")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "project_to_id",nullable=true)
	private ProjectInfoBaseEntity projectTo;
	
	@MetaData(value = "项目子表id")
	@Column(length = 36)
	private String fromSubId;
	
	@MetaData(value = "项目子表id")
	@Column(length = 36)
	private String toSubId;
	
	@MetaData(value = "借的数量")
	@Column()
	private Long actualAmount;
	
	@MetaData(value = "欠的数量")
	@Column()
	private Long oweAmount=0l;
	

	@MetaData(value = "单据类型")
	@Column(length = 2)
	private String billState="0";//0未还，1已还

	public MaterialBaseEntity getMaterial() {
		return material;
	}

	public void setMaterial(MaterialBaseEntity material) {
		this.material = material;
	}

	public ProjectInfoBaseEntity getProjectFrom() {
		return projectFrom;
	}

	public void setProjectFrom(ProjectInfoBaseEntity projectFrom) {
		this.projectFrom = projectFrom;
	}

	public ProjectInfoBaseEntity getProjectTo() {
		return projectTo;
	}

	public void setProjectTo(ProjectInfoBaseEntity projectTo) {
		this.projectTo = projectTo;
	}

	public String getFromSubId() {
		return fromSubId;
	}

	public void setFromSubId(String fromSubId) {
		this.fromSubId = fromSubId;
	}

	public String getToSubId() {
		return toSubId;
	}

	public void setToSubId(String toSubId) {
		this.toSubId = toSubId;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

	public String getBillState() {
		return billState;
	}

	public void setBillState(String billState) {
		this.billState = billState;
	}

	public Long getOweAmount() {
		return oweAmount;
	}

	public void setOweAmount(Long oweAmount) {
		this.oweAmount = oweAmount;
	}

}