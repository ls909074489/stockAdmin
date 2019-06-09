package com.king.common.dao;

import java.math.BigInteger;
import java.sql.Connection;
import java.sql.ParameterMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ColumnListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.commons.lang3.ArrayUtils;

import com.king.common.exception.DAOException;

public class DbUtilsDAO {
	private DataSource dataSource;
	private QueryRunner queryRunner;
	// private static Logger logger = LoggerFactory.getLogger(ParameterInitial.class);
	private boolean pmdKnownBroken = true;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public DataSource getDataSource() {
		return this.dataSource;
	}

	private ScalarHandler<Object> scalarHandler = new ScalarHandler<Object>() {
		@Override
		public Object handle(ResultSet rs) throws SQLException {
			Object obj = super.handle(rs);
			if (obj instanceof BigInteger)
				return ((BigInteger) obj).longValue();
			return obj;
		}
	};

	private List<Class<?>> PrimitiveClasses = new ArrayList<Class<?>>() {
		private static final long serialVersionUID = 1L;

		{
			add(Long.class);
			add(Integer.class);
			add(String.class);
			add(java.util.Date.class);
			add(java.sql.Date.class);
			add(java.sql.Timestamp.class);
		}
	};

	// 返回单一列时用到的handler
	private final static ColumnListHandler<Object> columnListHandler = new ColumnListHandler<Object>() {
		@Override
		protected Object handleRow(ResultSet rs) throws SQLException {
			Object obj = super.handleRow(rs);
			if (obj instanceof BigInteger)
				return ((BigInteger) obj).longValue();
			return obj;
		}

	};

	private String getDBName() {
		// return "Oracle";
		try {
			return dataSource.getConnection().getMetaData().getDatabaseProductName();
		} catch (SQLException e) {
			e.printStackTrace();
			// logger.error("获取数据库类型错误，返回默认值(mysql)", e);
			return "mysql";
		}
	}

	/**
	 * 批量修改记录
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            二维参数数组
	 * @return 受影响的行数的数组
	 * @throws DAOException
	 */
	public int[] batchUpdate(String sql, Object[][] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		int[] affectedRows = new int[0];
		try {
			affectedRows = queryRunner.batch(sql, params);
		} catch (SQLException e) {
			throw new DAOException("DAO批量修改记录错误：" + e.getMessage(), e);
		}
		return affectedRows;
	}

	public long count(String sql, Object... params) throws DAOException {
		Number num = 0;
		try {
			queryRunner = new QueryRunner(dataSource);
			if (params == null) {
				num = (Number) queryRunner.query(sql, scalarHandler);
			} else {
				num = (Number) queryRunner.query(sql, scalarHandler, params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO统计数量错误：" + e.getMessage(), e);
		}
		return (num != null) ? num.longValue() : -1;
	}

	/**
	 * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @return 查询结果
	 * @throws DAOException
	 */
	public <T> List<T> find(Class<T> entityClass, String sql) throws DAOException {
		return find(entityClass, sql, null);
	}

	/**
	 * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @param param
	 *            参数
	 * @return 查询结果
	 * @throws DAOException
	 */
	public <T> List<T> find(Class<T> entityClass, String sql, Object param) throws DAOException {
		return find(entityClass, sql, new Object[] { param });
	}

	/**
	 * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 查询结果
	 * @throws DAOException
	 */
	public <T> List<T> find(Class<T> entityClass, String sql, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		List<T> list = new ArrayList<T>();
		try {
			if (params == null) {
				list = (List<T>) queryRunner.query(sql, new BeanListHandler<T>(entityClass));
			} else {
				list = (List<T>) queryRunner.query(sql, new BeanListHandler<T>(entityClass), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);

		}
		return list;
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中
	 * 
	 * @param sql
	 *            sql语句
	 * @return 查询结果
	 * @throws DAOException
	 */
	public List<Map<String, Object>> find(String sql) throws DAOException {
		return find(sql, null);
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中
	 * 
	 * 各列按照select语句中的顺序进行组装
	 * 
	 * @author wzw 2014年12月18日
	 * @param sql
	 * @return
	 * @throws DAOException
	 */
	public List<Map<String, Object>> findWithColumnOrder(String sql) throws DAOException {
		return findWithColumnOrder(sql, null);
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中
	 * 
	 * @param sql
	 *            sql语句
	 * @param param
	 *            参数
	 * @return 查询结果
	 * @throws DAOException
	 */
	public List<Map<String, Object>> find(String sql, Object param) throws DAOException {
		return find(sql, new Object[] { param });
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 查询结果
	 * @throws DAOException
	 */
	public List<Map<String, Object>> find(String sql, Object[] params) throws DAOException {
		// logger.debug(sql);
		queryRunner = new QueryRunner(dataSource);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			if (params == null) {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler());
			} else {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler(), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return list;
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中,各列按照select语句中的顺序进行组装，然后将所有Map对象保存到List中
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 查询结果
	 * @throws DAOException
	 */
	public List<Map<String, Object>> findWithColumnOrder(String sql, Object[] params) throws DAOException {
		// logger.debug(sql);
		queryRunner = new QueryRunner(dataSource);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			if (params == null) {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new LinkMapListHandler());
			} else {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new LinkMapListHandler(), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return list;
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnIndex
	 *            列索引
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, int columnIndex) throws DAOException {
		return findBy(sql, columnIndex, null);
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnIndex
	 *            列索引
	 * @param param
	 *            参数
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, int columnIndex, Object param) throws DAOException {
		return findBy(sql, columnIndex, new Object[] { param });
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnIndex
	 *            列索引
	 * @param params
	 *            参数数组
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, int columnIndex, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		Object object = null;
		try {
			if (params == null) {
				object = queryRunner.query(sql, new ScalarHandler<Object>(columnIndex));
			} else {
				object = queryRunner.query(sql, new ScalarHandler<Object>(columnIndex), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return object;
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnName
	 *            列名
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, String params) throws DAOException {
		return findBy(sql, params, null);
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnName
	 *            列名
	 * @param param
	 *            参数
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, String columnName, Object param) throws DAOException {
		return findBy(sql, columnName, new Object[] { param });
	}

	/**
	 * 查询某一条记录，并将指定列的数据转换为Object
	 * 
	 * @param sql
	 *            sql语句
	 * @param columnName
	 *            列名
	 * @param params
	 *            参数数组
	 * @return 结果对象
	 * @throws DAOException
	 */
	public Object findBy(String sql, String columnName, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		Object object = null;
		try {
			if (params == null) {
				object = queryRunner.query(sql, new ScalarHandler<Object>(columnName));
			} else {
				object = queryRunner.query(sql, new ScalarHandler<Object>(columnName), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return object;
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成对象
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @return 对象
	 * @throws DAOException
	 */
	public <T> T findFirst(Class<T> entityClass, String sql) throws DAOException {
		return findFirst(entityClass, sql, null);
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成对象
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @param param
	 *            参数
	 * @return 对象
	 * @throws DAOException
	 */
	public <T> T findFirst(Class<T> entityClass, String sql, Object param) throws DAOException {
		return findFirst(entityClass, sql, new Object[] { param });
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成对象
	 * 
	 * @param entityClass
	 *            类名
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 对象
	 * @throws DAOException
	 */
	@SuppressWarnings("unchecked")
	public <T> T findFirst(Class<T> entityClass, String sql, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		Object object = null;
		try {
			if (params == null) {
				object = queryRunner.query(sql, new BeanHandler<T>(entityClass));
			} else {
				object = queryRunner.query(sql, new BeanHandler<T>(entityClass), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return (T) object;
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成Map对象
	 * 
	 * @param sql
	 *            sql语句
	 * @return 封装为Map的对象
	 * @throws DAOException
	 */
	public Map<String, Object> findFirst(String sql) throws DAOException {
		return findFirst(sql, null);
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成Map对象
	 * 
	 * @param sql
	 *            sql语句
	 * @param param
	 *            参数
	 * @return 封装为Map的对象
	 * @throws DAOException
	 */
	public Map<String, Object> findFirst(String sql, Object param) throws DAOException {
		return findFirst(sql, new Object[] { param });
	}

	/**
	 * 查询出结果集中的第一条记录，并封装成Map对象
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 封装为Map的对象
	 * @throws DAOException
	 */
	public Map<String, Object> findFirst(String sql, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource);
		Map<String, Object> map = null;
		try {
			if (params == null) {
				map = (Map<String, Object>) queryRunner.query(sql, new MapHandler());
			} else {
				map = (Map<String, Object>) queryRunner.query(sql, new MapHandler(), params);
			}
		} catch (SQLException e) {
			// e.printStackTrace();
			// LOG.error("findFirst.查询一条记录错误" + sql, e);
			throw new DAOException("DAO查询错误：" + e.getMessage(), e);
		}
		return map;
	}

	/**
	 * 
	 * @param <T>分页查询
	 * @param beanClass
	 * @param sql
	 * @param page
	 * @param count
	 * @param params
	 * @return
	 * @throws DAOException
	 */
	public <T> List<T> findPage(Class<T> beanClass, String sql, int page, int pageSize, Object... params)
			throws DAOException {
		if (page <= 1) {
			page = 0;
		}
		return query(beanClass, sql + " LIMIT ?,?", ArrayUtils.addAll(params, new Integer[] { page, pageSize }));
	}

	/**
	 * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 查询结果
	 * @throws DAOException
	 */
	public List<Map<String, Object>> findPage(String sql, int pageindex, int pagesize, Object... params)
			throws DAOException {
		String dbname = getDBName();
		Object[] pageparams = null;
		if ("mysql".equalsIgnoreCase(dbname)) {
			sql = sql + " LIMIT ?,?";
			pageparams = new Object[] { pageindex, pagesize };
		} else if ("oracle".equalsIgnoreCase(dbname)) {
			sql = "select * from ( select row_.*, rownum rownum_ from ( " + sql
					+ " ) row_ where rownum <= ?) where rownum_ > ?";
			pageparams = new Object[] { pageindex * pagesize, (pageindex - 1) * pagesize };
		}
		// else if("sqlserver".equalsIgnoreCase(dbname)){
		// sql = "select * from ( " + sql + " )";
		// pageparams = new Object[]{pageindex * pagesize, (pageindex - 1) * pagesize};
		// }
		else {
			throw new DAOException("DAO数据分页查询错误：目前只支持Oracle、Mysql数据库");
		}

		queryRunner = new QueryRunner(dataSource);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			if (params == null) {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler(), pageparams);
			} else {
				list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler(),
						ArrayUtils.addAll(params, pageparams));
			}
		} catch (SQLException e) {
			throw new DAOException("DAO数据分页查询错误：" + e.getMessage());
		}
		return list;
	}

	/**
	 * 
	 * @param sql
	 *            插入sql语句
	 * @param params
	 *            插入参数
	 * @return 返回影响行数
	 * @throws DAOException
	 */
	public int insert(String sql, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource, pmdKnownBroken);
		int affectedRows = 0;
		try {
			if (params == null) {
				affectedRows = queryRunner.update(sql);
			} else {
				affectedRows = queryRunner.update(sql, params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO插入记录错误：" + e.getMessage(), e);
		}
		return affectedRows;
	}

	/**
	 * 插入数据库，返回自动增长的主键
	 * 
	 * @param sql
	 *            执行的sql语句
	 * @return 主键 注意；此方法没关闭资源
	 * @throws DAOException
	 */
	public int insertForKeys(String sql, Object[] params) throws DAOException {
		int key = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ParameterMetaData pmd = stmt.getParameterMetaData();
			if (params.length < pmd.getParameterCount()) {
				throw new SQLException("参数错误:" + pmd.getParameterCount());
			}
			for (int i = 0; i < params.length; i++) {
				stmt.setObject(i + 1, params[i]);
			}
			stmt.executeUpdate();
			rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				key = rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO插入返回主键错误：" + e.getMessage(), e);
		} finally {
			if (rs != null) { // 关闭记录集
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) { // 关闭声明
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (conn != null) { // 关闭连接对象
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return key;
	}

	// 判断是否为原始类型
	private boolean isPrimitive(Class<?> cls) {
		return cls.isPrimitive() || PrimitiveClasses.contains(cls);
	}

	// map
	@SuppressWarnings("unchecked")
	public <T> List<T> query(Class<T> beanClass, String sql, Object... params) throws DAOException {
		try {
			queryRunner = new QueryRunner(dataSource);
			if(isPrimitive(beanClass)){
				return (List<T>) queryRunner.query(sql,columnListHandler, params);
			}else{
				return (List<T>) queryRunner.query(sql,new BeanListHandler<T>(beanClass), params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO错误：" + e.getMessage() + "\nSQL:" + e.getMessage(), e);
		}
	}

	/**
	 * 执行sql语句
	 * 
	 * @param sql
	 *            sql语句
	 * @return 受影响的行数
	 * @throws DAOException
	 */
	public int update(String sql) throws DAOException {
		return update(sql, null);
	}

	/**
	 * 单条修改记录
	 * 
	 * @param sql
	 *            sql语句
	 * @param param
	 *            参数
	 * @return 受影响的行数
	 * @throws DAOException
	 */
	public int update(String sql, Object param) throws DAOException {
		return update(sql, new Object[] { param });
	}

	/**
	 * 单条修改记录
	 * 
	 * @param sql
	 *            sql语句
	 * @param params
	 *            参数数组
	 * @return 受影响的行数
	 * @throws DAOException
	 */
	public int update(String sql, Object[] params) throws DAOException {
		queryRunner = new QueryRunner(dataSource, pmdKnownBroken);
		int affectedRows = 0;
		try {
			if (params == null) {
				affectedRows = queryRunner.update(sql);
			} else {
				affectedRows = queryRunner.update(sql, params);
			}
		} catch (SQLException e) {
			throw new DAOException("DAO修改记录错误：" + e.getMessage(), e);
		}
		return affectedRows;
	}

	public boolean isPmdKnownBroken() {
		return pmdKnownBroken;
	}

	public void setPmdKnownBroken(boolean pmdKnownBroken) {
		this.pmdKnownBroken = pmdKnownBroken;
	}
}