package com.king.modules.sys.imexlate;

public enum ImexlateAuxiliary {
	DFU("使用说明","使用说明"),
	DFU_ONE("1、单据的单据头可以只填一行，且与以下单据头为空白的行表示同一单据。","使用说明1"),
	DFU_TWO("2、红色字体列不能为空","使用说明2"),
	DFU_THREE("3、下拉框请选择下拉框中的值","使用说明3"),
	DFU_FOUR("4、本表为使用说明，实际录入请在表一中填写。","使用说明4"),
	LINENUM("imlinenum","行号key值"),
	CHILD("child","导出导入子表map key值");
	
	private String code;
	private String name;
	
	
	private ImexlateAuxiliary(String code,String name) {
		this.code = code;
		this.name = name;
	}

	public String toCodeValue() {
		return this.code;
	}
	
	public String toStatusNameValue(){
		return this.name;
	}
}
