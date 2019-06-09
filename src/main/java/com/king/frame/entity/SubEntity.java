package com.king.frame.entity;

import javax.persistence.MappedSuperclass;

import com.king.common.annotation.MetaData;

/**
 * 实体子表基类 -超级
 * 
 * 
 * @author zhangcb
 *
 */
@MappedSuperclass
public class SubEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	@MetaData(value = "来源单据号")
	protected String sourcebillcode;
	
	@MetaData(value = "来源单据类型")  
	protected String sourcebilltype;
	
	@MetaData(value = "来源业务类型") 
	protected String sourcebusinesstype; 
	
	@MetaData(value = "来源id") 
	protected String sourceid;

	@MetaData(value = "来源子id")
	protected String sourcechildid;
	
	
	
	@MetaData(value = "源头单据号") //not null
	protected String firstbillcode;
	
	@MetaData(value = "源头单据类型") //not null
	protected String firstbilltype;
	
	@MetaData(value = "源头业务类型") 
	protected String firstbusinesstype; 
	
	@MetaData(value = "源头id")	//not null
	protected String firstid;
	
	@MetaData(value = "源头单据号子id")
	protected String firstchildid;

	@MetaData(value = "行号")
	protected Integer rowno;

	public String getSourcebillcode() {
		return sourcebillcode;
	}

	public void setSourcebillcode(String sourcebillcode) {
		this.sourcebillcode = sourcebillcode;
	}

	public String getSourcebilltype() {
		return sourcebilltype;
	}

	public void setSourcebilltype(String sourcebilltype) {
		this.sourcebilltype = sourcebilltype;
	}

	public String getSourcebusinesstype() {
		return sourcebusinesstype;
	}

	public void setSourcebusinesstype(String sourcebusinesstype) {
		this.sourcebusinesstype = sourcebusinesstype;
	}

	public String getSourceid() {
		return sourceid;
	}

	public void setSourceid(String sourceid) {
		this.sourceid = sourceid;
	}

	public String getSourcechildid() {
		return sourcechildid;
	}

	public void setSourcechildid(String sourcechildid) {
		this.sourcechildid = sourcechildid;
	}

	public String getFirstbillcode() {
		return firstbillcode;
	}

	public void setFirstbillcode(String firstbillcode) {
		this.firstbillcode = firstbillcode;
	}

	public String getFirstbilltype() {
		return firstbilltype;
	}

	public String getFirstbusinesstype() {
		return firstbusinesstype;
	}

	public void setFirstbusinesstype(String firstbusinesstype) {
		this.firstbusinesstype = firstbusinesstype;
	}

	public void setFirstbilltype(String firstbilltype) {
		this.firstbilltype = firstbilltype;
	}

	public String getFirstid() {
		return firstid;
	}

	public void setFirstid(String firstid) {
		this.firstid = firstid;
	}

	public String getFirstchildid() {
		return firstchildid;
	}

	public void setFirstchildid(String firstchildid) {
		this.firstchildid = firstchildid;
	}

	public Integer getRowno() {
		return rowno;
	}

	public void setRowno(Integer rowno) {
		this.rowno = rowno;
	}

}
