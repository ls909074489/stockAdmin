package com.king.modules.info.receive;

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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.info.projectinfo.ProjectInfoEntity;
import com.king.modules.info.projectinfo.ProjectSubBaseEntity;

/**
 * 收货
 * @author ls2008
 * @date 2019-07-23 16:59:39
 */
@Entity
@Table(name = "yy_project_receive")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectReceiveEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public static final String receiveType_add="1";//增加
	public static final String receiveType_sub="0";//减少
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private ProjectInfoEntity main;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "subid")
	private ProjectSubBaseEntity sub;
	
	@MetaData(value = "收货数量")
	@Column()
	private Long receiveAmount;
	
	@MetaData(value = "收货 类型")
	@Column(length=2)
	private String receiveType;
	
	
	@Transient
	@JsonIgnore
	private String mainId;
	@Transient
	@JsonIgnore
	private String subId;

	public ProjectInfoEntity getMain() {
		return main;
	}

	public void setMain(ProjectInfoEntity main) {
		this.main = main;
	}

	public ProjectSubBaseEntity getSub() {
		return sub;
	}

	public void setSub(ProjectSubBaseEntity sub) {
		this.sub = sub;
	}

	public Long getReceiveAmount() {
		return receiveAmount;
	}

	public void setReceiveAmount(Long receiveAmount) {
		this.receiveAmount = receiveAmount;
	}

	public String getReceiveType() {
		return receiveType;
	}

	public void setReceiveType(String receiveType) {
		this.receiveType = receiveType;
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public String getSubId() {
		return subId;
	}

	public void setSubId(String subId) {
		this.subId = subId;
	}


}