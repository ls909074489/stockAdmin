package com.king.frame.attachment;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.common.utils.FileUtils;
import com.king.frame.entity.BaseEntity;

/**
 * 附件.
 * 
 */
@Entity
@Table(name = "yy_attachment")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class AttachmentEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "所属实体类")
	@Column(nullable = false, length = 100)
	private String entityType;

	@MetaData(value = "所属记录UUID")
	@Column(nullable = false, length = 50)
	private String entityUuid;

	//0:应用服务器  1:阿里云服务器 
	@MetaData(value = "附件分类")
	@Column(nullable = true, length = 100)
	private String attaType="0";

	@MetaData(value = "分组名称")
	@Column(nullable = true, length = 100)
	private String groupName;

	@MetaData(value = "文件类型")
	@Column(nullable = false)
	private String fileType;

	@MetaData(value = "文件名称")
	@Column(nullable = false)
	private String fileName;

	@MetaData(value = "标签")
	@Column(nullable = true)
	private String tag;

	@MetaData(value = "附件URL")
	@Column(nullable = true)
	private String url;

	@MetaData(value = "文件大小")
	@Column(nullable = true)
	private String fileSize;

	@MetaData(value = "附件说明")
	@Column(nullable = true, length = 1000)
	private String description;

	@MetaData(value = "附件上传时间")
	@Column(nullable = true)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	private Date uploadDate;

	@MetaData(value = "上传人")
	@Column(nullable = false)
	private String uploadUserId;

	@MetaData(value = "上传人")
	@Column(nullable = false)
	private String uploadUserName;
	
	@MetaData(value = "附件URL前缀")
	@Column(nullable = true)
	private String preurl;
	
	
	
	@MetaData(value = "附件的分类")
	@Column(name="file_class",length=20,nullable = true)
	private String fileClass;
	
	@MetaData(value = "附件的分类")
	@Column(name="file_memo",length=250,nullable = true)
	private String fileMemo;
	
  	
	@Transient
	private boolean isOrgiName=false;//是否使用原名字

	/**
	 * 所属实体类
	 */
	public String getEntityType() {
		return this.entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	/**
	 * 所属记录UUID
	 */
	public String getEntityUuid() {
		return this.entityUuid;
	}

	public void setEntityUuid(String entityUuid) {
		this.entityUuid = entityUuid;
	}

	/**
	 * 附件分类
	 */
	public String getAttaType() {
		return this.attaType;
	}

	public void setAttaType(String attaType) {
		this.attaType = attaType;
	}

	/**
	 * 分组名称
	 */
	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	/**
	 * 文件类型
	 */
	public String getFileType() {
		return this.fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	/**
	 * 文件名称
	 */
	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * 标签
	 */
	public String getTag() {
		return this.tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	/**
	 * 附件URL
	 */
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * 文件大小
	 */
	public String getFileSize() {
		return FileUtils.reviewFileSize(this.fileSize);
	}
	
	/**
	 * 获取原始文件大小，没经过加工
	 * @return
	 */
	public String getOriginalFileSize() {
		return this.fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	/**
	 * 附件说明
	 */
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * 附件上传
	 */
	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getUploadUserId() {
		return uploadUserId;
	}

	public void setUploadUserId(String uploadUserId) {
		this.uploadUserId = uploadUserId;
	}

	public String getUploadUserName() {
		return uploadUserName;
	}

	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}

	public String getPreurl() {
		return preurl;
	}

	public void setPreurl(String preurl) {
		this.preurl = preurl;
	}

	public String getFileClass() {
		return fileClass;
	}

	public void setFileClass(String fileClass) {
		this.fileClass = fileClass;
	}

	public String getFileMemo() {
		return fileMemo;
	}

	public void setFileMemo(String fileMemo) {
		this.fileMemo = fileMemo;
	}

	public boolean isOrgiName() {
		return isOrgiName;
	}

	public void setOrgiName(boolean isOrgiName) {
		this.isOrgiName = isOrgiName;
	}
	
}
