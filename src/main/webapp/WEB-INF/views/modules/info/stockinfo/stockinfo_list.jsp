<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/stockinfo"/>
<html>
<head>
<title>仓库</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<shiro:hasPermission name="stockinfoAdd">
					<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="stockinfoDel">
					<button id="yy-btn-remove" class="btn red btn-sm">
						<i class="fa fa-trash-o"></i> 删除
					</button>
				</shiro:hasPermission>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_name" class="control-label">仓库编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">仓库名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_name"
						id="search_LIKE_name" class="form-control input-sm">

					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th>
							<th>操作</th>
							<th>仓库编码</th>
							<th>仓库名称</th>
							<th>备注</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>

	<script type="text/javascript">
		_isNumber = true;
		var _tableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "50"
			},{				data : "uuid",
				orderable : false,
				className : "center",
				/* visible : false, */
				width : "20",
				render : YYDataTableUtils.renderCheckCol
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				//render : YYDataTableUtils.renderActionCol,
				render : function(data, type, full) {
					return "<div class='yy-btn-actiongroup'>"
					+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
					+ "<shiro:hasPermission name='stockinfoEdit'><button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button></shiro:hasPermission>"
					+ "<shiro:hasPermission name='stockinfoDel'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></shiro:hasPermission>"
					+ "</div>";
				},
				width : "40"
			},{
				data : "code",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "name",
				width : "160",
				className : "center",
				orderable : false
			},{
				data : "memo",
				width : "200",
				className : "center",
				orderable : false
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/query?orderby=createtime@desc');
		});
	</script>
</body>
</html>	

