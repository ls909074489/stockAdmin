<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/message" />
<html>
<head>
<title>审批意见</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
		
			<div class="row">
				<table id="yy-table-list" class="yy-table">

					<thead>
						<tr>
							<th>操作时间</th>
							<th>操作人</th>
							<th>标题</th>
							<th>内容</th>
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
		var _tableCols = [
				{
					data : 'sendtime',
					width : "60",
					className : "center",
					orderable : false
				},
				{
					data : 'creatorname',
					width : "50",
					className : "center",
					orderable : false
				},
				{
					data : 'title',
					width : "60",
					className : "center",
					orderable : true
				}, {
					data : 'content',
					width : "160",
					className : "left",
					orderable : false
				} ];

		//刷新
		function onRefresh(_isServerPage) {
			loadList(null, true); //非服务器分页
		}

		$(document).ready(function() {
			//按钮绑定事件
			bindListActions();
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				//"createdRow" : YYDataTableUtils.setActions,
				"processing" : true,//加载时间长，显示加载中
				"paging" : false,
				//"pageLength" : 50,
				"order" : []
			});
			loadList(null, false); //非服务器分页
		});

		function loadList(url, isnumber) {
			if (url == null) {
				url = '${serviceurl}/dataMessage?msgtype=${msgtype}&billtype=${billtype}&billid=${billid}';
			}

			_queryData = $("#yy-form-query").serializeArray();
			$.ajax({
				url : url,
				type : 'post',
				data : _queryData,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						_tableList.clear();
						_tableList.rows.add(data.records);
						_tableList.draw();
						if (isnumber) {
							_tableList.on('order.dt search.dt', function() {
								_tableList.column(0, {
									search : 'applied',
									order : 'applied'
								}).nodes().each(function(cell, i) {
									cell.innerHTML = i + 1;
								});
							}).draw();
						}
					} else {
						layer.alert(data.msg);
					}
				}
			});
		}
	</script>
</body>
</html>