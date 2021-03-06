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
			<div class="col-md-3" style="padding-left: 0px;">
				<!-- BEGIN SAMPLE TABLE PORTLET-->
					<div class="portlet box blue tasks-widget">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-weixin"></i> 系统消息
							</div>
							<div class="tools">
								<a href="" class="reload" onclick="loadApply()"> </a>
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
												<span class="task-title-sp" style="font-size:14px;" onclick="">
												<a href="javascript:;" style="color:green;">业务消息提示</a>
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
			<div class="col-md-9" style="padding-left: 0px;">
				<div class="portlet box blue tasks-widget">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-bell-o"></i>预警物料
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
																	
											<label for="search_LIKE_sourceBillCode" class="control-label">源单号</label>
											<input type="text" autocomplete="on" name="search_LIKE_sourceBillCode"
												id="search_LIKE_sourceBillCode" class="form-control input-sm">
											
											<div style="height: 5px;"></div>	
											<label for="search_LIKE_creatorname" class="control-label">操作人&nbsp;&nbsp;&nbsp;&nbsp;</label>	
											<input type="text" autocomplete="on" name="search_LIKE_creatorname"
												id="search_LIKE_creatorname" class="form-control input-sm">
												
											<!-- <label class="control-label">操作时间</label> 
											<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 150px;" id="search_GTE_createtime" class="form-control input-sm Wdate"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});">
											
											<label class="control-label">&nbsp;&nbsp;&nbsp;&nbsp;到&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label> 
											<input type="text" autocomplete="on" name="search_LTE_createtime" style="width: 150px;" id="search_LTE_createtime"
											class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',minDate:'#F{$dp.$D(\'search_GTE_createtime\')}'});">	 -->
											
											
											<label class="control-label">入库时间</label> 
											<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 90px;" id="search_GTE_createtime" 
												class="form-control input-sm Wdate" onclick="WdatePicker();">
							
											<label class="control-label">预警时间</label> 
											<input type="text" autocomplete="on" name="search_LTE_warningTime" style="width: 90px;" id="search_LTE_warningTime" 
												class="form-control input-sm Wdate" onclick="WdatePicker();">
											
											<label class="control-label">状态</label> 
											<select class="yy-input-enumdata form-control" id="GT_surplusAmount" name="GT_surplusAmount">
												<option value="">请选择</option>
												<option value="1">在库</option>
												<option value="0">已出库</option>
											</select>
											
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
													<th>仓库名称</th>
													<th>物料编码</th>
													<th>华为物料编码</th>
													<th>物料名称</th>
													<th>源单号</th>
													<th>操作人</th>
													<th>操作时间</th>
													<!-- <th>单据类型</th> -->
													<!-- <th>总数量</th> -->
													<th>剩余数量</th>
													<th>预占数量</th>
													<th>可用数量</th>
													<th>预警时间</th>
													<th>状态</th>
													<!-- <th>预警状态</th> -->
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
			data : "stock.name",
			width : "100",
			className : "center",
			orderable : false
		},{
			data : "material.code",
			width : "100",
			className : "center",
			orderable : false
		},{
			data : "material.hwcode",
			width : "100",
			className : "center",
			orderable : false
		},{
			data : "material.name",
			width : "100",
			className : "center",
			orderable : false
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
		}/* ,{
			data : "operType",
			width : "100",
			className : "center",
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("StockSteamOperType", data);
			},
			orderable : false
		} ,{
			data : "totalAmount",
			width : "60",
			className : "center",
			orderable : false
		}*/,{
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
		},{
			data : "surplusAmount",
			width : "50",
			className : "center",
			render : function(data, type, full) {
			     if(data>0){
			    	 return "在库";
			     }else{
			    	 return "已出库";
			     }
			},
			orderable : false
		}];
		

		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			$("#GT_surplusAmount").val(1);
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${ctx}/info/stockstream/dataWarning?orderby=createtime@desc');
			
			$(".showDivHeightCls").height((window.screen.availHeight-350));
			
			loadApply();
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
		
		function loadApply(){
			$.ajax({
				"dataType" : "json",
				"data":{
					"start": 0,
					"length": 10,
					"search_IN_applyType": "1,2",
					"orderby": "createtime@desc"
				},
				"type" : "POST",
				"url" : "${ctx}/info/apply/query",
				"async" : false,
				"success" : function(data) {
					if (data.success) {
						var records = data.records;
						var str="";
						for(var i=0;i<records.length;i++){
							str+='<li style="height: 35px;">'+
									'<div class="task-title">'+
										'<span class="task-title-sp" style="font-size:14px;" onclick="showApplyBill(\''+records[i].sourceBillId+'\');">'+
										'<a href="javascript:;" style="color:green;">'+records[i].creatorname+"  "+records[i].content+'</a>'+
										'</span>'+
										'<span style="float: right;">'+records[i].createtime+'</span>'+
									'</div>'+
								'</li>';
						}
						$("#messageList").html(str);
					} else {
						//YYUI.promAlert("获取失败，原因：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					//YYUI.promAlert("HTTP错误。");
				}
			});
		}
		
		function showApplyBill(sid){
			layer.open({
				title:"项目单",
			    type: 2,
			    area: ['96%', '95%'],
			    shadeClose : false,
				shade : 0.8,
			    content: "${ctx}/info/projectinfoSub/detailList?sourceBillId="+sid
			});
		}
	</script>
</body>
</html>	

