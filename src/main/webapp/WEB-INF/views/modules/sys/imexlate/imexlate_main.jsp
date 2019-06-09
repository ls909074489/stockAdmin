<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/imexlate"/>
<c:set var="subserviceurl" value="${ctx}/sys/implateSub" />
<html>
<head>
<title>导入模板</title>

</head>
<body>
	<div class="container-fluid page-container page-content">

		<!-- 查看页面 -->
		<%@include file="imexlate_list.jsp"%>

		<!-- 编辑页面 -->
		<%@include file="imexlate_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="imexlate_detail.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="imexlatesub_list.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/subcommonscript.jsp"%>
		
		<!-- 功能脚本 -->
		<%@include file="imexlate_script.jsp"%>
		
		
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/imexscript.jsp"%>
		<%@include file="/WEB-INF/views/common/imexlate_uploadfile.jsp"%>
	</div>
</body>
</html>