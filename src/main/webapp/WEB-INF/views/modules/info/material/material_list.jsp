<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/material"/>
<html>
<head>
<title>物料</title>
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
				<button class="btn green btn-sm btn-info" id="yy-btn-import">
					<i class="fa fa-chevron-down"></i> 导入
				</button>
				<button class="btn green btn-sm btn-info" id="yy-btn-templatedownload">
					<i class="fa fa-chevron-down"></i> 导入模板下载
				</button>
				<button id="yy-btn-export-query" queryformId="yy-form-query" class="btn green btn-sm">
					<i class="fa fa-chevron-up"></i> 导出
				</button>
			</div>
			<div class="hide">
				<form action="#" id="importfile">
					<input type="file" id="multifile" multiple size="120" />
				</form>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_EQ_billstatus" class="control-label">是否风险物料</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_hasRisk" 
						name="search_EQ_hasRisk" data-enum-group="BooleanType"></select>

					<label for="search_LIKE_name" class="control-label">物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_code"
						id="search_LIKE_code" class="form-control input-sm">
						
					<label for="search_LIKE_name" class="control-label">物料名称</label>
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
							<th>物料编码</th>
							<th>名称</th>
							<th>是否风险物料</th>
							<th>分类描述</th>
							<th>物料描述</th>
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
				width : "40",
				render : YYDataTableUtils.renderCheckCol
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				render : YYDataTableUtils.renderActionCol,
				width : "50"
			},{
				data : "code",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "name",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "hasRisk",
				width : "100",
				className : "center",
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BooleanType", data);
				},
				orderable : true
			},{
				data : "classDesc",
				width : "100",
				className : "center",
				orderable : true
			},{
				data : "memo",
				width : "100",
				className : "center",
				orderable : true
			}];


		//var _setOrder = [[5,'desc']];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage(null);
			
			onImportExport();
		});
		
		function onImportExport(){
			$("#yy-btn-import").bind('click', importfileClick);//附件
			$("#importfile #multifile").bind('change', onImportData);
			 
			//模板下载
			$("#yy-btn-templatedownload").bind('click',function(){
				window.open('${ctx}${templatePath}',"_blank");
			});
			
			$("#yy-btn-export-query").click(function(){
				window.open('${serviceurl}/exportQuery?'+$("#yy-form-query").serialize(),"_blank"); 
			});
		}
		
		//点击选择文件按钮事件
		function importfileClick(){
			//点击选择文件按钮事件
			$("#importfile #multifile").click();
		}
			

		//导入数据
		function onImportData() {
			var file = this.form.multifile.value;
			if (!file){
				return;
			}
			var extArray = new Array(".xls", ".xlsx");
			var allowSubmit = false;
			while (file.indexOf("\\") != -1){
				file = file.slice(file.indexOf("\\") + 1);
			}
			var ext = file.slice(file.indexOf(".")).toLowerCase();
			for (var i = 0; i < extArray.length; i++) {
				if (extArray[i] == ext) {
					allowSubmit = true;
					break;
				}
			}
			if (allowSubmit){
				var file = $("#importfile #multifile")[0].files[0];
				var posturl = "${serviceurl}/import";
				var formData = new FormData();
				formData.append("attachment", file,file.name);
				var importLoad = layer.msg('数据导入中，每100条数据大概需要50秒。', {icon:16,time: 500*1000});
				$.ajax( {
					url : posturl,
					data: formData,
		            cache: false,
		            contentType: false,
		            processData: false,
		            type: 'POST',     
					success : function(data) {
						if(data.success){
							layer.close(importLoad);
							YYUI.succMsg("导入成功,重新加载页面。");
							//loadBody(data.records);
							location.reload();
						} else{
							layer.close(importLoad);
							YYUI.failMsg("导入错误：" + data.msg);
							location.reload();
						}
					},
					"error" : function(XMLHttpRequest, textStatus, errorThrown) {
						layer.close(importLoad);
						YYUI.failMsg("导入失败。");
						location.reload();
					}
				});
			} else {
				YYUI.promAlert("只能上传以下格式的文件:  " + (extArray.join("  "))
							+ "\n请重新选择符合条件的文件" + "再上传.");
			}
		}

	</script>
</body>
</html>	

