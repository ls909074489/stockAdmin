package com.king.common.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 检查参数的格式是否正确
 * @author WangMin
 */
public class RegexUtil  {
	// 正则表达式
	private static final String MOBILE_PHONE = "^0?1[3458]\\d{9}$";// 手机号码正则
	private static final String IDCARD = "^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";//身份证号码正则
	private static final String EMAIL = "^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$";//邮箱正则
	private static final String USER_NAME = "^[a-zA-Z0-9]\\w{5,17}$";//用户名正则，6到18位，字母数字开头
	private static final String PASSWORD = "^[a-zA-Z0-9]\\w{5,17}$"; //密码正则，，6到18位，字母数字开头
	private static final String DATESTRREG1 = "^((?:19|20)\\d\\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$"; // yyyy-MM-dd
	private static final String DARESTRREG2 = "^(((20[0-3][0-9]-(0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|(20[0-3][0-9]-(0[2469]|11)-(0[1-9]|[12][0-9]|30))) (20|21|22|23|[0-1][0-9]):[0-5][0-9]:[0-5][0-9])$"; // yyyy-MM-dd HH:mm:ss                        
	

	// 禁止实例化
	private RegexUtil() {
	}
	
	
	/**
	 * 验证 yyyy-MM-dd 和   yyyy-MM-dd HH:mm:ss 字符串日期格式
	 */
	public static boolean  isDateStr(String dataStr){
		if(isEmpty(dataStr)){
			return false;
		}
		return dataStr.matches(DATESTRREG1)||dataStr.matches(DARESTRREG2);
	}
	
	/**
	 * yyyy-MM-dd
	 */
	public static boolean isDateStrOfShort(String dataStr){
		if(isEmpty(dataStr)){
			return false;
		}
		return dataStr.matches(DATESTRREG1);
	}
	
	/**
	 * yyyy-MM-dd HH:mm:ss          
	 */
	public static boolean isDateStrOfLong(String dataStr){
		if(isEmpty(dataStr)){
			return false;
		}
		return dataStr.matches(DARESTRREG2);
		
	}
	
	
	
	/**
	 * 用户名校验
	 */
	public static boolean isUserName(String userName){
		if (!userName.matches(USER_NAME)) {
			return false;
		}
		return true;
	}
	
	/**
	 * 密码校验
	 */
	public static boolean isPassword(String password){
		if (!password.matches(PASSWORD)) {
			return false;
		}
		return true;
	}
	

	/**
	 * 判断是否为浮点数或者整数
	 * @param str
	 * @return true Or false
	 */
	public static boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("^(-?\\d+)(\\.\\d+)?$");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 检查是否为正确的身份证号码
	 */
	public static boolean isIdCard(String card) {
		Pattern pattern = Pattern.compile(IDCARD);
		Matcher isIdCard = pattern.matcher(card);
		if (!isIdCard.matches()) {
			return false;
		}
		return true;
	}

	/**
	 * 判断是否为正确的邮件格式
	 * @param str
	 * @return boolean
	 */
	public static boolean isEmail(String str) {
		if (isEmpty(str))
			return false;
		return str.matches(EMAIL);
	}

	/**
	 * 判断字符串是否为合法手机号 11位 13 14 15 18开头
	 * @param str
	 * @return boolean
	 */
	public static boolean isMobile(String str) {
		if (isEmpty(str))
			return false;
		return str.matches("^(13|14|15|18)\\d{9}$");
	}

	/**
	 * 判断是否为数字
	 * @param str
	 * @return
	 */
	public static boolean isNumber(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (Exception ex) {
			return false;
		}
	}

	/**
	 * 判断字符串是否为非空(包含null与"")
	 * @param str
	 * @return
	 */
	public static boolean isNotEmpty(String str) {
		if (str == null || "".equals(str))
			return false;
		return true;
	}

	/**
	 * 判断字符串是否为非空(包含null与"","    ")
	 * @param str
	 * @return
	 */
	public static boolean isNotEmptyIgnoreBlank(String str) {
		if (str == null || "".equals(str) || "".equals(str.trim()))
			return false;
		return true;
	}

	/**
	 * 判断字符串是否为空(包含null与"")
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		if (str == null || "".equals(str.trim()))
			return true;
		return false;
	}

	/**
	 * 判断字符串是否为空(包含null与"","    ")
	 * @param str
	 * @return
	 */
	public static boolean isEmptyIgnoreBlank(String str) {
		if (str == null || "".equals(str) || "".equals(str.trim()))
			return true;
		return false;
	}

	// 测试主函数
	public static void main(String[] args) {
		System.out.println("CheckOutParamsFormat.main()" + isIdCard("430922199310194618"));
		System.out.println("CheckOutParamsFormat.main()" + isEmail("ranying2013@163.com"));
		System.out.println("CheckOutParamsFormat.main()" + isEmail("ranying201163.com"));
		System.out.println("CheckOutParamsFormat.main()" + isMobile("15209996098"));
	}

	/**
	 * @return the mobilePhone
	 */
	public static String getMobilePhone() {
		return MOBILE_PHONE;
	}

	/**
	 * @return the idcard
	 */
	public static String getIdcard() {
		return IDCARD;
	}

	/**
	 * @return the email
	 */
	public static String getEmail() {
		return EMAIL;
	}


	public static String getUserName() {
		return USER_NAME;
	}


	public static String getPassword() {
		return PASSWORD;
	}


}
