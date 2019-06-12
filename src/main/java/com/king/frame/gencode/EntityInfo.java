package com.king.frame.gencode;

/**
 * 实体信息
 * @ClassName: EntityInfo
 * @author liusheng
 * @date 2017年6月28日 下午2:59:14
 */
public class EntityInfo {

	public static String GENTYPE_WEBPAGE="1";//普通列表（前端分页）
	public static String GENTYPE_SERVERPAGE="2";//普通列表（服务器分页）
	public static String GENTYPE_TREEMAINPAGE="3";// 树状结构
	public static String GENTYPE_TREELISTPAGE="4";// 左树右列表
	public static String GENTYPE_MAINSON_SERVERPAGE="5";// 主子表（服务器分页）
	public static String GENTYPE_MAINSON_WEBPAGE="6";// 主子表（前端分页）
	
	
	public static String GENTYPE_REFLISTSELECT="11";// 列表单选
	public static String GENTYPE_REFTREESELECT="12";// 树单选
	
	
	private String entityName;//实体名
	
	private String tableName;//表名
	
	private String packagePath;//包路径
	
	private String extendEntityName;//继承
	
	private String reqMappingPath;
	
	private String title;//类注释
	
	private String author;//作者
	
	private String jspPath;//jsp页面的路径
	
	private String genType="2";//生成类型  1 普通列表（前端分页） 2 普通列表（服务器分页） 3 树状结构
	
	private boolean isMain=true;//是否主表
	
	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getPackagePath() {
		return packagePath;
	}

	public void setPackagePath(String packagePath) {
		this.packagePath = packagePath;
	}

	public String getExtendEntityName() {
		return extendEntityName;
	}

	public void setExtendEntityName(String extendEntityName) {
		this.extendEntityName = extendEntityName;
	}
	
	public String getReqMappingPath() {
		return reqMappingPath;
	}

	public void setReqMappingPath(String reqMappingPath) {
		this.reqMappingPath = reqMappingPath;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getJspPath() {
		return jspPath;
	}

	public void setJspPath(String jspPath) {
		this.jspPath = jspPath;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getGenType() {
		return genType;
	}

	public void setGenType(String genType) {
		this.genType = genType;
	}

	public boolean isMain() {
		return isMain;
	}

	public void setMain(boolean isMain) {
		this.isMain = isMain;
	}

}
