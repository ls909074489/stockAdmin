<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/job/log" />
<html>
<head>
<title>后台任务执行情况</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<div class="row yy-searchbar">
			<form id="yy-form-query">
				<div class="row hide">
					<div class="col-md-3 form-inline">
						<div id="" data-column="2">
							未读消息 <input type="text" class="form-control input-sm" id="search_EQ_jobname" name="search_EQ_jobname"
								value="${jobname}">
						</div>
					</div>
				</div>
			</form>
		</div>

		<div class="page-content" id="yy-page-list">
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th>序号</th>
							<th>任务名称</th>
							<th>任务实例ID</th>
							<th>开始执行时间</th>
							<th>结束执行时间</th>
							<th>耗时(秒)</th>
							<th>状态</th>
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
	<script type="text/javascript">
		var _tableCols = [ {
			data : null,
			orderable : false,
			className : "center",
			width : "20",
			render : function(data, type, full) {
				return "";
			}
		}, {
			data : 'jobname',
			width : "80",
			className : "center",
			orderable : false
		}, {
			data : 'jobid',
			width : "60",
			className : "center",
			orderable : false
		}, {
			data : 'begintime',
			width : "60",
			className : "center",
			orderable : true
		}, {
			data : 'endtime',
			width : "60",
			className : "center",
			orderable : true
		}, {
			data : 'costtime',
			width : "50",
			className : "center",
			orderable : true
		}, {
			data : 'jobstatus',
			width : "40",
			className : "center",
			orderable : true
		} ];

		//刷新
		function onRefresh() {
			_tableList.draw(); //服务器分页
		}

		//绑定按钮事件
		function bindButtonActions() {
		}

		/**
		 * 添加行操作事件
		 */
		YYDataTableUtils.setActions = function(nRow, aData, iDataIndex) {
			$(nRow).dblclick(function() {
				//onViewDetailRow(aData, iDataIndex, nRow);
			});
		};

		$(document).ready(function() {
			//按钮绑定事件
			bindButtonActions();
			//服务器分页
			serverPage(null);
		});

		var _isNumber = true;
		
		//服务器分页
		function serverPage(url) {
			doBeforeServerPage();
			if (url == null) {
				url = '${serviceurl}/query';
			}
			_queryData = $("#yy-form-query").serializeArray();
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order" : [],
				"processing" : true,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				"pageLength" : 10,
				"paging" : true,
				
				"fnDrawCallback" : fnDrawCallback,
				"ajax" : {
					"url" : url,
					"type" : 'POST',
					"data" : function(d) {
						d.orderby = getOrderbyParam(d);
						if (_queryData == null)
							return;
						$.each(_queryData, function(index) {
							if (this['value'] == null || this['value'] == "")
								return;
							d[this['name']] = this['value'];
						});
					},
					"dataSrc" : function(json) {
						_pageNumber = json.pageNumber;
						return json.records == null ? [] : json.records;
					}
				}
			});
		}

		//服务器分页，排序
		function getOrderbyParam(d) {
			var orderby = d.order[0];
			if (orderby != null && null != _tableCols) {
				var dir = orderby.dir;
				var orderName = _tableCols[orderby.column].data;
				return orderName + "@" + dir;
			}
			return "ts@desc";
		}
	</script>
</body>
</html>