<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/stockstream"/>
<html>
<head>
<title>库存明细</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_EQ_operType" class="control-label">单据类型</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_operType" name="search_EQ_operType"
					 data-enum-group="StockStreamOperType"></select>	
					
					<label for="search_LIKE_sourceBillCode" class="control-label">源单号</label>
					<input type="text" autocomplete="on" name="search_LIKE_sourceBillCode"
						id="search_LIKE_sourceBillCode" class="form-control input-sm">
						
					<label for="search_LIKE_creatorname" class="control-label">操作人</label>	
					<input type="text" autocomplete="on" name="search_LIKE_creatorname"
						id="search_LIKE_creatorname" class="form-control input-sm">
						
					<label class="control-label">操作时间</label> 
					<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 150px;" id="search_GTE_createtime" 
						class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});">
					 到 
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
							<th>源单号</th>
							<th>操作人</th>
							<th>操作时间</th>
							<th>单据类型</th>
							<th>总数量</th>
							<th>剩余数量</th>
							<th>预占数量</th>
							<th>可用数量</th>
							<th>预警时间</th>
							<th>备注</th>
							<!-- <th>预警状态</th> -->
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
				data : "sourceBillCode",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "creatorname",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "createtime",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "operType",
				width : "100",
				className : "center",
				render : function(data, type, full) {
				       return YYDataUtils.getEnumName("StockStreamOperType", data);
				},
				orderable : false
			},{
				data : "totalAmount",
				width : "60",
				className : "center",
				orderable : false
			},{
				data : "surplusAmount",
				width : "60",
				className : "center",
				orderable : false
			},{
				data : "occupyAmount",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "actualAmount",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "warningTime",
				width : "60",
				className : "center",
				orderable : false
			},{
				data : "memo",
				width : "100",
				className : "center",
				orderable : false
			}/* ,{
				data : "warningType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					   return YYDataUtils.getEnumName("StockStreamWarningType", data);
				},
				orderable : false
			} */];
		
		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			loadEnumData();
			
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataSubRecord?subId=${subId}&orderby=createtime@desc');
		});
		
		
		/**
		 * 加载枚举数据到本地缓存中 xuechen
		 */
		function loadEnumData() {
			var url = '${ctx}/sys/enumdata/getEnumDataMap';
			$.ajax({
				"dataType" : "json",
				"url" : url,
				"success" : function(data) {
					if (data.success) {
						var map = data.records[0];
						localStorage.setItem("yy-enum-map", JSON.stringify(map));
						YYUI.setEnumField();
					} else {
						//YYUI.failMsg("加载枚举数据失败" + data.msg);
					}
				}
			});
		}
		
		function onEditRow(aData, iDataIndex, nRow) {
			//console.info(11111111);
			return false;
		}
	</script>
</body>
</html>	

