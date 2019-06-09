package com.king.common.exception.base.impl;

import com.king.common.exception.base.CustomException;

/**
 * 服务器数据错误
 * @author WangMin
 *
 */
public class ServiceDateError extends CustomException {
	
	private static final long serialVersionUID = 1L;

	public ServiceDateError() {
	}

	public ServiceDateError(String message) {
		super(message);
	}

}
