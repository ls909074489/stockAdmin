<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${contextPath}" />
<c:set var="serviceurl" value="${ctx}${controllerPath}/${shortEntityName}" />
<html>
<head>
<title>${entityChinese}</title>
</head>
<body>

	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
			<div class="row-fluid" style="padding-bottom: 5px;">
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
		<div id="ztree" class="ztree"></div>
	</div>

	<div id="maindiv" class="ui-layout-center">
		<div class="row yy-toolbar" id="yy-toolbar-list">
			<!-- <button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
			</button> -->
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
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
				<input name="uuid" type="hidden" value=""> 
				<input name="parent.uuid" type="hidden" value="">
		<#list fieldList as var>
				<#if var_index%3 == 0>
				<div class="row">
				</#if>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">${var[1]}</label>
								<div class="col-md-8"><input class="form-control " name="${var[0]}"  type="text"></div>
							</div>
						</div>	
		<#if (fieldList?size>=3) >
			<#if (fieldList?size==(var_index+1))>
				</div>
			</#if>
			<#if (fieldList?size!=(var_index+1))>
				<#if var_index%3 == 2>
				</div>
				</#if>
			</#if>					
		</#if>
		<#if (fieldList?size<3) >
			<#if (fieldList?size==var_index)>
				</div>
			</#if>
		</#if>
			</#list>
				<!-- 系统信息 -->
				<%@include file="/WEB-INF/views/common/sys/sys_info.jsp"%>
			</form>
		</div>
	</div>
	<!-- 公共脚本 -->
	<%@include file="${shortEntityName}_script.jsp"%>
	
	<!-- 树功能脚本 -->
	<jsp:include page="/WEB-INF/views/common/ztreescript.jsp" flush="true">   
	     <jsp:param name="serviceurl" value="${serviceurl}"/>
	     <jsp:param name="dataTreeUrl" value="${ctx}/bd/${shortEntityName}/dataTreeList"/>
	     <jsp:param name="onDblClickMethod" value="selfOnClick"/> 
	     <jsp:param name="onClickMethod" value="selfOnClick"/>
	</jsp:include> 
</body>
</html>