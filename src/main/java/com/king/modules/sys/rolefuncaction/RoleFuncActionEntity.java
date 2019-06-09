package com.king.modules.sys.rolefuncaction;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.func.action.FuncActionEntity;
import com.king.modules.sys.rolefunc.RoleFuncEntity;

@Entity
@Table(name = "yy_rolefunc_action")
// @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class RoleFuncActionEntity extends BaseEntity{
	private static final long serialVersionUID = 3408316052435974525L;

	@ManyToOne(targetEntity = RoleFuncEntity.class)
	@JoinColumn(name = "rolefunc_id", referencedColumnName = "uuid")
	private RoleFuncEntity roleFunc;
	
	@ManyToOne(targetEntity = FuncActionEntity.class)
	@JoinColumn(name = "func_action_id", referencedColumnName = "uuid")
	private FuncActionEntity funcAction;

	public RoleFuncEntity getRoleFunc() {
		return roleFunc;
	}

	public void setRoleFunc(RoleFuncEntity roleFunc) {
		this.roleFunc = roleFunc;
	}

	public FuncActionEntity getFuncAction() {
		return funcAction;
	}

	public void setFuncAction(FuncActionEntity funcAction) {
		this.funcAction = funcAction;
	}

	
}
