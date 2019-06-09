package com.king.modules.sys.user;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.org.OrgRef;

@MetaData(value = "用户信息")
@Entity
@Table(name = "yy_user")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public static int USERTYPE_MANAGER = 1;
	public static int USERTYPE_NORMAL = 2;
	public static int USERTYPE_TEACHER = 3;
	public static int USERTYPE_STUDENT = 4;

	@MetaData(value = "所属机构Id")
	@Column(length = 36)
	private String orgid;

	@MetaData(value = "所属业务单元")
	@ManyToOne(cascade = CascadeType.REFRESH, optional = true)
	@JoinColumn(name = "pk_corp", nullable = true)
	private OrgRef org;

	@MetaData(value = "登录名")
	@Column(nullable = false, unique = true, length = 20)
	private String loginname;

	@Column(nullable = false, length = 100)
	@MetaData(value = "用户名")
	private String username;

	@MetaData(value = "用户类型", enumType = "UserType")
	@Column(nullable = false)
	private Integer usertype;

	@JsonIgnore
	@Column(nullable = false)
	private String password;

	// 盐值
	@JsonIgnore
	private String salt;

	@Transient
	@JsonIgnore
	private String plainpassword;

	@MetaData(value = "最后登录时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	private Date last_time;

	@MetaData(value = "最后登录IP")
	@Column(length = 50)
	private String last_ip;

	@MetaData(value = "生效日期")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date validdate;

	@MetaData(value = "失效日期")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	private Date invaliddate;

	@MetaData(value = "描述")
	private String description;

	@MetaData(value = "显示顺序")
	private Integer showorder;

	@MetaData(value = "部门编码")
	@Column(length = 50)
	private String deptid;

	@MetaData(value = "手机")
	@Column(length = 20)
	private String mobilephone;

	@MetaData(value = "电话")
	@Column(length = 20)
	private String telephone;

	@MetaData(value = "邮箱")
	@Column(length = 50)
	private String mailbox;

	@MetaData(value = "地址")
	@Column(length = 200)
	private String address;

	@MetaData(value = "备注")
	@Column(length = 250)
	private String remark;

	@MetaData(value = "出生日期")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	private Date birthdate;

	@MetaData(value = "工号")
	@Column(name = "jobnumber", unique = true, length = 100)
	private String jobnumber;

	@Column(length = 2, columnDefinition = "varchar(2) default '1'")
	@MetaData(value = "是否启用")
	private String is_use = "1";

	@Column(name = "changepwd", length = 2)
	@MetaData(value = "修改密码的次数")
	private Long changepwd = 0l;

	@Column(name = "login_fail_count", length = 2)
	@MetaData(value = "登录失败的次数")
	private Long loginFailCount = 0l;

	@MetaData(value = "性别")
	@Column(name = "sex", length = 2)
	private String sex;

	@Transient
	private String orgname;
	@Transient
	private String deptname;

	@Transient
	private String userrole;// 角色下的用户id add by ls2008
	
	@Transient
	private String apiUserType;//

	public String getIs_use() {
		return is_use;
	}

	public void setIs_use(String is_use) {
		this.is_use = is_use;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Integer getUsertype() {
		return usertype;
	}

	public void setUsertype(Integer usertype) {
		this.usertype = usertype;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getLast_time() {
		return last_time;
	}

	public void setLast_time(Date last_time) {
		this.last_time = last_time;
	}

	public String getLast_ip() {
		return last_ip;
	}

	public void setLast_ip(String last_ip) {
		this.last_ip = last_ip;
	}

	public Date getValiddate() {
		return validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}

	public Date getInvaliddate() {
		return invaliddate;
	}

	public void setInvaliddate(Date invaliddate) {
		this.invaliddate = invaliddate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getShoworder() {
		return showorder;
	}

	public void setShoworder(Integer showorder) {
		this.showorder = showorder;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	public String getPlainpassword() {
		return plainpassword;
	}

	public void setPlainpassword(String plainpassword) {
		this.plainpassword = plainpassword;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getMailbox() {
		return mailbox;
	}

	public void setMailbox(String mailbox) {
		this.mailbox = mailbox;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getJobnumber() {
		return jobnumber;
	}

	public void setJobnumber(String jobnumber) {
		this.jobnumber = jobnumber;
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}

	public Long getChangepwd() {
		return changepwd;
	}

	public void setChangepwd(Long changepwd) {
		this.changepwd = changepwd;
	}

	public Long getLoginFailCount() {
		return loginFailCount;
	}

	public void setLoginFailCount(Long loginFailCount) {
		this.loginFailCount = loginFailCount;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public OrgRef getOrg() {
		return org;
	}

	public void setOrg(OrgRef org) {
		this.org = org;
	}

	public String getApiUserType() {
		return apiUserType;
	}

	public void setApiUserType(String apiUserType) {
		this.apiUserType = apiUserType;
	}

}
