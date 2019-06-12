table 样式
yy_table.css
table.dataTable tbody tr
#FFF5EE  改为 #fbfcfd

.table-hover>tbody>tr:hover, .table>tbody>tr.active>td, .table>tbody>tr.active>th,
	.table>tbody>tr>td.active, .table>tbody>tr>th.active, .table>tfoot>tr.active>td,
	.table>tfoot>tr.active>th, .table>tfoot>tr>td.active, .table>tfoot>tr>th.active,
	.table>thead>tr.active>td, .table>thead>tr.active>th, .table>thead>tr>td.active,
	.table>thead>tr>th.active
	
#BFBFBF 改为 #fafafa


layer.js
弹出框背景 #000 改为  #00000030

##############################配置附件的虚拟路径#########################################################################

<Context reloadable="true" docBase="D:/lsinstall/apache-tomcat-8.0.33-jlbc/webapps/wtpwebapps/zsdxuploadfiles/qrcode/temp" 
path="/stockAdmin/jlbcuploadfiles/qrcode/temp"/>


#######################################################################################################
		render : function(data, type, full) {
		       return YYDataUtils.getEnumName("sys_sex", data);
		}
		
		
#######################################################################################################		
		render : function(data, type, full) {
			return creSelectStr('eleTypeEnum','grade',data,false)+'<input type="hidden" name="uuid" value="'+full.uuid+'">';
		}
		
			//创建下拉框(新)
	function creSelectStr(fype, fieldname,value,disabled){
		var selectStr = '';
		if(disabled){
			selectStr = selectStr + '<fieldset disabled>';
		}
		selectStr = selectStr +'<select class="yy-input-enumdata form-control" id="'+fieldname+'" reallyname="'+fieldname+
					'" name="'+fieldname+'" data-enum-group="'+fype+'">';
		var enumMap = YYDataUtils.getEnumMap();
		var enumdatas = enumMap[fype];
		if(enumdatas){
			selectStr = selectStr + '<option value="">&nbsp;</option>';
			for (i = 0; i < enumdatas.length; i++) {
				if(enumdatas[i].enumdatakey == value){ 
					selectStr = selectStr + "<option selected='selected' value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
				} else {
					selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
				}
			}
		}
		selectStr = selectStr +'</select>';
		if(disabled){
			selectStr = selectStr + '</fieldset>';
		}
		return selectStr;
	}
#######################################################################################################s