package com.king.common.enums;

public enum BillStatus {
	FREE(1, "自由态"), SUBMIT(2, "提交态"), INAPPROVED(3, "审批态"), REJECT(4, "退回态"), APPROVAL(5, "通过态");

	private int status;
	private String name;

	private BillStatus(int status, String name) {
		this.status = status;
		this.name = name;
	}

	public int toStatusValue() {
		return this.status;
	}

	public String toStatusNameValue() {
		return this.name;
	}

	public static BillStatus toStatus(int status) {
		if (INAPPROVED.status == status) {
			return INAPPROVED;
		} else if (FREE.status == status) {
			return FREE;
		} else if (SUBMIT.status == status) {
			return SUBMIT;
		} else if (INAPPROVED.status == status) {
			return INAPPROVED;
		} else if (REJECT.status == status) {
			return REJECT;
		} else if (APPROVAL.status == status) {
			return APPROVAL;
		} else {
			return null;
		}
	}

}
