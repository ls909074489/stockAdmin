package com.king.modules.sys.userrole;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.role.RoleEntity;
import com.king.modules.sys.user.UserEntity;

@Entity
@Table(name = "yy_userrole")
// @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserRoleEntity extends BaseEntity{

	private static final long serialVersionUID = 7189328760547844257L;
	

	@ManyToOne(targetEntity = UserEntity.class)
	@JoinColumn(name = "user_id", referencedColumnName = "uuid")
	private UserEntity user;
	
	@ManyToOne(targetEntity = RoleEntity.class)
	@JoinColumn(name = "role_id", referencedColumnName = "uuid")
	private RoleEntity role;

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public RoleEntity getRole() {
		return role;
	}

	public void setRole(RoleEntity role) {
		this.role = role;
	}
}
