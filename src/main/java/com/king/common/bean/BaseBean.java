package com.king.common.bean;

/**
 * 用于保存键值对
 * @ClassName: BaseBean
 * @author liusheng
 * @date 2016年6月29日 上午11:59:14
 */
public class BaseBean {
	private String id;
	private String name;
	
	private String pid;
	
	private String type;
	
	
	public BaseBean() {
	}
	
	
	public BaseBean(String id, String name, String pid, String type) {
		this.id = id;
		this.name = name;
		this.pid = pid;
		this.type = type;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
}
