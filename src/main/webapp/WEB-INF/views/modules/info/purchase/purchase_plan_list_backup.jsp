<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/purchase"/>
<html>
<head>
<title>计划列表</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content">
	
		<div class="row yy-toolbar" style="display: none;">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
		<div style="display: none;">
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
					<input name="uuid" id="uuid" type="hidden"/>
					<div class="row">
						<div class="col-md-8">
							<div class="form-group">
								<label class="control-label col-md-2">名称</label>
								<div class="col-md-10"><input class="form-control"  id="name" name="name"  type="text" value="${entity.name}"></div>
							</div>
						</div>	
					</div>
			</form>
		</div>
		
		<div class="yy-tab" id="yy-page-sublist">
				<div class="tabbable-line">
					<ul class="nav nav-tabs ">
						<li class="active">
							<a href="#tab0" data-toggle="tab"> 计划列表</a>
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
					</div>
				</div>
			</div>
	</div>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	
	<script type="text/javascript">
	var _subYaoxinTableList;//子表
	var _addList = new Array(); //新增的行/修改的行
	var _deletePKs = new Array();//需要删除的PK数组
	var _columnNum;
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
	

	var _pageNumberYx;
	
	$(document).ready(function() {
		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		     //当切换tab时，强制重新计算列宽
		     $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
		} );
		
		bindEditActions();//綁定平台按鈕
		
		initSubTable();
				
		setValue();
		
		$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
		$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
		
		validateForms();
	});
	
	
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
		
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();
			
			var subNewData = [ {
				'uuid' : '',
				'columnAnno' : '',
				'columnName' :'',
				'width' :'100',
				'isDisplay' : '',
				'isCompare' : '',
				'compareType' : ''
			} ];
			var nRow = _subYaoxinTableList.rows.add(subNewData).draw().nodes()[0];//添加行，并且获得第一行
			_subYaoxinTableList.on('order.dt search.dt',
			        function() {
				_subYaoxinTableList.column(0, {
					        search: 'applied',
					        order: 'applied'
				        }).nodes().each(function(cell, i) {
					        cell.innerHTML = i + 1;
				        });
			}).draw(); 
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
	
	//设置默认值
	function setValue(){
		if('${openstate}'=='add'){
			//$("input[name='billdate']").val('${billdate}');
			$("#stationUuid").val('${currentStation.uuid}');
			$("#stationName").val('${currentStation.name}');
		}else if('${openstate}'=='edit'){
			$("input[name='uuid']").val('${entity.uuid}');
			$("input[name='search_EQ_main.uuid']").val('${entity.uuid}');//子表查询时，主表id	
			$("input[name='mainId']").val('${entity.uuid}');//子表查询时，主表id	
		}
	}
	
	
	//主子表保存
	function onSave(isClose) {
		var subValidate=validOther();
		var mainValidate=$('#yy-form-edit').valid();
		if(!subValidate||!mainValidate){
			return false;
		}
		
		//保存新增的子表记录 
		var subList = new Array();
		
         _table = $("#yy-table-sublist").dataTable();
         var rows = _table.fnGetNodes();
         for(var i = 0; i < rows.length; i++){
             subList.push(getRowData(rows[i]));
         }
		var subData = null;
		//所有需要保存的参数
		subData = {
			"subList" : subList,
			"deletePKs" : _deletePKs
		};
		
		var posturl = "${serviceurl}/addwithsub";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != null)
			posturl = "${serviceurl}/updatewithsub";
			
		var saveWaitLoad=layer.load(2);
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			success : function(data) {
				layer.close(saveWaitLoad);
				if (data.success == true) {
					_deletePKs = new Array();
					_addList = new Array();
					hasLoadSub = false;
					YYUI.succMsg(data.msg);
					window.parent.onRefresh(true);
					closeEditView();
					window.location.reload();
				} else {
					YYUI.promAlert(data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	
	//表头校验
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
           		'name' : {required : true,maxlength:50}
			}	
		}); 
	}
	//校验子表
	function validOther(){
		if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row]"),getRowValidator())==false){
			return false;
		}
		else{
			return true;
		} 
		return true;
	}
	
	//表体校验
	function getRowValidator() {
		return [{
					name : "mapkey",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "mapval",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				}
		];
	}
	
	
	//刷新子表
	function onRefreshSub() {
		_subYaoxinTableList.draw(); //服务器分页
	}
	//重置子表查询条件
	function onResetSub() {
		YYFormUtils.clearForm("yy-form-subquery-yx");
		return false;
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
</script>
</body>
</html>