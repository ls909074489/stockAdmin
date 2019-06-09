<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/session" />
<html>
<head>
<title>评分情况-图表</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">

			<div class="row">
				<table id="yy-table-list" class="yy-table">

					<thead>
						<tr>
							<th>序号</th>
							<th>会话ID</th>
							<th>用户名</th>
							<th>登录名</th>
							<th>登录IP</th>
							<th>最后访问时间</th>
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
					data : null,
					orderable : false,
					className : "center",
					width : "30",
					render : function(data, type, full) {
						return '';
					}
				},
				{
					data : 'ids',
					width : "80",
					className : "center",
					render : function(data, type, full) {
						return YYDataUtils.getEnumName("OrgType", data);
					}
				},
				{
					data : 'org_name',
					width : "160",
					className : "left"
				},
				{
					data : 'scores',
					width : "80",
					className : "right",
					orderable : true
				},
				{
					data : 'scores',
					width : "80",
					className : "right",
					orderable : true
				}];

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

		});

		function loadList(url, isnumber) {
			if (url == null) {
				url = '${serviceurl}/getOnlineUsers';
			}

			$.ajax({
				url : url,
				type : "POST",
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