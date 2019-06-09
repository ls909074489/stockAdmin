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
	
		<div class="row yy-toolbar" style="">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel-dialog" class="btn blue btn-sm" onclick="closeEditView();">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
		<div class="yy-tab" id="yy-page-sublist">
					<div class="tab-content">
						<div class="tab-pane active" id="tab0">
							<div class="row yy-toolbar" id="subListToolId" style="">
								<button id="addNewSub" class="btn green btn-sm btn-info" type="button">
									<i class="fa fa-plus"></i> 添加
								</button>
								<span id="tipTd"></span>
								
								<div role="form" class="form-inline" style="display: none;">
									<form id="yy-form-subquery-yx">	
										<input type="hidden" name="uuid" id="uuid" value="${uuid}">	
										<input type="hidden" name="toDay" id="toDay" value="${toDay}">	
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
										<th>计划生产数量</th>
										<th>入库数量</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="5" style="text-align: right;">
											计划生产总量<span id="totalCount"></span>&nbsp;&nbsp;
										</td>
									</tr>
								</tfoot>
							</table>
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
		width : "80",
		//render :YYDataTableUtils.renderRemoveActionCol
		render:function (data, type, full){
			var actionStr="<div class='yy-btn-actiongroup'>";
			if(data!=0){
				actionStr+="<button id='yy-btn-edit-row' class='btn btn-xs btn-info edit-row' data-rel='tooltip' title='生产'><i class='fa fa-edit'></i>生产</button>";
			}
			
			actionStr+='<button onclick="delTr(this);" type="button" class="btn btn-xs btn-danger" data-rel="tooltip" title="删除"><i class="fa fa-trash-o"></i>删除</button>';
			actionStr+="</div>";
			return actionStr;
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
			return '<input type="hidden" class="notSubFormEle" name="uuid" value="'+tUuid+'"><input type="hidden" class="notSubFormEle" name="orderId" value="'+tOrderId+'">'+
			'<input value="'+ data + '" name="produceDate" class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\'});">';
			//data;
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
			return '<input class="form-control planCountCls" value="'+ data + '" name="planCount" onkeyup="resetTotalCount();">';
			//return data;
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
		
		_subYaoxinTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			"createdRow" : selRowAction,
			"paging" : false
		});
		
		initSubTable();
				
		setValue();
		
		$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
		$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
		
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();
			
			var tDay=$("#toDay").val();
			var nextDay=addOneDay($("#toDay").val());
			$("#toDay").val(nextDay);
			
			var subNewData = [ {
				'uuid' : 0,
				'produceDate' : tDay,
				'planCount' :'',
				'produceCount' :''
			} ];
			var nRow = _subYaoxinTableList.rows.add(subNewData).draw().nodes()[0];//添加行，并且获得第一行
			resetRowNum();
		});
		
		$(".planCountCls").change(function(){
			resetTotalCount();
		});
	});
	
	function addOneDay(startDate) {
        startDate = new Date(startDate);
        startDate = +startDate + 1000*60*60*24;
        startDate = new Date(startDate);
        var hourStr=(startDate.getMonth()+1)+"";
        if(hourStr.length==1){
        	hourStr="0"+hourStr;
        }
        var secondStr=startDate.getDate()+"";
        if(secondStr.length==1){
        	secondStr="0"+secondStr;
        }
        var nextStartDate = startDate.getFullYear()+"-"+hourStr+"-"+secondStr;
        return nextStartDate;
    }
	
	
	function initSubTable(){
		$.ajax({
			url : '${apiurl}/order/listPlan',
			data : {
				"uuid" : '${uuid}',
				"orderby" : "createtime@asc"
			},
			xhrFields: {withCredentials: true},
	        crossDomain: true,
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(json) {
				_subYaoxinTableList.clear();
				
				json.recordsFiltered=json.total;
				json.recordsTotal=json.total;
				json.total=json.total;
				json.pageNumber=json.page;
				_pageNumberYx = json.pageNumber-1;
				
				if (json.flag==-10) {
					YYUI.promMsg('会话超时，请重新的登录!');
					window.location = '${ctx}/logout';
					return [];
				}
				_subYaoxinTableList.rows.add(json.obj == null ? [] : json.obj);
				_subYaoxinTableList.draw();
				resetRowNum();
				resetTotalCount();
			}
		});
	}
	
	function resetTotalCount(){
		var tTotal=0;
		$(".planCountCls").each(function(){
			var tVal=$(this).val();
			console.info(tVal);
			if(tVal!=null&&tVal!=''){
				tTotal=parseFloat(tTotal)+parseFloat(tVal);
			}
		});
		$("#totalCount").html(tTotal);
	}
	
	function resetRowNum(){
		var pageLength = $('select[name="yy-table-sublist_length"]').val() || 10;
		_subYaoxinTableList.column(0).nodes().each(function(cell, i) {
			cell.innerHTML = i + 1 ;// (_pageNumberYx) * pageLength;
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
	
	function delTr(t){
		layer.confirm("确定要删除吗？", function(index) {
			layer.close(index);
			var nRow = $(t).closest('tr')[0];
			var row = _subYaoxinTableList.row(nRow);
			var data = row.data();
			row.remove().draw();
			resetRowNum();
			resetTotalCount();
		});
	}
	
	//设置默认值
	function setValue(){
		var rowData=window.parent.getRowData('${uuid}');
		$("#tipTd").html("订单数量:"+rowData.planCount+",使用现有库存:"+rowData.useStorageCount+",需生产数量:"+(rowData.planCount-rowData.useStorageCount));
		
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
		if (!validOther()) return false;
		
		var result = new Array();
		$("#yy-table-sublist tbody tr").each(function(){
			var trObj={}
			$(this).find('input, select').not('.notSubFormEle').each(function(){
				if(trObj[this['name']]){
					trObj[this['name']] = trObj[this['name']]+","+this['value']; 
				}else{ 
					trObj[this['name']] = this['value']; 
				} 
			});
			result.push(trObj);
		});

		var postData={"produceList": JSON.stringify(result),"uuid":$("input[name='uuid']").val()};
		var waitInfoLoading = layer.load(2);
		$.ajax({
			type : "POST",
			data :postData,
			url : "${apiurl}/order/makePlan",
			async : true,
			xhrFields: {withCredentials: true},
	        crossDomain: true,
			dataType : "json",
			success : function(data) {
				layer.close(waitInfoLoading);
				if (data.flag==0) {
					if (isClose) {
						window.parent.YYUI.succMsg(data.msg);
						window.parent.onRefresh(true);
						closeDialog();
					} else {
						YYUI.succMsg(data.msg);
					}
				}else if (data.flag==-10) {
					YYUI.promMsg('会话超时，请重新的登录!');
					window.location = '${ctx}/logout';
				} else {
					window.parent.YYUI.failMsg(data.msg);
				}
			},
			error : function(data) {
				layer.close(waitInfoLoading);
				YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
			}
		});
	}
		
	//取消编辑，返回列表视图
	function closeDialog() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
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
		return [ {
			name : "produceDate",
			rules : {
				required :true,
				maxlength:20
			},
			message : {
				required : "必输",
				maxlength : "最大长度为20"
			}
		},{
			name : "planCount",
			rules : {
				required :true,
				digits :true,
				maxlength:20
			},
			message : {
				required : "必输",
				digits : "只能输入整数",
				maxlength : "最大长度为20"
			}
		}
		];
	}
	
	
	//刷新子表
	function onRefreshSub() {
		//_subYaoxinTableList.draw(); //服务器分页
		initSubTable();
		window.parent.onRefresh(true);
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