<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/sample"/>
<html>
<head>
<title>样品信息</title>
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
			<table style="width: 98%;text-align: center;">
				<tr>
					<td style="width: 10%;">
						价格
					</td>
					<td>
						<input name="price" type="text" class="form-control" value="">
					</td>
				</tr>			
			</table>
		</form>
	</div>
	<!-- 公用脚本 -->
	<%-- <%@include file="/WEB-INF/views/common/editscript.jsp"%> --%>
	<script type="text/javascript">
		var isClose = true;
		$(document).ready(function() {
			//按钮绑定事件
			//bindEditActions();
			validateForms();
			setValue();
			
			$("#yy-btn-cancel").bind('click', closeDialog);
			$("#yy-btn-save").bind("click", function() {
				onSave(isClose);
			});
		});

		
		//取消编辑，返回列表视图
		function closeDialog() {
			$('#yy-form-edit div.control-group').removeClass('error');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
		
		//设置默认值
		function setValue() {
		
		}
		

		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'name' : {required : true,maxlength : 100},
					'price' : {required : true,number:true,maxlength : 20,min:0.001},
					'argument' : {required : true,maxlength : 100},
					'stationName' : {required : true},
					'memo' : {maxlength : 200},
				}
			});
		}
		
		function onSave(isClose) {
			if (!$('#yy-form-edit').valid()) return false;
			
			var editview = layer.load(2);
			
			var posturl = "${apiurl}/sample/setPrice";
			var opt = {
				url : posturl,
				type : "post",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(data) {
					if (data.flag==0) {
						layer.close(editview);
						if (isClose) {
							window.parent.YYUI.succMsg(data.msg);
							window.parent.onRefresh(true);
							closeDialog();
						} else {
							YYUI.succMsg(data.msg);
						}
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
