<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/customer"/>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/css/fix_top.css?v=2"/>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<!-- <button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button> -->
				<button id="yy-btn-open-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_paramtername" class="control-label">关键字</label>
					<input type="text" autocomplete="on" name="searchKey"
						id="searchKey" class="form-control input-sm">	
						
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table" style="table-layout: fixed; width: 100%!important;">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<th>操作</th>
							<th>客户名称</th>
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
							className : "center",
							orderable : false,
							//visible : false,
							render : YYDataTableUtils.renderRemoveActionCol,
							width : "50"
						},{
							data : "customer",
							width : "80%",
							className : "center",
							orderable : false
						}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${apiurl}/stuff/listCustomer');
			
			$("#yy-btn-open-add").bind('click', onOpenAdd);
		});
		
		
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
		
		
		function onRemoveRow(aData, iDataIndex, nRow){
			layer.confirm("确定要删除？", function(index) {
				layer.close(index);
				
				var waitInfoLoading = layer.load(2);
				$.ajax({
					type : "POST",
					data :{"customer": aData.customer},
					url : "${apiurl}/stuff/deleteCustomer",
					async : true,
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					dataType : "json",
					success : function(data) {
						layer.close(waitInfoLoading);
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
		}
		
		function onOpenAdd(){
			layer.open({
				title:" ",
			    type: 2,
			    area: ['70%', '70%'],
			    shadeClose : false,
				shade : 0.8,
			    content: '${serviceurl}/onAdd'
			});
		}
	</script>
</body>
</html>	

