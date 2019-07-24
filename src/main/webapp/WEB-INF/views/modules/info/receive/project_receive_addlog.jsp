<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/receive"/>
<html>
<head>
<title>收货记录</title>
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
					<input name="subId" type="hidden" class="hide" value="${subId}">
					<div>
						<div style="height: 20px;"></div>
						<table>
							<tr>
								
								<td style="color: #e02222;">&nbsp;&nbsp;&nbsp;&nbsp;收货类型&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<select name="receiveType" id="receiveType" data-enum-group="ReceiveType" class="yy-input-enumdata form-control"></select>
								</td>
								<td style="color: #e02222;">&nbsp;&nbsp;&nbsp;&nbsp;收货数量&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<input name="receiveAmount" id="receiveAmount" type="text" value="" class="form-control">
								</td>
								<td style="color: #e02222;">&nbsp;&nbsp;&nbsp;&nbsp;收货时间&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>
									<input class="Wdate" type="text" name="receiveTime" onClick="WdatePicker()" value="${curDate}">
								</td>
							</tr>
							<tr style="height: 50px;">
								<td style="">&nbsp;&nbsp;&nbsp;&nbsp;备注&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td colspan="5">
									<input name="memo" id="memo" type="text" value="" class="form-control" style="width: 100%;">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
	</div>

		<script type="text/javascript">
			
			$(document).ready(function() {
				
				$("select[name='limitCount']").val('${entity.limitCount}');
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
						'receiveAmount' : {required : true,digits :true,maxlength : 5},
						'receiveTime' : {required : true},
						'receiveType' : {required : true},
						'memo' : {maxlength : 250}
					}	
				}); 
			}
			
			
			var isClose=true;
		 	function onSave(isClose) {
				if (!$('#yy-form-edit').valid()) return false;

				layer.confirm("确认收货将生成入库单，确定要保存吗", function() {
					var editview = layer.load(2);
					var posturl = "${serviceurl}/saveReceiveLog";
					var opt = {
						url : posturl,
						type : "post",
						success : function(data) {
							if (data.success) {
								layer.close(editview);
								if (isClose) {
									window.parent.YYUI.succMsg('保存成功!');
									window.parent.onRefreshSub(true);
									var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
									parent.layer.close(index); //再执行关闭 
								} else {
									YYUI.succMsg('保存成功!');
								}
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
				});
			} 
		 	
		 	function onConfirmCancel(){
		 		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
		 	}
		</script>
	</div>
</body>
</html>