package com.king.common.enums;

public enum DataStatus {
	NORMAL(1, "正常"),
	DELETE(0, "删除")
	;
	
	
	private int status;
	private String name;
	
	
	private DataStatus(int status,String name) {
		this.status = status;
		this.name = name;
	}

	public int toStatusValue() {
		return this.status;
	}
	
	public String toStatusNameValue(){
		return this.name;
	}
	
	public static DataStatus toStatus(int status) {
		if (NORMAL.status == status) {
			return NORMAL;
		} else if (DELETE.status == status) {
			return DELETE;
		} else {
			return null;
		}
	}
	
}
