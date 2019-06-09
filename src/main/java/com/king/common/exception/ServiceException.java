package com.king.common.exception;

import java.io.PrintStream;
import java.io.PrintWriter;

/**
 * service的异常
 * 
 */
public class ServiceException extends Exception {

	private static final long serialVersionUID = 1L;
	private Throwable nestedThrowable = null;

	public ServiceException() {
		super();
	}

	public ServiceException(String msg) {
		super(msg);
	}

	public ServiceException(Throwable nestedThrowable) {
		this.nestedThrowable = nestedThrowable;
	}

	public ServiceException(String msg, Throwable nestedThrowable) {
		super(msg);
		this.nestedThrowable = nestedThrowable;
	}

	public void printStackTrace() {
		super.printStackTrace();
		if (nestedThrowable != null) {
			nestedThrowable.printStackTrace();
		}
	}

	public void printStackTrace(PrintStream ps) {
		super.printStackTrace(ps);
		if (nestedThrowable != null) {
			nestedThrowable.printStackTrace(ps);
		}
	}

	public void printStackTrace(PrintWriter pw) {
		super.printStackTrace(pw);
		if (nestedThrowable != null) {
			nestedThrowable.printStackTrace(pw);
		}
	}

}
