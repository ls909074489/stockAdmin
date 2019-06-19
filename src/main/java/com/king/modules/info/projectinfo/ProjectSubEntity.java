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

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Entity
@Table(name = "yy_project_sub")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectSubEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@ManyToOne(optional = false)
	@JoinColumn(name = "mainid")
	private ProjectInfoEntity main;
	
	@MetaData(value = "计划数量")
	@Column()
	private Long planAmount;
	
	@MetaData(value = "实际数量")
	@Column()
	private Long actualAmount;

	@MetaData(value = "备注")
	@Column()
	private Long memo;

	
	public ProjectInfoEntity getMain() {
		return main;
	}

	public void setMain(ProjectInfoEntity main) {
		this.main = main;
	}

	public Long getPlanAmount() {
		return planAmount;
	}

	public void setPlanAmount(Long planAmount) {
		this.planAmount = planAmount;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

	public Long getMemo() {
		return memo;
	}

	public void setMemo(Long memo) {
		this.memo = memo;
	}
	
	

}