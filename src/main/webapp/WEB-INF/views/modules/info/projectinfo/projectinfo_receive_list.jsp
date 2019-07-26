<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
<title>项目</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
				<button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_name" class="control-label">项目号</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">项目名称</label>
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
							<th>单据状态</th>
							<th>收货状态</th>
							<th>项目号</th>
							<th>项目名称</th>
							<th>仓库</th>
							<th>创建人</th>
							<th>创建时间</th>
						</tr>
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
				render : YYDataTableUtils.renderViewEditActionCol,
				width : "60"
			},{
				data : "billstatus",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BillStatus", data);
				},
				orderable : true
			},{
				data : "receiveType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("ReceiveStatus", data);
				},
				orderable : true
			},{
				data : "code",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "name",
				width : "200",
				className : "center",
				orderable : true
			},{
				data : "stock.name",
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
			if (!onEditRowBefore(aData, iDataIndex, nRow)) {
				return;
			}
			if (aData.billstatus > 0 && aData.billstatus != '1'
				&& aData.billstatus != '4') {
				YYUI.promMsg(YYMsg.alertMsg('sys-edit-no'));//已经提交或者审核的数据不能修改。
				return;
			}
			layer.open({
				type : 2,
				title : false,//标题
				shadeClose : false,//是否点击遮罩关闭
				shade : 0.8,//透明度
				closeBtn : 0,//关闭按钮
				area : [ '100%', '100%' ],
				content : '${serviceurl}/onReceiveEdit?uuid=' + aData.uuid + '&' + _editParam, //iframe的url
			});
		}
		//行查看 param data 行数据 param rowidx 行下标
		function onViewDetailRow(data, rowidx, row) {
			layer.open({
				type : 2,
				title : false,//标题
				shadeClose : false,//是否点击遮罩关闭
				shade : 0.8,//透明度
				closeBtn : 0,//关闭按钮
				area : [ '100%', '100%' ],
				content : '${serviceurl}/onReceiveDetail?uuid=' + data.uuid + '&' + _detailParam, //iframe的url
			});
		}
	</script>
</body>
</html>	

