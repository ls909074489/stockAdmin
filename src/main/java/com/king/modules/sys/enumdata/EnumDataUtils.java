package com.king.modules.sys.enumdata;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.king.common.utils.DateUtil;


public class EnumDataUtils {

	// 系统启动后自动缓存加载枚举到该map
	public static Map<String, List<EnumDataSubEntity>> mapEnum;

	static {
		mapEnum = new HashMap<String, List<EnumDataSubEntity>>();
	}

	/**
	 * 从枚举缓存map中获取枚举对象
	 * 
	 * @param enumGroupCode
	 *            分组编码
	 * @return
	 */
	public static List<EnumDataSubEntity> getEnumSubList(String enumGroupCode) {
		if (mapEnum != null && mapEnum.containsKey(enumGroupCode))
			return mapEnum.get(enumGroupCode);
		else
			return null;
	}

	/**
	 * 从枚举缓存map中获取枚举值
	 * 
	 * @param key
	 *            键值
	 * @param enumGroupCode
	 *            分组编码
	 * @return
	 */
	public static String getEnumValue(String key, String enumGroupCode) {
		List<EnumDataSubEntity> subList = getEnumSubList(enumGroupCode);
		if (subList != null && subList.size() > 0) {
			for (EnumDataSubEntity sub : subList) {
				if (key.equals(sub.getEnumdatakey())) {
					return sub.getEnumdataname();
				}
			}
		}
		return null;
	}

	/**
	 * 从枚举缓存map中获取枚举 编码key
	 * 
	 * @param value
	 *            值
	 * @param enumGroupCode
	 *            分组编码
	 * @return
	 */
	public static String getEnumKey(String value, String enumGroupCode) {
		List<EnumDataSubEntity> subList = getEnumSubList(enumGroupCode);
		if (subList != null && subList.size() > 0) {
			for (EnumDataSubEntity sub : subList) {
				if (value.equals(sub.getEnumdataname())) {
					return sub.getEnumdatakey();
				}
			}
		}
		return null;
	}

	/**
	 * 删除枚举缓存
	 * 
	 * @param pe
	 */
	public static void removeEnum(EnumDataEntity ed) {
		mapEnum.remove(ed.getGroupcode());
	}

	public static void removeEnum(String enumGroupCode) {
		mapEnum.remove(enumGroupCode);
	}

	public static void updateEnumDatas(Map<String, List<EnumDataSubEntity>> enumMap) {
		for (String enumGroupCode : enumMap.keySet()) {
			updateEnumData(enumGroupCode, enumMap.get(enumGroupCode));
		}
	}

	public static void updateEnumData(String enumGroupCode, List<EnumDataSubEntity> subList) {
		mapEnum.put(enumGroupCode, subList);
	}

	/**
	 * 动态添加年份枚举
	 * 
	 * @author wzw 2014年11月27日
	 * @param map
	 */
	public static void setYearEnumToMap(Map map) {
		List<Integer> yearList = DateUtil.getYearEnum(10, 5);
		List<EnumDataSubEntity> subList = new ArrayList<EnumDataSubEntity>();
		for (int i = 0; i < yearList.size(); i++) {
			int year = yearList.get(i);
			EnumDataSubEntity sub = new EnumDataSubEntity();
			sub.setEnumdatakey(String.valueOf(year));
			sub.setEnumdataname(String.valueOf(year));
			sub.setShoworder(Short.parseShort(i + ""));
			subList.add(sub);
		}
		map.put("YEAR", subList);
	}
	
	/**
	 * 获得枚举实体
	 * @author v-chenchengjin
	 * 2017-5-20 16:47:01
	 * @param key 枚举组某个key
	 * @param enumGroupCode 枚举组编码
	 * @return EnumDataSubEntity枚举实体
	 */
	public static EnumDataSubEntity getEnumEntity(String key, String enumGroupCode) {
		List<EnumDataSubEntity> subList = getEnumSubList(enumGroupCode);
		if (subList != null && subList.size() > 0) {
			for (EnumDataSubEntity sub : subList) {
				if (key.equals(sub.getEnumdatakey())) {
					return sub;
				}
			}
		}
		return null;
	}
}
