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
					
					<label class="control-label">项目</label>
					<div class="input-group">
						<select class="combox form-control" id="search_LIKE_mainId" name="search_LIKE_main.uuid" style="float: left;width: 200px;">
							<option value=""></option>
						</select>
					</div>
												
					<label for="search_LIKE_main.name" class="control-label">箱号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<select class="yy-input-enumdata form-control" id="search_EQ_boxNum" name="search_EQ_boxNum"
								 data-enum-group="BoxNum"></select>	
								 
					<label for="search_LIKE_materialCode" class="control-label">物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_materialCode" class="form-control input-sm">
					
					<label for="search_LIKE_material.name" class="control-label">物料名称</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm">			 
							
					<label for="search_LIKE_barcode" class="control-label">条码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					<input type="text" autocomplete="on" name="search_LIKE_barcode" id="search_LIKE_barcode" class="form-control input-sm">	  

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
							<!-- <th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
							</th> -->
							<th>操作</th>
							<th>新条码</th>
							<th>条码</th>
							<th>单据状态</th>
							<th>项目号</th>
							<th>项目名称</th>
							<th>箱号</th>
							<th>物料编码</th>
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
					+ "<button  onclick='saveNewBarcode(this);' rowUuid='"+full.uuid+"'class='btn btn-xs btn-info' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button>"
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
				orderable : false
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
				width : "80",
				className : "center",
				orderable : false
			},{
				data : "main.name",
				width : "100",
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
				width : "100",
				className : "center",
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
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataDetail?orderby=createtime@desc;mid@desc');
			
			$("#yy-btn-match").bind('click', matchMaterial);//
			
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
			
			$("#search_LIKE_mainId").select2({
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
				//"pageLength" : 15,
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
								if(totalRecord==1){
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
			if(t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			var t_boxNum = $("#search_EQ_boxNum").val();
			if(t_boxNum==''){
				YYUI.promMsg("请选择箱号");
				return false;
			}
			
			_ismatchSearch=true;//设置为扫描条形码查询
			
			var searchCode = "";
			var t_sweepCode = $("#sweepCode").val();
			if(t_sweepCode!=null&&t_sweepCode!=''){
				if(jsonResp!=null&&jsonResp.length>0){
					for (i = 0; i < jsonResp.length; i++) {
						var t_pre = jsonResp[i].enumdatakey;
						var materialLength = parseInt(jsonResp[i].showorder);
						console.info(t_pre+"======"+t_sweepCode.indexOf(t_pre)+">>>"+(t_pre.length+materialLength));
						if(t_sweepCode.indexOf(t_pre)==0){
							searchCode = t_sweepCode.substring(t_pre.length,t_pre.length+materialLength);
							console.info("searchCode>>>>>>>>>"+searchCode);
							$("#search_LIKE_materialCode").val(searchCode);
							break;
						}
					}
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
			console.info($(t).attr("rowUuid"));
			$.ajax({
				type : "POST",
				data :{"newBarcode": newBarcodeVal,"subId":$(t).attr("rowUuid")},
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
	</script>
</body>
</html>	

