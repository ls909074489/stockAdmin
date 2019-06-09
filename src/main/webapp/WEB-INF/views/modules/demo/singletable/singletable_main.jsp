<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/demo/singletable" />
<html>
<head>
<title>单表-前端分页Demo</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 查看页面 -->
		<%@include file="singletable_list.jsp"%>

		<!-- 编辑页面 -->
		<%@include file="singletable_edit.jsp"%>

		<!-- 明细页面 -->
		<%@include file="singletable_detail.jsp"%>

		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="singletable_script.jsp"%>

	</div>
</body>
</html>