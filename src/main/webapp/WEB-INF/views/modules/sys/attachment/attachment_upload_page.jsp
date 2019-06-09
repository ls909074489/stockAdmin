<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/frame/attachment"/>
<html>
<head>
<title>导入</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
	<div class="page-content" id="yy-page-list">
			<div class="row" style="margin-left: 20px;">
				<form id="yy-form-edit" >
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
			<div class="is-modal-footer" >
				<div id="imexclate-button-pre">
					<button id="yy-import-btn-confirm" class="btn yellow btn-sm btn-info is-modal-btn" >
						 导&nbsp;&nbsp;&nbsp;&nbsp;入
					</button>
				</div>
			</div>
	</div>

		<script type="text/javascript">
			
			$(document).ready(function() {
				$("#yy-import-btn-confirm").bind('click', confirmImport);//确定导入
				$("#yy-btn-findfile").bind('click', onfindfileFile);
				$("#multifile").bind('change', onQueryFile);
				
				 //验证表单
				validateForms();
			});
			
			
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
				
				var posturl = "${apiuploadUrl}";
				var file = $("#multifile")[0].files[0];
					var formData = new FormData();
					formData.append("file", file,file.name);
					formData.append("uuid", "${entityUuid}");
					formData.append("filetype", "${entityType}");
					var importLoad = layer.msg('数据导入中...', {icon:16,time: 500*1000});
					$.ajax( {
						url : posturl,
						data: formData,
			            cache: false,
			            contentType: false,
			            processData: false,
			            type: 'POST',     
			            xhrFields: {withCredentials: true},
				        crossDomain: true,
						success : function(data) {
							if(data.success){
								layer.close(importLoad);
								data.fileName=$("#fileName").val();
								YYUI.succMsg("导入成功,重新加载页面。");
								var _method = '${callBackMethod}';
								if (_method) {
									eval(_method + "(data)");
								} else {
									window.parent.callBackMethod(data);
								}
								
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
				//if(prefix == "ini"||prefix == "xls"||prefix == "dat"){
					$("#fileName").val(this.files[0].name);
				//}else{
					//YYUI.failMsg("请选择上传 "+accFile+"文件");
				//}
			}
			
			//点击浏览
			function onfindfileFile(){
				$("#multifile").click();
			}
			
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
		           		'years' : {required : true},
		           		'semester' : {required : true}
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