package com.king.modules.sys.rolefunc;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.role.RoleEntity;


@MetaData(value = "角色权限信息")
@Entity
@Table(name="yy_role_func")
@DynamicInsert
@DynamicUpdate
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class RoleFuncEntity extends BaseEntity{
	
	private static final long serialVersionUID = -2104356367361714693L;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ROLE_ID", nullable = false)
	private RoleEntity role;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FUNC_ID", nullable = false)
	private FuncEntity func;


	public RoleEntity getRole() {
		return role;
	}

	public void setRole(RoleEntity role) {
		this.role = role;
	}

	public FuncEntity getFunc() {
		return func;
	}

	public void setFunc(FuncEntity func) {
		this.func = func;
	}

	
	
}
