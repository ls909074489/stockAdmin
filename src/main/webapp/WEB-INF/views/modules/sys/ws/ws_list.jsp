<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/ws"/>
<html>
<head>
<title>标准映射表</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar form-inline">
				<button id="" type="button" class="btn btn-sm btn-info" onclick="getAllSession();">
					<i class="fa fa-search"></i>查询
				</button>
			</div>
			<div id="sessionIds"></div>
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
	</script>
</body>
</html>	

