<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/reject"/>
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
				<!-- <button id="yy-btn-set-reject" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 退货
				</button> -->
				<button id="yy-btn-set-rework" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 返工
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_paramtername" class="control-label">客户名或型号</label>
					<input type="text" autocomplete="on" name="searchKey"
						id="searchKey" class="form-control input-sm">	
				
					<label class="control-label">时间</label> 
					<input type="text" autocomplete="on" name="startDate" style="width: 150px;"
					id="startDate" class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}'});"> 
					到 
					<input type="text" autocomplete="on" name="endDate" style="width: 150px;"
					id="endDate" class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}'});">
						
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
							<th>订单编号</th>
							<th>客户名称</th>
							<th>产品料号</th>
							<th>产品型号</th>
							<th>退货数量</th>
							<th>返工数量</th>
							<th>退货时间</th>
							<th>退货原因</th>
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
							width : "20",
							render : YYDataTableUtils.renderCheckCol
						},{
							data : "uuid",
							className : "center",
							orderable : false,
							visible : false,
							render : YYDataTableUtils.renderActionCol,
							width : "50"
						},{
							data : "number",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "customer",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "stuff",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "model",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "rejectCount",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "reworkCount",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "date",
							width : "100",
							className : "center",
							orderable : false
						},{
							data : "reason",
							width : "100",
							className : "center",
							orderable : false
						}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${apiurl}/order/listRejectOrder');
			
			$("#yy-btn-set-reject").bind('click', setReject);
			$("#yy-btn-set-rework").bind('click', setRework);
			$("#yy-btn-export").bind('click', onExport);
		});
		
		//导出
		function onExport() {
			var formSearch = $("#yy-form-query").serializeArray();
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :formSearch,
				url : "${apiurl}/reject/export",
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
		
		//退货
		function setReject(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/toReject?uuid='+pks.toString()
				});
			} else {
				YYUI.promMsg("请选择一条记录");
			}
		}
		//返工
		function setRework(){
			var pks = YYDataTableUtils.getSelectPks();
			if (pks != null && pks.length == 1) {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['70%', '70%'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/toRework?uuid='+pks.toString()
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

