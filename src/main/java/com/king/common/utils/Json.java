package com.king.common.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.google.gson.Gson;

public class Json {
	private static ObjectMapper mapper = new ObjectMapper(); // can reuse, share
	private static final Log logger = LogFactory.getLog(Json.class);
	private static final Gson gson = new Gson();

	/**
	 * 将对象转成json.
	 * 
	 * @param obj
	 *            对象
	 * @return
	 */
	public static String toJson(Object obj) {
		if (obj == null) {
			return null;
		}
		
		try {
			return mapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}
	
	/**
	 * json转List.
	 * 
	 * @param content
	 *            json数据
	 * @param valueType
	 *            泛型数据类型
	 * @return
	 */
	public static <T> List<T> toListObject(String content, Class<T> valueType) {
		if (content == null || content.length() == 0) {
			return null;
		}
		try {
			return mapper.readValue(content, TypeFactory.defaultInstance().constructCollectionType(List.class, valueType));
		} catch (JsonParseException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	public static <T> List<T> toObject(List<String> jsonList, Class<T> valueType) {
		if (jsonList == null || jsonList.isEmpty()) {
			return null;
		}
		List<T> list = new ArrayList<T>();
		for (String json : jsonList) {
			list.add(Json.toObject(json, valueType));
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> toMap(String content) {
		return Json.toObject(content, Map.class);
	}

	@SuppressWarnings("unchecked")
	public static Set<Object> toSet(String content) {
		return Json.toObject(content, Set.class);
	}

	@SuppressWarnings("unchecked")
	public static <T> Map<String, T> toMap(String json, Class<T> clazz) {
		return Json.toObject(json, Map.class);
	}

	@SuppressWarnings("unchecked")
	public static <T> Set<T> toSet(String json, Class<T> clazz) {
		return Json.toObject(json, Set.class);
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> toNotNullMap(String json) {
		Map<String, Object> map = Json.toObject(json, Map.class);
		if (map == null) {
			map = new LinkedHashMap<String, Object>();
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	public static <T> Map<String, T> toNotNullMap(String json, Class<T> clazz) {
		Map<String, T> map = Json.toObject(json, Map.class);
		if (map == null) {
			map = new LinkedHashMap<String, T>();
		}
		return map;
	}

	@SuppressWarnings("unchecked")
	public static <T> Set<T> toNotNullSet(String json, Class<T> clazz) {
		Set<T> set = Json.toObject(json, Set.class);
		if (set == null) {
			set = new LinkedHashSet<T>();
		}
		return set;
	}

	/**
	 * 类型转换.
	 * 
	 * @param obj
	 * @param clazz
	 * @return
	 */
	public static <T> T convert(Object obj, Class<T> clazz) {
		String json = Json.toJson(obj);
		return toObject(json, clazz);
	}

	/**
	 * 将Json转换成对象.
	 * 
	 * @param json
	 * @param valueType
	 * @return
	 */
//	public static <T> T toObject(String json, Class<T> clazz) {
//		if (json == null || json.length() == 0) {
//			return null;
//		}
//		try {
//			return mapper.readValue(json, clazz);
//		} catch (JsonParseException e) {
//			logger.error(e.getMessage(), e);
//		} catch (JsonMappingException e) {
//			logger.error(e.getMessage(), e);
//		} catch (IOException e) {
//			logger.error(e.getMessage(), e);
//		}
//		return null;
//	}

	public static <T> T toObject(String json, Class<T> clazz) {
		if (json == null || json.length() == 0) {
			return null;
		}

		return gson.fromJson(json, clazz);
	}

	public static void print(Object obj) {
		String json = Json.toJson(obj);
		logger.info("json:" + json);
	}

	public static void print(Object obj, String name) {
		String json = Json.toJson(obj);
		logger.info("json info " + name + "::" + json);
	}
}
