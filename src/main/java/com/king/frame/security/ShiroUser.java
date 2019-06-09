package com.king.frame.security;

import java.io.Serializable;

import org.apache.shiro.SecurityUtils;

import com.google.common.base.Objects;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.org.OrgUtils;
import com.king.modules.sys.user.UserEntity;

/**
 * 自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息.
 */
public class ShiroUser implements Serializable {

	private static final long serialVersionUID = 9137711927317844432L;

	public String id;
	public UserEntity userEntity;

	public ShiroUser(String id, UserEntity userEntity) {
		this.id = id;
		this.userEntity = userEntity;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public UserEntity getUserEntity() {
		return userEntity;
	}

	public void setUserEntity(UserEntity userEntity) {
		this.userEntity = userEntity;
	}

	/**
	 * 本函数输出将作为默认的<shiro:principal/>输出.
	 */
	@Override
	public String toString() {
		return id;
	}

	/**
	 * 重载hashCode,只计算loginName;
	 */
	@Override
	public int hashCode() {
		return Objects.hashCode(id);
	}

	/**
	 * 重载equals,只计算loginName;
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ShiroUser other = (ShiroUser) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	/**
	 * 更新Shiro中当前用户信息.
	 * 
	 * @param user
	 */
	public static void updateCurrentUserEntity(UserEntity user) {
		ShiroUser u = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (user != null)
			u.userEntity = user;
	}

	/**
	 * 获取Shiro中当前用户对象
	 * 
	 * @return
	 */
	public static UserEntity getCurrentUserEntity() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (user != null)
			return user.userEntity;
		else
			return null;
	}

	/**
	 * 获取Shiro中当前用户所在的业务单元
	 * 
	 * @return
	 * 
	 * @return
	 */
	public static OrgEntity getCurrentOrgEntity() {
		ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		if (user != null) {
			return OrgUtils.getEntity(user.userEntity.getOrgid());
		}
		return null;
	}

}
