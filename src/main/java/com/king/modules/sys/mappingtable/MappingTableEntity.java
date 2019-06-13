package com.king.modules.sys.mappingtable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "映射表")
@Entity
@Table(name = "yy_mapping_table")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class MappingTableEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	public static String GENTYPE_WEBPAGE="1";//普通列表（前端分页）
	public static String GENTYPE_SERVERPAGE="2";//普通列表（服务器分页）
	public static String GENTYPE_TREEMAINPAGE="3";// 树状结构
	public static String GENTYPE_TREELISTPAGE="4";// 左树右列表
	public static String GENTYPE_MAINSON_SERVERPAGE="5";// 主子表（服务器分页）
	public static String GENTYPE_MAINSON_WEBPAGE="6";// 主子表（前端分页）
	
	
	public static String GENTYPE_REFLISTSELECT="11";// 列表单选
	public static String GENTYPE_REFTREESELECT="12";// 树单选
	
	
	@MetaData(value = "模板名称")
	@Column(name="template_name",length =250)
	private String templateName;

	@MetaData(value = "模板类型")
	@Column(name="template_type",length =250)
	private String templateType;

	@MetaData(value = "java文件路径")
	@Column(name="java_workspace",length =250)
	private String javaWorkspace;

	@MetaData(value = "包路径")
	@Column(name="package_name",length =250)
	private String packageName;

	@MetaData(value = "页面保存位置")
	@Column(name="jsp_workspace",length =250)
	private String jspWorkspace;

	@MetaData(value = "访问根地址")
	@Column(name="controller_path",length =250)
	private String controllerPath;

	@MetaData(value = "页面路径")
	@Column(name="jsp_path",length =250)
	private String jspPath;

	@MetaData(value = "表名注释")
	@Column(name="entity_chinese",length =250)
	private String entityChinese;

	@MetaData(value = "数据库表名")
	@Column(name="table_name",length =250)
	private String tableName;

	@MetaData(value = "实体名称")
	@Column(name="entity_name",length =250)
	private String entityName;

	@MetaData(value = "实体父类")
	@Column(name="extends_entity",length =250)
	private String extendsEntity;

	private boolean isMain=true;//是否主表
	private String author;//作者
		
	public String getTemplateType() {
		return templateType;
	}

	public void setTemplateType(String templateType) {
		this.templateType = templateType;
	}
	
	public String getJavaWorkspace() {
		return javaWorkspace;
	}

	public void setJavaWorkspace(String javaWorkspace) {
		this.javaWorkspace = javaWorkspace;
	}
	
	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	
	public String getJspWorkspace() {
		return jspWorkspace;
	}

	public void setJspWorkspace(String jspWorkspace) {
		this.jspWorkspace = jspWorkspace;
	}
	
	public String getControllerPath() {
		return controllerPath;
	}

	public void setControllerPath(String controllerPath) {
		this.controllerPath = controllerPath;
	}
	
	public String getJspPath() {
		return jspPath;
	}

	public void setJspPath(String jspPath) {
		this.jspPath = jspPath;
	}
	
	public String getEntityChinese() {
		return entityChinese;
	}

	public void setEntityChinese(String entityChinese) {
		this.entityChinese = entityChinese;
	}
	
	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}
	
	public String getExtendsEntity() {
		return extendsEntity;
	}

	public void setExtendsEntity(String extendsEntity) {
		this.extendsEntity = extendsEntity;
	}
	
	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public boolean isMain() {
		return isMain;
	}

	public void setMain(boolean isMain) {
		this.isMain = isMain;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	

}
