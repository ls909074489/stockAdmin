<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="serviceurl" value="${ctx}/sys/person" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>业务人员</title>
<style type="text/css">
/* 设置树的5个按钮的间距 */
.btn-group-sm>.btn,.btn-sm{padding:5px 7px;}
</style>
</head>
<body>
	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
		   <div class="input-group" style="padding-bottom: 5px;">
				<input id="currentOrgId" name="currentOrgId" type="hidden" value="${orgId}"> 
				<input name="currentOrgName" type="text" class="form-control">
				<span class="input-group-btn">
					<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
			<div class="row-fluid">
				<div class="btn-group btn-group-solid">
					<button id="yy-expandSon" type="button" class="btn btn-sm blue">
						展开
					</button>
					<button id="yy-collapseSon" type="button" class="btn btn-sm green ">
						折叠
					</button>
					<button id="yy-treeRefresh" type="button" class="btn btn-sm blue">
						刷新
					</button>
				</div>
			</div>
			<span class="span12">
				<input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<div id="treeFunc" class="ztree"></div>
	</div>

	<div id="maindiv" class="ui-layout-center">
		<!-- 查看页面 -->
		<%@include file="person_select_list.jsp"%>

		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="person_select_script.jsp"%>
		
	</div>
	 <%@include file="person_select_deptscript.jsp"%>
</body>
</html>