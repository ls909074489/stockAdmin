package com.king.modules.sys.role;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.rolefunc.RoleFuncEntity;
import com.king.modules.sys.rolegroup.RoleGroupEntity;


@MetaData(value = "角色信息")
@Entity
@Table(name="yy_role")
@DynamicInsert
@DynamicUpdate
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class RoleEntity extends BaseEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@MetaData(value="角色名称")
	@Column(nullable=false,length=50)
	private String name;
	
	@MetaData(value="角色编码")
	@Column(nullable=false,length=50,unique=true)
	private String code;
	
	@MetaData(value="角色描述")
	@Column(length=256)
	private String description;

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "role")
	private Set<RoleFuncEntity> roleFuncs = new HashSet<RoleFuncEntity>(0);
	
	
	@MetaData(value="角色组")
	@ManyToOne(optional = false)
	@OrderBy("rolegroup_name")
	@JoinColumn(name = "rolegroupId")
	private RoleGroupEntity rolegroup;
	
	@MetaData(value="角色组名称")
	@Transient
	private String roleGroupName;
	
	@MetaData(value="角色与用户中间表id")
	@Transient
	private String urUuid;
	
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@JsonBackReference
	public Set<RoleFuncEntity> getRoleFuncs() {
		return roleFuncs;
	}
	@JsonBackReference
	public void setRoleFuncs(Set<RoleFuncEntity> roleFuncs) {
		this.roleFuncs = roleFuncs;
	}
	public RoleGroupEntity getRolegroup() {
		return rolegroup;
	}
	public void setRolegroup(RoleGroupEntity rolegroup) {
		this.rolegroup = rolegroup;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getRoleGroupName() {
		return roleGroupName;
	}

	public void setRoleGroupName(String roleGroupName) {
		this.roleGroupName = roleGroupName;
	}

	public String getUrUuid() {
		return urUuid;
	}

	public void setUrUuid(String urUuid) {
		this.urUuid = urUuid;
	}
	
	
}
