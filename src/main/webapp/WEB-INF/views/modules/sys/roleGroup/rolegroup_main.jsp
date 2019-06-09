<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/roleGroup" />
<html>
<head>
<title></title>
</head>
<body>
	<div id="leftdiv" class="ui-layout-west">
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
		<div class="row-fluid">
			<!-- <div style="text-align: center;">
				<a id="expandAllBtn" href="#" onclick="return false;">【展开】</a> 
				<a id="collapseAllBtn" href="#" onclick="return false;">【折叠】</a>
			</div> -->
			<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<div id="tree" class="ztree"></div> 
	</div>

	<div id="maindiv" class="ui-layout-center">
		<div class="row yy-toolbar" id="yy-toolbar-list">
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
			<button id="yy-btn-edit" class="btn blue btn-sm">
				<i class="fa fa-edit"></i> 修改
			</button>
			<button id="yy-btn-remove" class="btn red btn-sm">
				<i class="fa fa-trash-o"></i> 删除
			</button>
			<button id="yy-btn-refresh" class="btn blue btn-sm">   
				<i class="fa fa-refresh"></i> 刷新
			</button>
		</div>
		<div class="row yy-toolbar hide" id="yy-toolbar-edit">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left" class="btn blue btn-sm"></i> 取消
			</button>
		</div>
		<div>
		<form id="yy-form-edit" class="form-horizontal">
				<input name="uuid" type="hidden" value="">
				 <input name="islast" type="hidden" value=""> 
				<input name="parentid" type="hidden">
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">角色组编码</label>
							<div class="col-md-8">
								<input name="rolegroup_code" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">角色组名称</label>
							<div class="col-md-8">
								<input name="rolegroup_name" type="text" class="form-control">
							</div>
						</div>
					</div>
					
				</div>
				
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">功能描述</label>
							<div class="col-md-10">
								<textarea name="description" class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<%-- <!-- 编辑页面 -->
		<%@include file="rolegroup_edit.jsp"%> --%>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/treecommonscript.jsp"%>
	
	<!-- 功能脚本 -->
	<%@include file="rolegroup_script.jsp"%>
</body>
</html>
