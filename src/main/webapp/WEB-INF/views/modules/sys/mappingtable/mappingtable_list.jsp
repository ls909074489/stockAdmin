<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/mappingTable"/>
<html>
<head>
<title>标准映射表</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">

					<label for="search_LIKE_name" class="control-label">名称</label>
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
							<!-- <th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th> -->
							<th>操作</th>
							<th>名称</th>
							<th>最后提交时间</th>
							<th>新建时间</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>

	<c:choose>
		<c:when test="${hasSelStation eq 0}">
			<script type="text/javascript">
				layer.open({
					title:"请选择",
				    type: 2,
				    area: ['500px', '250px'],
				    shadeClose : false,
					shade : 0.8,
					closeBtn : 0,
				    content: '${ctx}/sys/org/toChangeStation'
				});
			</script>
		</c:when>
	</c:choose>
	
	<script type="text/javascript">
		//回到选择当前的厂商纷纷
		function callSelectSessionStation(data){
			onRefresh();
		}
		
		_isNumber = true;
		var _tableCols = [ {
							data : null,
							orderable : false,
							className : "center",
							width : "50"
						}/* ,{
							data : "uuid",
							orderable : false,
							className : "center",
							width : "40",
							render : YYDataTableUtils.renderCheckCol
						} */,{
							data : "uuid",
							className : "center",
							orderable : false,
							render : YYDataTableUtils.renderActionCol,
							width : "50"
						},{
							data : "name",
							width : "50%",
							className : "center",
							orderable : true
						},{
							data : "ts",
							width : "30%",
							className : "center",
							orderable : true
						},{
							data : "createtime",
							width : "30%",
							className : "center",
							visible: false,
							orderable : true
						}];


		var _setOrder = [[4,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage(null);
		});
		
		//重写删除校验
		function checkDelete(pks){
			return true;
		}
	</script>
</body>
</html>	

