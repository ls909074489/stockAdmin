package com.king.modules.sys.notice;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@Entity
@Table(name = "yy_notice")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)

public class NoticeEntity extends BaseEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@MetaData(value = "所属系统")
	@Column(length = 100)
	private String system_name;

	@MetaData(value = "标题")
	@Column(length = 200)
	private String notice_title;

	@Lob
	@MetaData(value = "内容")
	private String notice_content;

	@MetaData(value = "通知分类", enumType = "NoticeCategory")
	@Column(length = 50)
	private String notice_category;

	@MetaData(value = "通知状态")
	@Column(length = 50)
	private String notice_status;

	@MetaData(value = "发布人")
	@Column(length = 50)
	private String publisher;

	@MetaData(value = "发布时间")
	private String issue_date;
	
	@MetaData(value = "通知类型 用户表的usertype")
	@Column(length = 2)
	private String notice_type;
	

	public String getSystem_name() {
		return system_name;
	}

	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}

	public String getNotice_title() {
		// return StringEscapeUtils.unescapeHtml(notice_title);
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public String getNotice_category() {
		return notice_category;
	}

	public void setNotice_category(String notice_category) {
		this.notice_category = notice_category;
	}

	public String getNotice_status() {
		return notice_status;
	}

	public void setNotice_status(String notice_status) {
		this.notice_status = notice_status;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getIssue_date() {
		return issue_date;
	}

	public void setIssue_date(String issue_date) {
		this.issue_date = issue_date;
	}

	public String getNotice_type() {
		return notice_type;
	}

	public void setNotice_type(String notice_type) {
		this.notice_type = notice_type;
	}

	
}