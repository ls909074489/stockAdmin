package com.king.frame.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.user.UserEntity;

/**
 * 实体类基类-基本的实体
 * 
 *
 */
// JPA 基类的标识
@MappedSuperclass
public class BaseEntity implements IBaseEntity<T>, Serializable {
	private static final long serialVersionUID = 1L;

	@MetaData(value = "ID")
	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "org.hibernate.id.UUIDGenerator")
	@Column(length = 36, nullable = false)
	protected String uuid;

	@MetaData(value = "记录状态", comments = "1：正常，0：删除")
	// @Column(precision = 2, scale = 0)
	@Column(nullable = false)
	protected Integer status = 1;

	@MetaData(value = "创建人ID")
	@Column(length = 36)
	protected String creator;

	@MetaData(value = "创建人")
	@Column(length = 200)
	protected String creatorname;

	@MetaData(value = "创建时间戳")
	protected Date createtime;

//	@MetaData(value = "创建时间戳")
//	protected Date create_time;

	@MetaData(value = "修改人id")
	@Column(length = 36)
	protected String modifier;

	@MetaData(value = "修改人")
	@Column(length = 200)
	protected String modifiername;

	@MetaData(value = "修改时间戳")
	protected Date modifytime;


	@MetaData(value = "最后修改时间")
	protected Date ts;

	public String getCreator() {
		return creator;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		if(StringUtils.isBlank(uuid)) {
			uuid = null;
		}
		this.uuid = uuid;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getModifytime() {
		return modifytime;
	}

	public void setModifytime(Date modifytime) {
		this.modifytime = modifytime;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreatorname() {
		return creatorname;
	}

	public void setCreatorname(String creatorname) {
		this.creatorname = creatorname;
	}

	public String getModifiername() {
		return modifiername;
	}

	public void setModifiername(String modifiername) {
		this.modifiername = modifiername;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getTs() {
		return ts;
	}

	public void setTs(Date ts) {
		this.ts = ts;
	}

	@PrePersist
	public void prePersist() {
		if (StringUtils.isEmpty(getCreator()) && StringUtils.isEmpty(getCreatorname())) {
			UserEntity user = ShiroUser.getCurrentUserEntity();
			if (null != user && StringUtils.isNotBlank(user.getUuid())) {
				this.creator = user.getUuid();
				this.creatorname = user.getUsername();
				// this.modifier = user.getUuid();
			}
		}
		this.createtime = new Date();
		this.ts = new Date();
		// this.modifytime = new Date();
	}

	@PreUpdate
	public void preUpdate() {
		this.ts = new Date();
	}
}
