package com.king.common.exception;

import java.io.PrintStream;
import java.io.PrintWriter;

/**
 * DAO的异常
 * 
 */
public class DAOException extends Exception {

	private static final long serialVersionUID = 4449252083159767248L;
	private Throwable nestedThrowable = null;

	public DAOException() {
		super();
	}

	public DAOException(String msg) {
		super(msg);
	}

	public DAOException(Throwable nestedThrowable) {
		this.nestedThrowable = nestedThrowable;
	}

	public DAOException(String msg, Throwable nestedThrowable) {
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
