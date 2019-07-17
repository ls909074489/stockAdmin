<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/orderinfo"/>
<c:set var="servicesuburl" value="${ctx}/info/orderinfoSub"/>
<html>
<head>
<title>订单</title>
</head>
<body>
<div id="yy-page-detail" class="container-fluid page-container page-content">
		<div class="row yy-toolbar">
				<button id="yy-btn-backtolist" class="btn blue btn-sm">
					<i class="fa fa-rotate-left"></i> 返回
				</button>
		</div>
		<div>
			<form id="yy-form-detail" class="form-horizontal yy-form-detail">
				<input name="uuid" id="uuid" type="hidden" value="${entity.uuid}"/>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >订单编码</label>
							<div class="col-md-8" >
								<input name="code" id="code" type="text" value="${entity.code}" class="form-control">
							</div>
						</div>
					</div>
					<%-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >订单名称</label>
							<div class="col-md-8" >
								<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
							</div>
						</div>
					</div> --%>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">仓库</label>
							<div class="col-md-8">
								<input id="stockUuid" name="stock.uuid" type="hidden" value="${entity.stock.uuid}"> 
								<input id="stockName" name="stockName" type="text" class="form-control" readonly="readonly" 
									value="${entity.stock.name}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >订单类型</label>
							<div class="col-md-8" >
								<select name="orderType" id="orderType" data-enum-group="OrderType" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div>
					<%-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >预计到货时间</label>
							<div class="col-md-8" >
								<input name="planArriveTime" id="planArriveTime" type="text" value="${entity.planArriveTime}" class="Wdate form-control" onclick="WdatePicker();">
							</div>
						</div>
					</div> --%>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">供应商</label>
							<div class="col-md-8">
								<div class="input-group input-icon right">
										<input id="supplierUuid" name="supplier.uuid" type="hidden" value="${entity.supplier.uuid}"> 
										<i class="fa fa-remove" onclick="cleanDef('supplierUuid','supplierName');" title="清空"></i>
										<input id="supplierName" name="supplierName" type="text" class="form-control" readonly="readonly" 
											value="${entity.supplier.name}">
										<span class="input-group-btn">
											<button id="supplier-select-btn" class="btn btn-default btn-ref" type="button">
												<span class="glyphicon glyphicon-search"></span>
											</button>
										</span>
									</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >备注</label>
							<div class="col-md-10" >
								<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">列表
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<div class="row yy-toolbar">
						<div role="form" class="form-inline" style="">
							<form id="yy-form-subquery">	
								<input type="hidden" name="search_EQ_main.uuid" id="mainId" value="${entity.uuid}">	
								&nbsp;&nbsp;	
								<label for="search_LIKE_material.code" class="control-label">物料编码</label>
								<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_material.code" class="form-control input-sm">
								
								<label for="search_LIKE_material.name" class="control-label">物料名称</label>
								<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm">
								
								<button id="yy-btn-searchSub" type="button" class="btn btn-sm btn-info">
									<i class="fa fa-search"></i>查询
								</button>
								<button id="rap-searchbar-resetSub" type="reset" class="red">
									<i class="fa fa-undo"></i> 清空
								</button>	
							</form>
						</div>
					</div>
					<table id="yy-table-sublist" class="yy-table">
						<thead>
							<tr>
								<th>序号</th>	
								<th>物料编码</th>	
								<th>物料名称</th>	
								<th>计划数量</th>
								<th>预警时间</th>		
								<th>备注</th>	
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/detailscript.jsp"%>
	
	
	<script type="text/javascript">
		var _subTableList;//子表
		var _deletePKs = new Array();//需要删除的PK数组
		var _columnNum;
		
		
		/* 子表操作 */
		var _subTableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "50"
			}, {
				data : 'material.code',
				width : "80",
				className : "center",
				orderable : true
			}, {
				data : 'material.name',
				width : "80",
				className : "center",
				orderable : true,
				render : function(data, type, full) {
					return '<span class="materialNameInputCls">'+data+'</span>';
				}
			}, {
				data : 'planAmount',
				width : "80",
				className : "center",
				orderable : true
			}, {
				data : 'warningTime',
				width : "80",
				className : "center",
				orderable : true
			}, {
				data : 'memo',
				width : "160",
				className : "center",
				orderable : true
			}];

		 
		$(document).ready(function() {
			bindDetailActions();//綁定平台按鈕
			
			_subTableList = $('#yy-table-sublist').DataTable({
				"columns" : _subTableCols,
				"paging" : false//,
				//"order" : [[5,"asc"]]
			});
			
			setValue();
			
			$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
			$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
			
			YYFormUtils.lockForm("yy-form-detail");
		});
		

		//设置默认值
		function setValue(){
			if('${openstate}'=='add'){
				//$("input[name='billdate']").val('${billdate}');
			}else if('${openstate}'=='detail'){
				$("#orderType").val('${entity.orderType}');
				loadSubList();
			}
		}
		
		//刷新子表
		function onRefreshSub() {
			//_subTableList.draw(); //服务器分页
			loadSubList();
		}
		//重置子表查询条件
		function onResetSub() {
			YYFormUtils.clearForm("yy-form-subquery");
			return false;
		}
		
		//加载从表数据
		function loadSubList() {
			var loadSubWaitLoad=layer.load(2);
			$.ajax({
				url : '${servicesuburl}/query',
				data : $("#yy-form-subquery").serializeArray(),//{"search_EQ_main.uuid" : "${entity.uuid}"},
				dataType : 'json',
				type : 'post',
				async : false,
				success : function(data) {
					layer.close(loadSubWaitLoad);
					_subTableList.clear();
					_subTableList.rows.add(data.records);
					_subTableList.on('order.dt search.dt',
					        function() {
						_subTableList.column(0, {
							        search: 'applied',
							        order: 'applied'
						        }).nodes().each(function(cell, i) {
							        cell.innerHTML = i + 1;
						        });
					}).draw();
				}
			});
			
			/* _subTableList = $('#yy-table-sublist').DataTable({
				"columns" : _subTableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order" : [],//_setOrder  edit by liusheng
				"processing" : true,
				"retrieve": true,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				"paging" : false,
				"fnDrawCallback" : fnDrawSubCallback,
				"ajax" : {
					"url" : '${servicesuburl}/query',
					"type" : 'POST',
					"data" : function(d) {
						d.orderby = getOrderbyParam(d);
						var _subqueryData = $("#yy-form-subquery").serializeArray();
						if (_subqueryData == null)
							return;
						$.each(_subqueryData, function(index) {
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
			}); */
		}
		
		function fnDrawSubCallback(){
			var pageLength = $('select[name="yy-table-list_length"]').val() || 10;
			_columnNum = _columnNum || 0;
			_subTableList.column(_columnNum).nodes().each(function(cell, i) {
				cell.innerHTML = i + 1+(_pageNumber)*pageLength;
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
			return "uuid@desc";
		}
	</script>
</body>
</html>
