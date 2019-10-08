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
				<!-- <button id="yy-btn-update" class="btn blue btn-sm">
					<i class="fa fa-edit"></i> 修改
				</button> -->
				<button id="yy-btn-cancel" class="btn blue btn-sm">
					<i class="fa fa-chevron-down"></i> 取消
				</button>
				<!-- <button id="yy-btn-back" class="btn blue btn-sm">
					<i class="fa fa-reply"></i> 退料
				</button> -->
			</div>
			
			<div class="row" style="margin-left: 20px;">
				<form id="yy-form-edit" >
					<input name="subId" id="subId" type="text" class="hide" value="${subId}">
					<input name="operType" id="operType" type="hidden"  value="">
					<input name="hwcode" id="hwcode" type="hidden"  value="${hwcode}">
					<div>
						<div style="height: 20px;"></div>
						<table>
							<tr>
								<td style="color: #e02222;">新条码&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="width: 400px;">
									<input name="newBarcodeVal" id="newBarcodeVal" type="text" value="" class="form-control">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
	</div>

		<script type="text/javascript">
			
			var jsonResp = jQuery.parseJSON('${subList}');
		
			$(document).ready(function() {
				
				$("#newBarcodeVal").focus();//光标定位在条码框里
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
				
				$("#yy-btn-back").bind("click", function() {
					$("#operType").val('back');
					onSave(isClose);
				});
				
				
				$("#yy-btn-cancel").bind('click', onConfirmCancel);
				 
			});
			
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						'newBarcodeVal' : {required : true,maxlength : 50}
					}	
				}); 
			}
			
			
			var isClose=true;
		 	function onSave(isClose) {
				if (!$('#yy-form-edit').valid()) return false;

				var newBarcodeVal = $("#newBarcodeVal").val();
				
				var showLengthConfirm=false;
				if(jsonResp!=null&&jsonResp.length>0&&newBarcodeVal!=null){
					for (i = 0; i < jsonResp.length; i++) {
						var t_pre = jsonResp[i].enumdatakey;
						var materialLength = parseInt(jsonResp[i].keyLength);
						if(newBarcodeVal.indexOf(t_pre)==0){//以19,39...开头的
							searchCode = newBarcodeVal.substring(t_pre.length,t_pre.length+materialLength);//截取位数
							console.info("searchCode>>>>>>>>>"+searchCode);
							console.info("限制长度："+jsonResp[i].description+">>条码长度："+newBarcodeVal.length);
							var limitLength = jsonResp[i].description;
							if(limitLength!=null&&limitLength!=''&&parseInt(limitLength)!=newBarcodeVal.length){
								showLengthConfirm =true;
							}
							break;
						}
					}
				}
				var tr_hwcode =$("#hwcode").val();
				if(showLengthConfirm){
					layer.confirm(jsonResp[i].enumdataname+'限制长度为'+limitLength+',确定要保存吗', function(index) {
						layer.close(index);
						if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
							onComparetBarcode(newBarcodeVal,$("#subId").val());
						}else{
							layer.confirm("条码与华为物料编码不符合，确定要保存吗", function(index) {
								layer.close(index);
								onComparetBarcode(newBarcodeVal,$("#subId").val());
							});
						}
					});
				}else{
					if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
						onComparetBarcode(newBarcodeVal,$("#subId").val());
					}else{
						layer.confirm("条码与华为物料编码不符合，确定要保存吗", function(index) {
							layer.close(index);
							onComparetBarcode(newBarcodeVal,$("#subId").val());
						});
					}
				}
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
					data :{"newBarcode": newBarcodeVal,"newUuid":subId,"subAmount":1},
					url : "${serviceurl}/updateBarcode",
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