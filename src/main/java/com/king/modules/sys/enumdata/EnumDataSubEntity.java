package com.king.modules.sys.enumdata;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.frame.entity.BaseEntity;

/**   
* 枚举子类数据 实体
* @author xuechen 
* @date 2015年11月27日 下午2:11:45 
*/
@Entity
@Table(name = "yy_enumdata_sub")
@DynamicInsert @DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class EnumDataSubEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;
	
	@Column(nullable = false,length=36)
	private String enumdatakey;	//数据键
	
	@Column(nullable = false,length=50)
	private String enumdataname;	//显示名称
	
	@Column(length=50)
	private String icon;	//显示图标
	
	private Integer keyLength=0;	//
	
	private Short showorder;	//显示顺序
	
	private Boolean isdefault = false;	//是否为默认值
	
	@Column(length=100)
	private String description;	//说明
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "enumdataid")
	private EnumDataEntity enumdata;

	public String getEnumdatakey() {
		return enumdatakey;
	}

	public void setEnumdatakey(String enumdatakey) {
		this.enumdatakey = enumdatakey;
	}

	public String getEnumdataname() {
		return enumdataname;
	}

	public void setEnumdataname(String enumdataname) {
		this.enumdataname = enumdataname;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Short getShoworder() {
		return showorder;
	}

	public void setShoworder(Short showorder) {
		this.showorder = showorder;
	}

	public Boolean getIsdefault() {
		return isdefault;
	}

	public void setIsdefault(Boolean isdefault) {
		this.isdefault = isdefault;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public EnumDataEntity getEnumdata() {
		return enumdata;
	}

	public void setEnumdata(EnumDataEntity enumdata) {
		this.enumdata = enumdata;
	}

	public Integer getKeyLength() {
		return keyLength;
	}

	public void setKeyLength(Integer keyLength) {
		this.keyLength = keyLength;
	}

	@Override
	public String toString() {
		return "EnumDataSubEntity [enumdatakey=" + enumdatakey + ", enumdataname=" + enumdataname + ", icon=" + icon
				+ ", keyLength=" + keyLength + ", showorder=" + showorder + ", isdefault=" + isdefault
				+ ", description=" + description + ", enumdata=" + enumdata + "]";
	}

}
