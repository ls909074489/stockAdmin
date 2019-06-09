<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/role" />
<html>
<head>
<title>角色管理</title>

<script type="text/javascript" src="${ctx}/assets/scrolltop/scrolltopcontrol.js"></script>
</head>
<body>
	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
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
		<%@include file="role_list.jsp"%>
		<!-- 编辑页面 -->
		<%@include file="role_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="role_detail.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="role_script.jsp"%>
		
		<%@include file="role_group_script.jsp"%>
		
	</div>
</body>
</html>