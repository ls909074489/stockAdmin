<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/dc/mail_template"/>
<html>
<head>
<title>邮件模板</title>
<link href="${ctx}/assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">

<script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/assets/umeditor/zh-cn.js"></script>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 查看页面 -->
		<%@include file="mail_template_list.jsp"%>

		<!-- 编辑页面 -->
		<%@include file="mail_template_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="mail_template_detail.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="mail_template_script.jsp"%>

	</div>
</body>
</html>