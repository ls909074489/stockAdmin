<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/stockdetail"/>
<html>
<head>
<title>库存明细</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<!-- <div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div> -->
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_name" class="control-label">仓库名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_stock.name"
						id="search_LIKE_stock.name" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">物料编码</label>
					<input type="text" search_LIKE_material.code="on" name="search_LIKE_material.code"
						id="search_LIKE_material.code" class="form-control input-sm">
						
					<label for="search_LIKE_material.hwcode" class="control-label">华为物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.hwcode"
						id="search_LIKE_material.hwcode" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">物料名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.name"
						id="search_LIKE_material.name" class="form-control input-sm">

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
							<th>操作</th>
							<th>仓库名称</th>
							<th>物料编码</th>
							<th>华为物料编码</th>
							<th>物料名称</th>
							<th>总数量</th>
							<th>剩余数量</th>
							<th>预占数量</th>
							<th>可用数量</th>
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
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				render: function (data,type,row,meta ) {
					return "<div class='yy-btn-actiongroup'>" 
					+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i>查看记录</button>"
					+ "</div>";
		        },
				width : "50"
			},{
				data : "stock.name",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "material.code",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "material.hwcode",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "material.name",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "totalAmount",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "surplusAmount",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "occupyAmount",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "actualAmount",
				width : "100",
				className : "center",
				orderable : true
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage(null);
		});
		
		
		//行查看 param data 行数据 param rowidx 行下标
		function onViewDetailRow(data, rowidx, row) {
			console.info(data.stock.uuid+"========="+data.material.uuid);
			layer.open({
				title:"库存记录(【"+data.stock.name+"】物料"+data.material.code+")",
			    type: 2,
			    area: ['90%', '95%'],
			    shadeClose : false,
				shade : 0.8,
			    content: "${ctx}/info/stockstream/toRecord?stockId="+data.stock.uuid+"&materialId="+data.material.uuid
			});
		}
		
		//重写防止双击
		function onEditRow(aData, iDataIndex, nRow){
			return false;
		}
	</script>
</body>
</html>	

