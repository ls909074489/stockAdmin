<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/instructions" />
<html>
<head>
<title>帮助手册</title>
<link href="${ctx}/assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/assets/umeditor/zh-cn.js"></script>
</head>
<body>

	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
			<div class="row-fluid" style="padding-bottom: 5px;">
				<div class="btn-group btn-group-solid">
					<!-- <button id="yy-expandAll" type="button" class="btn btn-sm blue">
						全展开
					</button>
					<button  id="yy-collapseAll" type="button" class="btn btn-sm green ">
						全折叠
					</button> -->
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
		<div id="ztree" class="ztree"></div>
	</div>

	<div id="maindiv" class="ui-layout-center">
		<div class="row yy-toolbar" id="yy-toolbar-list">
			<!-- <button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
			</button> 
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
			-->
			<button id="yy-btn-edit" class="btn blue btn-sm">
				<i class="fa fa-edit"></i> 修改
			</button>
			<button id="yy-btn-remove" class="btn blue btn-sm">
				<i class="fa fa-trash-o"></i> 删除
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
				<input id="instructionsUuid" name="uuid" type="hidden" value=""> 
				<input name="funcId" type="hidden" value="">
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1">名称</label>
							<div class="col-md-11">
								<input name="func_name" type="text" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1 required-tip">标题</label>
							<div class="col-md-11">
								<input name="title" type="text" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1 required-tip">内容</label>
							<div class="col-md-11">
								<div id="contentEditDiv" style="display: none;">
									<!--style给定宽度可以影响编辑器的最终宽度-->
									<script type="text/plain" id="myEditor" style="" name="content">
									</script>
								</div>
								<div id="contentViewDiv" class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered" style="background-color: #eef1f5;">
								
								</div>
							</div>
						</div>
					</div>	
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1">备注</label>
							<div class="col-md-11">
								<textarea rows="" cols="" name="remark"  class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 公共脚本 -->
	<%@include file="instructions_script.jsp"%>
	
	<!-- 树功能脚本 -->
	<jsp:include page="/WEB-INF/views/common/ztreescript.jsp" flush="true">   
	 	 <jsp:param name="serviceurl" value="${serviceurl}"/>
	     <jsp:param name="dataTreeUrl" value="${serviceurl}/getLeftFunc?funcId=${funcId}"/>
	     <jsp:param name="onAsyncSuccessMethod" value="selfOnAsyncSuccess"/> 
	</jsp:include> 
	<%-- <jsp:param name="onDblClickMethod" value="selfOnClick"/> 
	     <jsp:param name="onClickMethod" value="selfOnClick"/> --%>
</body>
</html>