<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfo"/>
<c:set var="servicesuburl" value="${ctx}/info/projectinfoSub"/>
<html>
<head>
<title>项目</title>
</head>
<body>
<div id="yy-page-edit" class="container-fluid page-container page-content">
	
		<div class="row yy-toolbar">
			<!-- <button id="yy-btn-confrim-receive" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 确认收货
			</button>
			<button id="yy-btn-temp-receive" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 暂存
			</button> -->
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
		<div>
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" id="uuid" type="hidden" value="${entity.uuid}"/>
				<fieldset disabled="disabled">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >项目号</label>
							<div class="col-md-8" >
								<input name="code" id="code" type="text" value="${entity.code}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >项目名称</label>
							<div class="col-md-8" >
								<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">仓库</label>
							<div class="col-md-8">
								<div class="input-group input-icon right">
										<input id="stockUuid" name="stockId" type="hidden" value="${entity.stock.uuid}"> 
										<i class="fa fa-remove" onclick="cleanDef('stockUuid','stockName');" title="清空"></i>
										<input id="stockName" name="stockName" type="text" class="form-control" readonly="readonly" 
											value="${entity.stock.name}">
										<span class="input-group-btn">
											<button id="stock-select-btn" class="btn btn-default btn-ref" type="button">
												<span class="glyphicon glyphicon-search"></span>
											</button>
										</span>
									</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >备注</label>
							<div class="col-md-10" >
								<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				</fieldset>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">列表
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<div class="row yy-toolbar">
						<div role="form" class="form-inline" style="">
							<form id="yy-form-subquery">	
								<!-- <button id="addNewSub" class="btn blue btn-sm" type="button">
									<i class="fa fa-plus"></i> 添加
								</button> -->
								&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="search_EQ_main.uuid" id="mainId" value="${entity.uuid}">	
								<input type="hidden" name="isShowReceiveLog" id="isShowReceiveLog" value="1">	
								&nbsp;&nbsp;
								<label for="search_LIKE_boxNum" class="control-label">箱号</label>
								<input type="text" autocomplete="on" name="search_LIKE_boxNum" id="search_LIKE_boxNum" 
								 class="form-control input-sm">							

								<label for="search_LIKE_material.code" class="control-label">物料编码</label>
								<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_material.code" class="form-control input-sm">
								
								<label for="search_LIKE_material.hwcode" class="control-label">华为物料编码</label>
								<input type="text" autocomplete="on" name="search_LIKE_material.hwcode" id="search_LIKE_material.hwcode" class="form-control input-sm">
								
								<label for="search_LIKE_material.name" class="control-label">物料名称</label>
								<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm">
								
								<button id="yy-btn-searchSub" type="button" class="btn btn-sm btn-info">
									<i class="fa fa-search"></i>查询
								</button>
								<button id="rap-searchbar-resetSub" type="reset" class="red">
									<i class="fa fa-undo"></i> 清空
								</button>	
							</form>
						</div>
					</div>
					<table id="yy-table-sublist" class="yy-table">
						<thead>
							<tr>
								<th>序号</th>	
								<th>操作</th>	
								<th>箱号</th>	
								<th>物料编码</th>	
								<th>华为物料编码</th>
								<th>条码类型</th>
								<th>计划数量</th>	
								<th>备注</th>	
								<th>已收数量</th>	
								<th>收货记录</th>	
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
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	
	
	<script type="text/javascript">
		var enumMap = YYDataUtils.getEnumMap();
		var enumdatas = enumMap['MaterialLimitCount'];
		
		var _subTableList;//子表
		var _deletePKs = new Array();//需要删除的PK数组
		var _columnNum;
		
		/* 子表操作 */
		var _subTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "20"
		},{
			data : "uuid",
			className : "center",
			orderable : false,
			render : function(data, type, full) {
				return '<button class="btn btn-xs btn-info" onclick="appendLog(\''+data+'\');" data-rel="tooltip" title="添加收货记录"><i class="fa fa-edit"></i>添加收货记录</button>';
			},
			width : "20"
		}, {
			data : 'boxNum',
			width : "20",
			className : "center",
			orderable : false
		}, {
			data : 'material',
			width : "80",
			className : "center",
			orderable : false,
			render : function(data, type, full) {
				var tUuid=full.uuid;
				if (typeof(tUuid) == "undefined"){
					tUuid="";
				}
				var str ='<div class="input-group materialRefDiv"> '+
				 '<input type="hidden" name="uuid" value="'+tUuid+'">'+data.code
				 '<input class="form-control"  value="'+ data.uuid + '" type="hidden" reallyname="materialId" name="materialId"> '+
				 '</div> ';
				return str;
			}
		}, {
			data : 'material.hwcode',
			width : "80",
			className : "center",
			orderable : false
		}, {
			data : 'limitCount',
			width : "20",
			className : "center",
			orderable : false,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("MaterialLimitCount", data);
			}
		}, {
			data : 'planAmount',
			width : "60",
			className : "center",
			orderable : false
		}, {
			data : 'memo',
			width : "60",
			className : "center",
			orderable : false
		}, {
			data : 'actualAmount',
			width : "80",
			className : "center",
			orderable : false
		}, {
			data : 'receiveLog',
			width : "160",
			className : "center",
			orderable : false
		}];

		 
		$(document).ready(function() {
			_subTableList = $('#yy-table-sublist').DataTable({
				"columns" : _subTableCols,
				"fixedHeader": true,//表头
				"paging" : false/* ,
				"order" : [[5,"asc"]] */
			});
			
			bindEditActions();//綁定平台按鈕
			
			$("#yy-btn-confrim-receive").bind("click", function() {
				layer.confirm("确认收货将生成入库单，确定要保存吗", function() {
					confirmReceive(isClose);
				});
			});
			$("#yy-btn-temp-receive").bind("click", function() {
				tempReceive(isClose);
			});
			
			validateForms();
			
			setValue();
			
			$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
			$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
			
			//添加按钮事件
			$('#addNewSub').click(function(e) {
				onAddSub();
			});
			
			//行操作：删除子表
			$('#yy-table-sublist').on('click', '.delete', function(e) {
				e.preventDefault();
				var delThis=$(this);
				layer.confirm('确实要删除吗？', function(index) {
					layer.close(index);
					
					//此处的this表示layer.confirm,所以delThis变量
					var nRow = delThis.closest('tr')[0];
					
					var row = _subTableList.row(nRow);
					var data = row.data();
					if (typeof (data) == null || data.uuid == '') {
						//新增的直接删除
						row.remove().draw();
					} else {
						_deletePKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
						row.remove().draw();
					}
				});
			});
		});
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'code' : {required : true,maxlength : 100},
					'name' : {required : true,maxlength : 100},
					'stockName' : {required : true,maxlength : 100},
					'memo' : {maxlength : 100}
				}
			});
		}


		//设置默认值
		function setValue(){
			if('${openstate}'=='add'){
				//$("input[name='billdate']").val('${billdate}');
			}else if('${openstate}'=='edit'){
				loadSubList();
			}
		}
		
		//主子表保存
		function confirmReceive(isClose) {
			var subValidate=validConfirm();
			var mainValidate=$('#yy-form-edit').valid();
			if(!subValidate||!mainValidate){
				return false;
			}
			//保存新增的子表记录 
	        var _subTable = $("#yy-table-sublist").dataTable();
	        var subList = new Array();
	        var rows = _subTable.fnGetNodes();
	        for(var i = 0; i < rows.length; i++){
	            subList.push(getRowData(rows[i]));
	        }
	        if(subList.length==0){
	        	YYUI.promAlert("请添加明细");
	        	return false;
	        }
			
			var saveWaitLoad=layer.load(2);
			var opt = {
				url : "${serviceurl}/confirmReceive",
				type : "post",
				data : {"subList" : subList,"deletePKs" : _deletePKs},
				success : function(data) {
					layer.close(saveWaitLoad);
					if (data.success == true) {
						_deletePKs = new Array();
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
					} else {
						YYUI.promAlert("保存失败：" + data.msg);
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
		
		
		function tempReceive(isClose) {
			var subValidate=validTemp();
			var mainValidate=$('#yy-form-edit').valid();
			if(!subValidate||!mainValidate){
				return false;
			}
			//保存新增的子表记录 
	        var _subTable = $("#yy-table-sublist").dataTable();
	        var subList = new Array();
	        var rows = _subTable.fnGetNodes();
	        for(var i = 0; i < rows.length; i++){
	            subList.push(getRowData(rows[i]));
	        }
	        if(subList.length==0){
	        	YYUI.promAlert("请添加明细");
	        	return false;
	        }
			
			var saveWaitLoad=layer.load(2);
			var opt = { 
				url : "${serviceurl}/tempReceive",
				type : "post",
				data : {"subList" : subList,"deletePKs" : _deletePKs},
				success : function(data) {
					layer.close(saveWaitLoad);
					if (data.success == true) {
						_deletePKs = new Array();
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
					} else {
						YYUI.promAlert("保存失败：" + data.msg);
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
		
		//校验子表
		function validTemp(){
			if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row]"),getRowValidatorTemp())==false){
				return false;
			}else{
				return true;
			} 
		}
		
		function validConfirm(){
			if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row]"),getRowValidatorConfirm())==false){
				return false;
			}else{
				return true;
			} 
		}
		
		//表体校验
		function getRowValidatorTemp() {
			return [ {
				name : "actualAmount",
				rules : {
					//required : true,
					//number :true,
					digits :true,
					maxlength:8
				},
				message : {
					//required : "必输",
					//number :"请输入合法的数字",
					digits :"只能输入整数",
					maxlength : "最大长度为8"
				}
			}];
		}
		
		function getRowValidatorConfirm() {
			return [ {
				name : "actualAmount",
				rules : {
					required : true,
					//number :true,
					digits :true,
					maxlength:8
				},
				message : {
					required : "必输",
					//number :"请输入合法的数字",
					digits :"只能输入整数",
					maxlength : "最大长度为8"
				}
			}];
		}
		
		//提交数据时需要特殊处理checkbox的值
		function getRowData(nRow){
			var data = $('input, select', nRow).not('input[type="checkbox"]').serialize();
			//处理checkbox的值
			$('input[type="checkbox"]',nRow).each(function(){
				var checkboxName = $(this).attr("name");
				var checkboxValue = "false";
				if(this.checked){
					checkboxValue = "true";
				}
				data = data+"&"+checkboxName+"="+checkboxValue;
			});
			return data;
		}
		
		//刷新子表
		function onRefreshSub() {
			//_subTableList.draw(); //服务器分页
			loadSubList();
		}
		//重置子表查询条件
		function onResetSub() {
			YYFormUtils.clearForm("yy-form-subquery");
			return false;
		}
		
		//加载从表数据 mainTableId主表Id
		function loadSubList() {
			var loadSubWaitLoad=layer.load(2);
			$.ajax({
				url : '${servicesuburl}/query',
				data : $("#yy-form-subquery").serializeArray(),//{"search_EQ_main.uuid" : "${entity.uuid}"},
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
		
		function appendLog(subId){
			console.info(subId);
			layer.open({
				type : 2,
				title : '收货记录',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/receive/toAppendLog?subId='+subId
			});
		}
	</script>
</body>
</html>
