<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<html>
<head>
<title>修改条码</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
	<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-save" class="btn blue btn-sm">
					<i class="fa fa-chevron-down"></i> 保存
				</button>
				<button id="yy-btn-cancel" class="btn blue btn-sm">
					<i class="fa fa-chevron-down"></i> 取消
				</button>
			</div>
			
			<div class="row" style="margin-left: 20px;">
				<form id="yy-form-edit" >
					<input name="projectSubId" type="text" class="hide" value="${projectSubId}">
					<input name="barcodeUuid" type="text" class="hide" value="${barcodeUuid}">
					<div>
						<div style="height: 5px;"></div>
						<div  style="text-align: center;font-size: 24px;">是否修改条码</div>
						<div style="height: 5px;"></div>
						<table>
							<tr>
								<td style="color: #e02222;">新条码&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="width: 280px;">
									<input name="barcode" type="text" class="form-control" value="">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
	</div>

		<script type="text/javascript">
			
			$(document).ready(function() {
				 //验证表单
				validateForms();
				 
				$("#yy-btn-save").bind("click", function() {
					onSave(isClose);
				});
				
				$("#yy-btn-cancel").bind('click', onConfirmCancel);
				 
			});
			
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						'barcode' : {required : true,maxlength : 100}
					}	
				}); 
			}
			
			
			var isClose=true;
		 	function onSave(isClose) {
				if (!$('#yy-form-edit').valid()) return false;

				var editview = layer.load(2);
				
				var posturl = "${serviceurl}/modifyBarcode";
				var opt = {
					url : posturl,
					type : "post",
					success : function(data) {
						if (data.success) {
							layer.close(editview);
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭 
						} else {
							window.parent.YYUI.failMsg("保存失败：" + data.msg);
							layer.close(editview);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						window.parent.YYUI.promAlert("保存失败，HTTP错误。");
						layer.close(editview);
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			} 
		 	
		 	function onConfirmCancel(){
		 		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
		 	}
		</script>
	</div>
</body>
</html>