<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%> --%>
<c:set var="ctx" value="${contextPath}"/>
<c:set var="serviceurl" value="${ctx}${controllerPath}"/>
<html>
<head>
<title>${entityChinese}</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 列表 -->
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" type="button">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm btn-info" type="button">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" type="button">
					<i class="fa fa-refresh"></i> 刷新
				</button>
				<div class="btn-group btn-group-export">
				     <a class="btn green" href="javascript:;" data-toggle="dropdown" aria-expanded="false">
					     导出<i class="fa fa-angle-down"></i>
				     </a>
				     <ul class="dropdown-menu" style="min-width:100px;">
					 <li id="yy-btn-export"><a href="javascript:;"><i class="fa fa-chevron-up"></i>选择导出 </a></li>
					 <li id="yy-btn-export-query" queryformId="yy-form-query"><a href="javascript:;"><i class="fa fa-file-text-o"></i>查询导出</a></li>
				     </ul>
				 </div>	
			</div>
			<div class="row yy-searchbar">
			<#list fieldList as var>
				<#if (var_index<2) >
				<div class="col-md-3 form-inline">
					<div id="div_col${var_index+2}_filter" data-column="${var_index+2}">
						${var[1]} <input type="text" name="${var[0]}" class="column_filter form-control input-sm" id="col${var_index+2}_filter">
					</div>			
				</div>
				</#if>
			</#list>
				<div class="col-md-6 form-inline">
					<div class="dataTables_filter" id="yy-table-list_filter">
						<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder=""></label>
					</div>
				</div>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					
					<thead>
						<tr>
							<th style="width:30px;">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
							</th>
							<th>操作</th>
							<#list fieldList as var>
							<#if (var[4]=='1')><th>${var[1]}</th></#if>
							</#list>					
						</tr>
					</thead>
					<tbody>				
						
					</tbody>
				</table>
			</div>
		</div>

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