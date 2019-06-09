<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/template" />
<c:set var="subserviceurl" value="${ctx}/sys/templatesub" />
<html>
<head>
<title>高级查询</title>
</head>
<body>

	<div class="container-fluid page-container page-content">

		<!-- 查看页面 -->
		<%@include file="template_list.jsp"%>

		<!-- 编辑页面 -->
		<%@include file="template_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="template_detail.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="template_sup.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/subcommonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="template_script.jsp"%>
		
	</div>
		
</body>
</html>