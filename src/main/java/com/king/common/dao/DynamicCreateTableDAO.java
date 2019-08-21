/**
 * 
 */
package com.king.common.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Session;
import org.springframework.orm.hibernate4.SessionFactoryUtils;
import org.springframework.stereotype.Repository;

/**
 * 动态创建表
 * 
 * @author linjq 2016年6月6日
 */
@Repository
public class DynamicCreateTableDAO {

	@PersistenceContext()
	private EntityManager entityManager;

	public List<Map<String, Object>> findResultSet(String dropSqlStr, String createSqlStr, List<String> sqlStrList,
			String querySqlStr) {
		Session session = (Session) entityManager.getDelegate();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = (Connection) SessionFactoryUtils.getDataSource(session.getSessionFactory()).getConnection();
			Statement stmt = conn.createStatement();
			stmt.addBatch(dropSqlStr);// "DROP TABLE IF EXISTS temp_sn"
			stmt.addBatch(createSqlStr);
			for (int i = 0; i < sqlStrList.size(); i++) {
				stmt.addBatch(sqlStrList.get(i));
			}
			stmt.executeBatch();
			// conn.getAutoCommit(false);
			conn.commit();

			rs = stmt.executeQuery(querySqlStr);

			return resultSetToList(rs);
		} catch (Exception e) {
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

		}

		return null;
	}

	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> resultSetToList(ResultSet rs) throws java.sql.SQLException {
		if (rs == null)
			return Collections.EMPTY_LIST;
		ResultSetMetaData md = rs.getMetaData(); // 得到结果集(rs)的结构信息，比如字段数、字段名等
		int columnCount = md.getColumnCount(); // 返回此 ResultSet 对象中的列数
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> rowData = new HashMap<String, Object>();
		while (rs.next()) {
			rowData = new HashMap<String, Object>(columnCount);
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getObject(i));
			}
			list.add(rowData);
		}
		return list;
	}
}
