<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/org" />
<html>
<head>
<title>切换当前厂商</title>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
		<div class="row">
			<form class="form-horizontal" name="yy-form-edit" id="yy-form-edit">
				<table style="width: 90%;">
					<tr style="height: 10px;"><td></td><td></td></tr>
					<tr style="height: 40px;">
						<td style="width: 100px;"><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;请选择</label></td>
						<td style="width: 200px;">
							<%-- <select class="yy-input-enumdata form-control" id="stationId" name="stationId">
								<option value=""></option>
								<c:forEach items="${stationLists}" var="clist">
									<option value="${clist.uuid}">${clist.name}</option>
								</c:forEach>
							</select> --%>
							
							<select id="stationId"  name="stationId" class="yy-select2-single form-control">
								<option value=""></option>
								<c:forEach items="${stationLists}" var="list">
									<option value="${list.uuid}">${list.name}(${list.org_code})</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<div class="row form-actions yy-toolbar" style="margin-top: 10px;text-align: center;background-color: white;">
					<button id="btn-post" type="button">
						<i class="fa fa-save"></i> 确定
					</button>
					<button id="yy-btn-cancel" type="button" class="btn blue btn-sm">
						<i class="fa fa-rotate-left"></i> 关闭
					</button>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function changeStation() {
			if (!$('#yy-form-edit').valid())
				return false;
			var postData = $("#yy-form-edit").serializeArray();
			
			$.ajax({
				url : '${serviceurl}/changeSessionStation',
				type : 'POST',
				dataType : "json",
				ContentType : "application/json; charset=utf-8",
				data : postData,
				success : function(data) {
					if (data.success) {
						 YYUI.succMsg('操作成功!');
						$('#yy-form-edit')[0].reset();
						
						window.parent.callSelectSessionStation(data);
						//修改密码成功后关闭框  edit by liusheng
						var index = parent.layer.getFrameIndex(window.name);
						//先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭 
					} else {
						YYUI.failMsg("操作失败："+data.msg); 
					}
				}
			});
		}

		$(document).ready(function() {
			$('#btn-post').bind('click', changeStation);
			
			$('#stationId').select2();
			//验证 表单
			validateForms();
			
			$("#yy-btn-cancel").bind('click', function(){
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			});
		});
		
		 //验证表单
		 //验证表单
		function validateForms(){
			$('#yy-form-edit').validate({
				rules : {
					stationId : {
						required : true
					}
				},
				messages : {
					stationId : {
						required : "请选择厂商"
					}
				}
			}); 
		}
	</script>
</body>
</html>