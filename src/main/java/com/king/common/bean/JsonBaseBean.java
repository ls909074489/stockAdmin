package com.king.common.bean;

/**
 * 作为json返回的通用bean
 * @ClassName: JsonBaseBean
 * @author liusheng 
 * @date 2015年12月17日 下午1:54:57
 */
public class JsonBaseBean {
	
	private int flag;//状态
	
	private String msg="";//描述
	
	private boolean success;//操作是否成功

	public JsonBaseBean() {
	}

	public JsonBaseBean(String msg, boolean success) {
		this.msg = msg;
		this.success = success;
	}

	public JsonBaseBean(int flag, String msg) {
		this.flag = flag;
		this.msg = msg;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
}
