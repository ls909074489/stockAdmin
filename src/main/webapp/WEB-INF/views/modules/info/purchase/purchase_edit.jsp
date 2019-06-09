<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/purchase"/>
<html>
<head>
<title>订购信息</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden" value="">
			<input id="fileList" name="files" type="hidden" value="">
			<span id="fileSpan"></span>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">订单编号</label>
						<div class="col-md-8">
							<input name="number" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">客户名称</label>
						<div class="col-md-8">
							<div class="input-group">
									<fieldset disabled="disabled">
										<input name="customer" id="customer" type="text" class="form-control">
									</fieldset>
									<span class="input-group-btn">
										<button id="yy-def-customer" class="btn btn-default btn-ref" type="button"
											data-select2-open="single-append-text">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">产品料号</label>
						<div class="col-md-8">
							<div class="input-group">
									<fieldset disabled="disabled">
										<input name="stuff" id="stuff" type="text" class="form-control">
									</fieldset>
									<span class="input-group-btn">
										<button id="yy-def-iconcls" class="btn btn-default btn-ref" type="button"
											data-select2-open="single-append-text">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">产品型号</label>
						<div class="col-md-8">
							<input name="model" id="model" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">使用现有库存</label>
						<div class="col-md-8">
							<input name="useStorageCount" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">材料用量</label>
						<div class="col-md-8">
							<input name="stuffCount" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">订单价格</label>
						<div class="col-md-8">
							<input name="price" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">备注</label>
						<div class="col-md-8">
							<input name="remark" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">下单时间</label>
						<div class="col-md-8">
							<input name="reqTime" type="text" class="form-control Wdate"  
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">订单数量</label>
						<div class="col-md-8">
							<input name="planCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">计划生产总量</label>
						<div class="col-md-8">
							<input name="producePlanCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">交付时间</label>
						<div class="col-md-8">
							<input name="deliveryTime" type="text" class="form-control Wdate"  
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">已入库数量</label>
						<div class="col-md-8">
							<input name="produceCount" type="text" class="form-control" value="" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">生产完成时间</label>
						<div class="col-md-8">
							<input name="produceFinishTime" type="text" class="form-control Wdate"  
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">已交付数量</label>
						<div class="col-md-8">
							<input name="deliveryCount" type="text" class="form-control" value="" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">交付完成时间</label>
						<div class="col-md-8">
							<input name="deliveryFinishTime" type="text" class="form-control Wdate"  
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
		</form>
		<!-- 附件上传 -->
		<tags:uploadFilesApi id="uploadFiles" />
		
		<!-- <div class="row" >
			<div class="col-md-4">
					<div class="form-group">
						<div class="control-label col-md-4" style="">请选择</div>
						<div class="col-md-8">
							<div class="imexlate-text-input"><input type="text" id="fileName" class="imexlate-fileName" readonly="readonly"/></div>
							<div class="imexlate-text-input" style="margin-left:5px;"> 
								<button id="yy-btn-findfile" class="btn green btn-sm">
									<i class="fa fa-file-o"></i>&nbsp;浏览
								</button>
							</div>
						</div>
					</div>
			</div>
			<div class="hide">
				<form id="yy-import-file" >
					<input type="file" id="multifile" name="file" /> 
				</form>
			</div>
		</div> -->
		
		
		<div class="yy-tab" id="yy-page-sublist">
				<div class="tabbable-line">
					<ul class="nav nav-tabs ">
						<li class="active">
							<a href="#tab0" data-toggle="tab"> 计划列表</a>
						</li>
						<li class="">
							<a href="#tab1" data-toggle="tab"> 交付列表</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab0">
							<div class="row yy-toolbar" id="subListToolId" style="display: none;">
								<!-- <button id="addNewSubYaoxin" class="btn blue btn-sm" type="button">
									<i class="fa fa-plus"></i> 添加遥信
								</button> -->
								
								<button id="yy-btn-pass-yxall" class="btn btn-sm btn-info edit" 
									data-rel="tooltip" title="通过">
									<i class="fa fa-check"></i>通过
								</button>
								<button id="yy-btn-question-yxall" class="btn btn-sm btn-danger delete" 
									data-rel="tooltip" title="质疑">
									<i class="fa fa-hourglass-2"></i>质疑
								</button>
								
								<div role="form" class="form-inline" style="display: inline-block;">
									<form id="yy-form-subquery-yx">	
										<input type="hidden" name="uuid" id="uuid" value="${uuid}">	
										&nbsp;&nbsp;	
										<label for="search_EQ_substatus" class="control-label">状态 </label>
										<select class="yy-input-enumdata form-control" id="search_EQ_substatus" name="search_EQ_substatus" data-enum-group="VersionSubStatus"></select>
										
										&nbsp;&nbsp;	
										<button class="yy-btn-searchSub" type="button" class="btn btn-sm btn-info">
											<i class="fa fa-search"></i>查询
										</button>
										<button class="yy-searchbar-resetSub" type="reset" class="red">
											<i class="fa fa-undo"></i> 清空
										</button>	
									</form>
								</div>
							</div>
							<table id="yy-table-sublist" class="yy-table">
								<thead>
									<tr>
										<th>序号</th>
										<!-- <th class="table-checkbox" style=""><input type="checkbox"
											class="group-checkable" data-set="#yy-table-yaoxin .checkboxes" />
										</th> -->
										<th>操作</th>	
										<th>产出日期</th>
										<th>订单数量</th>
										<th>入库数量</th>
									</tr>
								</thead>
								<tbody>
		
								</tbody>
							</table>
						</div>
						<div class="tab-pane" id="tab1">
							<div class="row yy-toolbar" id="subListToolId" style="display: none;">
								<!-- <button id="addNewSubYaoxin" class="btn blue btn-sm" type="button">
									<i class="fa fa-plus"></i> 添加
								</button> -->
								
								<div role="form" class="form-inline" style="display: inline-block;">
									<form id="yy-form-subquery-delivery">	
										<input type="hidden" name="uuid" id="uuid" value="${uuid}">	
										&nbsp;&nbsp;	
										<label for="search_EQ_substatus" class="control-label">状态 </label>
										<select class="yy-input-enumdata form-control" id="search_EQ_substatus" name="search_EQ_substatus" data-enum-group="VersionSubStatus"></select>
										
										&nbsp;&nbsp;	
										<button class="yy-btn-searchSub" type="button" class="btn btn-sm btn-info">
											<i class="fa fa-search"></i>查询
										</button>
										<button class="yy-searchbar-resetSub" type="reset" class="red">
											<i class="fa fa-undo"></i> 清空
										</button>	
									</form>
								</div>
							</div>
							<table id="yy-table-delivery" class="yy-table">
								<thead>
									<tr>
										<th>序号</th>
										<!-- <th class="table-checkbox" style=""><input type="checkbox"
											class="group-checkable" data-set="#yy-table-yaoxin .checkboxes" />
										</th> -->
										<!-- <th>操作</th>	 -->
										<th>交付日期</th>
										<th>交付数量</th>
										<th>物流信息</th>
									</tr>
								</thead>
								<tbody>
		
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		
		</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	<script type="text/javascript">
		var _fileUploadTool;//上传变量
	
		/* 子表操作 */
		var _subTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "20"
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "20",
			//render :YYDataTableUtils.renderRemoveActionCol
			render:function (data, type, full){
				return "<div class='yy-btn-actiongroup'>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info edit-row' data-rel='tooltip' title='生产'><i class='fa fa-edit'></i>生产</button>"
				+ "</div>";
			}
		}, {
			data : "produceDate",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				var tUuid=full.uuid;
				if (typeof(tUuid) == "undefined"){
					tUuid="";
				}
				var tOrderId=full.orderId;
				if (typeof(tOrderId) == "undefined"){
					tOrderId="";
				}
				if(data==null){
					data="";
				}
				return '<input type="hidden" name="uuid" value="'+tUuid+'"><input type="hidden" name="orderId" value="'+tOrderId+'">'+
				//'<input class="form-control" value="'+ data + '" name="produceDate">';
				data;
			}
		}, {
			data : "planCount",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				//return '<input class="form-control" value="'+ data + '" name="planCount">';
				return data;
			}
		}, {
			data : "produceCount",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				//return '<input class="form-control" value="'+ data + '" name="produceCount">';
				return data;
			}
		}];
		
		/* 子表操作 */
		var _deliveryTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "30"
		}/* , {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "50",
			render:function (data, type, full){
				return "<div class='yy-btn-actiongroup'>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info edit-row' data-rel='tooltip' title='生产'><i class='fa fa-edit'></i>交付</button>"
				+ "</div>";
			}
		} */, {
			data : "deliveryTime",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				var tUuid=full.uuid;
				if (typeof(tUuid) == "undefined"){
					tUuid="";
				}
				var tOrderId=full.orderId;
				if (typeof(tOrderId) == "undefined"){
					tOrderId="";
				}
				if(data==null){
					data="";
				}
				return '<input type="hidden" name="uuid" value="'+tUuid+'"><input type="hidden" name="orderId" value="'+tOrderId+'">'+
				//'<input class="form-control" value="'+ data + '" name="deliveryTime">';
				data;
			}
		}, {
			data : "deliveryCount",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				//return '<input class="form-control" value="'+ data + '" name="deliveryCount">';
				return data;
			}
		}, {
			data : "deliveryNumber",
			orderable : false,
			className : "center",
			width : "180",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				//return '<input class="form-control" value="'+ data + '" name="deliveryNumber">';
				return data;
			}
		}];
		
		
		var _pageNumberYx,_pageNumberDelivery;
		$(document).ready(function() {
			
			$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			     //当切换tab时，强制重新计算列宽
			     $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
			} );
			
			//按钮绑定事件
			bindEditActions();
			validateForms();
			setValue();
			
			//附件用
			_fileUploadTool = new FileUploadTool("uploadFiles","noticeEntity");
			_fileUploadTool.init("edit");
			
			$('#yy-def-iconcls').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择',
					shadeClose : false,
					shade : 0.8,
					area : [ '70%', '90%' ],
					content : '${serviceurl}/toSelectStuff', //iframe的url
				});
			});
			$('#yy-def-customer').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择',
					shadeClose : false,
					shade : 0.8,
					area : [ '70%', '90%' ],
					content : '${serviceurl}/toSelectCustomer', //iframe的url
				});
			});
			
			initSubTable();
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
			
			} else if ('${openstate}' == 'edit') {
				var waitInfoLoading = layer.load(2);
				$.ajax({
					type : "POST",
					data :{"uuid": '${uuid}'},
					url : "${apiurl}/order/getOrder",
					async : true,
					dataType : "json",
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					success : function(json) {
						layer.close(waitInfoLoading);
						console.info(json);
						if(json.flag==0){
							$("input[name='uuid']").val(json.obj.uuid);
							$("input[name='number']").val(json.obj.number);
							$("input[name='customer']").val(json.obj.customer);
							$("#stuff").val(json.obj.stuff);
							$("input[name='model']").val(json.obj.model);
							$("input[name='useStorageCount']").val(json.obj.useStorageCount);
							$("input[name='stuffCount']").val(json.obj.stuffCount);
							$("input[name='price']").val(json.obj.price);
							$("input[name='remark']").val(json.obj.remark);
							$("input[name='planCount']").val(json.obj.planCount);
							$("input[name='producePlanCount']").val(json.obj.producePlanCount);
							$("input[name='deliveryTime']").val(json.obj.deliveryTime);
							$("input[name='produceFinishTime']").val(json.obj.produceFinishTime);
							$("input[name='deliveryFinishTime']").val(json.obj.deliveryFinishTime);
							$("input[name='reqTime']").val(json.obj.reqTime);
							$("input[name='produceCount']").val(json.obj.produceCount);
							$("input[name='deliveryCount']").val(json.obj.deliveryCount);
							var oldFiles=json.obj.files;
							if(oldFiles!=null){
								$("#fileList").val(JSON.stringify(oldFiles));
							}
							_fileUploadTool.loadFilsTableList(oldFiles,'edit');
						}else if (json.flag==-10) {
							window.location = '${ctx}/logout';
						}else{
							YYUI.promAlert("获取数据失败："+json.msg);
						}
					},
					error : function(data) {
						layer.close(waitInfoLoading);
						YYUI.promAlert("http错误，请联系管理员");
					}
				});
			}
		}
		
		function initSubTable(){
			var yxFreshLoad=null;
			//子表
			_subYaoxinTableList = $('#yy-table-sublist').DataTable({
				"columns" : _subTableCols,
				"createdRow" : selRowAction,
				//"scrollX" : true,
				"processing" : false,//加载时间长，显示加载中
				"paging" :true,
				"order" : [],
				"scrollX" : true,
				"processing" : false,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				//"pageLength" : 2,
				"paging" : true,
				"fnDrawCallback" : fnDrawCallbackYx,//列对齐设置
				"ajax" : {
					"url" : '${apiurl}/order/listPlan',
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					"type" : 'POST',
					"sync":'false',
					"data" : function(d) {
						yxFreshLoad = layer.load(2);
						//d.orderby = getOrderbyParam(d);
						var _subqueryData = $("#yy-form-subquery-yx").serializeArray();
						if (_subqueryData == null)
							return;
						$.each(_subqueryData, function(index) {
							if (this['value'] == null || this['value'] == "")
								return;
							d[this['name']] = this['value'];
						});
					},
					"dataSrc" : function(json) {
						if(yxFreshLoad != null) {
							layer.close(yxFreshLoad);
						}

						json.recordsFiltered=json.total;
						json.recordsTotal=json.total;
						json.total=json.total;
						json.pageNumber=json.page;
						_pageNumberYx = json.pageNumber-1;
						
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
					if(yxFreshLoad != null) {
						layer.close(yxFreshLoad);
					}
				}
			});
			
			
			var deliveryFreshLoad=null;
			//子表
			_subDeliveryTableList = $('#yy-table-delivery').DataTable({
				"columns" : _deliveryTableCols,
				"createdRow" : selRowAction,
				//"scrollX" : true,
				"processing" : true,//加载时间长，显示加载中
				"paging" :false,
				"order" : [],
				"scrollX" : true,
				"processing" : false,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				//"pageLength" : 15,
				"paging" : true,
				"fnDrawCallback" : fnDrawCallbackDelivery,//列对齐设置
				"ajax" : {
					"url" : '${apiurl}/order/listDelivery',
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					"type" : 'POST',
					"sync":'false',
					"data" : function(d) {
						deliveryFreshLoad = layer.load(2);
						//d.orderby = getOrderbyParam(d);
						var _subqueryData = $("#yy-form-subquery-delivery").serializeArray();
						if (_subqueryData == null)
							return;
						$.each(_subqueryData, function(index) {
							if (this['value'] == null || this['value'] == "")
								return;
							d[this['name']] = this['value'];
						});
					},
					"dataSrc" : function(json) {
						if(deliveryFreshLoad != null) {
							layer.close(deliveryFreshLoad);
						}
						json.recordsFiltered=json.total;
						json.recordsTotal=json.total;
						json.total=json.total;
						//json.totalPages=1;
						json.pageNumber=json.page;
						_pageNumberDelivery = json.pageNumber-1;
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
					if(deliveryFreshLoad != null) {
						layer.close(deliveryFreshLoad);
					}
				}
			});
		}
		
		 //定义行点击事件
		function selRowAction(nRow, aData, iDataIndex) {
			$(nRow).dblclick(function() {
				onViewDetailRow(aData, iDataIndex, nRow);
			});
		
			$('#yy-btn-edit-row', nRow).click(function() {
				layer.open({
					title:" ",
				    type: 2,
				    area: ['500px', '150px'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/toProduce?uuid='+aData.uuid+'&orderId='+aData.orderId
				});
			});
		};
		
		function fnDrawCallbackYx(){
			var pageLength = $('select[name="yy-table-sublist_length"]').val() || 10;
			_subYaoxinTableList.column(0).nodes().each(function(cell, i) {
				cell.innerHTML = i + 1 + (_pageNumberYx) * pageLength;
			});
		}
		
		function fnDrawCallbackDelivery(){
			var pageLength = $('select[name="yy-table-sublist"]').val() || 10;
			_subDeliveryTableList.column(0).nodes().each(function(cell, i) {
				cell.innerHTML = i + 1 + (_pageNumberDelivery) * pageLength;
			});
		}
		//生产回调方法 刷新子表
		function onRefreshSub() {
			_subYaoxinTableList.draw(); //服务器分页
		}
		
		
		
		
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'number' : {required : true,maxlength : 100},
					'customer' : {required : true,maxlength : 100},
					'model' : {required : true,maxlength : 100},
					'price' : {required : true,number:true,maxlength : 100},
					'planCount' : {required : true,number:true,digits:true,maxlength : 100},
					'producePlanCount' : {required : true,number:true,digits:true,maxlength : 100},
					//'useStorageCount' : {required : true,number:true,digits:true,maxlength : 20},
					//'stuffCount' : {required : true,number:true,digits:true,maxlength : 20},
					'memo' : {maxlength : 200}
				}
			});
		}
		
		
		var fileuploadLoading;
		
		function onSave(isClose) {
			addSubListValid();
			if (!$('#yy-form-edit').valid()) return false;
			doBeforeSave();
			if (!validOther()) return false;
			
			fileuploadLoading=layer.load(2);
			_fileUploadTool.saveFiles("${apiuploadUrl}","afterUploadFile");
		}
		
		
		//上传附件回调方法
		function afterUploadFile(data){
			console.info("afterUploadFile-------------------------");
			console.info(data);
			
			layer.close(fileuploadLoading);
			
			var editview = layer.load(2);
			if(data.flag==0){
				var posturl = "${apiurl}/order/create";
				var pk = $("input[name='uuid']").val();
				if (pk != "" && typeof (pk) != "undefined") {
					posturl = "${apiurl}/order/update";
				}
				
				var fileObj=data.obj;
				var resultFile=new Array();
			    $(".uploadFilePathCls").each(function(){
					console.info("======"+$(this).val());
					resultFile.push($(this).val());
				 });
				if(fileObj!=null&&fileObj.length>0){
					for(var i=0;i<fileObj.length;i++){
						resultFile.push(fileObj[i]);
					}
				}
				$("#fileList").val(JSON.stringify(resultFile));
				
				var opt = {
					url : posturl,
					type : "post",
					xhrFields: {withCredentials: true},
			        crossDomain: true,
					success : function(data) {
						if (data.flag==0) {
							layer.close(editview);
							if (isClose) {
								window.parent.YYUI.succMsg(data.msg);
								window.parent.onRefresh(true);
								closeEditView();
							} else {
								YYUI.succMsg(data.msg);
							}
							doAfterSaveSuccess(data.records);
						}else if (data.flag==-10) {
							YYUI.promMsg('会话超时，请重新的登录!');
							window.location = '${ctx}/logout';
							return [];
						} else {
							window.parent.YYUI.failMsg(data.msg);
							layer.close(editview);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						window.parent.YYUI.promAlert("操作失败，HTTP错误。");
						layer.close(editview);
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			}else if (data.flag==-10) {
				YYUI.promMsg('会话超时，请重新的登录!');
				window.location = '${ctx}/logout';
				return [];
			}else{
				YYUI.promMsg('上传附件失败：'+data.msg);
			}
		}
		
		//回调选择产品料号
		function callBackSelectStuff(data){
			$("#stuff").val(data.stuff);
			$("#model").val(data.model);
		}
		//回调选择客户
		function callBackSelectCustomer(data){
			$("#customer").val(data.customer);
		}
	</script>
</body>
</html>
