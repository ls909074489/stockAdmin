package com.king.common.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;

/**
 * Double包装类型的运算工具类
 * @author linjq
 * @Date 2016年3月11日
 */
public class DoubleArithUtil {
	private static final int DEF_DIV_SCALE = 10;

	/**
	 * * 两个Double数相加 *
	 * 
	 * @param v1
	 *            *
	 * @param v2
	 *            *
	 * @return Double
	 */
	public static Double add(Double v1, Double v2) {
		v1 = v1==null?0d:v1;
		v2 = v2==null?0d:v2;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return new Double(b1.add(b2).doubleValue());
		
	}

	/**
	 * 获取数值的绝对值
	 * @param v1
	 * @return
	 */
	public static Double abs(Double v1) {
		v1 = v1==null?0d:v1;
		BigDecimal b1 = new BigDecimal(v1.toString());
		return new Double(b1.abs().doubleValue());
		
	}
	
	/**
	 * * 两个Double数相减 *
	 * 
	 * @param v1
	 *            *
	 * @param v2
	 *            *
	 * @return Double
	 */
	public static Double sub(Double v1, Double v2) {
		v1 = v1==null?0d:v1;
		v2 = v2==null?0d:v2;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return new Double(b1.subtract(b2).doubleValue());
	}
	

	/**
	 * * 两个Double数相乘 *
	 * 
	 * @param v1
	 *            *
	 * @param v2
	 *            *
	 * @return Double
	 */
	public static Double mul(Double v1, Double v2) {
		v1 = v1==null?0d:v1;
		v2 = v2==null?0d:v2;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return new Double(b1.multiply(b2).doubleValue());
	}

	/**
	 * * 两个Double数相除 *
	 * 
	 * @param v1
	 *            *
	 * @param v2
	 *            *
	 * @return Double
	 */
	public static Double div(Double v1, Double v2) {
		v1 = v1==null?0d:v1;
		v2 = v2==null?0d:v2;
		BigDecimal b1 = new BigDecimal(v1.toString());
		BigDecimal b2 = new BigDecimal(v2.toString());
		return new Double(b1.divide(b2, DEF_DIV_SCALE, BigDecimal.ROUND_HALF_UP).doubleValue());
	}

	
	/**
//	 * 格式化掉不要小数
//	 * @param d
//	 * @return
//	 */
	public static Double formatNoDecimals(Double d){
		DecimalFormat df1 = new DecimalFormat("##########");
		try {
			return Double.valueOf(df1.format(d));
		} catch (Exception e) {
			return 0D;
		}
	}
	
//	public static Double formatTwoDecimals(Double d) {
//		if(d == null) {
//			return null;
//		}
//		DecimalFormat df = new DecimalFormat("#.00");
//        return Double.valueOf(df.format(d));
//	}
	
	
	public static Double formatFourDecimals(Double d) {
		if(d == null) {
			return null;
		}
		DecimalFormat df = new DecimalFormat("#.0000");
        return Double.valueOf(df.format(d));
	}
}
