package com.king.modules.info.apply;

import javax.persistence.Column;
import com.king.frame.entity.BaseEntity;
import com.king.common.annotation.MetaData;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 申请消息
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Entity
@Table(name = "yy_project_apply")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ProjectApplyEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public static final String APPLYING = "1";
	public static final String DEALING = "2";
	public static final String HANDLED = "3";
	public static final String REJECTED = "4";
	
	@MetaData(value = "申请类型")
	@Column(length = 2)
	private String applyType;

	@MetaData(value = "原单id")
	@Column(length = 36)
	private String sourceBillId;
	
	@MetaData(value = "原单号")
	@Column(length = 50)
	private String sourceBillCode;

	@MetaData(value = "申请内容")
	@Column(length = 200)
	private String content;

	public String getSourceBillCode() {
		return sourceBillCode;
	}

	public void setSourceBillCode(String sourceBillCode) {
		this.sourceBillCode = sourceBillCode;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public String getSourceBillId() {
		return sourceBillId;
	}

	public void setSourceBillId(String sourceBillId) {
		this.sourceBillId = sourceBillId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}