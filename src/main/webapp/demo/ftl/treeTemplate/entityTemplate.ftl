package ${packageName};

import com.fasterxml.jackson.annotation.JsonFormat;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.yy.common.annotation.MetaData;
import com.yy.frame.entity.TreeEntity;

/**
 * ${entityChinese}
 * @ClassName: ${commonEntityName}Entity 
 * @author 
 * @date ${createDate}
 */
@MetaData(value = "${commonEntityName}信息")
@Entity
@Table(name = "${tableName}")
public class ${entityName} extends TreeEntity {

	private static final long serialVersionUID = 1L;

	@ManyToOne(cascade = { CascadeType.REFRESH }, fetch = FetchType.LAZY)
	@JoinColumn(name = "parentid")
	@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
	private ${commonEntityName}Entity parent;

	<#list fieldList as var>
	@MetaData(value = "${var[1]}")
	<#if (var[2]=='Lob')>
	@Lob
	private String ${var[0]};
	<#else> 
	@Column(name="${var[5]}"<#if (var[2]=='String')>,length =${var[7]}</#if>)
	private ${var[2]} ${var[0]};
	</#if>

	</#list>
		

	public ${commonEntityName}Entity getParent() {
		return parent;
	}

	public void setParent(${commonEntityName}Entity parent) {
		this.parent = parent;
	}

	<#list fieldList as var>
	<#if (var[2]=='Date')>
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	</#if>
	<#if (var[2]=='Lob')>
	public String get${var[3]}() {
		return ${var[0]};
	}

	public void set${var[3]}(String ${var[0]}) {
		this.${var[0]} = ${var[0]};
	}
	<#else> 
	public ${var[2]} get${var[3]}() {
		return ${var[0]};
	}

	public void set${var[3]}(${var[2]} ${var[0]}) {
		this.${var[0]} = ${var[0]};
	}
	</#if>
	
	</#list>


	@Override
	public String getParentId() {
		if(parent!=null&&parent.getUuid()!=null){
			return this.parent.getUuid();
		}else{
			return "";
		}
	}

	@Override
	public String getCode() {
		return this.getUuid();
	}

	@Override
	public String getName() {
		return this.getXXXXname();//返回一个树要显示的值
	}

}
