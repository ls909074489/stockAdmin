<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/course" />
<html>
<head>
</head>
<body>
	<div class="" id="yy-page-list" style="background-color: #ffffff;">
		<div role="form" class="row yy-toolbar">
			<form id="yy-form-query">
				<div class="col-sm-4 form-inline" style="">
					<div id="div_col6_filter" data-column="6">
						关键字<input type="text" id="searchKey" name="searchKey" class="form-control input-sm">
					</div>
				</div>
				<div class="col-sm-4 form-inline" style="">
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
					<i class="fa fa-search"></i>查询</button>
					<button id="yy-btn-clear" type="button" class="btn red btn-sm btn-info">
					<i class="fa fa-trash-o"></i>清空</button>
				</div>
			</form>
		</div>
		<div class="row">
			<table id="yy-table-list" class="yy-table">
				<thead>
					<tr>
						<th>序号</th>
						<th>操作</th>
						<th>客户姓名</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common/yy-map.jsp"%>
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	
	<script type="text/javascript">
		var _isNumber=true;
		var _tableList, _queryData,_bottomTableList;
		var _tableCols = [{
			data : "customer",
			orderable : false,
			width : "20",
			className : "center"
		},{
			data : "",
			orderable : false,
			className : "center",
			width : "20",
			render : YYDataTableUtils.renderSelectActionSubCol
		},{
			data : 'customer',
			width : "90%",
			orderable : true
		}];

	$(document).ready(function() {
		_queryData = $("#yy-form-query").serializeArray();
		
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"order" : [],
			"processing" : true,
			"searching" : false,
			"serverSide" : true,
			"showRowNumber" : true,
			"createdRow" : renderRowAction,
		    "pagingType" : "bootstrap_full_number",
			"paging" : true,
			"fnDrawCallback" : fnDrawCallback,
			"ajax" : {
				"url" : '${apiurl}/stuff/listCustomer',
				"type" : 'POST',
				xhrFields: {withCredentials: true},
		        crossDomain: true,
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
					json.recordsFiltered=json.total;
					json.recordsTotal=json.total;
					json.total=json.total;
					//json.totalPages=1;
					json.pageNumber=json.page;
					_pageNumber = json.pageNumber-1;
					if(json.flag==0){
						return json.obj == null ? [] : json.obj;
					}else if (json.flag==-10) {
						YYUI.promMsg('会话超时，请重新的登录!');
						window.location = '${ctx}/logout';
						return [];
					}else{
						return json.obj == null ? [] : json.obj;
					}
				}
			}
		});
		
		
		bindButtonActions();
		
	});
	
	
	
	
	//绑定按钮事件
	function bindButtonActions() {
		$("#yy-btn-search").bind('click', onQuery);
		$("#yy-btn-clear").bind('click', resetSearchForm);
	}
	
	//清楚搜索数据
	function resetSearchForm() {
		$('#yy-form-query')[0].reset();
	}
	
	function getSelectValue(otableId) {
		var aDatas = new Array();
		_table = $("#yy-table-bottom-list").dataTable();
		var rows = _table.fnGetNodes();
		for (var i = 0; i < rows.length; i++) {
			var aData = _table.fnGetData(rows[i]);
			aDatas.push(aData);
		}
		return aDatas;
	};
	
	
	renderRowAction = function(nRow, aData, iDataIndex) {
		$(nRow).dblclick(function() {
			onSelect(aData, iDataIndex, nRow);
		});
		$(nRow).on('click', '.btn-success', function(e) {
			onSelect(aData, iDataIndex, nRow);
		});
	}
	
	
	
	function onSelect(aData, iDataIndex, nRow){
		window.parent.callBackSelectCustomer(aData);
		
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	 }
	
</script>
	
</body>

</html>
