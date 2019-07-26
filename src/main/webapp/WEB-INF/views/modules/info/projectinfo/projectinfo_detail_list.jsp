<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<html>
<head>
<title>项目明细</title>
<style type="text/css">
#yy-table-list{
	width: 100% !important;
}
//如果遇到设有横向滚动条时，就固定设置Table宽度

#yy-table-listxxxxx{
	width: ***px !important;
}

</style>
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
				
				
				 <button id="yy-btn-approve-project" class="btn yellow btn-sm btn-info" type="button">
					<i class="fa fa-check"></i> 审核
				</button>
				<button id="yy-btn-unapprove-project" class="btn yellow btn-sm btn-info">
					<i class="fa fa-reply"></i> 取消审核
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
					
					<!-- <label class="control-label">项目</label>
					<div class="input-group input-icon right">
						<input id="search_LIKE_mainId" name="search_LIKE_main.uuid" type="hidden"> 
						<i class="fa fa-remove" onclick="cleanDef('search_LIKE_mainId','search_LIKE_mainName');" title="清空"></i>
						<input id="search_LIKE_mainName" name="search_LIKE_main.name" type="text" class="form-control" readonly="readonly">
						<span class="input-group-btn">
							<button id="yy-project-select" class="btn btn-default btn-ref" type="button">
								<span class="glyphicon glyphicon-search"></span>
							</button>
						</span>
					</div> -->
					
					<c:choose>
						<c:when test="${empty sourceBillId}">
							<label class="control-label">项目</label>
							<div class="input-group">
								<select class="combox form-control projectSelectCls" id="search_LIKE_mainId" name="search_LIKE_main.uuid" style="float: left;width: 200px;">
									<option value=""></option>
								</select>
							</div>
						</c:when>
						<c:otherwise>
							<input name="search_LIKE_main.uuid" id="search_LIKE_mainId" type="hidden" value="${sourceBillId}" class="yy-input"> 
							<span style="display: none;">
								<select class="combox form-control projectSelectCls"  name="" style="display: none;">
										<option value="${sourceBillId}">${sourceBillId}</option>
								</select>
							</span>
						</c:otherwise>
					</c:choose>
												
					<label for="search_EQ_boxNum" class="control-label">箱号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<!-- <select class="yy-input-enumdata form-control" id="search_EQ_boxNum" name="search_EQ_boxNum"
								 data-enum-group="BoxNum"></select>	 -->
					<input type="text" autocomplete="on" name="search_EQ_boxNum" id="search_EQ_boxNum" class="form-control input-sm">
								 
					<label for="search_LIKE_materialCode" class="control-label">物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_materialCode" class="form-control input-sm">
					
					<label for="search_LIKE_materialHwCode" class="control-label">华为物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.hwcode" id="search_LIKE_materialHwCode" class="form-control input-sm">
					
					<label for="search_LIKE_material.name" class="control-label">物料名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm">			 
							
					<label for="search_LIKE_barcode" class="control-label">条码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" autocomplete="on" name="search_LIKE_barcode" id="search_LIKE_barcode" class="form-control input-sm">	  

					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="yy-searchbar-reset" type="button" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
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
							<th>新条码</th>
							<th>条码</th>
							<th>单据状态</th>
							<th>项目号</th>
							<!-- <th>项目名称</th> -->
							<th>箱号</th>
							<th>条码类型</th>
							<th>华为物料编码</th>
							<th>物料名称</th>
							<th>计划数量</th>	
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
		var _ismatchSearch=false;//是否条码匹配的
		var jsonResp = jQuery.parseJSON('${subList}');
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
				render : function(data, type, full) {
					return "<div class='yy-btn-actiongroup'>"
					+ "<button  onclick='saveNewBarcode(this);' rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button>"
					+ "</div>";
				},
				width : "30"
			}, {
				data : 'newBarcode',
				width : "80",
				className : "center",
				orderable : true,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					return '<input class="form-control" value="'+ data + '" name="newBarcode">';
				}
			}, {
				data : 'barcode',
				width : "80",
				className : "center",
				render : function(data, type, full) {
					if(full.checkStatus=='30'){
						return '<span style="color:#e02222;">'+data+'</span>';
					} else if(full.checkStatus=='20'){
						return '<span style="color:#319430;">'+data+'</span>';
					}else{
						return data;
					}
				},
				orderable : false
			},{
				data : "main.billstatus",
				width : "50",
				className : "center",
				render : function(data, type, full) {
					if(full.checkStatus=='30'){
						return '<span style="color:#e02222;">'+YYDataUtils.getEnumName("BillStatus", data)+'</span>';
					} else if(full.checkStatus=='20'){
						return '<span style="color:#319430;">'+YYDataUtils.getEnumName("BillStatus", data)+'</span>';
					}else{
						return YYDataUtils.getEnumName("BillStatus", data);
					}
				},
				orderable : false
			},{
				data : "main.code",
				width : "80",
				className : "center",
				render : function(data, type, full) {
					if(full.checkStatus=='30'){
						return '<span style="color:#e02222;">'+data+'</span>';
					} else if(full.checkStatus=='20'){
						return '<span style="color:#319430;">'+data+'</span>';
					}else{
						return data;
					}
				},
				orderable : false
			}/* ,{
				data : "main.name",
				width : "100",
				className : "center",
				render : function(data, type, full) {
					if(full.checkStatus=='30'){
						return '<span style="color:#e02222;">'+data+'</span>';
					} else if(full.checkStatus=='20'){
						return '<span style="color:#319430;">'+data+'</span>';
					}else{
						return data;
					}
				},
				orderable : false
			} */, {
				data : 'boxNum',
				width : "30",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("BoxNum", data);
				}
			},{
				data : "limitCount",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return '<a onclick="toUpdateLimitCount(\''+full.uuid+'\');">【'+YYDataUtils.getEnumName("MaterialLimitCount", data)+'】</a>';
				},
				orderable : false
			},{
				data : "material.hwcode",
				width : "100",
				className : "center",
				render : function(data, type, full) {
					return '<a onclick="showMaterial(\''+full.material.uuid+'\');">'+data+'</a>';
				},
				orderable : false
			},{
				data : "material.name",
				width : "100",
				className : "center",
				render : function(data, type, full) {
					return '<a onclick="showMaterial(\''+full.material.uuid+'\');">'+data+'</a>';
				},
				orderable : false
			}, {
				data : 'planAmount',
				width : "30",
				className : "center",
				orderable : false
			}/* ,{
				data : "memo",
				width : "100",
				className : "center",
				orderable : false
			} */];


		//var _setOrder = [[5,'desc']];
			//分页页码
		$.fn.dataTable.defaults.aLengthMenu = [ [10, 50, 100, 200, 500 ],
			[ 10, 50, 100, 200, 500 ] ];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataDetail?orderby=createtime@desc;mid@desc');
			
			$("#yy-btn-match").bind('click', matchMaterial);//
			$("#yy-btn-approve-project").bind('click', approveProject);//
			$("#yy-btn-unapprove-project").bind('click', unApproveProject);//
			
			//选择角色
			$('#yy-project-select').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择项目',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					content : '${ctx}/sys/ref/refProjectInfo?callBackMethod=window.parent.callBackSelectProject'//iframe的url
				});
			});
			
			$(".projectSelectCls").select2({
		        theme: "bootstrap",
		        allowClear: true,
		        placeholder: "请选择",
		        ajax:{
		            url:"${ctx}/info/projectinfo/select2Query",
		            dataType:"json",
		            delay:250,
		            data:function(params){
		                return {codeOrName: params.term};
		            },
		            cache:true,
		            processResults: function (res, params) {
		            	console.info(res);
		            	console.info(params);
		                var options = [];
		                var records = res.records;
		                for(var i= 0, len=records.length;i<len;i++){
		                    var option = {"id":records[i].uuid, "text":records[i].name+"("+records[i].code+")"};
		                    options.push(option);
		                }
		                return {
		                    results: options
		                };
		            },
		            escapeMarkup: function (markup) { return markup; },
		            minimumInputLength: 1
		        }
		    });
			
		});
		
		
		//清空
		function onReset() {
			YYFormUtils.clearQueryForm("yy-form-query");
			$(".projectSelectCls").select2("val", " "); 
			return false;
		}
		
		//重写双击点击
		function onEditRow(aData, iDataIndex, nRow){
			return false;
		}
		
		//服务器分页
		function serverPage(url) {
			var serverPageWaitLoad=layer.load(2);//加载等待ceng edit by liusheng		
			doBeforeServerPage();
			if (url == null) {
				url = '${serviceurl}/query';
			}
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order" : _setOrder,
				"scrollX" : true,
				"processing" : false,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				"pageLength" : 200,
				"paging" : true,
				//"fixedHeader": true,//表头
				"footerCallback" : setTotal,//合计
				"fnDrawCallback" : fnDrawCallback,//列对齐设置
				"ajax" : {
					"url" : url,
					"type" : 'POST',
					"sync":'false',
					"data" : function(d) {
						freshLoad = layer.load(2);
						d.orderby = getOrderbyParam(d);
						if (_queryData == null)
							return;
						$.each(_queryData, function(index) {
							if (this['value'] == null || this['value'] == "")
								return;
							d[this['name']] = this['value'];
						});
					},
					"dataSrc" : function(json) {
						if(freshLoad != null) {
							layer.close(freshLoad);
						}
						_pageNumber = json.pageNumber;
						if(_ismatchSearch){
							var totalRecord = json.recordsTotal;
							if(totalRecord>0){
								YYUI.succMsg('匹配'+totalRecord+'条记录');
								if(json.records.length==1){
									json.records[0].newBarcode=$("#sweepCode").val();
								}
							}
						}
						return json.records == null ? [] : json.records;
					}
				},
				"initComplete": function(settings, json) {
					console.info("initComplete>>>>>>>>>>>>>>");
					if(freshLoad != null) {
						layer.close(freshLoad);
					}
					layer.close(serverPageWaitLoad);//关闭加载等待ceng edit by liusheng
				}
			});
		}
		
		
		//匹配物料
		function matchMaterial(){
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			var t_boxNum = $("#search_EQ_boxNum").val();
			if(t_boxNum==null||t_boxNum==''){
				YYUI.promMsg("请填写箱号");
				return false;
			}
			
			_ismatchSearch=true;//设置为扫描条形码查询
			
			var searchCode = "";
			var t_sweepCode = $("#sweepCode").val();
			if(t_sweepCode!=null&&t_sweepCode!=''){
				var hasMatch=false;
				if(jsonResp!=null&&jsonResp.length>0){
					for (i = 0; i < jsonResp.length; i++) {
						var t_pre = jsonResp[i].enumdatakey;
						var materialLength = parseInt(jsonResp[i].showorder);
						console.info(t_pre+"======"+t_sweepCode.indexOf(t_pre)+">>>"+(t_pre.length+materialLength));
						if(t_sweepCode.indexOf(t_pre)==0){//以19,39...开头的
							searchCode = t_sweepCode.substring(t_pre.length,t_pre.length+materialLength);//截取位数
							console.info("searchCode>>>>>>>>>"+searchCode);
							$("#search_LIKE_materialHwCode").val(searchCode);
							hasMatch=true;
							break;
						}
					}
				}
				if(!hasMatch){
					$("#search_LIKE_materialHwCode").val(t_sweepCode);
				}
			}
			//获取查询数据，在表格刷新的时候自动提交到后台
			_queryData = $("#yy-form-query").serializeArray();
			onRefresh();
		}
		
		
		function doBeforeQuery() {
			_ismatchSearch=false;
			return true;
		}
		
		
		//回调选择项目
		function callBackSelectProject(selNode){
			$("#search_LIKE_mainId").val(selNode.uuid);
			$("#search_LIKE_mainName").val(selNode.name);
		}
		
		function saveNewBarcode(t){
			var newBarcodeVal = $(t).closest("tr").find("input[name='newBarcode']").val();
			var row = $(t).closest("tr");
			var tr_hwcode = _tableList.row(row).data().material.hwcode;
			console.info("tr_hwcode>>>>11>>>>"+tr_hwcode);
			console.info(tr_hwcode+">>>>>>>>>"+newBarcodeVal);
			console.info(newBarcodeVal.indexOf(tr_hwcode));
			
			var showLengthConfirm=false;
			if(jsonResp!=null&&jsonResp.length>0&&newBarcodeVal!=null){
				for (i = 0; i < jsonResp.length; i++) {
					var t_pre = jsonResp[i].enumdatakey;
					var materialLength = parseInt(jsonResp[i].showorder);
					console.info(t_pre+"======"+newBarcodeVal.indexOf(t_pre)+">>>"+(t_pre.length+materialLength));
					if(newBarcodeVal.indexOf(t_pre)==0){//以19,39...开头的
						searchCode = newBarcodeVal.substring(t_pre.length,t_pre.length+materialLength);//截取位数
						console.info("searchCode>>>>>>>>>"+searchCode);
						console.info("限制长度："+jsonResp[i].description+">>条码长度："+newBarcodeVal.length);
						var limitLength = jsonResp[i].description;
						if(limitLength!=null&&limitLength!=''&&parseInt(limitLength)!=newBarcodeVal.length){
							showLengthConfirm =true;
						}
						break;
					}
				}
			}
			if(showLengthConfirm){
				layer.confirm(jsonResp[i].enumdataname+'限制长度为'+limitLength+',确定要保存吗', function(index) {
					if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
						onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"));
					}else{
						layer.confirm("条码与华为物料编码不符合，确定要保存吗", function() {
							onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"));
						});
					}
				});
			}else{
				if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
					onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"));
				}else{
					layer.confirm("条码与华为物料编码不符合，确定要保存吗", function() {
						onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"));
					});
				}
			}
		}
		
		
		function onCheckBarCode(newBarcodeVal,subId){
			$.ajax({
				type : "POST",
				data :{"newBarcode": newBarcodeVal,"subId":subId},
				url : "${serviceurl}/checkBarcode",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						onSaveBarCode(newBarcodeVal,subId);
					}else{
						layer.confirm(data.msg+",确定要修改吗?", function() {
							onSaveBarCode(newBarcodeVal,subId);
						});
					}
				},
				error : function(data) {
					YYUI.promMsg("操作失败，请联系管理员");
				}
			});
		}
		
		function onSaveBarCode(newBarcodeVal,subId){
			$.ajax({
				type : "POST",
				data :{"newBarcode": newBarcodeVal,"newUuid":subId},
				url : "${serviceurl}/updateBarcode",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						YYUI.succMsg(data.msg);
						onQuery();
					}else{
						YYUI.promMsg(data.msg);
					}
				},
				error : function(data) {
					YYUI.promMsg("操作失败，请联系管理员");
				}
			});
		}
		
		function approveProject(){
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			
			$.ajax({
				type : "POST",
				data :{"pks": t_projectId},
				url : "${ctx}/info/projectinfo/batchApprove",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						YYUI.succMsg("审核成功");
						onQuery();
					}else{
						YYUI.promMsg(data.msg);
					}
				},
				error : function(data) {
					YYUI.promMsg("操作失败，请联系管理员");
				}
			});
		}
		
		function unApproveProject(){
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			
			$.ajax({
				type : "POST",
				data :{"pks": t_projectId},
				url : "${ctx}/info/projectinfo/batchUnApprove",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						YYUI.succMsg("取消审核成功");
						onQuery();
					}else{
						YYUI.promMsg(data.msg);
					}
				},
				error : function(data) {
					YYUI.promMsg("操作失败，请联系管理员");
				}
			});
		}
		
		//查看物料明细
		function showMaterial(uuid){
			layer.open({
				type : 2,
				title : '物料信息',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/material/onDetail?isShowBtn=0&uuid='+uuid//iframe的url
			});
		}
		
		//修改批次数量
		function toUpdateLimitCount(subId){
			layer.open({
				type : 2,
				title : '修改条码类型',
				shadeClose : false,
				shade : 0.8,
				area : [ '500px', '250px;' ],
				content : '${ctx}/info/projectinfoSub/toUpdateLimitCount?subId='+subId//iframe的url
			});
		}
	</script>
</body>
</html>	

