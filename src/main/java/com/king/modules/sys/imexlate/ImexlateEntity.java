package com.king.modules.sys.imexlate;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "导入信息")
@Entity
@Table(name = "yy_imexlate", uniqueConstraints = { @UniqueConstraint(columnNames = "coding") })
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ImexlateEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@OneToMany(cascade = { CascadeType.REMOVE, CascadeType.PERSIST }, fetch = FetchType.EAGER, mappedBy = "implate")
	@OrderBy("exportCellNum")
	@JsonIgnore
	private List<ImexlateSubEntity> implateSub;

	@MetaData(value = "模板名称")
	@Column
	private String templateName;

	@MetaData(value = "模板编码")
	@Column
	private String coding;

	@MetaData(value = "是否创建模板")
	@Column
	private String iscreate = "1";

	@MetaData(value = "导出文件名")
	@Column
	private String exportFileName;

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getCoding() {
		return coding;
	}

	public void setCoding(String coding) {
		this.coding = coding;
	}

	public String getExportFileName() {
		return exportFileName;
	}

	public void setExportFileName(String exportFileName) {
		this.exportFileName = exportFileName;
	}

	public String getIscreate() {
		return iscreate;
	}

	public void setIscreate(String iscreate) {
		this.iscreate = iscreate;
	}

	public List<ImexlateSubEntity> getImplateSub() {
		return implateSub;
	}

	public void setImplateSub(List<ImexlateSubEntity> implateSub) {
		this.implateSub = implateSub;
	}

}
