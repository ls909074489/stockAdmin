<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<c:set var="servicemainurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
<title>项目明细</title>
<style type="text/css">
/* #yy-table-list{
	width: 100% !important;
}
//如果遇到设有横向滚动条时，就固定设置Table宽度

#yy-table-listxxxxx{
	width: ***px !important;
}
th,td{
     white-space:nowrap;
 }
.dataTables_scrollHead { 
        		height: 39px;
 } */
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
				<button id="yy-btn-temp-receive" class="btn blue btn-sm">
					<i class="fa fa-save"></i> 暂存收货
				</button>
				<button id="yy-btn-confrim-receive" class="btn blue btn-sm">
					<i class="fa fa-check"></i> 确认收货
				</button>
				<button id="yy-btn-cancel-receive" class="btn blue btn-sm">
					<i class="fa fa-check"></i> 撤销收货
				</button>
				<button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button>
				
				 <button id="yy-btn-approve-project" class="btn yellow btn-sm btn-info" type="button">
					<i class="fa fa-check"></i> 审核
				</button>
				<button id="yy-btn-unapprove-project" class="btn yellow btn-sm btn-info">
					<i class="fa fa-reply"></i> 取消审核
				</button>
				
				<button id="yy-btn-export-pks" queryformid="yy-form-query" class="btn green btn-sm btn-info">
					<i class="fa fa-chevron-up"></i> 导出
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
								<select class="combox form-control projectSelectCls" id="search_LIKE_mainId" onchange="changeProjectSel();" name="search_LIKE_main.uuid" style="float: left;width: 200px;">
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
												
					<label for="search_EQ_boxNum" class="control-label">箱号</label>
					<!-- <select class="yy-input-enumdata form-control" id="search_EQ_boxNum" name="search_EQ_boxNum"
								 data-enum-group="BoxNum"></select>	 -->
					<input type="text" autocomplete="on" name="search_EQ_boxNum" id="search_EQ_boxNum" style="width:120px;" class="form-control input-sm">
								 
					<!-- <label for="search_LIKE_materialCode" class="control-label">物料编码</label>
					<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_materialCode" class="form-control input-sm"> -->
					
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
				<form id="yy-form-edit" class="form-horizontal yy-form-edit">
					<!-- 提交收货form -->
					<input name="uuid" id="projectInfoId" type="hidden" value=""/>
				</form>
				<table id="yy-table-list" class="yy-table-x">
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
							<th>收货状态</th>
							<th>项目号</th>
							<!-- <th>项目名称</th> -->
							<th>箱号</th>
							<th>条码类型</th>
							<th>华为物料编码</th>
							<th>物料名称</th>
							<th>计划数量</th>	
							<th>剩余数量</th>
							<th>收货数量</th>
							<th>收货时间</th>
							<th>预警时间</th>
							<th>收货备注</th>	
							<th>挪料</th>
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
					var btnAble ='';
					if(full.main.billstatus==5){//“已审核”项变为深灰色底色
						btnAble ='disabled="disabled" title="已审核不能操作" ';
					}
					var uuidInput = '<input type="hidden" name="uuid" value="'+data+'">';
					if(full.barcode!=null&&full.barcode!=''){
						return uuidInput+"<div class='yy-btn-actiongroup'>"
						+ "<button  onclick='changeToSave(this);' "+btnAble+" rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info' data-rel='tooltip' title='修改'><i class='fa yy-btn-save'></i>修改</button>"
						+ "<button  onclick='saveNewBarcode(this);' "+btnAble+"  style='display: none;' rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info saveBcBtn' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button>"
						+ "</div>";
					}else{
						return uuidInput+"<div class='yy-btn-actiongroup'>"
						+ "<button  onclick='saveNewBarcode(this);' "+btnAble+" rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info saveBcBtn' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button>"
						+ "</div>";
					}
				},
				width : "30"
			}, {
				data : 'newBarcode',
				width : "200",
				className : "center",
				orderable : true,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.main.billstatus==5){//“已审核”项变为深灰色底色
						return '<input class="form-control newBarcodeInput" value="'+ data + '" name="newBarcode"  readonly="readonly">';
					}
					if(full.barcode!=null&&full.barcode!=''){
						return '<input class="form-control newBarcodeInput" value="'+ data + '" name="newBarcode"  readonly="readonly">';
					}else{
						return '<input class="form-control newBarcodeInput" value="'+ data + '" name="newBarcode">';
					}
				}
			}, {
				data : 'barcode',
				width : "80",
				className : "center",
				render : function(data, type, full) {
					if(full.checkStatus=='30'){
						return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e02222;">'+data+'</span></a>';
					} else if(full.checkStatus=='20'){
						if(full.barcodeStatus=='30'){
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e92810;">'+data+'</span></a>';
						}else{
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#319430;">'+data+'</span></a>';
						}
					}else{
						if(full.barcodeStatus=='30'){
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e92810;">'+data+'</span></a>';
						}else{
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');">'+data+"</a>";
						}
					}
				},
				orderable : false
			},{
				data : "main.billstatus",
				width : "70",
				className : "center",
				render : function(data, type, full) {
					var billStatusStyle="";
					if(data==5){//“已审核”项变为深灰色底色
						billStatusStyle=" background-color:#a19797;";
					}
					if(full.checkStatus=='30'){
						return '<a onclick="onApproveLook(\'projectInfo\',\''+full.main.uuid+'\');"><div style="color:#e02222;'+billStatusStyle+'">'+YYDataUtils.getEnumName("BillStatus", data)+'</div></a>';
					} else if(full.checkStatus=='20'){
						return '<a onclick="onApproveLook(\'projectInfo\',\''+full.main.uuid+'\');"><div style="color:#319430;'+billStatusStyle+'">'+YYDataUtils.getEnumName("BillStatus", data)+'</div></a>';
					}else{
						return '<a onclick="onApproveLook(\'projectInfo\',\''+full.main.uuid+'\');">'+YYDataUtils.getEnumName("BillStatus", data)+'</a>';
					}
				},
				orderable : false
			},{
				data : "main.receiveType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return "<a onclick=\"showReceiveLog(\'"+full.uuid+"\');\">"+YYDataUtils.getEnumName("ReceiveStatus", data)+"</a>";
				},
				orderable : true
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
				width : "80",
				className : "center",
				render : function(data, type, full) {
					if(full.main.billstatus==5){//“已审核”项变为深灰色底色
						return '<span title="已审核不能操作">【'+YYDataUtils.getEnumName("MaterialLimitCount", data)+'】</span>';
					}else{
						return '<a onclick="toUpdateLimitCount(\''+full.uuid+'\');">【'+YYDataUtils.getEnumName("MaterialLimitCount", data)+'】</a>';
					}
					
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
				render : function(data, type, full) {
					if(full.firstRow=="1"){
						return data;
					}else{
						return '';
					}
					
				},
				orderable : false
			}, {
				data : 'surplusAmount',
				width : "30",
				className : "center",
				render : function(data, type, full) {
					if(full.firstRow=="1"){
						return '<a onclick="showSubStream(\''+full.uuid+'\');">'+data+'</a>';
					}else{
						return '';
					}
					
				},
				orderable : false
			}, {
				data : 'actualAmount',
				width : "80",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						if(full.main.receiveType=="1"){
							return "<a onclick=\"showReceiveLog(\'"+full.uuid+"\');\">"+data+"</a>";
						}else{
							return '<input class="form-control" value="'+ data + '" name="actualAmount">';
						}
					}else{
						return '';
					}
				}
			}, {
				data : 'receiveTime',
				width : "110",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						if(full.main.receiveType=="1"){
							return data;
						}else{
							return '<input class="form-control Wdate" value="'+ data + '" name="receiveTime" onClick="WdatePicker()">';
						}
					}else{
						return '';
					}
				}
			}, {
				data : 'warningTime',
				width : "110",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						if(full.main.receiveType=="1"){
							return data;
						}else{
							return '<input class="form-control Wdate" value="'+ data + '" name="warningTime" onClick="WdatePicker()">';
						}
					}else{
						return '';
					}
				}
			}, {
				data : 'receiveMemo',
				width : "80",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						if(full.main.receiveType=="1"){
							return data;
						}else{
							return '<input class="form-control" value="'+data+'" name="memo">';
						}
					}else{
						return '';
					}
					
				}
			},{
				data : "uuid",
				width : "160",
				className : "center",
				render : function(data, type, full) {
					if(full.firstRow=="1"){
						var btnAble ='';
						if(full.main.billstatus==5){//“已审核”项变为深灰色底色
							//btnAble ='disabled="disabled" title="已审核不能操作" ';
						}
						var appendReceiveStr = "";
						if(full.main.receiveType=="1"){
							appendReceiveStr = '<button class="btn btn-xs btn-info" onclick="appendLog(\''+data+'\');" data-rel="tooltip" title="添加收货记录"><i class="fa fa-edit"></i>添加收货记录</button>';
						}else{
							appendReceiveStr = '<button class="btn btn-xs btn-info" disabled="disabled"  data-rel="tooltip" title="已收货才能追加收货记录"><i class="fa fa-edit"></i>追加收货记录</button>';
						}
						return "<div class='yy-btn-actiongroup'>"
						+ appendReceiveStr
						+ "<button  onclick=\"toBorrowMaterital(\'"+data+"\');\" "+btnAble+" class='btn btn-xs btn-info' data-rel='tooltip' title='挪料'><i class='fa yy-btn-edit'></i>挪料</button>"
						+ "</div>";
					}else{
						return "";
					}
				},
				orderable : false
			}];


		//改变当前项目
		function changeProjectSel(){
			onQuery();
		}
		
		//var _setOrder = [[5,'desc']];
			//分页页码
		$.fn.dataTable.defaults.aLengthMenu = [ [10, 50, 100, 200, 500 ],
			[ 10, 50, 100, 200, 500 ] ];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			serverPage('${serviceurl}/dataDetail?orderby=mid@desc;boxNum@asc');
			
			$("#yy-btn-match").bind('click', matchMaterial);//
			$("#yy-btn-approve-project").bind('click', approveProject);//
			$("#yy-btn-unapprove-project").bind('click', unApproveProject);//
			$("#yy-btn-temp-receive").bind("click", function() {
				tempReceive();
			});
			$("#yy-btn-confrim-receive").bind("click", function() {
				confirmReceive();
			});
			$("#yy-btn-cancel-receive").bind("click", function() {
				cancelReceive();
			});
			
			$("#yy-btn-export-pks").bind('click', exportPks);//选择导出
			
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
				//"autoWidth":true,
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
						var materialLength = parseInt(jsonResp[i].keyLength);
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
			console.info($("#search_LIKE_mainId").val()+">>>>>>>>>>>.");
			$("#projectInfoId").val($("#search_LIKE_mainId").val());
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
					var materialLength = parseInt(jsonResp[i].keyLength);
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
		
		//编辑变保存按钮
		function changeToSave(t){
			$(t).closest("tr").find(".saveBcBtn").show();
			$(t).closest("tr").find(".newBarcodeInput").removeAttr("readonly");
			$(t).closest("tr").find(".newBarcodeInput").attr("readonly",false);
			$(t).hide();
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
			console.info(111);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			console.info(111);
			
			approveRecordx("${ctx}/info/projectinfo", t_projectId, onQuery);
			
/* 			layer.confirm('确实要审核吗？', function() {
				var listview = layer.load(2);
				$.ajax({
					"dataType" : "json",
					"type" : "POST",
					"url" : "${ctx}/info/projectinfo/batchApprove",
					"data" : {"pks" : t_projectId},
					"success" : function(data) {
						if (data.success) {
							layer.close(listview);
							YYUI.succMsg("审核成功");
							onQuery();
						} else {
							layer.close(listview);
							YYUI.failMsg("审核失败，原因：" + data.msg);
						}
					},
					"error" : function(XMLHttpRequest, textStatus, errorThrown) {
						layer.close(listview);
						YYUI.failMsg("审核失败，HTTP错误。");
					}
				});
			}); */
		}
		
		//审核前检查
		function checkApprove(pks) {
			/* if (pks.length < 1) {
				YYUI.promMsg("请选择需要审核的记录");
				return;
			}
			for (var i = 0; i < pks.length; i++) {
				var row = $("input[value='" + pks[i] + "']").closest("tr");
				var billstatus = _tableList.row(row).data().billstatus;
				if (billstatus != 2) {
					YYUI.failMsg("存在不能审核的记录！");
					return false;
				}
			} */
			return true;
		}
		
		function unApproveProject(){
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			
			layer.confirm('确实要取消审核吗？', function() {
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
			});
		}
		
		//提交
		function onSubmit() {
			var pks = $("#search_LIKE_mainId").val();
			if(pks==null||pks==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			
			if (doBeforeSubmit(pks)) {
				submitRecord('${servicemainurl}/batchSubmit', pks, onRefresh);
			}
		}
		
		//提交前检查
		function checkSubmit(pks) {
			return true;
		}
		
		//撤销提交
		function onUnSubmit() {
			var pks = $("#search_LIKE_mainId").val();
			if(pks==null||pks==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			if (doBeforeUnSubmit(pks)) {
				unSubmitRecord('${servicemainurl}/batchUnSubmit', pks, onRefresh);
			}
		}
		//撤销提交前检查
		function checkUnSubmit(pks) {
			return true;
		}
		
		

		function tempReceive() {
			var t_projectId = $("#search_LIKE_mainId").val();
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			if($("#projectInfoId").val()!=$("#search_LIKE_mainId").val()){
				YYUI.promMsg("请选择项目进行查询");
				return false;
			}
			var subValidate=validTemp();
			if(!subValidate){
				return false;
			}
			//保存新增的子表记录 
	        var _subTable = $("#yy-table-list").dataTable();
	        var subList = new Array();
	        var rows = _subTable.fnGetNodes();
	        for(var i = 0; i < rows.length; i++){
	        	if(_tableList.row(rows[i]).data().firstRow=="1"){
	        		 subList.push(getRowData(rows[i]));
	        	}
	        }
	        if(subList.length==0){
	        	YYUI.promAlert("请添加明细");
	        	return false;
	        }
			
			var saveWaitLoad=layer.load(2);
			var opt = { 
				url : "${servicemainurl}/tempReceive",
				type : "post",
				data : {"subList" : subList},
				success : function(data) {
					layer.close(saveWaitLoad);
					if (data.success == true) {
						YYUI.succMsg('保存成功!');
						onQuery();
					} else {
						YYUI.promAlert("保存失败：" + data.msg);
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
		
		//确认收货
		function confirmReceive() {
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			if($("#projectInfoId").val()!=$("#search_LIKE_mainId").val()){
				YYUI.promMsg("请选择项目进行查询");
				return false;
			}
			var subValidate=validConfirm();
			console.info(subValidate+">>>>>>>>>..");
			if(!subValidate){
				return false;
			}
			layer.confirm("确认收货将生成入库单，确定要保存吗", function() {
				//保存新增的子表记录 
		        var _subTable = $("#yy-table-list").dataTable();
		        var subList = new Array();
		        var rows = _subTable.fnGetNodes();
		        for(var i = 0; i < rows.length; i++){
		            if(_tableList.row(rows[i]).data().firstRow=="1"){
		        		 subList.push(getRowData(rows[i]));
		        	}
		        }
		        if(subList.length==0){
		        	YYUI.promAlert("请添加明细");
		        	return false;
		        }
				
				var saveWaitLoad=layer.load(2);
				var opt = {
					url : "${servicemainurl}/confirmReceive",
					type : "post",
					data : {"subList" : subList},
					success : function(data) {
						layer.close(saveWaitLoad);
						if (data.success == true) {
							YYUI.succMsg('保存成功!');
							onQuery();
						} else {
							YYUI.promAlert("保存失败：" + data.msg);
						}
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			});
		}
		
		
		//取消收货
		function cancelReceive() {
			var t_projectId = $("#search_LIKE_mainId").val();
			console.info(">>>>>>>>>>>>"+t_projectId);
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			if($("#projectInfoId").val()!=$("#search_LIKE_mainId").val()){
				YYUI.promMsg("请选择项目进行查询");
				return false;
			}
			layer.confirm("撤销收货将减少对应的物料库存并清空收货流水，确定要撤销收货吗", function() {
				var saveWaitLoad=layer.load(2);
				var opt = {
					url : "${servicemainurl}/cancelReceive",
					type : "post",
					data : {},
					success : function(data) {
						layer.close(saveWaitLoad);
						if (data.success == true) {
							YYUI.succMsg('操作成功!');
							onQuery();
						} else {
							YYUI.promAlert("操作失败：" + data.msg);
						}
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			});
		}
		
		
		//选择导出
		function exportPks(){
			var t_projectId = $("#search_LIKE_mainId").val();
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			YYUI.promMsg('正在导出，请稍后.',3000);
			window.open('${servicemainurl}/exportCsByIds?pks='+t_projectId,"_blank");
		}
		
		//校验子表
		function validTemp(){
			if(validateRowsData($("#yy-table-list tbody tr:visible[role=row]"),getRowValidatorTemp())==false){
				return false;
			}else{
				return true;
			} 
		}
		
		function validConfirm(){
			if(validateRowsData($("#yy-table-list tbody tr:visible[role=row]"),getRowValidatorConfirm())==false){
				return false;
			}else{
				return true;
			} 
		}
		
		//校验多行数据 返回boolean类型
		function validateRowsData(rowList,validator) {
			console.info("========================================");
			var result = true;
			for (var i = 0; i < rowList.length; i++) {
				if(_tableList.row(rowList[i]).data().firstRow=="1"&&!validateRowData(rowList[i],validator)){
					console.info(rowList[i]);
					result = false;
				}
			}
			return result;
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
		
		//查看流水
		function showSubStream(subId){
			layer.open({
				type : 2,
				title : '库存流水',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/stockstream/toSubRecord?subId='+subId//iframe的url
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
		
		//查看条码记录
		function showBarcodeLog(subId){
			layer.open({
				type : 2,
				title : '条码记录',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/barcode/toLog?subId='+subId
			});
		}

		//查看记录
		function showReceiveLog(subId){
			layer.open({
				type : 2,
				title : '收货记录',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/receive/toViewLog?subId='+subId
			});
		}
		
		//增加收货记录
		function appendLog(subId){
			layer.open({
				type : 2,
				title : '收货记录',
				shadeClose : false,
				shade : 0.8,
				area : [ '800px', '250px' ],
				content : '${ctx}/info/receive/toAppendLog?subId='+subId
			});
		}
		
		//挪料
		function toBorrowMaterital(subId){
			layer.open({
				type : 2,
				title : '项目库存',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/info/stockstream/toStockMaterialIn?subId='+subId
			});
		}
		
		function onRefreshSub(){
			onQuery();
		}
	</script>
</body>
</html>	

