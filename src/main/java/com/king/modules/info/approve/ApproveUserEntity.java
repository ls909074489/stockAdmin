package com.king.modules.info.approve;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.user.UserEntity;

/**
 * 审核人
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Entity
@Table(name = "yy_approve_user")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ApproveUserEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;
	
	public static final String PROJECTINFO_TYPE="02";
	
	@MetaData(value = "申请类型")
	@Column(length = 2)
	private String applyType;
	
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "userid")
	private UserEntity user;


	public String getApplyType() {
		return applyType;
	}


	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}


	public UserEntity getUser() {
		return user;
	}


	public void setUser(UserEntity user) {
		this.user = user;
	}
	
	

}