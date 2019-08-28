<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<html>
<head>
<title>清单信息</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
	<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 添加
				</button>
				<button id="yy-btn-update" class="btn blue btn-sm">
					<i class="fa fa-edit"></i> 修改
				</button>
				<button id="yy-btn-cancel" class="btn blue btn-sm">
					<i class="fa fa-chevron-down"></i> 取消
				</button>
			</div>
			
			<div class="row" style="margin-left: 20px;">
				<form id="yy-form-edit" >
					<input name="subId" id="subId" type="text" class="hide" value="${subId}">
					<input name="operType" id="operType" type="hidden"  value="">
					<input name="newBarcodeVal" id="newBarcodeVal" type="text" class="hide" value="${newBarcodeVal}">
					<div>
						<div style="height: 20px;"></div>
						<table>
							<tr>
								<td style="color: #e02222;">确定领料数量&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<input name="planAmount" id="planAmount" type="text" value="${planAmount}" class="form-control">
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
				 
				$("#yy-btn-add").bind("click", function() {
					$("#operType").val('add');
					onSave(isClose);
				});
				$("#yy-btn-update").bind("click", function() {
					$("#operType").val('update');
					onSave(isClose);
				});
				
				$("#yy-btn-cancel").bind('click', onConfirmCancel);
				 
			});
			
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						'planAmount' : {required : true,digits :true,min:1,maxlength : 8}
					}	
				}); 
			}
			
			
			var isClose=true;
		 	function onSave(isClose) {
				if (!$('#yy-form-edit').valid()) return false;

				onComparetBarcode($("#newBarcodeVal").val(),$("#subId").val());
			} 
		 	
		 	function onConfirmCancel(){
		 		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
		 	}
		 	
		 	
		 	function onComparetBarcode(newBarcodeVal,subId){
				$.ajax({
					type : "POST",
					data :{"newBarcode": newBarcodeVal,"subId":subId},
					url : "${serviceurl}/checkBarcode",
					async : true,
					dataType : "json",
					success : function(data) {
						if(data.success){
							onSaveBarCode(newBarcodeVal,subId);
						}else{
							//已存在条码
							layer.confirm(data.msg+",确定要修改吗?", function() {
								onSaveBarCode(newBarcodeVal,subId);
							});
						}
					},
					error : function(data) {
						YYUI.promMsg("操作失败，请联系管理员");
					}
				});
			}
			
			function onSaveBarCode(newBarcodeVal,subId){
				$.ajax({
					type : "POST",
					data :{"newBarcode": newBarcodeVal,"subId":subId,"subAmount":$("#planAmount").val(),"operType":$("#operType").val()},
					url : "${serviceurl}/updateBarcodePc",
					async : true,
					dataType : "json",
					success : function(data) {
						if(data.success){
							YYUI.succMsg(data.msg);
							window.parent.onQuery();
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭 
						}else{
							YYUI.promAlert(data.msg);
						}
					},
					error : function(data) {
						YYUI.promMsg("操作失败，请联系管理员");
					}
				});
			}
		</script>
	</div>
</body>
</html>