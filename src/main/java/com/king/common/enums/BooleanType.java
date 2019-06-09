package com.king.common.enums;

public enum BooleanType {
	is("1", "是"),
	no("0", "否")
	;
	
	
	private String code;
	private String value;
	
	
	private BooleanType(String code,String value) {
		this.code = code;
		this.value = value;
	}

	public String toCode() {
		return this.code;
	}
	
	public String toValue(){
		return this.value;
	}
}
