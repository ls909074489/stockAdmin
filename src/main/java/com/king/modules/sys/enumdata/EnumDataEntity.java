package com.king.modules.sys.enumdata;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.frame.entity.BaseEntity;


 
/**   
* 枚举数据实体类
* @author xuechen 
* @date 2015年11月27日 下午2:10:43 
*/
@Entity
@Table(name = "yy_enumdata")
@DynamicInsert @DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class EnumDataEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;
	@Column(length=50)
	private String modulecode;	//所属模块
	@Column(nullable = false,unique = true, length=50)
	private String groupcode;	//分组编码
	@Column(nullable = false, unique = true,length=100)
	private String groupname;	//分组名称
	private Boolean sys = false;
	@Column(length=100)
	private String description;	//说明
	
	@OneToMany(cascade={CascadeType.REMOVE,CascadeType.PERSIST},fetch=FetchType.LAZY,mappedBy="enumdata")
	@OrderBy("showorder,enumdatakey")
	@JsonIgnore
	private List<EnumDataSubEntity> subdatas;

	public String getModulecode() {
		return modulecode;
	}

	public void setModulecode(String modulecode) {
		this.modulecode = modulecode;
	}

	public String getGroupcode() {
		return groupcode;
	}

	public void setGroupcode(String groupcode) {
		this.groupcode = groupcode;
	}

	public String getGroupname() {
		return groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	public Boolean getSys() {
		return sys;
	}

	public void setSys(Boolean sys) {
		this.sys = sys;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<EnumDataSubEntity> getSubdatas() {
		return subdatas;
	}

	public void setSubdatas(List<EnumDataSubEntity> subdatas) {
		this.subdatas = subdatas;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
