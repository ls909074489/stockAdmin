package com.king.frame.specifications;

import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;

public class SearchFilter {
	/**
	 * BW 以什么开始 begin with, EW 以什么结尾 end with
	 * 
	 * @author wzw 2014年10月27日
	 *
	 */
	public enum Operator {
		EQ("equal"), LIKE("like"), GT("greater-than"), LT("less-than"), GTE("greater-than-or-equal-to"), LTE(
				"less-than-or-equal-to"), NULL("is-null"), NOTNULL("is-not-null"), BW("begin-with"), EW("end-with"), NE(
						"not-equal"), IN("in"), NOTIN("not-in"), OR("or"), CONTAIN("contain");

		private final String desc;

		private Operator(String desc) {
			this.desc = desc;
		}
	}

	public String fieldName;
	public Object value;
	public Operator operator;

	public SearchFilter(String fieldName, Operator operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.operator = operator;
	}

	/**
	 * searchParams中key的格式为OPERATOR_FIELDNAME
	 */
	public static Map<String, SearchFilter> parse(Map<String, Object> searchParams) {
		Map<String, SearchFilter> filters = Maps.newHashMap();

		for (Entry<String, Object> entry : searchParams.entrySet()) {
			// 过滤掉空值
			String key = entry.getKey();
			Object value = entry.getValue();

			// 拆分operator与filedAttribute
			String[] names = StringUtils.split(key, "_");

			// if (names.length != 2) {
			// throw new IllegalArgumentException(key + " is not a valid search filter name");
			// }
			// String filedName = names[1];

			// edit by ls2008
			if (names.length < 2) {
				throw new IllegalArgumentException(key + " is not a valid search filter name");
			}
			String filedName = key.substring(key.indexOf("_") + 1, key.length());// 避免查询条件的字段 有下划线 ，如
																					// search_LIKE_job_number

			Operator operator = Operator.valueOf(names[0]);

			if (operator != Operator.NULL && operator != Operator.NOTNULL) {
				if (StringUtils.isBlank((String) value)) {
					continue;
				}
			}

			SearchFilter filter = new SearchFilter(filedName, operator, value);
			filters.put(key, filter);
		}

		return filters;
	}
}
