package com.king.frame.specifications;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import com.king.frame.controller.QueryRequest;
import com.king.frame.specifications.DynamicSpecifications;
import com.king.frame.specifications.SearchFilter.Operator;

public class SearchFilterServer {

	/**
	 * 参考 SearchFilter 的枚举类型
	 */
	private static final String PREFIX = "_";
	public static final String ORDERBY_DESC = "@desc";
	public static final String ORDERBY_ASC = "@asc";

	
	/**
	 * 获取分页对象
	 * @return
	 */
	private static Sort getSortRequest(String sortstr) {
		List<Sort.Order> orders = new ArrayList<Sort.Order>();
		if (StringUtils.isEmpty(sortstr))
			return null;

		String[] sortfields = sortstr.split(";");
		for (String field : sortfields) {
			String[] fs = field.split("@");
			String property = fs[0];
			Sort.Direction dir = Sort.Direction.ASC;
			if (fs.length > 1) {
				String dirstr = fs[1];
				if (dirstr.toLowerCase().startsWith("d")) {
					dir = Sort.Direction.DESC;
				}
			}
			Sort.Order order = new Sort.Order(dir, property);
			orders.add(order);
		}
		Sort sort = new Sort(orders);
		return sort;
	}
	
	/**
	 * 封装查询对象
	 * @param searchMap 搜索map, 键值对：值由"SEARCH_EQ+字段" 组成
	 * @param sortStr 由 "字段+ORDERBY_DESC" 组成
	 * @param pageSize 需要查询的数量, 如果pageSize为null时，表示查询全部
	 * @param startIdx 从第几条开始
	 * @return QueryRequest
	 */
	public static  <T> QueryRequest<T> getQueryRequest(Map<String, Object> searchMap, String sortStr, final Class<T> clazz, Integer pageSize, Integer startIdx) {
		QueryRequest<T> qr = new QueryRequest<T>();

		// 排序
		Sort sort = getSortRequest(sortStr);
		
		// 分页信息（针对jquery datatable）
		if (pageSize!=null && pageSize>0) {
			int pageIndex = startIdx / pageSize;
			PageRequest pr = new PageRequest(pageIndex, pageSize, sort);
			qr.setPageRequest(pr);
		}
		
		//动态封装查询条件
		qr.setSpecification(DynamicSpecifications.buildSpecification(searchMap, clazz));
		qr.setSort(sort);

		return qr;
	}
	
	/**
	 * 构建equals条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildEquals(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.EQ + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建not equals条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildNotEquals(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.NE + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建likes条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildLike(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.LIKE + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建大于条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildGT(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.GT + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建小于条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildLT(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.LT + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建大于等于条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildGTE(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.GTE + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建小于等于条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildLTE(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.LTE + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建null条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildNull(Map<String,Object> inMap, String field) {
		inMap.put(Operator.NULL + PREFIX+field, null);
		return inMap;
	}
	/**
	 * 构建not null条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildNotNull(Map<String,Object> inMap, String field) {
		inMap.put(Operator.NOTNULL + PREFIX+field, null);
		return inMap;
	}
	/**
	 * 构建以什么开始条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildBW(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.BW + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建以什么结束条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值
	 * @return map
	 */
	public static Map<String,Object> buildEW(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.EW + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建in条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值, 用逗号隔开
	 * @return map
	 */
	public static Map<String,Object> buildIn(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.IN + PREFIX+field, value);
		return inMap;
	}
	/**
	 * 构建not in条件
	 * @param inMap 初始化map
	 * @param field 查询的字段
	 * @param value 查询的值, 用逗号隔开
	 * @return map
	 */
	public static Map<String,Object> buildNotIn(Map<String,Object> inMap, String field, Object value) {
		if(null==value || value.toString().trim().length()==0) {
			return inMap;
		}
		inMap.put(Operator.NOTIN + PREFIX+field, value);
		return inMap;
	}
	

}
