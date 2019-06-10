package ${packageName};

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import com.yy.common.annotation.MetaData;
import com.yy.frame.entity.${extendsEntity};

@MetaData(value = "${commonEntityName}信息")
@Entity
@Table(name = "${tableName}")
public class ${entityName} extends ${extendsEntity} {

	private static final long serialVersionUID = 1L;

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
}
