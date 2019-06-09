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
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
		<div>
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" type="text" class="hide" value="${uuid}">
				<input name="orderId" type="text" class="hide" value="${orderId}">
				<input id="useStorageMaxCount" name="useStorageMaxCount" type="text" class="hide" value="0">
				<table style="width: 98%;text-align: center;">
					<tr>
						<td style="width: 30%;">
							
						</td>
						<td style="float: left;">
							<span id="tipCountSpan"></span>
						</td>
					</tr>
					<tr>
						<td style="width: 30%;">
							使用现有库存
						</td>
						<td>
							<input id="useStorageCount" name="useStorageCount" type="text" class="form-control" value="">
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
			
			$("#yy-btn-cancel").bind('click', closeDialog);
			$("#yy-btn-save").bind("click", function() {
				onSave(isClose);
			});
			
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :{"uuid": "${uuid}"},
				url : "${apiurl}/order/getStorage",
				async : true,
				dataType : "json",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(data) {
					layer.close(waitInfoLoading);
					console.info(data);
					if (data.flag==0) {
						var tMaxCount=data.obj.existCount+data.obj.remainCount;//+data.obj.reworkCount
						if(tMaxCount<0){
							tMaxCount=0;
						}
						var rowData=window.parent.getRowData('${uuid}');
						$("#tipCountSpan").html("订单数量:"+rowData.planCount+",额外库存: "+tMaxCount);
						$("#useStorageMaxCount").val(tMaxCount);
					}else if (data.flag==-10) {
						window.location = '${ctx}/logout';
					}else {
						YYUI.promAlert("获取数据失败："+data.msg);
					}
				},
				error : function(data) {
					layer.close(waitInfoLoading);
					$("#login-msg").html("查询失败，请联系管理员");
				}
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
					'useStorageCount' : {required : true,number:true,digits:true,maxlength : 20}
				}
			});
		}
		
		function onSave(isClose) {
			if (!$('#yy-form-edit').valid()) return false;
			
			
			/*var t_useStorageMaxCount=$("#useStorageMaxCount").val();
			var useStorageCount=$("#useStorageCount").val();
			if(useStorageCount>t_useStorageMaxCount){
				YYUI.failMsg("成品数量不能大于"+t_useStorageMaxCount);
				return false;
			}*/
			
			var editview = layer.load(2);
			
			var posturl = "${apiurl}/order/setStorageUsed";
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
						window.parent.YYUI.failMsg(data.msg);
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
