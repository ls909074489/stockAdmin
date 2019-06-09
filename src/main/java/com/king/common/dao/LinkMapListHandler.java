package com.king.common.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.dbutils.handlers.MapListHandler;

/**
 * 数据库查询返回的数据列名顺序不对，查询语句为select id,name from info_user， 按道理返回的列顺序应该是id,name,但是由于HashMap的无序性，造成返回的数据是name,id，
 * 对此，重写了MapListHandler的handleRow方法
 *
 */
public class LinkMapListHandler extends MapListHandler {

	@Override
	protected Map<String, Object> handleRow(ResultSet rs) throws SQLException {
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		ResultSetMetaData rsmd = rs.getMetaData();
		int cols = rsmd.getColumnCount();
		for (int i = 1; i <= cols; i++) {
			result.put(rsmd.getColumnName(i), rs.getObject(i));
		}
		return result;
	}
}