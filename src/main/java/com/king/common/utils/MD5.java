package com.king.common.utils;

import java.security.MessageDigest;

import sun.misc.BASE64Encoder;

/**
 * MD5加密工具类
 * @author WangMin
 */
public class MD5 {
	
	private final static String[] hexDigits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d","e", "f" };
	
    private final static BASE64Encoder base64Encode = new BASE64Encoder();

	private static String byteArrayToHexString(byte[] bytes) {
		StringBuffer sb = new StringBuffer();
		for (byte b : bytes) {
			sb.append(byteToHexString(b));
		}
		return sb.toString();
	}

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n = 256 + n;
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];
	}

	/**
	 * 将字符串加密成MD5字符串
	 *
	 * @param origin
	 *            需要加密的字符串
	 * @return 加密后的字符串
	 */
	public static String MD5Encode(String origin) {
		String ret = null;
		try {
			ret = new String(origin);
			MessageDigest md = MessageDigest.getInstance("MD5");
			ret = byteArrayToHexString(md.digest(ret.getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	/**
	* @Title: md5EncryptAndBase64  
	* @Description: base 64后 md5
	* @param @param str
	* @param @return    设定文件  
	* @return String    返回类型  
	* @throws
	 */
	public static String md5EncryptAndBase64(String str) {
        return encodeBase64(md5Encrypt(str));
    }
	
	private static byte[] md5Encrypt(String encryptStr) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(encryptStr.getBytes("utf8"));
            return md5.digest();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    private static String encodeBase64(byte[] b) {
        String str = base64Encode.encode(b);
        return str;
    }
	
	
}