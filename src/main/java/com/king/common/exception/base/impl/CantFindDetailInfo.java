package com.king.common.exception.base.impl;

import com.king.common.exception.base.CustomException;

/**
 * 不能找到详细信息异常
 * @author WangMin
 */
public class CantFindDetailInfo extends CustomException{
	
	/**
	 * 不能找到详细的信息
	 */
	private static final long serialVersionUID = 1L;

	public CantFindDetailInfo() {
	}
	
	public CantFindDetailInfo(String message){
		super(message);
	}

}

