package com.king.common.result;

/**
 * 返回值封装
 * @author WangMin
 */
public class ResultInfo {

	private static final long serialVersionUID = 1L;
	private static final String SUCCESS_NUM = "200"; //
	private static final String SERVICE_FAIL_NUM = "500";
	private static final String PARAM_FAIL_NUM = "400";
	private static final String NOINFO_NUM = "404";
	private static final String NOPERMISSION_NUM = "407";
	private static final String SUCCESS_INFO = "SUCCESS";
	private static final String FAIL_INFO = "FAIL";
	private static final String message = "message";
	private static final String addSuccess = "新增成功";
	private static final String operationFailure = "操作失败";
	private static final String operationSuccess = "操作成功";
	private static final String paramsConvertFail = "参数转换失败";
	private static final String noInfo = "没有相关结果";
	private static final String verifyFail = "验证失败";
	private static final String IOException = "Http请求异常";
	private static final String IOInfo = "网络繁忙,请稍候重试";
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static String getSuccessNum() {
		return SUCCESS_NUM;
	}

	public static String getServiceFailNum() {
		return SERVICE_FAIL_NUM;
	}

	public static String getSuccessInfo() {
		return SUCCESS_INFO;
	}

	public static String getFailInfo() {
		return FAIL_INFO;
	}

	public static String getMessage() {
		return message;
	}

	public static String getAddsuccess() {
		return addSuccess;
	}

	public static String getOperationfailure() {
		return operationFailure;
	}

	public static String getParamsconvertfail() {
		return paramsConvertFail;
	}

	public static String getNoinfoNum() {
		return NOINFO_NUM;
	}

	public static String getNoinfo() {
		return noInfo;
	}

    public static String getVerifyfail() {
        return verifyFail;
    }

	public static String getParamFailNum() {
		return PARAM_FAIL_NUM;
	}

	public static String getIoexception() {
		return IOException;
	}

	public static String getOperationsuccess() {
		return operationSuccess;
	}

	public static String getIoinfo() {
		return IOInfo;
	}

	public static String getNopermissionNum() {
		return NOPERMISSION_NUM;
	}
	
}
