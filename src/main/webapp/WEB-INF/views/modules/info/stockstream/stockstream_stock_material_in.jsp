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
					<!-- <label for="search_EQ_operType" class="control-label">单据类型</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_operType" name="search_EQ_operType"
					 data-enum-group="StockStreamOperType"></select> -->	
					
					
					<input name="stockId" id="stockId" type="hidden" value="${stockId}"/>
					<input name="materialId" id="materialId" type="hidden" value="${materialId}"/>
					<input name="projectId" id="projectId" type="hidden" value="${projectId}"/>
					
					<label for="search_LIKE_sourceBillCode" class="control-label">源单号</label>
					<input type="text" autocomplete="on" name="search_LIKE_sourceBillCode"
						id="search_LIKE_sourceBillCode" class="form-control input-sm">
						
					<label for="search_LIKE_creatorname" class="control-label">操作人</label>	
					<input type="text" autocomplete="on" name="search_LIKE_creatorname"
						id="search_LIKE_creatorname" class="form-control input-sm">
						
					<label class="control-label">操作时间</label> 
					<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 150px;" id="search_GTE_createtime" class="form-control input-sm Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});">
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
							<th>操作</th>
							<th>挪用数量</th>
							<th>源单号</th>
							<th>操作人</th>
							<th>操作时间</th>
							<th>单据类型</th>
							<th>总数量</th>
							<th>剩余数量</th>
							<th>预占数量</th>
							<th>可用数量</th>
							<th>预警时间</th>
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
				orderable : false,
				className : "center",
				width : "20",
				render : function(data, type, full) {
					return "<div class='yy-btn-actiongroup'>"
					+ "<button  onclick=\"saveBorrow(this);\" rowUuid=\'"+data+"\' class='btn btn-xs btn-info saveBcBtn' data-rel='tooltip' title='挪料'><i class='fa yy-btn-save'></i>挪料</button>"
					+ "</div>";
				}
			}, {
				data : 'uuid',
				width : "60",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					return '<input class="form-control" value="" name="actualAmount">';
				}
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
				width : "60",
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
				width : "60",
				className : "center",
				orderable : false
			},{
				data : "actualAmount",
				width : "60",
				className : "center",
				orderable : false
			},{
				data : "warningTime",
				width : "60",
				className : "center",
				orderable : false
			}];
		
		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataStockMaterialIn?orderby=createtime@desc');
		});
		
		
		function saveBorrow(t){
			var actualAmount = $(t).closest("tr").find("input[name='actualAmount']").val();
			if(actualAmount!=null&&actualAmount!=''){
				if ((/(^[1-9]\d*$)/.test(actualAmount))) { 
					$.ajax({
						type : "POST",
						data :{"fromStreamId": $(t).attr("rowUuid"),"toSubId":'${subId}',"actualAmount":actualAmount},
						url : "${serviceurl}/saveProjectBorrow",
						async : true,
						dataType : "json",
						success : function(data) {
							if(data.success){
								YYUI.succMsg(data.msg);
								window.parent.onQuery();
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭 
							}else{
								YYUI.promMsg(data.msg);
							}
						},
						error : function(data) {
							YYUI.promMsg("操作失败，请联系管理员");
						}
					});
				}else{
					YYUI.promMsg("请填写正整数");
				}
			}else{
				YYUI.promMsg("请填写挪用数量");
			}
		}
		
		function onEditRow(aData, iDataIndex, nRow) {
			return false;
		}
	</script>
</body>
</html>	

