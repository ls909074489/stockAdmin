<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/sample"/>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/css/fix_top.css?v=2"/>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<!-- <button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button> -->
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
				<button id="yy-btn-set-price" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 设置报价
				</button>
				<button id="yy-btn-accept-price" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 同意报价
				</button>
				<button id="yy-btn-set-plantime" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 预计送样日期
				</button>
				<button id="yy-btn-set-sendinfo" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 设置送样
				</button>
				<button id="yy-btn-accept-recog" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 确认承认书
				</button>
				<button id="yy-btn-feedback" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 客户反馈
				</button>
				<button id="yy-btn-setFinalPrice" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 修改最终报价
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<!-- <label for="search_EQ_sampleType" class="control-label">通道类型</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_sampleType" 
						name="search_EQ_sampleType" data-enum-group="sampleType"></select>
						
					<label for="search_LIKE_paramtername" class="control-label">名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_name"
						id="search_LIKEname" class="form-control input-sm"> -->
						
					<label for="search_LIKE_paramtername" class="control-label">客户名或型号</label>
					<input type="text" autocomplete="on" name="searchKey"
						id="searchKey" class="form-control input-sm">	
						
					<label class="control-label">时间</label> 
					<input type="text" autocomplete="on" name="startDate" style="width: 150px;"
					id="startDate" class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'});"> 
					到 
					<input type="text" autocomplete="on" name="endDate" style="width: 150px;"
					id="endDate" class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'});">
					
					<label for="search_EQ_sampleType" class="control-label">完成状态</label>
					<select class="form-control" id="finishType" name="finishType">
						<option value=""></option>
						<option value="0">全部</option>
						<option value="1">已完成</option>
						<option value="2">未完成</option>
					</select>
						
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
					<button id="yy-btn-export" type="button" class="btn green btn-sm btn-info">
						<i class="fa fa-chevron-up"></i> 导出
					</button>
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table" style="table-layout: fixed; width: 100%!important;">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th>
							<th>操作</th>
							<th>创建者</th>
							<th>客户名称</th>
							<th>样品料号</th>
							<th>样品型号</th>
							<th>索样数量</th>
							<th>价格</th>
							<th>送样时间</th>
							<th>承认书状态</th>
							<th>完成状态</th>
							<th>客户反馈</th>
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
		var _tableCols = [ {
							data : null,
							orderable : false,
							className : "center",
							width : "20"
						},{
							data : "uuid",
							orderable : false,
							className : "center",
							/* visible : false, */
							width : "30",
							render : YYDataTableUtils.renderCheckCol
						},{
							data : "uuid",
							className : "center",
							orderable : false,
							render : YYDataTableUtils.renderViewActionCol,//renderActionCol
							width : "30"
						},{
							data : "userName",
							width : "60",
							className : "center",
							orderable : false
						},{
							data : "customer",
							width : "60",
							className : "center",
							orderable : false
						},{
							data : "stuff",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "model",
							width : "60",
							className : "center",
							orderable : false
						},{
							data : "reqCount",
							width : "60",
							className : "center",
							orderable : false
						},{
							data : "priceStatusName",
							width : "100",
							className : "center",
							orderable : false,
							render : function(data, type, full) {
							  /*  if(data==1){
								   var curSysDate=parseInt('${curSysDate}');
								   if(curSysDate-parseInt(full.reqTimeL)>86400){
									   return "<span  style='color: red;'>等待处理</span>";
								   }else{
									   return "<span  style=''>等待处理</span>";
								   }
							   }else if(data==2){
								   return "工厂报价"+full.priceFac;
							   }else if(data==3){
								   return "客户报价"+full.priceBiz;
							   }else if(data==4){
								   return "最终报价"+full.price;
							   }else{
								   return "";
							   } */
								if(full.priceStatus==1){
								   var curSysDate=parseInt('${curSysDate}');
								   if(curSysDate-parseInt(full.reqTimeL)>86400){
									   return "<span  style='color: red;'>"+data+"</span>";
								   }else{
									   return data;
								   }
								 }else{
									return data;
								 }
							}
						},{
							data : "goodsStatusName",
							width : "120",
							className : "center",
							orderable : false,
							render : function(data, type, full) {
							   /* if(data==1){
								   var curSysDate=parseInt('${curSysDate}');
								   if(curSysDate-parseInt(full.reqTimeL)>86400){
									   return "<span  style='color: red;'>等待处理</span>";
								   }else{
									   return "<span  style=''>等待处理</span>";
								   }
							   }else if(data==2){
								   return "预计送样时间"+full.planTime;
							   }else if(data==3){
								   return "样品已发送"+full.sendTime;
							   }else{
								   return "异常状态";
							   } */
							   //如果列表的goodsStatus==2并且本地时间>planTime则红色
							   
								if(full.goodsStatus==1){
									   var curSysDate=parseInt('${curSysDate}');
									   if(curSysDate-parseInt(full.reqTimeL)>86400){
										   return "<span  style='color: red;'>等待处理</span>";
									   }else{
										   return "<span  style=''>等待处理</span>";
									   }
								}else if(full.goodsStatus==2&&full.planTimeL!=null){
								   var curSysDate=parseInt('${curSysDate}');
								   if(curSysDate-parseInt(full.planTimeL)>0){
									   return "<span  style='color: red;'>"+data+"</span>";
								   }else{
									   return data;
								   }
							   }else{
								   return data;
							   }
							}
						},{
							data : "recogStatusName",
							width : "50",
							className : "center",
							orderable : false,
							render : function(data, type, full) {
							   /* if(data==1){
								   return "等待处理";
							   }else if(data==2){
								   return "承认书已提供";
							   }else if(data==3){
								   return "客户已接收";
							   }else{
								   return "异常状态";
							   } */
							   return data;
							}
						},{
							data : "uuid",
							width : "50",
							className : "center",
							orderable : false,
							render : function(data, type, full) {
							   if(full.cancel){
									return "已取消";
							   }else{
								   if(full.finish){
									   return "已完成";
								   }else{
									   return "";
								   }
							   }
							}
						},{
							data : "result",
							width : "50",
							className : "center",
							orderable : false,
							render : function(data, type, full) {
							   if(data==1){
									return "OK";
							   }else  if(data==2){
									return "NG";
							   }else{
									return "";
							   }
							}
						}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage();
			
			$("#yy-btn-set-price").bind('click', setPrice);
			$("#yy-btn-accept-price").bind('click', acceptPrice);
			$("#yy-btn-set-plantime").bind('click', setPlanTime);
			$("#yy-btn-set-sendinfo").bind('click', setSendInfo);
			$("#yy-btn-accept-recog").bind('click', acceptRecog);
			$("#yy-btn-export").bind('click', onExport);
			$("#yy-btn-feedback").bind("click",onFeedBack);
			$("#yy-btn-setFinalPrice").bind("click",onFinalPrice);
		});
		
		//导出
		function onExport() {
			var formSearch = $("#yy-form-query").serializeArray();
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :formSearch,
				url : "${apiurl}/sample/export",
				async : true,
				dataType : "json",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(json) {
					layer.close(waitInfoLoading);
					console.info(json);
					if(json.flag==0){
						window.open(json.obj+"","_blank");
					}else if (json.flag==-10) {
						window.location = '${ctx}/logout';
					}else{
						YYUI.promAlert("导出失败："+json.msg);
					}
				},
				error : function(data) {
					layer.close(waitInfoLoading);
					YYUI.promAlert("http错误，请联系管理员");
				}
			});
		}
		

		//设置价格
		function setPrice(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/setPrice?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//确认价格
		function acceptPrice(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.confirm('确实要同意报价吗？', function() {
					var waitInfoLoading = layer.load(2);
					$.ajax({
						type : "POST",
						data :{"uuid": pks.toString()},
						url : "${apiurl}/sample/acceptPrice",
						async : true,
						xhrFields: {withCredentials: true},
				        crossDomain: true,
						dataType : "json",
						success : function(data) {
							layer.close(waitInfoLoading);
							console.info(data);
							if (data.flag==0) {
								YYUI.succMsg(data.msg);
								onRefresh(true);
							}else if (data.flag==-10) {
								YYUI.promMsg('会话超时，请重新的登录!');
								window.location = '${ctx}/logout';
								return [];
							}else {
								YYUI.promAlert(data.msg);
							}
						},
						error : function(data) {
							layer.close(waitInfoLoading);
							YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
						}
					});
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//设置价格
		function setPlanTime(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/setPlanTime?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//设置发送
		function setSendInfo(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/setSendInfo?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//确认承认书
		function acceptRecog(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.confirm('确认承认书？', function() {
					var waitInfoLoading = layer.load(2);
					$.ajax({
						type : "POST",
						data :{"uuid": pks.toString()},
						url : "${apiurl}/sample/acceptRecog",
						async : true,
						xhrFields: {withCredentials: true},
				        crossDomain: true,
						dataType : "json",
						success : function(data) {
							layer.close(waitInfoLoading);
							console.info(data);
							if (data.flag==0) {
								YYUI.succMsg(data.msg);
								onRefresh(true);
							}else {
								YYUI.promAlert(data.msg);
							}
						},
						error : function(data) {
							layer.close(waitInfoLoading);
							YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
						}
					});
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		
		//设置发送
		function onFeedBack(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/toFeedBack?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//
		function onFinalPrice(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/toFinalPrice?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		
		
		//服务器分页
		function serverPage(url) {
			var serverPageWaitLoad=layer.load(2);//加载等待ceng edit by liusheng		
			doBeforeServerPage();
			if (url == null) {
				url = '${serviceurl}/query';
			}
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order" : _setOrder,
				"scrollX" : true,
				"processing" : false,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				"paging" : true,
				"footerCallback" : setTotal,//合计
				"pageLength" : 25,
				"fnDrawCallback" : fnDrawCallback,//列对齐设置
				"ajax" : {
					"url" : url,
					"type" : 'POST',
					"sync":'false',
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					"data" : function(d) {
						freshLoad = layer.load(2);
						 //删除多余请求参数
				        for(var key in d){
				          if(key.indexOf("columns")==0){ //以columns开头的参数删除||key.indexOf("order")==0||key.indexOf("search")==0
				            delete d[key];
				          }
				        }
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
						if(freshLoad != null) {
							layer.close(freshLoad);
						}
						_pageNumber = json.pageNumber;
						return json.records == null ? [] : json.records;
					}
				},
				"initComplete": function(settings, json) {
					if(freshLoad != null) {
						layer.close(freshLoad);
					}
					layer.close(serverPageWaitLoad);//关闭加载等待ceng edit by liusheng
				}
			});
		}
	</script>
</body>
</html>	

