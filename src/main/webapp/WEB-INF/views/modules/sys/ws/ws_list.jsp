<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/ws"/>
<html>
<head>
<title>消息推送</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar form-inline">
				<button id="" type="button" class="btn btn-sm btn-info" onclick="getAllSession();">
					<i class="fa fa-search"></i>查询当前用户
				</button>
			</div>
			<div id="sessionIds"></div>
			<hr>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					用户<input type="text" autocomplete="on" name="userId"
						id="userId" class="form-control input-sm">
					内容<input type="text" autocomplete="on" name="content"
						id="content" class="form-control input-sm">

					<button type="button" class="btn btn-sm btn-info" onclick="sendUser();">
						<i class="fa fa-send"></i>发送
					</button>
					<button type="button" class="btn btn-sm btn-info" onclick="sendAll();">
						<i class="fa fa-send"></i>发送所有
					</button>
				</form>
			</div>
		</div>
	</div>

	
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		
		function getAllSession(){
			$.ajax({
				type : "POST",
				data :{},
				url : "${serviceurl}/getAllSession",
				//async : true,
				dataType : "json",
				success : function(data) {
					if (data.success) {
						console.info(data);
						$("#sessionIds").html(data.msg);
					} else {
						YYUI.failMsg("加载枚举数据失败");
					}
				},
				error : function(data) {
					$("#login-msg").html("登录失败，请联系管理员");
				}
			});
		}
		
		function sendUser(){
			$.ajax({
				type : "POST",
				data :{"userid":$("#userId").val(),"message":$("#content").val()},
				url : "${serviceurl}/sendMessageToUser",
				//async : true,
				dataType : "json",
				success : function(data) {
					console.info(data);
				},
				error : function(data) {
					YYUI.failMsg("发送失败");
				}
			});
		}
		
		function sendAll(){
			$.ajax({
				type : "POST",
				data :{"message":$("#content").val()},
				url : "${serviceurl}/sendMessageToUsers",
				//async : true,
				dataType : "json",
				success : function(data) {
					console.info(data);
				},
				error : function(data) {
					YYUI.failMsg("发送失败");
				}
			});
		}
	</script>
</body>
</html>	

