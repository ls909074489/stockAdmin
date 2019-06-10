<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%> --%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/codeTemplate"/>
<html>
<head>
<title>代码生成</title>
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
				<div class="col-md-3 form-inline">
					<div id="div_col2_filter" data-column="2">
						模板类型 <input type="text" name="templateType" class="column_filter form-control input-sm" id="col2_filter">
					</div>			
				</div>
				<div class="col-md-3 form-inline">
					<div id="div_col3_filter" data-column="3">
						java文件路径 <input type="text" name="javaWorkspace" class="column_filter form-control input-sm" id="col3_filter">
					</div>			
				</div>
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
							<th>模板类型</th>
							<th>java文件路径</th>
							<th>包路径</th>
							<th>页面保存位置</th>
							<th>访问根地址</th>
							<th>页面路径</th>
							<th>表名注释</th>
							<th>数据库表名</th>
							<th>实体名称</th>
							<th>实体父类</th>
							<th>模板名称</th>
						</tr>
					</thead>
					<tbody>				
						
					</tbody>
				</table>
			</div>
		</div>

		<!-- 编辑页面 -->
		<%@include file="codetemplate_edit.jsp"%>
		
		<!-- 明细页面 -->
		<%@include file="codetemplate_detail.jsp"%>
		
		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<%@include file="codetemplate_script.jsp"%>

	</div>
</body>
</html>