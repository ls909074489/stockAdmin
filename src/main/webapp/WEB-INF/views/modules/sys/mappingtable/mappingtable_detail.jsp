<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/mappingTable"/>
<c:set var="servicesuburl" value="${ctx}/info/mappingTableSub"/>
<html>
<head>
<title>标准映射表</title>
</head>
<body>
	<div id="yy-page-detail" class="container-fluid page-container page-content">
	
		<div class="row yy-toolbar">
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 返回
			</button>
		</div>
		<div class="hide">
		</div>
		<div>
			<form id="yy-form-detail" class="form-horizontal yy-form-detail">
				<input name="uuid" id="uuid" type="hidden" value="${entity.uuid}"/>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">模板名称</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="templateName" id="templateName" type="text" class="form-control" value="${entity.templateName}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">模板类型</label>
							<div class="col-md-8">
								<select name="templateType"  class="form-control">
									<option value="1">普通列表（前端分页）</option>
									<option value="2">普通列表（服务器分页）</option>
									<option value="3">树状结构</option>
									<option value="4">左树右列表</option>
									<option value="5">主子表（服务器分页）</option>
									<option value="6">主子表（前端分页）</option>
									<option value="11">列表单选</option>
									<option value="12">树单选</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">java文件路径</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="javaWorkspace" id="packageNamePath" type="text" class="form-control" value="${entity.javaWorkspace}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">java上级包名</label>
							<div class="col-md-8">
								<input name="packageName" id="packageName" type="text" class="form-control" value="${entity.packageName}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
						<input type="button" value="选择路径" id="javaPathBtn"/>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">页面文件路径</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="jspWorkspace" id="jspWorkspace" type="text" class="form-control" value="${entity.jspWorkspace}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">@RequestMapping(value = "/xx/xx")</label>
							<div class="col-md-8">
								<input name="controllerPath" type="text" class="form-control" value="${entity.controllerPath}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">页面路径(return "xx/xx";)</label>
							<div class="col-md-8">
								<input id="jspPath" name="jspPath" type="text" class="form-control" value="${entity.jspPath}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
						<input type="button" value="选择路径" id="jspPathBtn"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">实体的用途名</label>
							<div class="col-md-8">
								<input name="entityChinese" type="text" class="form-control" value="${entity.entityChinese}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">生成表的名字</label>
							<div class="col-md-8">
								<input name="tableName" type="text" class="form-control" value="${entity.tableName}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">实体的名字</label>
							<div class="col-md-8">
								<input name="entityName" type="text" class="form-control" value="${entity.entityName}">
							</div>
						</div>
					</div>
					<div class="col-md-2" style="padding-left: 0px;">
						extends
						<select name="extendsEntity">
							<option value="BaseEntity">BaseEntity</option>
							<option value="SuperEntity">SuperEntity</option>
							<option value="TreeEntity">TreeEntity</option>
						</select>
					</div>
				</div>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">映射关系
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<table id="yy-table-sublist" class="yy-table-x">
						<thead>
							<tr>
								<!-- <th class="table-checkbox"><input type="checkbox"
									class="group-checkable" data-set="#yy-table-sublist .checkboxes" /></th> -->
								<th>序号</th>	
								<th>操作</th>	
								<th>实体字段</th>
								<th>数据库字段</th>
								<th>备注</th>
								<th>列表是否显示</th>
								<th>是否主表</th>
								<th>页面显示方式</th>
								<th>字段类型</th>
								<th>字段长度</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/detailscript.jsp"%>
	
	<script type="text/javascript">
	var _subTableList;//子表
	var _addList = new Array(); //新增的行/修改的行
	var _deletePKs = new Array();//需要删除的PK数组
	var _columnNum;

	/* 子表操作 */
	var _subTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "30"
		}, {
			data : "colName",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				var tUuid=full.uuid;
				if (typeof(tUuid) == "undefined"){
					tUuid="";
				}
				if(data==null){
					data="";
				}
				return '<input type="hidden" name="uuid" value="'+tUuid+'"><input class="form-control inputChange" value="'+ data + '" name="colName">';
			}
		}, {
			data : "colNameDb",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colNameDb">';
			}
		}, {
			data : "colDesc",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colDesc">';
			}
		}, {
			data : "isListVisiable",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('BooleanType','isListVisiable',data,false);
			}
		}, {
			data : "isMain",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('BooleanType','isMain',data,false);
			}
		}, {
			data : "eleType",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('eleTypeEnum','eleType',data,false);
			}
		}, {
			data : "colType",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('colTypeEnum','colType',data,false);
			}
		}, {
			data : "colLength",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colLength">';
			}
		}
	];
	

	$(document).ready(function() {
		bindDetailActions();//綁定平台按鈕
		
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false/* ,
			"order" : [[5,"asc"]] */
		});
		
		setValue();
		
		$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
		$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
		
		YYFormUtils.lockForm("yy-form-detail");
	});
	
	//设置默认值
	function setValue(){
		$("input[name='uuid']").val('${entity.uuid}');
		$("input[name='search_EQ_main.uuid']").val('${entity.uuid}');//子表查询时，主表id	
		$("input[name='mainId']").val('${entity.uuid}');//子表查询时，主表id	
		$("input[name='name']").val('${entity.name}');
		loadSubList('${entity.uuid}');
	}
	
	
	
	//刷新子表
	function onRefreshSub() {
		_subTableList.draw(); //服务器分页
	}
	//重置子表查询条件
	function onResetSub() {
		YYFormUtils.clearForm("yy-form-subquery");
		return false;
	}
	
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		var loadSubWaitLoad=layer.load(2);
		$.ajax({
			url : '${servicesuburl}/query',
			data : {
				"search_EQ_main.uuid" : mainTableId
			},
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(data) {
				layer.close(loadSubWaitLoad);
				
				_subTableList.clear();
				_subTableList.rows.add(data.records);
				_subTableList.on('order.dt search.dt',
				        function() {
					_subTableList.column(0, {
						        search: 'applied',
						        order: 'applied'
					        }).nodes().each(function(cell, i) {
						        cell.innerHTML = i + 1;
					        });
				}).draw();
			}
		});
	}
	
</script>
</body>
</html>