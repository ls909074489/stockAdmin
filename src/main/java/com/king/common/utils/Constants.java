package com.king.common.utils;

/**
 * 常量
 * 
 * @ClassName: Constants
 * @author liusheng
 * @date 2015年12月17日 下午2:57:19
 */
public class Constants {

	public static final Integer PERSISTENCE_DELETE_STATUS = 0;// 删除

	public static final Integer PERSISTENCE_NOMAL_STATUS = 1;// 未删除

	public static final Integer JSON_SUC = 1;// 返回json操作表示成功
	public static final Integer JSON_FAIL = 0;// 返回json操作表示失败

	public static final String DEFAULT_CHINA_ID = "a037aaef-ca55-11e5-b7f9-5cb9018f5fb4";// 中国的区域id
	public static final String DEFAULT_CHINA_NAME = "中华人民共和国";// 中国

	public static final String EXPORT_MAX_COUNT = "4000";// 导出的最大条数

	public static final String CURRENTSTATION="currentStation";//当前session的厂商key
	
	
	public static final Integer MASVER_START=1;//起始的版本数
	
	public static final String SUBSTATUS_NOT="0";//0:未审核 1：质疑   2：通过
	public static final String SUBSTATUS_QUES="1";//0:未审核 1：质疑   2：通过
	public static final String SUBSTATUS_PASS="2";//0:未审核 1：质疑   2：通过
	
	
	/**
	 * boolean值
	 * 
	 * @ClassName: BooleanType
	 * @author liusheng
	 * @date 2016年3月3日 下午4:07:07
	 */
	public static class BooleanType {
		public static String YES = "1";
		public static String NO = "0";
	}

	// 用户管理下的用户类型
	public static class UserType {
		public static Integer COMMON = 1;// 普通
		public static Integer ADMIN = 2;// 管理
	}

	public static class RoleGroup {
		public static String OTGROUP = "OTGROUP";// 网点角色组
	}

	public static class ParamCode {
		public static String DEFAULT_PWD = "DEFAULT_PWD";// 默认的用户密码
	}

	public static class MSG {
		public static String SUC = "操作成功!";
		public static String FAIL = "操作失败!";
	}



}
