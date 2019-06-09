package com.king.modules.sys.func;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.TreeEntity;

@Entity
@Table(name = "yy_func")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class FuncEntity extends TreeEntity {

	private static final long serialVersionUID = 1L;

	// 不能重复unique = true
	@MetaData(value = "功能节点编码")
	@Column(nullable = false, length = 20, unique = true)
	private String func_code;

	@MetaData(value = "功能节点名称")
	@Column(nullable = false, length = 50)
	private String func_name;

	@MetaData(value = "类型:sys,module,space,func")
	@Column(length = 50)
	private String func_type;

	@MetaData(value = "使用状态")
	@Column(nullable = false)
	private String usestatus = "1";

	@MetaData(value = "是否末级节点")
	private Boolean islast;

	@MetaData(value = "链接URL")
	@Column(length = 500)
	private String func_url;

	@MetaData(value = "提示信息")
	private String hint;

	@MetaData(value = "帮助编号")
	@Column(length = 500)
	private String help_code;

	@MetaData(value = "类型")
	@Column(length = 50)
	private String auth_type;

	@MetaData(value = "图标")
	@Column(length = 50)
	private String iconcls;

	@MetaData(value = "样式")
	@Column(length = 100)
	private String fun_css;

	@MetaData(value = "排序")
	private Short showorder;

	@MetaData(value = "描述")
	private String description;

	@MetaData(value = "系统")
	private Boolean sys = false;

	@MetaData(value = "权限控制编码")
	private String permission_code;

	@MetaData(value = "父节点id")
	private String parentid;

	public String getFunc_code() {
		return func_code;
	}

	public void setFunc_code(String func_code) {
		this.func_code = func_code;
	}

	public String getFunc_name() {
		return func_name;
	}

	public void setFunc_name(String func_name) {
		this.func_name = func_name;
	}

	public String getFunc_url() {
		return func_url;
	}

	public void setFunc_url(String func_url) {
		this.func_url = func_url;
	}

	public String getHint() {
		return hint;
	}

	public void setHint(String hint) {
		this.hint = hint;
	}

	public String getHelp_code() {
		return help_code;
	}

	public void setHelp_code(String help_code) {
		this.help_code = help_code;
	}

	public String getFunc_type() {
		return func_type;
	}

	public void setFunc_type(String func_type) {
		this.func_type = func_type;
	}

	public String getAuth_type() {
		return auth_type;
	}

	public void setAuth_type(String auth_type) {
		this.auth_type = auth_type;
	}

	public String getIconcls() {
		return iconcls;
	}

	public void setIconcls(String iconcls) {
		this.iconcls = iconcls;
	}

	public String getFun_css() {
		return fun_css;
	}

	public void setFun_css(String fun_css) {
		this.fun_css = fun_css;
	}

	public Short getShoworder() {
		return showorder;
	}

	public void setShoworder(Short showorder) {
		this.showorder = showorder;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getSys() {
		return sys;
	}

	public void setSys(Boolean sys) {
		this.sys = sys;
	}

	public String getPermission_code() {
		return permission_code;
	}

	public void setPermission_code(String permission_code) {
		this.permission_code = permission_code;
	}

	@Override
	public String getCode() {
		return this.getFunc_code();
	}

	@Override
	public String getName() {

		return this.getFunc_name();
	}

	public Boolean getIslast() {
		return islast;
	}

	public void setIslast(Boolean islast) {
		this.islast = islast;
	}

	public String getParentid() {
		return parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	@Override
	public String getParentId() {
		return this.parentid;
	}

	public String getUsestatus() {
		return usestatus;
	}

	public void setUsestatus(String usestatus) {
		this.usestatus = usestatus;
	}

}
