package com.king.modules.sys.func.action;

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
import com.king.modules.sys.func.FuncEntity;

@Entity
@Table(name = "yy_func_action")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class FuncActionEntity extends BaseEntity {
	
	private static final long serialVersionUID = 3843362176672402288L;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "funcId")
	private FuncEntity func;
	@Column(nullable = false, length = 20,unique=true)
	private String actioncode;
	@Column(nullable = false, length = 50)
	private String actionname;
	@Column
	private Short showorder;

	public FuncEntity getFunc() {
		return func;
	}

	public void setFunc(FuncEntity func) {
		this.func = func;
	}

	public String getActioncode() {
		return actioncode;
	}

	public void setActioncode(String actioncode) {
		this.actioncode = actioncode;
	}

	public String getActionname() {
		return actionname;
	}

	public void setActionname(String actionname) {
		this.actionname = actionname;
	}

	public Short getShoworder() {
		return showorder;
	}

	public void setShoworder(Short showorder) {
		this.showorder = showorder;
	}
}
