<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/mappingTable"/>
<c:set var="servicesuburl" value="${ctx}/info/mappingTableSub"/>
<html>
<head>
<title>标准映射表</title>
</head>
<body>
	<div id="yy-page-detail" class="container-fluid page-container page-content">
	
		<div class="row yy-toolbar">
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 返回
			</button>
		</div>
		<div class="hide">
		</div>
		<div>
			<form id="yy-form-detail" class="form-horizontal yy-form-detail">
					<input name="uuid" id="uuid" type="hidden"/>
					<div class="row">
							<div class="col-md-8">
								<div class="form-group">
									<label class="control-label col-md-2">名称</label>
									<div class="col-md-10"><input class="form-control"  id="name" name="name"  type="text"></div>
								</div>
							</div>	
							<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">厂站</label>
								<div class="col-md-8">
										<input id="stationUuid" name="station.uuid" type="hidden" value="${entity.station.uuid}"> 
										<input id="stationName" name="stationName" type="text" class="form-control" readonly="readonly" 
												value="${entity.station.name}">
								</div>
							</div>
				</div>
					</div>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">映射关系
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<table id="yy-table-sublist" class="yy-table-x">
						<thead>
							<tr>
								<!-- <th class="table-checkbox"><input type="checkbox"
									class="group-checkable" data-set="#yy-table-sublist .checkboxes" /></th> -->
								<th>序号</th>	
								<th>键</th>
								<th>值</th>
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
	var _addList = new Array(); //新增的行/修改的行
	var _deletePKs = new Array();//需要删除的PK数组
	var _columnNum;
	/* 子表操作 */
	var _subTableCols = [{
		data : null,
		orderable : false,
		className : "center",
		width : "30"
	}, {
		data : "mapkey",
		orderable : false,
		className : "center",
		width : "80"
	}, {
		data : "mapval",
		orderable : false,
		className : "center",
		width : "80"
	}];
	

	$(document).ready(function() {
		bindDetailActions();//綁定平台按鈕
		
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false/* ,
			"order" : [[5,"asc"]] */
		});
		
		setValue();
		
		$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
		$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
		
		YYFormUtils.lockForm("yy-form-detail");
	});
	
	//设置默认值
	function setValue(){
		$("input[name='uuid']").val('${entity.uuid}');
		$("input[name='search_EQ_main.uuid']").val('${entity.uuid}');//子表查询时，主表id	
		$("input[name='mainId']").val('${entity.uuid}');//子表查询时，主表id	
		$("input[name='name']").val('${entity.name}');
		loadSubList('${entity.uuid}');
	}
	
	
	
	//刷新子表
	function onRefreshSub() {
		_subTableList.draw(); //服务器分页
	}
	//重置子表查询条件
	function onResetSub() {
		YYFormUtils.clearForm("yy-form-subquery");
		return false;
	}
	
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		var loadSubWaitLoad=layer.load(2);
		$.ajax({
			url : '${servicesuburl}/query',
			data : {
				"search_EQ_main.uuid" : mainTableId
			},
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
	}
	
</script>
</body>
</html>