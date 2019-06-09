package com.king.frame.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class RequestUtil {

	/**
	 * 打印请求中参数
	 * 
	 * @param request
	 */
	public static void printParams(ServletRequest request) {
		Map<String, String> map = RequestUtil.getParamsMap(request);
		for (String key : map.keySet()) {
			String value = map.get(key);
			System.out.println(">>> field:" + key + "   value:" + value);
		}
	}

	public static boolean hasParameter(ServletRequest request, String name) {
		Map m = request.getParameterMap();
		return m.containsKey(name);
	}

	public static String getParameter(ServletRequest request, String name) {
		return getParameter(request, name, false);
	}

	public static String getParameter(ServletRequest request, String name, String defaultValue) {
		return getParameter(request, name, defaultValue, false);
	}

	public static String getParameter(ServletRequest request, String name, boolean emptyStringsOK) {
		return getParameter(request, name, null, emptyStringsOK);
	}

	public static String getParameter(ServletRequest request, String name, String defaultValue, boolean emptyStringsOK) {
		String temp = request.getParameter(name);
		if (temp != null) {
			if (temp.equals("") && !emptyStringsOK)
				return defaultValue;
			else
				return temp;
		} else {
			return defaultValue;
		}
	}

	public static String[] getParameters(ServletRequest request, String name) {
		if (name == null)
			return new String[0];

		String paramValues[] = request.getParameterValues(name);
		if (paramValues == null || paramValues.length == 0)
			return new String[0];

		List values = new ArrayList(paramValues.length);
		for (int i = 0; i < paramValues.length; i++)
			if (paramValues[i] != null && !"".equals(paramValues[i]))
				values.add(paramValues[i]);
		return (String[]) values.toArray(new String[0]);
	}

	public static boolean getBooleanParameter(ServletRequest request, String name) {
		return getBooleanParameter(request, name, false);
	}

	public static boolean getBooleanParameter(ServletRequest request, String name, boolean defaultVal) {
		String temp = getParameter(request, name);
		if ("true".equals(temp) || "on".equals(temp) || "1".equals(temp) || "yes".equals(temp))
			return true;

		if ("false".equals(temp) || "off".equals(temp) || "0".equals(temp) || "no".equals(temp))
			return false;
		else
			return defaultVal;
	}

	public static int getIntParameter(ServletRequest request, String name, int defaultNum) {
		String temp = request.getParameter(name);
		if (temp != null && !temp.equals("")) {
			int num = defaultNum;
			try {
				num = Integer.parseInt(temp.trim());
			} catch (Exception ignored) {
			}
			return num;
		} else {
			return defaultNum;
		}
	}

	public static int[] getIntParameters(ServletRequest request, String name, int defaultNum) {
		String paramValues[] = request.getParameterValues(name);
		if (paramValues == null || paramValues.length == 0)
			return new int[0];

		int values[] = new int[paramValues.length];

		for (int i = 0; i < paramValues.length; i++)
			try {
				values[i] = Integer.parseInt(paramValues[i].trim());
			} catch (Exception e) {
				values[i] = defaultNum;
			}

		return values;
	}

	public static double getDoubleParameter(ServletRequest request, String name, double defaultNum) {
		String temp = request.getParameter(name);

		if (temp != null && !temp.equals("")) {
			double num = defaultNum;
			try {
				num = Double.parseDouble(temp.trim());
			} catch (Exception ignored) {
			}
			return num;

		} else {
			return defaultNum;
		}
	}

	public static Long getLongParameter(ServletRequest request, String name, long defaultNum) {
		String temp = request.getParameter(name);
		long num = defaultNum;
		try {
			num = Long.parseLong(temp.trim());
		} catch (Exception ignored) {
		}
		return Long.valueOf(num);
	}

	public static long[] getLongParameters(ServletRequest request, String name, long defaultNum) {
		String paramValues[] = request.getParameterValues(name);
		if (paramValues == null || paramValues.length == 0)
			return new long[0];
		long values[] = new long[paramValues.length];
		for (int i = 0; i < paramValues.length; i++)
			try {
				values[i] = Long.parseLong(paramValues[i].trim());
			} catch (Exception e) {
				values[i] = defaultNum;
			}
		return values;
	}

	public static String getAttribute(ServletRequest request, String name) {
		return getAttribute(request, name, false);
	}

	public static String getAttribute(ServletRequest request, String name, boolean emptyStringsOK) {
		String temp = (String) request.getAttribute(name);

		if (temp != null) {
			if (temp.equals("") && !emptyStringsOK)
				return null;
			else
				return temp;
		} else {
			return null;
		}
	}

	public static boolean getBooleanAttribute(ServletRequest request, String name) {
		String temp = (String) request.getAttribute(name);
		return temp != null && temp.equals("true");
	}

	public static int getIntAttribute(ServletRequest request, String name, int defaultNum) {
		String temp = (String) request.getAttribute(name);
		if (temp != null && !temp.equals("")) {
			int num = defaultNum;
			try {
				num = Integer.parseInt(temp.trim());
			} catch (Exception ignored) {
			}
			return num;
		} else {
			return defaultNum;
		}
	}

	public static long getLongAttribute(ServletRequest request, String name, long defaultNum) {
		String temp = (String) request.getAttribute(name);

		if (temp != null && !temp.equals("")) {
			long num = defaultNum;
			try {
				num = Long.parseLong(temp.trim());
			} catch (Exception ignored) {
			}
			return num;
		} else {
			return defaultNum;
		}
	}

	public static Map<String, String> getParamsMap(ServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		Set<String> keys = request.getParameterMap().keySet();
		for (String key : keys) {
			String value = getParameter(request, key);
			map.put(key, value);
		}
		return map;
	}

	public static String getJson(ServletRequest request) {
		StringBuffer sb = new StringBuffer();

		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e1) {
		}

		String json = sb.toString();
		return json;
	}

	public static String encode(String fileName, String encode) {
		String name = null;
		try {
			name = URLEncoder.encode(fileName, encode);
			name = name.replace("+", "%20");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return name;
	}

	/**
	 * 获取浏览器类型
	 * 
	 * @author wzw 2014年11月13日
	 * @param request
	 * @return IE9: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0) FireFox: Mozilla/5.0 (Windows
	 *         NT 6.1; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0 360:Mozilla/5.0 (Windows NT 6.1; WOW64)
	 *         AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36 IE10: Mozilla/5.0 (compatible;
	 *         MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0) google: Mozilla/5.0 (Windows NT 6.1; WOW64)
	 *         AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.104 Safari/537.36
	 */
	public static String getExplorerType(HttpServletRequest request) {
		try {
			String agent = request.getHeader("User-Agent");
			if (StringUtils.isBlank(agent))
				return null;
			if (agent.contains("MSIE")) {
				return agent.split(";")[1];
			} else if (agent.contains("Firefox")) {
				return "Firefox";
			} else if (agent.contains("Chrome")) {
				return "Chrome";
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}