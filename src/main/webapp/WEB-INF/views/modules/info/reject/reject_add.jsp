<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/purchase"/>
<html>
<head>
<title>订单信息</title>
<style type="text/css">
.required{
	color:#e02222;
}
</style>
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
			<table style="width: 98%;text-align: center;">
				<tr style="height: 50px;">
					<td style="width: 18%;" class="required">
						订单编号
					</td>
					<td>
						<input name="orderNumber" type="text" class="form-control" value="">
					</td>
					<td style="width: 18%;" class="required">
						客户名称
					</td>
					<td>
						<input name="customer" type="text" class="form-control" value="">
					</td>
				</tr>
				<tr style="height: 50px;">
					<td style="width: 18%;" class="required">
						产品料号
					</td>
					<td>
						<div class="input-group">
								<fieldset disabled="disabled">
									<input name="stuff" id="stuff" type="text" class="form-control">
								</fieldset>
								<span class="input-group-btn">
									<button id="yy-def-iconcls" class="btn btn-default btn-ref" type="button"
										data-select2-open="single-append-text">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
						</div>
					</td>
					<td style="width: 18%;" class="required">
						产品型号
					</td>
					<td>
						<input name="model" id="model" type="text" class="form-control" value="">
					</td>
				</tr>
				<tr style="height: 50px;">
					<td style="width: 18%;" class="required">
						退货数量
					</td>
					<td>
						<input name="rejectCount" type="text" class="form-control" value="">
					</td>
					<td style="width: 18%;" class="required">
						日期
					</td>
					<td>
						<input type="text"  name="date" id="produceDate" 
							class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value=""> 
					</td>
				</tr>	
				<tr style="height: 50px;">
					<td style="width: 18%;">
						原因
					</td>
					<td>
						<input name="reason" type="text" class="form-control" value="">
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
			
			$('#yy-def-iconcls').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择',
					shadeClose : false,
					shade : 0.8,
					area : [ '70%', '90%' ],
					content : '${serviceurl}/toSelectStuff', //iframe的url
				});
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
					'orderNumber' : {required : true,maxlength : 100},
					'customer' : {required : true,maxlength : 100},
					'stuff' : {required : true,maxlength : 100},
					'model' : {required : true,maxlength : 100},
					'rejectCount' : {required : true,number:true,digits:true,maxlength : 20},
					'date' : {required : true,maxlength : 20},
					'reason' : {maxlength : 200}
				}
			});
		}
		
		function onSave(isClose) {
			if (!$('#yy-form-edit').valid()) return false;
			
			var editview = layer.load(2);
			
			var posturl = "${apiurl}/order/rejectOrder";
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
		
		//回调选择产品料号
		function callBackSelectStuff(data){
			$("#stuff").val(data.stuff);
			$("#model").val(data.model);
		}
	</script>
</body>
</html>
