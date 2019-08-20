<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
<title>项目</title>
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
				<!-- <button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button> -->
				<!-- <button id="yy-btn-approve-x" class="btn yellow btn-sm btn-info">
					<i class="fa fa-check"></i> 审核
				</button> -->
				<button class="btn green btn-sm btn-info" id="yy-btn-import">
					<i class="fa fa-chevron-down"></i> 导入
				</button>
				<button class="btn green btn-sm btn-info" id="yy-btn-templatedownload">
					<i class="fa fa-chevron-down"></i> 导入模板下载
				</button>
				
				<button id="yy-btn-export-pks" queryformid="yy-form-query" class="btn green btn-sm btn-info">
					<i class="fa fa-chevron-up"></i> 导出
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_name" class="control-label">项目号</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">项目名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_name"
						id="search_LIKE_name" class="form-control input-sm">

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
							<!-- <th>收货状态</th> -->
							<th>项目号</th>
							<th>项目名称</th>
							<th>仓库</th>
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
	<%@include file="/WEB-INF/views/common/commonscript_approve.jsp"%>

	<script type="text/javascript">
		_isNumber = true;
		var _tableCols = [{
				data : null,
				orderable : false,
				className : "center",
				width : "50"
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
				render : YYDataTableUtils.renderActionCol,
				width : "60"
			},{
				data : "billstatus",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BillStatus", data);
				},
				orderable : false
			}/* ,{
				data : "receiveType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("ReceiveStatus", data);
				},
				orderable : false
			} */,{
				data : "code",
				width : "100",
				className : "center",
				orderable : false
			},{
				data : "name",
				width : "200",
				className : "center",
				orderable : false
			},{
				data : "stock.name",
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
			
			$("#yy-btn-export-pks").bind('click', exportPks);//选择导出
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
		
		//选择导出
		function exportPks(){
			var pks = YYDataTableUtils.getSelectPks();
			if(pks==""){
				YYUI.failMsg("请选择导出数据");
				return;
			}
			var sentence=pks+"";
			if(sentence.split(',').length>20){
				YYUI.promMsg('最多只能选择20条导出');
			}else{
				YYUI.promMsg('正在导出，请稍后.',3000);
				window.open('${serviceurl}/exportCsByIds?pks='+pks,"_blank");
			}
		}
	</script>
</body>
</html>	

