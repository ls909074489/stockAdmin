package com.king.modules.sys.param;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.frame.entity.BaseEntity;

/**
 * 系统参数 实体类
 * 
 *
 */
@Entity
@Table(name = "yy_parameter")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ParameterEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	private String groudcode; // 参数组
	@Column(nullable = false, length = 50, unique = true)
	private String paramtercode; // 参数编码
	@Column(nullable = false, length = 200)
	private String paramtername; // 参数名称
	private String paramtervalue; // 参数值
	private String defaultvalue;// 默认值
	private String paramtertype; // 值类型
	private String valuerange; // 值范围
	@Column(length = 1000)
	private String description; // 描述
	private Short showorder; // 显示顺序
	private Boolean sys = false; // 是否系统参数，系统参数不可删除

	private Boolean isshow = true; // 是否显示  例如邮箱的配置不需要在系统参数中设置，但需要经常读取的
	
	
	@Column(length = 2)
	private String ispreset="0";//是否预置

	public String getGroudcode() {
		return groudcode;
	}

	public void setGroudcode(String groudcode) {
		this.groudcode = groudcode;
	}

	public String getParamtercode() {
		return paramtercode;
	}

	public void setParamtercode(String paramtercode) {
		this.paramtercode = paramtercode;
	}

	public String getParamtername() {
		return paramtername;
	}

	public void setParamtername(String paramtername) {
		this.paramtername = paramtername;
	}

	public String getParamtervalue() {
		return paramtervalue;
	}

	public void setParamtervalue(String paramtervalue) {
		this.paramtervalue = paramtervalue;
	}

	public String getDefaultvalue() {
		return defaultvalue;
	}

	public void setDefaultvalue(String defaultvalue) {
		this.defaultvalue = defaultvalue;
	}

	public String getParamtertype() {
		return paramtertype;
	}

	public void setParamtertype(String paramtertype) {
		this.paramtertype = paramtertype;
	}

	public String getValuerange() {
		return valuerange;
	}

	public void setValuerange(String valuerange) {
		this.valuerange = valuerange;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Short getShoworder() {
		return showorder;
	}

	public void setShoworder(Short showorder) {
		this.showorder = showorder;
	}

	public Boolean getSys() {
		return sys;
	}

	public void setSys(Boolean sys) {
		this.sys = sys;
	}

	public Boolean getIsshow() {
		return isshow;
	}

	public void setIsshow(Boolean isshow) {
		this.isshow = isshow;
	}

	public String getIspreset() {
		return ispreset;
	}

	public void setIspreset(String ispreset) {
		this.ispreset = ispreset;
	}
}
