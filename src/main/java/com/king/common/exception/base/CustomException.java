package com.king.common.exception.base;

/**
 * 自定义异常
 * 程序猿自己抛出来的异常要继承这个类
 * @author WangMin
 */
public class CustomException extends Exception {
	
	private static final long	serialVersionUID	= 1L;

	public CustomException() {
	}
	
	public CustomException(String message){
		super(message);
	}
}
