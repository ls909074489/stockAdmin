<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/approveuser"/>
<html>
<head>
<title>审批用户</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">

					<label for="search_LIKE_user.username" class="control-label">用户姓名</label>	
					<input type="text" autocomplete="on" name="search_LIKE_user.username"
						id="search_LIKE_user.username" class="form-control input-sm">
						

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
							<th>登录账号</th>
							<th>用户姓名</th>
							<th>手机号码</th>
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
				/* visible : false, */
				width : "20",
				render : YYDataTableUtils.renderCheckCol
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				render : YYDataTableUtils.renderRemoveActionCol,
				width : "50"
			},{
				data : "user.loginname",
				width : "180",
				className : "center",
				orderable : true
			},{
				data : "user.username",
				width : "200",
				className : "center",
				orderable : true
			},{
				data : "user.mobilephone",
				width : "200",
				className : "center",
				orderable : true
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage(null);
		});
		
		function onAdd(){
			layer.open({
				type : 2,
				title : '请选择用户 ',
				shadeClose : false,
				shade : 0.8,
				area : [ '1000px', '90%' ],
				content : '${ctx}/sys/ref/refUserSel?callBackMethod=window.parent.callBackSelUser'
			});
		}
		
		function callBackSelUser(selNode){
			$.ajax({
				"dataType" : "json",
				"data":{
					"applyType": "02",
					"user.uuid": selNode.uuid,
				},
				"type" : "POST",
				"url" : "${serviceurl}/add",
				"async" : false,
				"success" : function(data) {
					console.info(data);
					if (data.success) {
						onQuery();
					} else {
						YYUI.promAlert("操作失败：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.promAlert("HTTP错误。");
				}
			});
		}
		
		//重写防止双击
		function onEditRow(aData, iDataIndex, nRow){
			return false;
		}
	</script>
</body>
</html>	

