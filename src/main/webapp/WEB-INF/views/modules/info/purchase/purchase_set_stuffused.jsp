<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/purchase"/>
<html>
<head>
<title>订单信息</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 确认材料
			</button>
			<button id="yy-btn-commit" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 提交说明
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
		<div>
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" type="text" class="hide" value="${uuid}">
				<input name="orderId" type="text" class="hide" value="${orderId}">
				<input name="setType" id="setType" type="text" class="hide" value="1">
				<table style="width: 98%;text-align: center;">
					<tr style="height: 30px;">
						<td style="width: 30%;">
							
						</td>
						<td id="tipTd" style="float: left;">
							
						</td>
					</tr>	
					<tr>
						<td style="width: 30%;">
							材料数量/说明
						</td>
						<td>
							<input id="typeNameId" name="stuffCount" type="text" class="form-control" value="">
						</td>
					</tr>			
				</table>
			</form>
		</div>
	</div>	
	<!-- 公用脚本 -->
	<%-- <%@include file="/WEB-INF/views/common/editscript.jsp"%> --%>
	
	<script type="text/javascript">
		var isClose = true;
		$(document).ready(function() {
			//按钮绑定事件
			//bindEditActions();
			validateForms();
			
			var rowData=window.parent.getRowData('${uuid}');
			$("#tipTd").html("订单数量:"+rowData.planCount+",使用现有库存:"+rowData.useStorageCount+",需生产数量:"+(rowData.planCount-rowData.useStorageCount));
			$("#typeNameId").val(rowData.stuffComment);
			
			$("#yy-btn-cancel").bind('click', closeDialog);
			$("#yy-btn-save").bind("click", function() {
				onSave(isClose);
			});
			$("#yy-btn-commit").bind("click", function() {
				onCommit(isClose);
			});
		});

		
		//取消编辑，返回列表视图
		function closeDialog() {
			$('#yy-form-edit div.control-group').removeClass('error');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
		

		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'stuffCount' : {required : true,number:true,digits:true,maxlength : 20}
				}
			});
		}
		
		function onSave(isClose) {
			$("#typeNameId").rules("remove");
            $("#typeNameId").rules("add", { required : true,number:true,digits:true,maxlength : 20});
            
			if (!$('#yy-form-edit').valid()) return false;
			
			$("#setType").val(1);
			$("#typeNameId").attr("name","stuffCount");
			
			var editview = layer.load(2);
			
			var posturl = "${apiurl}/order/setStuffUsed";
			var opt = {
				url : posturl,
				type : "post",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(data) {
					if (data.flag==0) {
						layer.close(editview);
						window.parent.YYUI.succMsg(data.msg);
						window.parent.onRefresh();
						closeDialog();
					}else if (data.flag==-10) {
						YYUI.promMsg('会话超时，请重新的登录!');
						window.location = '${ctx}/logout';
					} else {
						window.parent.YYUI.failMsg( data.msg);
						layer.close(editview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("操作失败，HTTP错误。");
					layer.close(editview);
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
		
		function onCommit(isClose) {
			$("#typeNameId").rules("remove");
            $("#typeNameId").rules("add", { required: true,maxlength : 200 });
			
			if (!$('#yy-form-edit').valid()) return false;
			
			$("#setType").val(2);
			$("#typeNameId").attr("name","stuffComment");
			
			var editview = layer.load(2);
			
			var posturl = "${apiurl}/order/setStuffUsed";
			var opt = {
				url : posturl,
				type : "post",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(data) {
					if (data.flag==0) {
						layer.close(editview);
						window.parent.YYUI.succMsg(data.msg);
						window.parent.onRefresh();
						closeDialog();
					}else if (data.flag==-10) {
						YYUI.promMsg('会话超时，请重新的登录!');
						window.location = '${ctx}/logout';
					} else {
						window.parent.YYUI.failMsg( data.msg);
						layer.close(editview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("操作失败，HTTP错误。");
					layer.close(editview);
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
	</script>
</body>
</html>
