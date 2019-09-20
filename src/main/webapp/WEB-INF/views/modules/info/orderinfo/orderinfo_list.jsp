<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/orderinfo"/>
<html>
<head>
<title>订单</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<shiro:hasPermission name="orderinfoAdd">
					<button id="yy-btn-add" class="btn blue btn-sm">
						<i class="fa fa-plus"></i> 新增
					</button>
				</shiro:hasPermission>	
				<shiro:hasPermission name="orderinfoDel">
					<button id="yy-btn-remove" class="btn red btn-sm">
						<i class="fa fa-trash-o"></i> 删除
					</button>
				</shiro:hasPermission>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
				<!-- <button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button> -->
				<shiro:hasPermission name="orderinfoApprove">
					<button id="yy-btn-approve-x" class="btn yellow btn-sm btn-info">
						<i class="fa fa-check"></i> 审核
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="orderinfoUnApprove">
					<button id="yy-btn-unapprove" class="btn yellow btn-sm btn-info">
						<i class="fa fa-reply"></i> 取消审核
					</button>
				</shiro:hasPermission>
				<!-- <button id="yy-btn-unapprove" class="btn yellow btn-sm btn-info">
					<i class="fa fa-reply"></i> 取消审核
				</button> -->
				<shiro:hasPermission name="orderinfoImport">
					<button class="btn green btn-sm btn-info" id="yy-btn-import">
						<i class="fa fa-chevron-down"></i> 导入
					</button>
					<button class="btn green btn-sm btn-info" id="yy-btn-templatedownload">
						<i class="fa fa-chevron-down"></i> 导入模板下载
					</button>
				</shiro:hasPermission>
				</div>
			<div class="row yy-searchbar form-inline">
				<!-- <form id="yy-form-query">
					<label for="search_EQ_orderType" class="control-label">订单类型</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_orderType" 
						name="search_EQ_orderType" data-enum-group="OrderType"></select>

					<label for="search_LIKE_code" class="control-label">订单编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">

					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
				</form> -->
				<form id="yy-form-query" class="queryform">
				<label for="search_EQ_orderType" class="control-label">订单类型</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_orderType" 
						name="search_EQ_orderType" data-enum-group="OrderType"></select>
						
					<label for="search_LIKE_code" class="control-label">订单编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">

					<label for="search_LIKE_name" class="control-label">创建人</label>
					<input type="text" autocomplete="on" name="search_LIKE_creatorname"
						id="search_LIKE_creatorname" class="form-control input-sm">
						
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
							<th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th>
							<th>操作</th>
							<th>单据状态</th>
							<th>订单类型</th>
							<th>订单编码</th>
							<!-- <th>订单名称</th> -->
							<th>仓库</th>
							<!-- <th>预计到货时间</th> -->
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
	<%@include file="/WEB-INF/views/common/commonscript_approve_simple.jsp"%>

	<script type="text/javascript">
		_isNumber = true;
		var _tableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "20"
			},{				data : "uuid",
				orderable : false,
				className : "center",
				/* visible : false, */
				width : "20",
				render : YYDataTableUtils.renderCheckCol
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				//render : YYDataTableUtils.renderActionCol,
				render : function(data, type, full) {
					return "<div class='yy-btn-actiongroup'>"
					+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
					+ "<shiro:hasPermission name='orderinfoEdit'><button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button></shiro:hasPermission>"
					+ "<shiro:hasPermission name='orderinfoDel'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></shiro:hasPermission>"
					+ "</div>";
				},
				width : "60"
			},{
				data : "billstatus",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					   return '<a onclick="onApproveLook(\'orderInfo\',\''+full.uuid+'\');">'+YYDataUtils.getEnumName("BillStatus", data)+'</a>';
				},
				orderable : false
			},{
				data : "orderType",
				width : "80",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("OrderType", data);
				},
				orderable : false
			},{
				data : "code",
				width : "100",
				className : "center",
				orderable : false
			}/* ,{
				data : "name",
				width : "100",
				className : "center",
				orderable : false
			} */,{
				data : "stock.name",
				width : "100",
				className : "center",
				orderable : false
			}/* ,{
				data : "planArriveTime",
				width : "100",
				className : "center",
				orderable : false
			} */,{
				data : "creatorname",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "createtime",
				width : "100",
				className : "center",
				orderable : false
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/query?orderby=createtime@desc');
			
			//模板下载
			$("#yy-btn-templatedownload").bind('click',function(){
				window.open('${ctx}${templatePath}',"_blank");
			});
			
			$("#yy-btn-import").bind('click', importfileClick);//附件
		});
		
		//点击选择文件按钮事件
		function importfileClick(){
			layer.open({
				title : '导入',
				type : 2,
				area : [ '850px', '510px' ],
				shadeClose : false,
				shade : 0.8,
				content : '${serviceurl}/toImport'
			});
		}
		
		//审核前检查
		function checkApprove(pks) {
			if (pks.length < 1) {
				YYUI.promMsg("请选择需要审核的记录");
				return;
			}
			for (var i = 0; i < pks.length; i++) {
				var row = $("input[value='" + pks[i] + "']").closest("tr");
				var billstatus = _tableList.row(row).data().billstatus;
				if (!(billstatus == 1||billstatus == 4)) {
					YYUI.failMsg("未提交或被退回才能审核");
					return false;
				}
			}
			return true;
		}
	</script>
</body>
</html>	

