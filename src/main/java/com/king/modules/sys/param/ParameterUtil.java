package com.king.modules.sys.param;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

/**
 * 系统参数工具类
 * 
 * 
 */
public class ParameterUtil {

	public static final String PARAM_CODE_CG_TEMPLATEDIR = "templatedir"; // 代码生成 模板目录
	public static final String PARAM_CODE_CG_OUTPUTDIR_JAVA = "outdir_java";// 代码生成 java目录
	public static final String PARAM_CODE_CG_OUTPUTDIR_WEB = "outdir_web";// 代码生成 jsp目录
	public static final String PARAM_CODE_PWD_TYPE = "sys_passwordType";// 密码类型
	public static final String PARAM_CODE_USER_INIT_PWD = "user_init_pwd";// 初始密码
	public static final String PARAM_CODE_ATTACHMENT_PATH = "attachment_path";// 附件目录
	public static final String PARAM_CODE_FILE_SAVE_TYPE = "file_save_type";// 附件存储类型 LOCAL/FTP
	public static final String PARAM_CODE_FTP_URL = "ftp_url";// ftp服务器地址
	public static final String PARAM_CODE_FTP_PORT = "ftp_port";// ftp服务器端口
	public static final String PARAM_CODE_FTP_USERNAME = "ftp_username";
	public static final String PARAM_CODE_FTP_PASSWORD = "ftp_password";
	public static final String PARAM_CODE_FTP_ATTAPATH = "ftp_path";
	public static final String PARAM_CODE_FTP_ENCODING = "ftp_encoding";// ftp传输编码方式
	public static String PARAM_CODE_TEMPPATH = "tempPath";// 系统默认的临时目录

	// 短信发送接口参数
	public static final String PARAM_CODE_EMPP_CLASS = "EMPP_CLASS";// 短信发送处理类，如：org.szgzw.common.msg.EmppSenderImpl
	public static final String PARAM_CODE_EMPP_SERVER = "EMPP_SERVER";
	public static final String PARAM_CODE_EMPP_PORT = "EMPP_PORT";
	public static final String PARAM_CODE_EMPP_USERNAME = "EMPP_USERNAME";
	public static final String PARAM_CODE_EMPP_PASSWORD = "EMPP_PASSWORD";

	// 移动app相关参数
	public static final String PARAM_CODE_APP_TIMEOUT_MINUTE = "APP_TIMEOUT_MINUTE";// 登录超时时间
	public static final String PARAM_CODE_APP_DES_KEY = "APP_DES_KEY";// 密码传输加密密钥

	// 系统启动后自动缓存加载参数到该map
	public static Map<String, ParameterEntity> mapParameter;

	static {
		mapParameter = new HashMap<String, ParameterEntity>();
	}

	/**
	 * 从参数缓存map中获取参数对象
	 * 
	 * @param paramCode
	 * @return
	 */
	public static ParameterEntity getParamEntity(String paramCode) {
		if (mapParameter != null && mapParameter.containsKey(paramCode))
			return mapParameter.get(paramCode);
		else
			return null;
	}

	/**
	 * 从参数缓存map中获取参数值
	 * 
	 * @param paramCode
	 * @return
	 */
	public static String getParamValue(String paramCode) {
		ParameterEntity pe = getParamEntity(paramCode);
		if (pe != null)
			return pe.getParamtervalue();
		return null;
	}

	/**
	 * 获取指定编码的参数值，如果没有设定，则返回指定默认值
	 * 
	 * @author hwq 2014年11月11日 上午10:38:45
	 * @param paramCode
	 *            参数编码
	 * @param defaultValue
	 *            默认值
	 * @return
	 */
	public static String getParamValue(String paramCode, String defaultValue) {
		String value = getParamValue(paramCode);
		if (StringUtils.isNotEmpty(value))
			return value;
		else
			return defaultValue;
	}

	/**
	 * 获取参数值并转为数字类型
	 * 
	 * @author hwq 上午10:36:57
	 * @param paramCode
	 *            参数编码
	 * @param defaultValue
	 *            默认值
	 * @return
	 */
	public static int getIntParamValue(String paramCode, int defaultValue) {
		String strval = getParamValue(paramCode);
		int val = defaultValue;
		if (StringUtils.isNotEmpty(strval)) {
			val = Integer.parseInt(strval);
		}
		return val;
	}

	/**
	 * 更新参数缓存
	 * 
	 * @param pe
	 */
	public static void updateParam(ParameterEntity pe) {
		mapParameter.put(pe.getParamtercode(), pe);
	}

	/**
	 * 批量更新参数缓存
	 * 
	 * @param pes
	 */
	public static void updateParam(Iterable<ParameterEntity> pes) {
		for (ParameterEntity pe : pes) {
			updateParam(pe);
		}
	}

	/**
	 * 删除参数缓存
	 * 
	 * @param pe
	 */
	public static void removeParam(ParameterEntity pe) {
		mapParameter.remove(pe.getParamtercode());
	}

	public static void removeParam(String paramCode) {
		mapParameter.remove(paramCode);
	}
}
