package com.king.common.bean;

/**
 * 基本的树bean
 * @ClassName: TreeBaseBean
 * @author liusheng 
 * @date 2015年12月17日 下午5:00:54
 */
public class TreeBaseBean {
	private String id;//id
	private String name;//名称
	private String pId;//父节点id
	private boolean checked;//是否勾选
	private boolean open;//是否打开
	
	private String iconSkin;//图标
	private String title;//标题
	private String type;//类型
	
	private Object nodeData;//返回的数据
	
	public TreeBaseBean() {
	}
	public TreeBaseBean(String id, String name, String pId, boolean checked,boolean open) {
		this.id = id;
		this.name = name;
		this.pId = pId;
		this.checked = checked;
		this.open=open;
		this.title=name;//edit by liusheng
	}
	public TreeBaseBean(String id, String name, String pId, boolean checked,boolean open,Object nodeData) {
		this.id = id;
		this.name = name;
		this.pId = pId;
		this.checked = checked;
		this.open=open;
		this.nodeData=nodeData;
		this.title=name;//edit by liusheng
	}
	public TreeBaseBean(String id, String name, String pId, boolean checked,boolean open,
			String iconSkin,String title,String type,Object nodeData) {
		this.id = id;
		this.name = name;
		this.pId = pId;
		this.checked = checked;
		this.open=open;
		this.iconSkin=iconSkin;
		this.title=title;
		this.type=type;
		this.nodeData=nodeData;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public String getIconSkin() {
		return iconSkin;
	}
	public void setIconSkin(String iconSkin) {
		this.iconSkin = iconSkin;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Object getNodeData() {
		return nodeData;
	}
	public void setNodeData(Object nodeData) {
		this.nodeData = nodeData;
	}
}
