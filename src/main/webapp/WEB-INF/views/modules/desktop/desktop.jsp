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
		<div class="row">
			<div class="col-md-4" style="padding-left: 0px;">
				<!-- BEGIN SAMPLE TABLE PORTLET-->
					<div class="portlet box blue tasks-widget">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-weixin"></i> 系统消息
							</div>
							<div class="tools">
								<a href="" class="reload" onclick="getMessage()"> </a>
							</div>
						</div>
						<div class="portlet-body">
							<div class="task-content">
								<div class="scroller showDivHeightCls" style="height: 600px;" data-always-visible="1" data-rail-visible1="1">
									<!-- START TASK LIST -->
									<ul class="task-list" id="messageList">
										<li style="height: 35px;">
											<div class="task-title">
												<!-- <span class="label label-sm label-success">业务消息</span>&nbsp; -->
												<span class="task-title-sp" style="font-size:14px;" onclick="showMessage('/ver/slaveapprove/slaveCheckList?approveType=1','1513a863-d20c-474f-b6ce-e18f1e2bd208','1','信息点表核查','bd6bd436-e256-4c96-9828-80ebbc2f5bad')">
												<a href="javascript:;" style="color:green;">张三-订购单CS001，请及时处理</a>
												</span>
												<span style="float: right;">2018-06-28 11:21:26</span>
											</div>
										</li>
										<li style="height: 35px;">
											<div class="task-title">
												<!-- <span class="label label-sm label-success">业务消息</span>&nbsp; -->
												<span class="task-title-sp" style="font-size:14px;" onclick="showMessage('/ver/slaveapprove/slaveCheckList?approveType=1','1513a863-d20c-474f-b6ce-e18f1e2bd208','1','信息点表核查','bd6bd436-e256-4c96-9828-80ebbc2f5bad')">
												<a href="javascript:;" style="color:green;">李四-订购单CS002，请及时处理</a>
												</span>
												<span style="float: right;">2018-06-28 11:21:26</span>
											</div>
										</li>
										<li style="height: 35px;">
											<div class="task-title">
												<!-- <span class="label label-sm label-success">业务消息</span>&nbsp; -->
												<span class="task-title-sp" style="font-size:14px;" onclick="showMessage('/ver/slaveapprove/slaveCheckList?approveType=1','1513a863-d20c-474f-b6ce-e18f1e2bd208','1','信息点表核查','bd6bd436-e256-4c96-9828-80ebbc2f5bad')">
												<a href="javascript:;" style="color:green;">王五-订购单CS003，请及时处理</a>
												</span>
												<span style="float: right;">2018-06-28 11:21:26</span>
											</div>
										</li>
								</div>
							</div>
						</div>
					</div>
					<!-- END SAMPLE TABLE PORTLET-->
			</div>
			<div class="col-md-8" style="padding-left: 0px;">
				<div class="portlet box blue tasks-widget">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-bell-o"></i>库存查询
						</div>
						<div class="tools">
							<a href="" class="reload" onclick="searchStock()"> </a>
						</div>
						<div class="actions">
							<div class="btn-group"></div>
						</div>
					</div>
					<div class="portlet-body">
						<div class="task-content">
							<div class="scroller showDivHeightCls" style="height: 600px;" data-always-visible="1" data-rail-visible1="0">
								<div class="page-content" id="yy-page-list">
									<div class="row yy-searchbar form-inline">
										<form id="yy-form-query">
											<label for="search_LIKE_name" class="control-label">仓库名称</label>
											<input type="text" autocomplete="on" name="search_LIKE_stock.name"
												id="search_LIKE_stock.name" class="form-control input-sm">
												
											<label for="search_LIKE_name" class="control-label">物料编码</label>
											<input type="text" autocomplete="on" name="search_LIKE_material.code"
												id="search_LIKE_material.code" class="form-control input-sm">
												
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
													<th>物料名称</th>
													<th>总数量</th>
													<th>预占数量</th>
													<th>剩余数量</th>
												</tr>
											</thead>
											<tbody></tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
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
				data : "occupyAmount",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "surplusAmount",
				width : "100",
				className : "center",
				orderable : true
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataSearch?orderby=createtime@desc');
			
			$(".showDivHeightCls").height((window.screen.availHeight-350));
		});
		
		
		//行查看 param data 行数据 param rowidx 行下标
		function onViewDetailRow(data, rowidx, row) {
			layer.open({
				title:"库存记录",
			    type: 2,
			    area: ['90%', '95%'],
			    shadeClose : false,
				shade : 0.8,
			    content: "${ctx}/info/stockstream/toRecord?stockId="+data.stock.uuid+"&materialId="+data.material.uuid
			});
		}
		
		//刷新库存页面
		function searchStock(){
			$("#rap-searchbar-reset").click();
			onQuery();
		}
	</script>
</body>
</html>	

