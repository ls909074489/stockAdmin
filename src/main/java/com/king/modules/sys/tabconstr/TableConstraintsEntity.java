package com.king.modules.sys.tabconstr;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "表的外键信息")
@Entity
@Table(name = "yy_table_constraint")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class TableConstraintsEntity extends BaseEntity{

	
	private static final long serialVersionUID = 2145004437788663177L;
	
	
	
	 @MetaData(value = "数据库名")
	 @Column(name="constraint_schema",length=50)
     private String constraintSchema;  
	
	 @MetaData(value = "表名")
	 @Column(name="table_name",length=50)
     private String tableName;  
	 @MetaData(value = "表名描述")
	 @Column(name="table_name_des",length=50)
     private String tableNameDes;  
	 @MetaData(value = "外键名")
	 @Column(name="constraint_name",length=50)
     private String constraintName;
	 @MetaData(value = "外键栏位")
	 @Column(name="column_name",length=50)
     private String columnName;
	 @MetaData(value = "外键栏位描述")
	 @Column(name="column_name_des",length=50)
     private String columnNameDes;
	 
	 
	 @MetaData(value = "参考表")
	 @Column(name="referenced_table_name",length=50)
     private String referencedTableName;
	 @MetaData(value = "参考表描述")
	 @Column(name="referenced_table_des",length=50)
     private String referencedTableDes;
	 
	 @MetaData(value = "参考字段")
	 @Column(name="referenced_column_name",length=50)
	 private String referencedColumnName;	 
	 @MetaData(value = "参考字段描述")
	 @Column(name="referenced_column_des",length=50)
	 private String referencedColumnDes;
	 
	 
	public String getConstraintSchema() {
		return constraintSchema;
	}
	public void setConstraintSchema(String constraintSchema) {
		this.constraintSchema = constraintSchema;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableNameDes() {
		return tableNameDes;
	}
	public void setTableNameDes(String tableNameDes) {
		this.tableNameDes = tableNameDes;
	}
	public String getConstraintName() {
		return constraintName;
	}
	public void setConstraintName(String constraintName) {
		this.constraintName = constraintName;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getColumnNameDes() {
		return columnNameDes;
	}
	public void setColumnNameDes(String columnNameDes) {
		this.columnNameDes = columnNameDes;
	}
	public String getReferencedTableName() {
		return referencedTableName;
	}
	public void setReferencedTableName(String referencedTableName) {
		this.referencedTableName = referencedTableName;
	}
	public String getReferencedColumnName() {
		return referencedColumnName;
	}
	public void setReferencedColumnName(String referencedColumnName) {
		this.referencedColumnName = referencedColumnName;
	}
	public String getReferencedColumnDes() {
		return referencedColumnDes;
	}
	public void setReferencedColumnDes(String referencedColumnDes) {
		this.referencedColumnDes = referencedColumnDes;
	}
	public String getReferencedTableDes() {
		return referencedTableDes;
	}
	public void setReferencedTableDes(String referencedTableDes) {
		this.referencedTableDes = referencedTableDes;
	}
	 
}
