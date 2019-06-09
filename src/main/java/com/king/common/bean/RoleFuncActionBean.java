package com.king.common.bean;


/**
 * 角色下菜单的按钮bean
 * @ClassName: RoleFuncActionBean
 * @author liusheng 
 * @date 2015年12月25日 下午5:10:00
 */
public class RoleFuncActionBean {
	
	private String actioncode;//按钮编码
	
	private String actionname;//按钮名称
	
	private String isSelect;//是否已经选择  1：已选择  0：未选择
	
	private String uuid;//按钮表的uuid

	public String getActioncode() {
		return actioncode;
	}

	public void setActioncode(String actioncode) {
		this.actioncode = actioncode;
	}

	public String getActionname() {
		return actionname;
	}

	public void setActionname(String actionname) {
		this.actionname = actionname;
	}

	public String getIsSelect() {
		return isSelect;
	}

	public void setIsSelect(String isSelect) {
		this.isSelect = isSelect;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
}
