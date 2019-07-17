<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/apply"/>
<html>
<head>
<title>申请消息</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<!-- <button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button> -->
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_EQ_billstatus" class="control-label">申请状态</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_applyType" 
						name="search_EQ_applyType" data-enum-group="projectApplyType"></select>

					<label for="search_LIKE_creatorname" class="control-label">创建人</label>	
					<input type="text" autocomplete="on" name="search_LIKE_creatorname"
						id="search_LIKE_creatorname" class="form-control input-sm">
						
					<label class="control-label">创建时间</label> 
					<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 150px;" id="search_GTE_createtime" class="form-control input-sm Wdate"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});">
					
					<label class="control-label">&nbsp;&nbsp;&nbsp;&nbsp;到&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label> 
					 <input type="text" autocomplete="on" name="search_LTE_createtime" style="width: 150px;" id="search_LTE_createtime"
				class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',minDate:'#F{$dp.$D(\'search_GTE_createtime\')}'});">	
						
						

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
							<th>申请状态</th>
							<th>源单号</th>
							<th>申请内容</th>
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
				render : YYDataTableUtils.renderActionCol,
				width : "50"
			},{
				data : "applyType",
				width : "80",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("projectApplyType", data);
				},
				orderable : true
			},{
				data : "sourceBillCode",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "content",
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
			serverPage(null);
		});
	</script>
</body>
</html>	

