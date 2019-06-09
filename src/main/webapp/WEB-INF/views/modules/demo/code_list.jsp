<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.commons.codec.binary.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<title>代码生成</title>
<script type="text/javascript">
	function addRow(){
		var html='<tr>'+
						'<td><input type="text" name="colName" class="inputChange" style="width: 49%;"/>&nbsp;<input type="text" name="colNameDb" style="width: 49%;"/></td>'+
						'<td><input type="text" name="colDesc" style="width: 98%;"/></td>'+
						'<td><select name="isShow" style="width: 98%;"><option value="1">是</option><option value="0">否</option></select></td>'+
						'<td><select name="eleType" style="width: 98%;"><option value="text">普通文本文本框</option><option value="select">下拉选择</option>'+
						'<option value="date">日期选择</option><option value="textarea">多行文本输入框</option></select></td>'+
						'<td><select name="colType" style="width: 49%;"><option value="String">String</option><option value="Long">Long</option>'+
						'<option value="Integer">Integer</option><option value="Date">Date</option>'+
						'<option value="Lob">Lob</option></select><input type="text" name="colLength" value="250" style="width: 49%;"/>'+
						'</td>'+
						'<td>'+
							'<input type="button" value="删除" onclick="delRow(this);"/>'+
						'</td>'+
					'</tr>';
		$("#entityTableBody").append(html);
		
		//样式inputChange绑定，大写转换为下横线加小写的
		inputChangeKeyup();
	}
	
	function delRow(curDom){
		$(curDom).parent().parent().remove();
	}
	
	
	$(document).ready(function() {
		var defaultJavaPath="D:\\workspace\\eclipse\\csc\\src\\main\\java";
		var defaultJspPath="D:\\workspace\\eclipse\\csc\\src\\main\\webapp\\WEB-INF\\views\\csc";
		$("#packageNamePath").val(defaultJavaPath);
		$("#jspPathPath").val(defaultJspPath);
		
		$("#javaPathBtn").bind('click', function(){
			layer.open({
				title:"选择路径",
			    type: 2,
			    area: ['800px', '400px'],
			    shadeClose : false,
				shade : 0.8,
			    content: '${ctx}/demo/toListFiles?objId=packageName&path=<%=new String(Base64.encodeBase64("D:\\workspace\\eclipse\\csc\\src\\main\\java".getBytes()))%>'
			});
		});
		
		$("#jspPathBtn").bind('click', function(){
			layer.open({
				title:"选择路径",
			    type: 2,
			    area: ['800px', '400px'],
			    shadeClose : false,
				shade : 0.8,
			    content: '${ctx}/demo/toListFiles?objId=jspPath&path=<%=new String(Base64.encodeBase64("D:\\workspace\\eclipse\\csc\\src\\main\\webapp\\WEB-INF\\views\\csc".getBytes()))%>'
			});
		});
		
		//样式inputChange绑定，大写转换为下横线加小写的
		inputChangeKeyup();
	});
	
	
	function changeType(curDom){
		$(curDom).parent().parent().find("input").each(function(){
			$(this).attr("checked",'false');
			$(this).removeAttr("checked");//取消全选   
		}); 
		$(curDom).prop("checked",true);
	}
	
	//回调选择路径
	function getSelPath(tPath,objId){
		console.info(tPath+"===11====="+objId);
		$("#"+objId+"Path").val(tPath);
		if(objId=='packageName'){
			var pName=tPath.substring((tPath.indexOf("java")+5),tPath.length);
			$("#"+objId).val(pName);
		}else{
			var pName=tPath.substring((tPath.indexOf("views")+5),tPath.length);
			$("#"+objId).val(pName);
		}
	}
	
	//样式inputChange绑定，大写转换为下横线加小写的
	function inputChangeKeyup(){
		$(".inputChange").bind('keyup',function(){
			var tVal=$(this).val();
			var newVal="";
			for(var i=0;i<tVal.length;i++){
				var c=tVal.charAt(i);
				if(c<'A' || c>'Z'){
					newVal+=c;
				}else{
					newVal+="_"+c.toLocaleLowerCase();
				}
			}
			$(this).next().val(newVal);
		});
	}
	
	//页面显示方式  改变事件
	function changeEleType(ele){
		console.info($(ele).val());
		if($(ele).val()=='date'){
			$(ele).parent().next().find("select").val('Date');
		}else{
			$(ele).parent().next().find("select").val('String');
		}
	}
</script>


<div class="page-content" id="yy-page-list" style="" align="center">
	
	<div style="margin-top: 20px;">
		<form  action="${ctx}/demo/createCode"  method="post">
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">模板类型</label>
						<div class="col-md-8">
							<label><input type="radio" name="templateType" value="1" checked="checked"/>普通列表（前端分页）</label>
							<label><input type="radio" name="templateType" value="3"/>普通列表（服务器分页）</label>
							<label><input type="radio" name="templateType" value="2"/>树状结构</label>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4"></label>
						<div class="col-md-8" id="" style="float: left;">
							<input name="javaWorkspace" id="packageNamePath" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-1">
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">java上级包名</label>
						<div class="col-md-8">
							<input name="packageName" id="packageName" type="text" class="form-control" value="com.yy.modules.demo.temp">
						</div>
					</div>
				</div>
				<div class="col-md-1">
					<input type="button" value="选择路径" id="javaPathBtn"/>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4"></label>
						<div class="col-md-8" id="" style="float: left;">
							<input name="jspWorkspace" id="jspPathPath" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-1">
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">controller访问路径(@RequestMapping(value = "/xx/xxx"))</label>
						<div class="col-md-8">
							<input name="controllerPath" type="text" class="form-control" value="/bd/test">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">jsp上级包名(return "xx/xxx/xxxxxx";)</label>
						<div class="col-md-8">
							<input id="jspPath" name="jspPath" type="text" class="form-control" value="csc/bd">
						</div>
					</div>
				</div>
				<div class="col-md-1">
					<input type="button" value="选择路径" id="jspPathBtn"/>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">实体的用途名</label>
						<div class="col-md-8">
							<input name="entityChinese" type="text" class="form-control" value="物料类型" style="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">生成表的名字</label>
						<div class="col-md-8">
							<input name="tableName" type="text" class="form-control" value="yy_test" style="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-4">实体的名字</label>
						<div class="col-md-8">
							<input name="entityName" type="text" class="form-control" value="TestEntity" style="">
						</div>
					</div>
				</div>
				<div class="col-md-2" style="padding-left: 0px;">
					extends
					<select name="extendsEntity">
						<option value="BaseEntity">BaseEntity</option>
						<option value="SuperEntity">SuperEntity</option>
						<option value="TreeEntity">TreeEntity</option>
					</select>
				</div>
			</div>
			<div style="height: 20px;"></div>
			<div class="row">
				<div class="row yy-toolbar" style="" align="left">
					<input type="button"  class="btn blue btn-sm" value="新增" onclick="addRow();"/>
				</div>
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th>属性名</th>
							<th>备注</th>
							<th>列表是否显示</th>
							<th>页面显示方式</th>
							<th>类型</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody id="entityTableBody">
						<tr>
							<td>
								<input type="text" name="colName" value="userName" class="inputChange" style="width: 49%;"/>
								<input type="text" name="colNameDb" value="user_name" style="width: 49%;"/>
							</td>
							<td><input type="text" name="colDesc" value="用户名" style="width: 98%;"/></td>
							<td>
								<select name="isShow" style="width: 98%;">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</td>
							<td>
								<select name="eleType" style="width: 98%;" onchange="changeEleType(this);">
									<option value="text">普通文本文本框</option>
									<option value="select">下拉选择</option>
									<option value="date">日期选择</option>
									<option value="textarea">多行文本输入框</option>
								</select>
							</td>
							<td>
							   <!-- 	
								<label><input type="checkbox" value="String" name="colType" checked="checked" onchange="changeType(this);"/>String</label>
								<label><input type="checkbox" value="Long" name="colType" onchange="changeType(this);"/>Long</label>
								<label><input type="checkbox" value="Integer" name="colType" onchange="changeType(this);"/>Integer</label>
								<label><input type="checkbox" value="Date" name="colType" onchange="changeType(this);"/>Date</laabel> 
								-->
								
								<select name="colType" style="width: 49%;">
									<option value="String">String</option>
									<option value="Long">Long</option>
									<option value="Integer">Integer</option>
									<option value="Date">Date</option>
									<option value="Lob">Lob</option>
								</select>
								<input type="text" name="colLength" value="250" style="width: 49%;"/>
							</td>
							<td>
								<input type="button" value="删除" onclick="delRow(this);"/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="colName" value="phone" class="inputChange" style="width: 49%;"/>
								<input type="text" name="colNameDb" value="phone" style="width: 49%;"/>
							</td>
							<td><input type="text" name="colDesc" value="手机号码" style="width: 98%;"/></td>
							<td>
								<select name="isShow" style="width: 98%;">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</td>
							<td>
								<select name="eleType" style="width: 98%;" onchange="changeEleType(this);">
									<option value="text">普通文本文本框</option>
									<option value="select">下拉选择</option>
									<option value="date">日期选择</option>
									<option value="textarea">多行文本输入框</option>
								</select>
							</td>
							<td>
								<select name="colType" style="width: 49%;">
									<option value="String">String</option>
									<option value="Long">Long</option>
									<option value="Integer">Integer</option>
									<option value="Date">Date</option>
									<option value="Lob">Lob</option>
								</select>
								<input type="text" name="colLength" value="250" style="width: 49%;"/>
							</td>
							<td>
								<input type="button" value="删除" onclick="delRow(this);"/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="colName" value="email" class="inputChange" style="width: 49%;"/>
								<input type="text" name="colNameDb" value="email" style="width: 49%;"/>
							</td>
							<td><input type="text" name="colDesc" value="邮箱" style="width: 98%;"/></td>
							<td>
								<select name="isShow" style="width: 98%;">
									<option value="1">是</option>
									<option value="0">否</option>
								</select>
							</td>
							<td>
								<select name="eleType" style="width: 98%;" onchange="changeEleType(this);">
									<option value="text">普通文本文本框</option>
									<option value="select">下拉选择</option>
									<option value="date">日期选择</option>
									<option value="textarea">多行文本输入框</option>
								</select>
							</td>
							<td>
								<select name="colType" style="width: 49%;">
									<option value="String">String</option>
									<option value="Long">Long</option>
									<option value="Integer">Integer</option>
									<option value="Date">Date</option>
									<option value="Lob">Lob</option>
								</select>
								<input type="text" name="colLength" value="250" style="width: 49%;"/>
							</td>
							<td>
								<input type="button" value="删除" onclick="delRow(this);"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<input type="submit"  class="btn blue btn-sm" value="保存"/>
		</form>
	</div>	
</div>	
	
	
	
