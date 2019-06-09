package com.king.common.bean;

import java.util.List;

/**
 * 用于保存键值对
 * @ClassName: BaseBean
 * @author liusheng
 * @date 2016年6月29日 上午11:59:14
 */
public class BaseBeanList {
	private String id;
	private String name;
	private String type;//fj附件 wgz 无故障  qt 其他
	
	List<BaseBeanList> list;
	
	
	public BaseBeanList() {
	}
	

	public BaseBeanList(String id, String name, String type) {
		this.id = id;
		this.name = name;
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

	public List<BaseBeanList> getList() {
		return list;
	}

	public void setList(List<BaseBeanList> list) {
		this.list = list;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
}
