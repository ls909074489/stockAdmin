<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/receive"/>
<html>
<head>
<title>收货记录</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar form-inline hide" style="display: none;">
				<form id="yy-form-query">
					<input type="hidden" name="search_EQ_sub.uuid" id="search_EQ_sub.uuid" value="${subId}" class="form-control input-sm">
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<th>收货类型</th>
							<th>收货数量</th>
							<th>收货时间</th>
							<th>备注</th>
							<th>创建人</th>
							<th>创建时间</th>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<%@include file="/WEB-INF/views/common/commonscript_approve.jsp"%>

	<script type="text/javascript">
		_isNumber = true;
		var _tableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "50"
			},{
				data : "receiveType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("ReceiveType", data);
				},
				orderable : true
			},{
				data : "receiveAmount",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "receiveTime",
				width : "200",
				className : "center",
				orderable : true
			},{
				data : "memo",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "creatorname",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "createtime",
				width : "100",
				className : "center",
				orderable : true
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/query?orderby=createtime@desc');
		});
		
		
		//行修改   param data 行数据  param rowidx 行下标
		function onEditRow(aData, iDataIndex, nRow) {
			return false;
		}
	</script>
</body>
</html>	

