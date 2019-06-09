package com.king.common.utils;

import java.util.Random;

/**
 * 随机数工具类
 * @author yy-team
 * @date 2017年12月8日
 */
public class RandomUtil {
	private static final String ALLCHAR = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final String LETTERCHAR = "abcdefghijkllmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

	/** 
	 * 返回一个定长的随机字符串(只包含大小写字母、数字) 
	 *  
	 * @param length 
	 *            随机字符串长度 
	 * @return 随机字符串 
	 */
	public static String getString(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			sb.append(ALLCHAR.charAt(random.nextInt(ALLCHAR.length())));
		}
		return sb.toString();
	}

	/** 
	 * 返回一个定长的随机纯字母字符串(只包含大小写字母)
	 *  
	 * @param length 
	 *            随机字符串长度 
	 * @return 随机字符串 
	 */
	public static String getMixString(int length) {
		StringBuffer sb = new StringBuffer();
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			sb.append(ALLCHAR.charAt(random.nextInt(LETTERCHAR.length())));
		}
		return sb.toString();
	}

	/** 
	 * 返回一个定长的随机纯大写字母字符串(只包含大小写字母) 
	 *  
	 * @param length 
	 *            随机字符串长度 
	 * @return 随机字符串 
	 */
	public static String getLowerString(int length) {
		return getMixString(length).toLowerCase();
	}

	/** 
	 * 返回一个定长的随机纯小写字母字符串(只包含大小写字母) 
	 *  
	 * @param length 
	 *            随机字符串长度 
	 * @return 随机字符串 
	 */
	public static String getUpperString(int length) {
		return getMixString(length).toUpperCase();
	}

	/**
	 * 返回长度为【strLength】的随机数字字符串，如果不够在前面补0
	 * @param strLength  随机字符串长度 
	 * @return
	 */
	public static String getInt(int strLength) {
		Random rm = new Random();
		// 获得随机数
		double pross = (1 + rm.nextDouble()) * Math.pow(10, strLength);
		// 将获得的获得随机数转化为字符串
		String fixLenthString = String.valueOf(pross);
		// 返回固定的长度的随机数
		return fixLenthString.substring(1, strLength + 1);
	}

}