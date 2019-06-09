package com.king.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;
import java.util.UUID;

/**
 * 用于生成订单号、token等
 * @author WangMin
 */

public class NumCreater {
//	private static SimpleDateFormat s = new SimpleDateFormat("yyMMDDHHssSSS");
	private static final String YearMonthDay = "yyyy-MM-dd"; 
	private static String baseStr = "abcdefghijklmnopqrstuvwxyz0123456789"; //生成字符串从此序列中取

	/**
	 * 有id的情况下生成订单
	 * 
	 * @param id
	 * @return
	 */
	public static String getOrderNum(Integer id) {
		SimpleDateFormat s = new SimpleDateFormat(YearMonthDay);
		return s.format(new Date()) + id + (int) (1 + Math.random() * 100);
	}

	/**
	 * 无id的情况下生成uuid
	 * @return
	 */
	public static String getOrderNum() {
		return UUID.randomUUID().toString().replace("-", "");
	}


	/**
	 * 根据订单号和会员id以及详情 和毫秒数 生成
	 */
	public static String getConsumeCode(String memberId, String detailId) {
		return memberId + new Date().getTime() + detailId;
	}
	
	/**
	 * 生成订单
	 * @param id1
	 * @param id2
	 * @return
	 */
	public static String getTradeNo(Integer id1,Integer id2){
		SimpleDateFormat format = new SimpleDateFormat("MMddHHmmss",Locale.getDefault());
		Date date = new Date();
		String key = format.format(date);
		Random r = new Random();
		key = key+id1 + r.nextInt()+id2;
		key = key.substring(0, 15);
		return key;
	}
	/**
	 * 生成订单
	 * @param id1
	 * @return
	 */
	public static String getTradeNo(Integer id){
		SimpleDateFormat format = new SimpleDateFormat("MMddHHmmss",Locale.getDefault());
		Date date = new Date();
		String key = format.format(date);
		Random r = new Random();
		key = key+id + r.nextInt();
		key = key.substring(0,15);
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < 15; i++) {
			int number = r.nextInt(baseStr.length());
			sb.append(baseStr.charAt(number));
		} 
		return key;
	}
	
	/**
	 * 生成批次号
	 * @param length
	 * @return
	 */
	public static String getBatchNo(int length){
		SimpleDateFormat s = new SimpleDateFormat(YearMonthDay);
		Date date = new Date();
		String key = s.format(date);
		Random r = new Random();
		StringBuffer sb = new StringBuffer();
		int j = length - key.length();
		for (int i = 0; i < j ; i++) {
			int number = r.nextInt(baseStr.length());
			sb.append(baseStr.charAt(number));
		} 
		return (key+sb.toString()).substring(0,length);
	}
	
	public static void main(String[] args) {
		System.out.println("NumCreater.main()"+getBatchNo(15));
	}
	
	

}
