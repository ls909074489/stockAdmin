<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
<title>导入</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
	<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-import-btn-confirm" class="btn blue btn-sm">
					<i class="fa fa-chevron-down"></i> 保存
				</button>
				<button id="yy-btn-cancel" class="btn blue btn-sm" onclick="javascript:downloadtemplate();">
					<i class="fa fa-chevron-down"></i> 下载导入模板
				</button>
			</div>
			
			<div class="row" style="margin-left: 20px;">
				<form id="yy-form-edit" >
					<div>
						<div style="height: 20px;"></div>
						<table>
							<tr>
								<td style="color: #e02222;">项目号&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<input name="code" id="code" type="text" value="${entity.code}" class="form-control">
								</td>
								<td style="color: #e02222;">&nbsp;&nbsp;&nbsp;&nbsp;项目名称&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
								</td>
								<td style="color: #e02222;">&nbsp;&nbsp;&nbsp;&nbsp;仓库&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<div class="input-group input-icon right">
										<input id="stockUuid" name="stock.uuid" type="hidden" value="${defaultStock}"> 
										<i class="fa fa-remove" onclick="cleanDef('stockUuid','stockName');" title="清空"></i>
										<input id="stockName" name="stockName" type="text" class="form-control" readonly="readonly" 
											value="${defaultStockName}">
										<span class="input-group-btn">
											<button id="stock-select-btn" class="btn btn-default btn-ref" type="button">
												<span class="glyphicon glyphicon-search"></span>
											</button>
										</span>
									</div>
								</td>
							</tr>
							
							<tr style="height: 50px;">
								<td>备注</td>
								<td colspan="5">
									<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
								</td>
							</tr>
							
							
						</table>
					</div>
				</form>
					<div id="imexlate-text-upload">
						<div class="imexlate-text-input" id="imexlate-text-input-span"><span id="imexlate-text-input-text">请选择：</span></div>
						<div class="imexlate-text-input"><input type="text" id="fileName" class="imexlate-fileName" readonly="readonly"/></div>
						<div class="imexlate-text-input" style="margin-left:5px;"> 
						
							<button id="yy-btn-findfile" class="btn green btn-sm">
								<i class="fa fa-file-o"></i>&nbsp;浏览
							</button>
						</div>
					</div>
					<div class="hide">
						<form id="yy-import-file" >
							<input type="file" id="multifile" name="file" /> 
						</form>
					</div>
			</div>
	</div>

		<script type="text/javascript">
			
			$(document).ready(function() {
				$("#years").val('${currentYears}');
				$("#semester").val('${currentSemester}');
				
				$("#yy-import-btn-confirm").bind('click', confirmImport);//确定导入
				$("#yy-btn-findfile").bind('click', onfindfileFile);
				$("#multifile").bind('change', onQueryFile);
				
				 //验证表单
				validateForms();
				 
				$('#stock-select-btn').on('click', function() {
					layer.open({
						type : 2,
						title : '请选择仓库',
						shadeClose : false,
						shade : 0.8,
						area : [ '90%', '90%' ],
						content : '${ctx}/sys/ref/refStock?callBackMethod=window.parent.callBackStock'
					});
				});
			});
			
			//回调选择
			function callBackStock(data){
				$("#stockUuid").val(data.uuid);
				$("#stockName").val(data.name);
			}
			
			//确定导入
			function confirmImport(){
				if($("#fileName").val()==null || $("#fileName").val()==""){
					YYUI.promAlert("请选择导入文件");
					return;
				}
				var mainValidate=$('#yy-form-edit').valid();
				if(!mainValidate){
					return false;
				}
				
				var posturl = "${serviceurl}/import";//import
				 
					var file = $("#multifile")[0].files[0];
					var formData = new FormData();
					formData.append("stock.uuid", $("#stockUuid").val());
					formData.append("code", $("#code").val());
					formData.append("name", $("#name").val());
					formData.append("memo", $("#memo").val());
					formData.append("attachment", file,file.name);
					var importLoad = layer.msg('数据导入中，每100条数据大概需要50秒。', {icon:16,time: 500*1000});
					$.ajax( {
						url : posturl,
						data: formData,
			            cache: false,
			            contentType: false,
			            processData: false,
			            type: 'POST',     
						success : function(data) {
							if(data.success){
								layer.close(importLoad);
								YYUI.succMsg("导入成功,重新加载页面。");
								window.parent.onRefresh();
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭 
							} else{
								layer.close(importLoad);
								YYUI.promAlert("导入错误：" + data.msg);
							}
						},
						"error" : function(XMLHttpRequest, textStatus, errorThrown) {
							layer.close(importLoad);
							YYUI.failMsg("导入失败。");
						}
					});
				 
				 
				 
				 
			}	
			
			//选择文件后
			function onQueryFile(){
				var fileName = this.files[0].name;
				var prefix = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
				if(prefix == "xls" || prefix == "xlsx"){
					$("#fileName").val(this.files[0].name);
				}else{
					YYUI.failMsg("文件格式不正确,您可以下载导入模板");
				}
			}
			
			//点击浏览
			function onfindfileFile(){
				$("#multifile").click();
			}
			
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						'orderType' : {required : true,maxlength : 100},
						'code' : {required : true,maxlength : 100},
						'name' : {required : true,maxlength : 100},
						'stockName' : {required : true,maxlength : 100},
						'memo' : {maxlength : 100}
					}	
				}); 
			}
			
			//下载模板
			function downloadtemplate(){
				window.open('${ctx}${templatePath}',"_blank");
			}
		</script>
	</div>
</body>
</html>