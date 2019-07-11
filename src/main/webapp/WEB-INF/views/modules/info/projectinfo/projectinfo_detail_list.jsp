<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<html>
<head>
<title>项目</title>
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
				</button>
				<button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button>
				<button id="yy-btn-approve-x" class="btn yellow btn-sm btn-info">
					<i class="fa fa-check"></i> 审核
				</button> -->
				
				<label for="sweepCode" class="control-label">扫描条码</label>
				<input type="text" autocomplete="on" name="sweepCode"
					id="sweepCode" class="input-sm" style="width: 380px;">
				<button id="yy-btn-match" type="button" class="btn btn-sm btn-info">
					<i class="fa fa-search"></i> 匹配
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<!-- <label for="search_LIKE_main.code" class="control-label">项目号&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" autocomplete="on" name="search_LIKE_main.code"
						id="search_LIKE_main.code" class="form-control input-sm">
						
					<label for="search_LIKE_main.name" class="control-label">项目名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_main.name"
						id="search_LIKE_main.name" class="form-control input-sm"> -->
					
						<label class="control-label">项目</label>
							<div class="input-group">
								<input id="roleId" name="roleId" type="hidden"> 
								<input id="roleName" name="roleName" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-role-select" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
												
					<label for="search_LIKE_main.name" class="control-label">箱号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_boxNum" name="search_EQ_boxNum"
								 data-enum-group="BoxNum"></select>	
								 
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
					<div style="height: 5px;"></div>
					
					<label for="search_LIKE_material.code" class="control-label">物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_material.code" class="form-control input-sm">
					
					<label for="search_LIKE_material.name" class="control-label">物料名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm">			 
							
					<label for="search_LIKE_barcode" class="control-label">条码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" autocomplete="on" name="search_LIKE_barcode" id="search_LIKE_barcode" class="form-control input-sm">		 

					
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<!-- <th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th> -->
							<th>操作</th>
							<th>单据状态</th>
							<th>项目号</th>
							<th>项目名称</th>
							<th>箱号</th>
							<th>物料编码</th>
							<th>物料名称</th>
							<th>计划数量</th>	
							<th>条码</th>
							<!-- <th>备注</th> -->
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<%@include file="/WEB-INF/views/common/commonscript_approve.jsp"%>

	<script type="text/javascript">
		_isNumber = true;
		var _tableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "30"
			}/* ,{				data : "uuid",
				orderable : false,
				className : "center",
				//visible : false,
				width : "20",
				render : YYDataTableUtils.renderCheckCol
			} */,{
				data : "uuid",
				className : "center",
				orderable : false,
				render : YYDataTableUtils.renderActionCol,
				width : "60"
			},{
				data : "main.billstatus",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BillStatus", data);
				},
				orderable : false
			},{
				data : "main.code",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "main.name",
				width : "200",
				className : "center",
				orderable : false
			}, {
				data : 'boxNum',
				width : "30",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BoxNum", data);
				}
			},{
				data : "material.code",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "material.name",
				width : "200",
				className : "center",
				orderable : false
			}, {
				data : 'planAmount',
				width : "60",
				className : "center",
				orderable : false
			}, {
				data : 'barcode',
				width : "80",
				className : "center",
				orderable : false
			}/* ,{
				data : "memo",
				width : "100",
				className : "center",
				orderable : false
			} */];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataDetail?orderby=createtime@desc;mid@desc');
			
			$("#yy-btn-match").bind('click', matchMaterial);//
		});
		
		//匹配物料
		function matchMaterial(){
			console.info("matchMaterial>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			var t_boxNum = $("#search_EQ_boxNum").val();
			console.info(t_boxNum+"============");
			if(t_boxNum==''){
				YYUI.promMsg("请选择箱号");
				return false;
			}
			onQuery();
		}
	</script>
</body>
</html>	

