package com.king.modules.sys.func.param;

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
@Table(name = "yy_func_param")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class FuncParamEntity extends BaseEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@ManyToOne(optional = false)
	@JoinColumn(name = "funcId")
	private FuncEntity func;
	@Column(nullable=false, length=20)
	private String paramcode;
	@Column(nullable = false, length = 50)
	private String paramname;
	@Column
	private String param;
	@Column
	private Short showorder;
	public FuncEntity getFunc() {
		return func;
	}
	public void setFunc(FuncEntity func) {
		this.func = func;
	}
	public String getParamcode() {
		return paramcode;
	}
	public void setParamcode(String paramcode) {
		this.paramcode = paramcode;
	}
	public String getParamname() {
		return paramname;
	}
	public void setParamname(String paramname) {
		this.paramname = paramname;
	}
	public Short getShoworder() {
		return showorder;
	}
	public void setShoworder(Short showorder) {
		this.showorder = showorder;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	
}
