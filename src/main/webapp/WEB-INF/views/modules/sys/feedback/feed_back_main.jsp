<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/feedback"/>
<html>
<head>
<title>意见反馈</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<%@include file="feed_back_detail.jsp"%>
		<!-- 查看页面 -->
		<%@include file="feed_back_list.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="feed_back_script.jsp"%>

	</div>
</body>
</html>