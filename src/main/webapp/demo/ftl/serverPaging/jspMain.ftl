<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${contextPath}"/>
<c:set var="serviceurl" value="${ctx}${controllerPath}"/>
<html>
<head>
<title>${entityChinese}</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 查看页面 -->
		<%@include file="${shortEntityName}_list.jsp"%>

		<!-- 编辑页面 -->
		<%@include file="${shortEntityName}_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="${shortEntityName}_detail.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="${shortEntityName}_script.jsp"%>

	</div>
</body>
</html>