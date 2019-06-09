package com.king.common.enums;

public enum AuditStatus {
	
	FREE(0,"自由态"),
//	FACTORY_REJECT(5, "工厂退回"),
	FACTORY_CONFIRM(10, "工厂确认"),
	SALES_REJECT(15, "业务员退回"),
	SALES_CONFIRM(20, "业务员确认回价"),
	
	SUCCESS(1, "通过"),
	FAIL(2, "失败");//相对于出入库来说是撤审
	
	
	private int status;
	private String name;
	
	
	private AuditStatus(int status,String name) {
		this.status = status;
		this.name = name;
	}

	public int toStatusValue() {
		return this.status;
	}
	
	public String toStatusNameValue(){
		return this.name;
	}
	
	
}
