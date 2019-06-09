package com.king.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang.StringUtils;

/**
 * 日期处理工具类
 */
public final class DateUtil {
	private static String previousDateTime;

	public static final String TIME_PATTERN_DEFAULT = "yyyy-MM-dd HH:mm:ss";
	public static final String YearMonthDay = "yyyy-MM-dd";
	public static final String YearMonthDayHHmmssSSS = "yyyy-MM-dd HH:mm:ss.SSS";
	public static final String MonthYearHHmmssSSS = "MM/dd/yyyy HH:mm:ss.SSS";
	public static final String ssmmHHddMMYear = "ss mm HH dd MM ? yyyy";

	private static SimpleDateFormat timedFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");

	// private static final SimpleDateFormat sqlServerSf = new SimpleDateFormat(YearMonthDayHHmmssSSS);
	// private static final SimpleDateFormat mysqlSf = new SimpleDateFormat(MonthYearHHmmssSSS);
	// private static final SimpleDateFormat cronSf = new SimpleDateFormat(ssmmHHddMMYear);
	//
	// private static final SimpleDateFormat shortSf = new SimpleDateFormat(YearMonthDay);

	/**
	 * SqlService的yyyy-MM-dd HH:mm:ss.S 格式转换 @Title: timedStrToDate @author WangMin @date 2016年8月7日
	 * 下午6:44:34 @param @param timedStr @param @return 设定文件 @return Date 返回类型 @throws
	 */
	public static Date timedStrToDate(String timedStr) {
		try {
			return timedFormat.parse(timedStr);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * 获取当前日期/1000 的时间戳
	 */
	public static String getShortDateTime() {
		Long time = new Date().getTime() / 1000;
		return String.valueOf(time);
	}

	/**
	 * 将yyyy-MM-dd 转换为 yyyy-MM-dd HH:mm:ss
	 * 
	 * @param dateStr
	 * @return
	 */
	public static String shortFdateToLongFDate(String dateStr) {
		Date date = null;
		try {
			SimpleDateFormat shortSf = new SimpleDateFormat(YearMonthDay);
			date = shortSf.parse(dateStr);
			return formatDateTime(date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String yearMonthDayDate(Date date) {
		try {
			SimpleDateFormat shortSf = new SimpleDateFormat(YearMonthDay);
			return shortSf.format(date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static Date yearMonthDayDate(String dateStr) {
		try {
			SimpleDateFormat shortSf = new SimpleDateFormat(YearMonthDay);
			return shortSf.parse(dateStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 转换为cron 格式
	 * 
	 * @param date
	 * @return
	 */
	public static String toCronDateStr(Date date) {
		SimpleDateFormat cronSf = new SimpleDateFormat(ssmmHHddMMYear);
		return cronSf.format(date);
	}

	/**
	 * @Title: toSqlServerSfDateStr @Description: 将date 转换为yyyy-MM-dd HH:mm:ss.SSS格式的字符串 @param @param
	 *         date @param @return 设定文件 @return String 返回类型 @throws
	 */
	public static String toSqlServerSfDateStr(Date date) {
		SimpleDateFormat sqlServerSf = new SimpleDateFormat(YearMonthDayHHmmssSSS);
		return sqlServerSf.format(date);
	}

	/**
	 * @Title: toSqlServerSfDateStr @Description: 将时间戳 转换为yyyy-MM-dd HH:mm:ss.SSS格式的字符串 @param @param
	 *         date @param @return 设定文件 @return String 返回类型 @throws
	 */
	public static String toSqlServerSfDateStr(Long date) {
		SimpleDateFormat sqlServerSf = new SimpleDateFormat(YearMonthDayHHmmssSSS);
		return sqlServerSf.format(new Date(date));
	}

	/**
	 * @Title: toSqlServerSfDate @Description: 将日期转换为yyyy-MM-dd HH:mm:ss.SSS字符串 @param @param
	 *         date @param @return @param @throws ParseException 设定文件 @return Date 返回类型 @throws
	 */
	public static Date toSqlServerSfDate(String date) throws ParseException {
		SimpleDateFormat sqlServerSf = new SimpleDateFormat(YearMonthDayHHmmssSSS);
		return sqlServerSf.parse(date);
	}

	public static String toMySQLSfDate(Date date) {
		SimpleDateFormat mysqlSf = new SimpleDateFormat(MonthYearHHmmssSSS);
		return mysqlSf.format(date);
	}

	public synchronized static String getUniqueDateTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateTime = sdf.format(new Date());
		while (dateTime.equals(previousDateTime)) {
			dateTime = sdf.format(new Date());
		}
		previousDateTime = dateTime;
		return dateTime;
	}

	/**
	 * 获取当前时间
	 * 
	 * @return Date
	 */
	public static Date getCurrentDate() {
		return new Date();
	}

	/**
	 * 将当前系统时间转换成直至Millisecond的样式
	 */
	public static String getDateTimeZone() {
		return new SimpleDateFormat("yyyyMMddHHmmssS").format(new Date());
	}

	/**
	 * 将当前系统时间转换成直至HHmmssS的样式
	 * 
	 * @date 2008-4-3 上午09:48:56
	 * @return
	 */
	public static String getTimeZone() {
		return new SimpleDateFormat("HHmmssS").format(new Date());
	}

	/**
	 * 根据时间格式取当前时间
	 * 
	 * @param format
	 */
	public static String getCurrentDate(String format) {
		return new SimpleDateFormat(format).format(new Date());
	}

	/**
	 * 得到当前系统时间和日期
	 */
	public static String getDateTime() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	}

	public static String getDateTime(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	}

	/**
	 * 获得当前系统日期
	 */
	public static String getDate() {
		return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	}

	/**
	 * 获得当前系统时间
	 * 
	 * @return
	 */
	public static String getTime() {
		return new SimpleDateFormat("HH:mm:ss").format(new Date());
	}

	/**
	 * 时间戳转换为Date
	 * 
	 * @param timestamp
	 * @return
	 */
	public static Date timestampToDate(String timestamp) {
		Date date = null;
		if (StringUtils.isBlank(timestamp) || "null".equals(timestamp)) {
			return null;
		}
		try {
			date = new Date(Long.valueOf(timestamp));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return date;
	}

	/**
	 * 把sqlServer 的字符串时间戳 转换成Date
	 */
	public static Date timestampStrToDate(String timestamp) {
		Date date = null;
		if (StringUtils.isBlank(timestamp) || "null".equals(timestamp)) {
			return null;
		}
		try {
			date = strToDate(timestamp, "yyyy-MM-dd HH:mm:ss.SSS");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return date;

	}

	/**
	 * 
	 * @param timeString
	 * @param rating
	 * @return
	 */
	public static boolean isDateAfter(String timeString, long rating) {
		try {
			Date date = addDay(timeString, rating);
			Date now = new SimpleDateFormat("yyyy-MM-dd HH:mm")
					.parse(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
			long min = date.getTime();
			long nowmin = now.getTime();
			if (nowmin - min > 10 * 60 * 1000)
				return true;
			else
				return false;
		} catch (ParseException e) {
			return false;
		}
	}

	/**
	 * 判断传入的日期是否大于当前系统时间额定的时间
	 * 
	 * @param timeString
	 * @param rating
	 * @return
	 */
	public static boolean isAfter(String timeString, int rating) {
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(timeString);
			Date now = new SimpleDateFormat("yyyy-MM-dd HH:mm")
					.parse(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));

			long min = date.getTime();
			long nowmin = now.getTime();
			long count = rating * 60 * 1000;
			if (nowmin - min > count)
				return true;
			else
				return false;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 判断传入的日期是否大于当前系统时间额定的时间
	 * 
	 * @param timeString
	 * @param rating
	 * @return
	 */
	public static boolean isBefore(String timeString, int rating) {
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(timeString);
			Date now = new SimpleDateFormat("yyyy-MM-dd HH:mm")
					.parse(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
			long min = date.getTime();
			long nowmin = now.getTime();

			if (nowmin - min < rating * 60 * 1000)
				return true;
			else
				return false;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 根据指定的日期格式显示日期
	 * 
	 * @param dDate
	 * @param sFormat
	 * @return
	 */
	public static String formatDate(Date dDate, String sFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat(sFormat);
		String dateString = formatter.format(dDate);
		return dateString;
	}

	public static String formatDateTime(Date dDate) {
		SimpleDateFormat formatter = new SimpleDateFormat(TIME_PATTERN_DEFAULT);
		try {
			String dateString = formatter.format(dDate);
			return dateString;
		} catch (Exception e) {
			return null;
		}
	}

	public static Date formateDate(String strDate) {
		SimpleDateFormat formatter = new SimpleDateFormat(TIME_PATTERN_DEFAULT);
		try {
			return formatter.parse(strDate);
		} catch (Exception e) {
			return null;
		}
	}

	public static String formatDateTimeC(Date dDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd日");
		String dateString = formatter.format(dDate);
		int vHour = dDate.getHours();
		if (vHour < 12) {
			return dateString + "上午";
		} else {
			return dateString + "下午";
		}
	}

	public static String dateToString(Date dDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(dDate);
		return dateString;
	}

	public static Date toDate(Date dDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = formatter.format(dDate);
		return strToDate(dateString, "yyyy-MM-dd");
	}

	public static Date toDatetime(Date dDate) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = formatter.format(dDate);
		return strToDate(dateString, "yyyy-MM-dd HH:mm:ss");
	}

	/**
	 * 将字符转换为指定的日期格式输出
	 * 
	 * @param s
	 * @param pattern
	 * @return
	 */
	public static Date strToDate(String s, String pattern) {
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		Date date1;
		try {
			Date theDate = formatter.parse(s);
			Date date = theDate;
			return date;
		} catch (Exception ex) {
			date1 = null;
		}
		return date1;
	}

	/**
	 * 将字符转换为日期
	 * 
	 * @param s
	 * @return
	 */
	public static Date strToDate(String s) {
		Date date;
		try {
			DateFormat df = DateFormat.getDateInstance();
			Date theDate = df.parse(s);
			Date date1 = theDate;
			return date1;
		} catch (Exception ex) {
			date = null;
		}
		return date;
	}

	/**
	 * 将字符转换为日期 支持yyyy-MM-dd格式或者yyyy-MM-dd HH:mm:ss
	 * 
	 * @param s
	 * @return
	 */
	public static Date strToDateOrDateTime(String s) {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateTime = formatter.parse(s);
			return dateTime;
		} catch (Exception ex) {
			try {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date date = formatter.parse(s);
				return date;
			} catch (Exception e) {
				return null;
			}
		}
	}

	/**
	 * 添加 - 秒
	 * 
	 * @param sDate
	 * @param iNbDay
	 * @return
	 */
	public static Date addSecond(Date ndate, long iNbTime) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(ndate);
		cal.add(Calendar.SECOND, (int) iNbTime);
		Date date = cal.getTime();
		return date;
	}

	/**
	 * 添加 - 分
	 * 
	 * @param sDate
	 * @param iNbDay
	 * @return
	 */
	public static Date addMinute(String sDate, long iNbTime) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strToDate(sDate, "yyyy-MM-dd HH:mm"));
		cal.add(Calendar.MINUTE, (int) iNbTime);
		Date date = cal.getTime();
		return date;
	}

	/**
	 * 添加小时
	 * 
	 * @param sDate
	 * @param iNbTime
	 * @return
	 */
	public static Date addHour(String sDate, long iNbTime) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strToDate(sDate, "yyyy-MM-dd HH:mm"));
		cal.add(Calendar.HOUR_OF_DAY, (int) iNbTime);
		Date date = cal.getTime();
		return date;
	}

	/**
	 * 添加小时和分
	 * 
	 * @param sDate
	 * @param iNbDay
	 * @return
	 */
	public static String addMinuteXzjy(Date sDate, long iNbTime) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(sDate);
		cal.add(Calendar.MINUTE, (int) iNbTime);
		Date date = cal.getTime();
		SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
		String dateString = formatter.format(date);
		return dateString;
	}

	/**
	 * 给指定添加天数
	 * 
	 * @param dDate
	 * @param iNbDay
	 * @return
	 */
	public static Date addDay(String sDate, long iNbDay) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strToDate(sDate, "yyyy-MM-dd HH:mm"));
		cal.add(Calendar.DAY_OF_MONTH, (int) iNbDay);
		Date result = cal.getTime();
		return result;
	}

	/**
	 * 取得指定日期N天后的日期
	 * 
	 * @param date
	 * @param days
	 * @return
	 */
	public static Date addDays(Date date, int days) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DAY_OF_MONTH, days);
		return cal.getTime();
	}

	/**
	 * 取得指定日期N天前的日期
	 * 
	 * @param date
	 * @param days
	 * @return
	 */
	public static Date subDays(Date date, int days) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DAY_OF_MONTH, days * -1);
		return cal.getTime();
	}

	/**
	 * 给但前时间添加天数
	 *
	 * @param sDate
	 * @param iNbDay
	 * @return
	 */
	public static Date addDay(long iNbDay) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_MONTH, (int) iNbDay);
		Date result = cal.getTime();
		return result;
	}

	/**
	 * 给当前时间添加 周
	 * 
	 * @param dDate
	 * @param iNbWeek
	 * @return
	 */
	public static Date addWeek(String sDate, long iNbWeek) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strToDate(sDate, "yyyy-MM-dd HH:mm"));
		cal.add(Calendar.WEEK_OF_YEAR, (int) iNbWeek);
		Date result = cal.getTime();
		return result;
	}

	/**
	 * 给当前时间添加 月
	 * 
	 * @param dDate
	 * @param iNbMonth
	 * @return
	 */
	public static Date addMonth(String sDate, int iNbMonth) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(strToDate(sDate, "yyyy-MM-dd HH:mm"));
		int month = cal.get(Calendar.MONTH);
		month += iNbMonth;
		int year = month / 12;
		month %= 12;
		cal.set(Calendar.MONTH, month);
		if (year != 0) {
			int oldYear = cal.get(Calendar.YEAR);
			cal.set(Calendar.YEAR, year + oldYear);
		}
		return cal.getTime();
	}

	/**
	 * 给当前时间添加 月
	 * 
	 * @param dDate
	 * @param iNbMonth
	 * @return
	 */
	public static Date addMonth(Date date, int iNbMonth) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int month = cal.get(Calendar.MONTH);
		month += iNbMonth;
		int year = month / 12;
		month %= 12;
		cal.set(Calendar.MONTH, month);
		if (year != 0) {
			int oldYear = cal.get(Calendar.YEAR);
			cal.set(Calendar.YEAR, year + oldYear);
		}
		return cal.getTime();
	}

	/**
	 * 给单当前时间添加 年
	 * 
	 * @param dDate
	 * @param iNbYear
	 * @return
	 */
	public static Date addYear(Date dDate, int iNbYear) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dDate);
		int oldYear = cal.get(1);
		cal.set(1, iNbYear + oldYear);
		return cal.getTime();
	}

	/**
	 * 得到当前日期是星期几
	 * 
	 * @param dDate
	 * @return
	 */
	public static int getWeek(Date dDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dDate);
		return cal.get(Calendar.DAY_OF_WEEK) - 1;
	}

	/**
	 * 得到当前天是星期几
	 * 
	 * @date Aug 30, 2008 9:48:45 PM
	 * @return
	 */
	public static String getWeeks() {
		final String dayNames[] = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
		SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		// SimpleDateFormat 是一个以与语言环境相关的方式来格式化和分析日期的具体类。它允许进行格式化（日期 -> 文本）、分析（文本
		// -> 日期）和规范化。
		Calendar calendar = Calendar.getInstance();
		Date date = new Date();
		try {
			date = sdfInput.parse(sdfInput.format(date));
		} catch (ParseException ex) {

		}
		calendar.setTime(date);
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);// get 和 set
															// 的字段数字，指示一个星期中的某天。
		System.out.println("dayOfWeek:" + dayOfWeek);
		return dayNames[dayOfWeek - 1];
	}

	/**
	 * 根据一个日期，返回是星期几的字符串
	 * 
	 * @param sdate
	 * @return
	 */
	public static String getWeek(String sdate) {
		// 再转换为时间
		Date date = strToDate(sdate);
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		// int hour=c.get(Calendar.DAY_OF_WEEK);
		// hour中存的就是星期几了，其范围 1~7
		// 1=星期日 7=星期六，其他类推
		return new SimpleDateFormat("EEEE").format(c.getTime());
	}

	/**
	 * 得到但前日期是 那个月的几号
	 * 
	 * @param dDate
	 * @return
	 */
	public static int getMonthOfDay(Date dDate) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(dDate);
		return cal.get(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 
	 * 计算两个日期之间相差的天数
	 * 
	 * @param date1
	 * 
	 * @param date2
	 * 
	 * @return
	 * 
	 */

	public static int daysBetween(Date date1, Date date2)

	{

		Calendar cal = Calendar.getInstance();

		cal.setTime(date1);

		long time1 = cal.getTimeInMillis();

		cal.setTime(date2);

		long time2 = cal.getTimeInMillis();

		long between_days = (time2 - time1) / (1000 * 3600 * 24);

		return Integer.parseInt(String.valueOf(between_days));

	}

	/**
	 * 生成随即数
	 * 
	 * @date 2008-4-3 上午09:57:56
	 * @param pwd_len
	 * @return
	 */
	public static String genRandomNum(int pwd_len) {
		// 35是因为数组是从0开始的，26个字母+10个数字
		final int maxNum = 36;
		int i; // 生成的随机数
		int count = 0; // 生成的密码的长度
		char[] str = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

		StringBuffer pwd = new StringBuffer("");
		Random r = new Random();
		while (count < pwd_len) {
			// 生成随机数，取绝对值，防止生成负数，
			i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1
			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}

	public static String genRandNum(int pwd_len) {
		// 35是因为数组是从0开始的，26个字母+10个数字
		final int maxNum = 36;
		int i; // 生成的随机数
		int count = 0; // 生成的密码的长度
		char[] str = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

		StringBuffer pwd = new StringBuffer("");
		Random r = new Random();
		while (count < pwd_len) {
			// 生成随机数，取绝对值，防止生成负数，
			i = Math.abs(r.nextInt(maxNum)); // 生成的数最大为36-1
			if (i >= 0 && i < str.length) {
				pwd.append(str[i]);
				count++;
			}
		}
		return pwd.toString();
	}

	/**
	 * 得到当前年
	 * 
	 * @date 2011-04-20
	 */
	public static String getNowYear() {
		int year = Calendar.getInstance().get(Calendar.YEAR);
		return String.valueOf(year);
	}

	/**
	 * 得到当前季度 1 第一季度 2 第二季度 3 第三季度 4 第四季度
	 * 
	 * @date 2011-04-20
	 */
	public static int getSeason() {
		int season = 0;
		int month = Calendar.getInstance().get(Calendar.MONTH);
		switch (month) {
		case Calendar.JANUARY:
		case Calendar.FEBRUARY:
		case Calendar.MARCH:
			season = 1;
			break;
		case Calendar.APRIL:
		case Calendar.MAY:
		case Calendar.JUNE:
			season = 2;
			break;
		case Calendar.JULY:
		case Calendar.AUGUST:
		case Calendar.SEPTEMBER:
			season = 3;
			break;
		case Calendar.OCTOBER:
		case Calendar.NOVEMBER:
		case Calendar.DECEMBER:
			season = 4;
			break;
		default:
			break;
		}
		return season;
	}

	/**
	 * 获取年份下拉列表 从大到小排序
	 */
	public static List<Integer> getYearEnum(int beforeLen, int behindLen) {
		if (beforeLen < 0 || behindLen < 0)
			return null;
		List<Integer> returnList = new ArrayList<Integer>();
		int year = Calendar.getInstance().get(Calendar.YEAR);
		returnList.add(year);
		int tempYear = year;
		for (int i = 0; i < beforeLen; i++) {
			int lastYear = tempYear - 1;
			returnList.add(lastYear);
			tempYear = lastYear;
		}
		tempYear = year;
		for (int i = 0; i < behindLen; i++) {
			int nextYear = tempYear + 1;
			returnList.add(nextYear);
			tempYear = nextYear;
		}
		// 排序 从大到小
		Collections.sort(returnList, Collections.reverseOrder());
		return returnList;
	}

	/**
	 * 得到这个月的第几天，前于当月第一天将返回当月第一天， 后于当月最后一天将返回当月最后一天
	 * 
	 * @param date
	 *            时间
	 * @param days
	 *            第几天
	 * @return
	 */
	public static Date getDateByMonthDay(Date date, int days) {
		Date firstDate = getDateStartByMonth(date);
		Date lastDate = getDateEndByMonth(date);

		Date resultDate = addDays(firstDate, (days - 1));
		if (resultDate.before(firstDate)) {
			return firstDate;
		}
		if (resultDate.after(lastDate)) {
			return lastDate;
		}
		return resultDate;
	}

	/**
	 * 当月第一天开始时间
	 * 
	 * @param date
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static Date getDateStartByMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, 0);
		calendar.set(calendar.DAY_OF_MONTH, 1);
		date = calendar.getTime();
		String dateStr = parseDate2(date, "yyyy-MM-dd");
		dateStr = dateStr + " 00:00:00";
		return strToDateOrDateTime(dateStr);
	}

	/**
	 * 当月最后一天最后时间
	 * 
	 * @param date
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static Date getDateEndByMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, 1);
		calendar.set(calendar.DAY_OF_MONTH, 0);
		date = calendar.getTime();
		String dateStr = parseDate2(date, "yyyy-MM-dd");
		dateStr = dateStr + " 23:59:59";
		return strToDateOrDateTime(dateStr);
	}

	/**
	 * 当天的起始时间
	 * 
	 * @param date
	 * @return
	 */
	public static Date getDateStart(Date date) {
		String dateStr = parseDate2(date, "yyyy-MM-dd");
		dateStr = dateStr + " 00:00:00";
		return strToDateOrDateTime(dateStr);
	}

	/**
	 * 得到一天的结束时间
	 * 
	 * @param date
	 * @return
	 */
	public static Date getDateEnd(Date date) {
		String dateStr = parseDate2(date, "yyyy-MM-dd");
		dateStr = dateStr + " 23:59:59";
		return strToDateOrDateTime(dateStr);
	}

	public static String parseDate2(Date date, String pattern) {
		DateFormat df = new SimpleDateFormat(pattern);
		return df.format(date);
	}

	/**
	 * 获取前n天的时间戳
	 * 
	 * @param n
	 * @return
	 */
	public static Long getBeforeTimestamp(int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, -n);
		return calendar.getTimeInMillis();
	}

	/**
	 * 判断时间是否在时间段内 @Title: isInDate @author WangMin 当前时间 yyyy-MM-dd HH:mm:ss @param strDateBegin 开始时间 00:00:00 @param
	 * strDateEnd 结束时间 00:05:00 @date 2016年8月11日 下午12:04:29 @return boolean 返回类型 @throws
	 */
	public static boolean isInDate(Date date, String strDateBegin, String strDateEnd) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(date);
		// 截取当前时间时分秒
		int strDateH = Integer.parseInt(strDate.substring(11, 13));
		int strDateM = Integer.parseInt(strDate.substring(14, 16));
		int strDateS = Integer.parseInt(strDate.substring(17, 19));
		// 截取开始时间时分秒
		int strDateBeginH = Integer.parseInt(strDateBegin.substring(0, 2));
		int strDateBeginM = Integer.parseInt(strDateBegin.substring(3, 5));
		int strDateBeginS = Integer.parseInt(strDateBegin.substring(6, 8));
		// 截取结束时间时分秒
		int strDateEndH = Integer.parseInt(strDateEnd.substring(0, 2));
		int strDateEndM = Integer.parseInt(strDateEnd.substring(3, 5));
		int strDateEndS = Integer.parseInt(strDateEnd.substring(6, 8));
		if ((strDateH >= strDateBeginH && strDateH <= strDateEndH)) {
			// 当前时间小时数在开始时间和结束时间小时数之间
			if (strDateH > strDateBeginH && strDateH < strDateEndH) {
				return true;
				// 当前时间小时数等于开始时间小时数，分钟数在开始和结束之间
			} else if (strDateH == strDateBeginH && strDateM >= strDateBeginM && strDateM <= strDateEndM) {
				return true;
				// 当前时间小时数等于开始时间小时数，分钟数等于开始时间分钟数，秒数在开始和结束之间
			} else if (strDateH == strDateBeginH && strDateM == strDateBeginM && strDateS >= strDateBeginS
					&& strDateS <= strDateEndS) {
				return true;
			}
			// 当前时间小时数大等于开始时间小时数，等于结束时间小时数，分钟数小等于结束时间分钟数
			else if (strDateH >= strDateBeginH && strDateH == strDateEndH && strDateM <= strDateEndM) {
				return true;
				// 当前时间小时数大等于开始时间小时数，等于结束时间小时数，分钟数等于结束时间分钟数，秒数小等于结束时间秒数
			} else if (strDateH >= strDateBeginH && strDateH == strDateEndH && strDateM == strDateEndM
					&& strDateS <= strDateEndS) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	/**
	 * 毫秒转化时分秒毫秒
	 * 
	 * @Title: isInDate
	 * @author WangMin
	 */
	public static String formatMSTime(Long ms) {
		Integer ss = 1000;
		Integer mi = ss * 60;
		Integer hh = mi * 60;
		Integer dd = hh * 24;

		Long day = ms / dd;
		Long hour = (ms - day * dd) / hh;
		Long minute = (ms - day * dd - hour * hh) / mi;
		Long second = (ms - day * dd - hour * hh - minute * mi) / ss;
		Long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;

		StringBuffer sb = new StringBuffer();
		if (day > 0) {
			sb.append(day + "天");
		}
		if (hour > 0) {
			sb.append(hour + "小时");
		}
		if (minute > 0) {
			sb.append(minute + "分钟");
		}
		// if(second > 0) {
		// sb.append(second+"秒");
		// }
		// if(milliSecond > 0) {
		// sb.append(milliSecond+"毫秒");
		// }
		return sb.toString();
	}

	/**
	 * 得到几天前的时间
	 * 
	 * @param d
	 * @param day
	 * @return
	 */
	public static Date getDateBefore(Date d, int day) {
		Calendar now = Calendar.getInstance();
		now.setTime(d);
		now.set(Calendar.DATE, now.get(Calendar.DATE) - day);
		return now.getTime();
	}

	/**
	 * 得到几天后的时间
	 * 
	 * @param d
	 * @param day
	 * @return
	 */
	public static Date getDateAfter(Date d, int day) {
		Calendar now = Calendar.getInstance();
		now.setTime(d);
		now.set(Calendar.DATE, now.get(Calendar.DATE) + day);
		return now.getTime();
	}

	// 测试
	public static void main(String[] args) {
		// Date d = timestampToDate("1460649600000");
		// System.out.println("DateUtil.main()"+getDateTime(d));

		Date d = null;
		String s = "2015-06-13 20:00:00.3";
		d = timestampStrToDate(s);
		System.out.println("DateUtil.main()" + d);
		System.out.println("DateUtil.main()" + d.getTime());

		s = "2015-06-13 20:00:00.005";
		d = timestampStrToDate(s);
		System.out.println("DateUtil.main()" + d.getTime());

		System.out.println("DateUtil.main()" + formatMSTime(171735000L).toString());

	}

}
