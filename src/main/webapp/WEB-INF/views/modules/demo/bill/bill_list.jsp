<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/demo/bill" />
<html>
<head>
<title>单据--主子表--列表</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh">
					<i class="fa fa-refresh"></i> 刷新
				</button>
				<button id="yy-btn-search">
					<i class="fa fa-search"></i> 查询
				</button>

				<button class="btn green btn-sm btn-info"
					data-target="#im-uploadfile" id="im-uploadfile-btu"
					data-toggle="modal">
					<i class="fa fa-chevron-down"></i> 导入
				</button>
					
				<button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-approve-x" class="btn yellow btn-sm btn-info">
					<i class="fa fa-check"></i> 审核
				</button>
			</div>
			<div class="row yy-searchbar">
				<div class="col-md-9 form-inline">
					<div id="div_col1_filter" data-column="1">
						文本 <input type="text" class="column_filter form-control input-sm" id="col1_filter">
					</div>
				</div>
				<div class="col-md-3 form-inline dataTables_filter">
					快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list"
						type="search" placeholder="">
				</div>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table-x">

					<thead>
						<tr>
							<th><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" /></th>
							<th>操作</th>
							<th>文本</th>
							<th>数字</th>
							<th>整数</th>
							<th>枚举</th>
							<th>日期</th>
							<th>大文本</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<%@include file="/WEB-INF/views/common/commonscript_approve.jsp"%>
	
	<!-- 导出导入页面 -->
	<%@include file="/WEB-INF/views/common/imexlate_uploadfile.jsp"%>

	<!-- 导出导入功能脚本 -->
	<%@include file="/WEB-INF/views/common/imexscript.jsp"%>
	
	<script type="text/javascript">
	
	//分页页码
	$.fn.dataTable.defaults.aLengthMenu = [ [ 5, 10, 15, 25, 50, 100, -1 ],
			[ 5, 10, 15, 25, 50, 100, '全部' ] ];
		var _tableCols = [ {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "3",
			render : YYDataTableUtils.renderCheckCol
		}, {
			data : "uuid",
			className : "center",
			orderable : false,
			render : YYDataTableUtils.renderActionCol,
			width : "100"
		}, {
			data : 'texts',
			width : "250",
			className : "center",
			orderable : true
		}, {
			data : 'numbers',
			width : "200",
			orderable : true
		}, {
			data : 'integers',
			width : "200",
			orderable : true
		}, {
			data : 'enumerates',
			width : "200",
			orderable : true
		}, {
			data : 'dates',
			width : "240",
			orderable : true
		}, {
			data : 'longtexts',
			width : "500",
			orderable : true
		} ];

		$(document).ready(function() {
			//按钮绑定事件
			bindListActions();
			serverPage(null);
		});
	</script>
</body>
</html>