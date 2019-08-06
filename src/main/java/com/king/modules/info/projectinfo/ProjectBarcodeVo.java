package com.king.modules.info.projectinfo;

public class ProjectBarcodeVo {

	private String uuid;
	private String bc;//条码
	
	public ProjectBarcodeVo() {
	}
	public ProjectBarcodeVo(String uuid, String bc) {
		this.uuid = uuid;
		this.bc = bc;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getBc() {
		return bc;
	}
	public void setBc(String bc) {
		this.bc = bc;
	}
}
