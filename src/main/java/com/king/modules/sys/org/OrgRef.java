package com.king.modules.sys.org;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;

/**
 * 业务单元
 * @ClassName: OrgRef
 * @author liusheng
 * @date 2016年4月11日 下午5:29:21
 */
@Entity
@Table(name = "yy_org")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrgRef {
	@Id
	@Column
	private String uuid;

	@MetaData(value = "机构代码")
	@Column(nullable = false, length = 20, unique = true)
	private String org_code;

	@MetaData(value = "机构名称")
	@Column(nullable = false, length = 100)
	private String org_name;

	@MetaData(value = "上级机构")
	@Column(length = 100)
	private String parentid;
	

	@MetaData("节点路径")
	@Column(length = 500)
	private String nodepath;
	
	

	public OrgRef() {
	}

	
	public OrgRef(String uuid) {
		this.uuid = uuid;
	}


	public OrgRef(String uuid, String org_code, String org_name) {
		this.uuid = uuid;
		this.org_code = org_code;
		this.org_name = org_name;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

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


	public String getNodepath() {
		return nodepath;
	}


	public void setNodepath(String nodepath) {
		this.nodepath = nodepath;
	}

}