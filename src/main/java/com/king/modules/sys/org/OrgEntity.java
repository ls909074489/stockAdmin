package com.king.modules.sys.org;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.TreeEntity;

@Entity
@Table(name = "yy_org")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrgEntity extends TreeEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "机构代码")
	@Column(nullable = false, length = 20, unique = true)
	private String org_code;

	@MetaData(value = "机构名称")
	@Column(nullable = false, length = 100)
	private String org_name;

	@MetaData(value = "机构类型")
	private String orgtype;

	@MetaData(value = "上级机构")
	@Column(length = 100)
	private String parentid;

	@MetaData(value = "描述")
	@Column(length = 1000)
	private String description;

	@MetaData(value = "创建人")
	@Column(length = 50)
	private String creater;

	@MetaData(value = "创建时间")
	private String createdDate;

	@MetaData(value = "是否启用")
	private String active;

	@MetaData(value = "是否末级节点")
	private Boolean islast;

	@MetaData(value = "机构级别")
	private String orglevel;
	
	@MetaData(value = "厂站图示")
	@Column(length = 250)
	private String sketch;

	@MetaData(value = "厂站图示url")
	@Column(length = 250)
	private String sketchUrl;

	
	@MetaData(value = "机构标示")
	@Column(nullable = false, length = 50)
	private String org_index;
	
	@Transient
	private String tparentid;
	
	public String getOrg_code() {
		return org_code;
	}

	public void setOrg_code(String org_code) {
		this.org_code = org_code;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	@Override
	public String getCode() {
		return this.getOrg_code();
	}

	@Override
	public String getName() {
		return this.getOrg_name();
	}

	@Override
	public String getParentId() {
		return this.parentid;
	}

	public Boolean getIslast() {
		return islast;
	}

	public void setIslast(Boolean islast) {
		this.islast = islast;
	}

	public String getOrgtype() {
		return orgtype;
	}

	public void setOrgtype(String orgtype) {
		this.orgtype = orgtype;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOrglevel() {
		return orglevel;
	}

	public void setOrglevel(String orglevel) {
		this.orglevel = orglevel;
	}

	public String getSketch() {
		return sketch;
	}

	public void setSketch(String sketch) {
		this.sketch = sketch;
	}

	public String getSketchUrl() {
		return sketchUrl;
	}

	public void setSketchUrl(String sketchUrl) {
		this.sketchUrl = sketchUrl;
	}

	public String getOrg_index() {
		return org_index;
	}

	public void setOrg_index(String org_index) {
		this.org_index = org_index;
	}

	public String getTparentid() {
		return tparentid;
	}

	public void setTparentid(String tparentid) {
		this.tparentid = tparentid;
	}
	
	
}