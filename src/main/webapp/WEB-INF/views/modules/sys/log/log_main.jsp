<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/log" />
<html>
<head>
<title>操作日志</title>
</head>
<body>
	<div class="container-fluid page-container">

		<!-- 查看页面 -->
		<%@include file="log_list.jsp"%>
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="log_script.jsp"%>

	</div>
</body>
</html>