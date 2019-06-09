package com.king.modules.sys.rolegroup;

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
@Table(name = "yy_rolegroup")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class RoleGroupEntity extends TreeEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "角色组编码")
	@Column(nullable = false, length = 20, unique = true)
	private String rolegroup_code;

	@MetaData(value = "角色组名称")
	@Column(nullable = false, length = 50)
	private String rolegroup_name;

	@MetaData(value = "描述")
	private String description;

	@MetaData(value = "图标")
	@Column(length = 50)
	private String iconcls;

	@MetaData(value = "样式")
	@Column(length = 100)
	private String rolegroup_css;

	@MetaData(value = "排序")
	private Short showorder;
	private Boolean sys = false;

	@MetaData(value = "父节点id")
	private String parentid;

	/*
	 * @MetaData(value="上级角色组")
	 * 
	 * @ManyToOne(fetch = FetchType.LAZY)
	 * 
	 * @JoinColumn(name = "parentId") // @JsonBackReference
	 * 
	 * @JsonIgnore private RoleGroupEntity parent;
	 */

	@MetaData(value = "是否末级节点")
	private Boolean islast;

	/*
	 * @OneToMany(cascade = { CascadeType.PERSIST, CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "parent")
	 * 
	 * @OrderBy("rolegroup_code") // @JsonManagedReference
	 * 
	 * @JsonIgnore private List<RoleGroupEntity> children = new ArrayList<RoleGroupEntity>();
	 */

	// @OneToMany(cascade = { CascadeType.PERSIST, CascadeType.REMOVE }, fetch = FetchType.LAZY, mappedBy = "rolegroup")
	// @JsonIgnore
	// private List<RoleEntity> roles = new ArrayList<RoleEntity>();

	/*
	 * public RoleGroupEntity getParent() { return parent; }
	 * 
	 * public void setParent(RoleGroupEntity parent) { this.parent = parent; }
	 */

	/*
	 * public void setChildren(List<RoleGroupEntity> children) { this.children = children; }
	 */

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

	/*
	 * public List<RoleGroupEntity> getChildren() { return children; }
	 */
	public String getRolegroup_code() {
		return rolegroup_code;
	}

	public void setRolegroup_code(String rolegroup_code) {
		this.rolegroup_code = rolegroup_code;
	}

	public String getRolegroup_name() {
		return rolegroup_name;
	}

	public void setRolegroup_name(String rolegroup_name) {
		this.rolegroup_name = rolegroup_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIconcls() {
		return iconcls;
	}

	public void setIconcls(String iconcls) {
		this.iconcls = iconcls;
	}

	public String getRolegroup_css() {
		return rolegroup_css;
	}

	public void setRolegroup_css(String rolegroup_css) {
		this.rolegroup_css = rolegroup_css;
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
	public String getCode() {
		// TODO Auto-generated method stub
		return this.getRolegroup_code();
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return this.getRolegroup_name();
	}

	@Override
	public String getParentId() {

		return this.parentid;
	}

}
