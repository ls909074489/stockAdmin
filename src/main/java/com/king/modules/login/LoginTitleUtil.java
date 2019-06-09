package com.king.modules.login;

import com.king.modules.sys.param.ParameterUtil;

/**
 * 系统登陆工具，主要用于登录页面显示的标题
 * 
 * 
 */
public class LoginTitleUtil {

	/**
	 * 从参数缓存map中获取参数值
	 * 
	 * @param paramCode
	 * @return
	 */
	public static String getLoginTitle() {
		return ParameterUtil.getParamValue("yy_title", "YY信息系统平台");
	}

}
