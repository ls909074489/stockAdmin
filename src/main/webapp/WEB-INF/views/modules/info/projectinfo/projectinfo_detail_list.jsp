<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<c:set var="servicemainurl" value="${ctx}/info/projectinfo"/>
<c:set var="receiveurl" value="${ctx}/info/receive"/>
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
			<div class="navbar-fixed-top">
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
					
					<button id="yy-btn-toscan" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i> 条码扫描
					</button>
					
					<!-- <label for="sweepCode" class="control-label">扫描条码</label>
					<input type="text" autocomplete="on" name="sweepCode"
						id="sweepCode" class="input-sm" style="width: 380px;">
					<button id="yy-btn-match" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i> 匹配
					</button> -->
					<!-- <button id="yy-btn-temp-receive" class="btn blue btn-sm">
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
					 -->
					 
					 <shiro:hasPermission name="projectdetailApprove">
					 	 <button id="yy-btn-approve-project" class="btn yellow btn-sm btn-info" type="button">
							<i class="fa fa-check"></i> 审核
						</button>
					 </shiro:hasPermission>
					 <shiro:hasPermission name="projectdetailUnApprove">
						<button id="yy-btn-unapprove-project" class="btn yellow btn-sm btn-info">
							<i class="fa fa-reply"></i> 取消审核
						</button>
					</shiro:hasPermission>
					<button id="yy-btn-check-null" class="btn green btn-sm btn-info">
						<i class="fa fa-video-camera"></i> 一键查漏
					</button>
					<button id="yy-btn-check-repeat" class="btn green btn-sm btn-info">
						<i class="fa fa-files-o"></i> 一键查重
					</button>
					<button id="yy-btn-check-unequal" class="btn green btn-sm btn-info">
						<i class="fa fa-files-o"></i> 欠料查询
					</button>
					
					
					<button id="yy-btn-export-pks" queryformid="yy-form-query" class="btn green btn-sm btn-info">
						<i class="fa fa-chevron-up"></i> 导出
					</button>
				</div>
				<div class="row yy-searchbar form-inline">
					<form id="yy-form-query" class="queryform">
						<!-- <label for="search_LIKE_main.code" class="control-label">项目号&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" autocomplete="on" name="search_LIKE_main.code"
							id="search_LIKE_main.code" class="form-control input-sm">
							
						<label for="search_LIKE_main.name" class="control-label">项目名称</label>
						<input type="text" autocomplete="on" name="search_LIKE_main.name"
							id="search_LIKE_main.name" class="form-control input-sm"> -->
						
						<!-- <label class="control-label">项目</label>
						<div class="input-group input-icon right">
							<input id="search_LIKE_mainId" name="search_EQ_main.uuid" type="hidden"> 
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
									<select class="combox form-control projectSelectCls" id="search_LIKE_mainId" onchange="changeProjectSel();" name="search_EQ_main.uuid" style="float: left;width: 200px;">
										<option value=""></option>
									</select>
								</div>
							</c:when>
							<c:otherwise>
								<input name="search_EQ_main.uuid" id="search_LIKE_mainId" type="hidden" value="${sourceBillId}" class="yy-input"> 
								<span style="display: none;">
									<select class="combox form-control projectSelectCls"  name="" style="display: none;">
											<option value="${sourceBillId}">${sourceBillId}</option>
									</select>
								</span>
							</c:otherwise>
						</c:choose>
													
						<label for="search_EQ_boxNum" class="control-label">箱号</label>
						<!-- <input type="text" autocomplete="on" name="search_EQ_boxNum" id="search_EQ_boxNum" style="width:120px;" class="form-control input-sm"> -->
						<select class="yy-input-enumdata form-control" id="search_EQ_boxNum" name="search_EQ_boxNum" style="width:120px;"></select>
									 
						<!-- <label for="search_LIKE_materialCode" class="control-label">物料编码</label>
						<input type="text" autocomplete="on" name="search_LIKE_material.code" id="search_LIKE_materialCode" class="form-control input-sm"> -->
						
						<label for="search_LIKE_materialHwCode" class="control-label">华为物料编码</label>
						<input type="text" autocomplete="on" name="search_LIKE_material.hwcode" id="search_LIKE_materialHwCode" class="form-control input-sm">
						
						<!-- <label for="search_LIKE_material.name" class="control-label">物料名称</label>
						<input type="text" autocomplete="on" name="search_LIKE_material.name" id="search_LIKE_material.name" class="form-control input-sm"> -->			 
								
						<label for="custom_search_barcode" class="control-label">条码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" autocomplete="on" name="custom_search_barcode" id="custom_search_barcode" class="form-control input-sm">
						
						<input type="hidden" name="checkVal" id="checkVal" class="form-control input-sm">
	
						<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
							<i class="fa fa-search"></i>查询
						</button>
						<button id="yy-searchbar-reset" type="button" class="red">
							<i class="fa fa-undo"></i> 清空
						</button>
					</form>
				</div>
			</div>
			<div class="row" style="margin-top: 100px;">
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
							<th>已收数量</th>
							<th>收货数量</th>
							<th>收货时间</th>
							<th>预警时间</th>
							<th>收货备注</th>	
							<th>添加收货记录</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>

	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<%@include file="/WEB-INF/views/common/commonscript_approve_simple.jsp"%>

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
					var newStreamId = full.newUuid.split("_");
					var unOutBtn = "";
					if(newStreamId[0].length>10){
						unOutBtn = "<shiro:hasPermission name='projectdetailUnout'><button  onclick=\"unOuntSub('"+full.newUuid+"');\" "+btnAble+" rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info unOuntSubBtn' data-rel='tooltip' title='撤销出库'><i class='fa fa-undo'></i>撤销出库</button></shiro:hasPermission>";
					}
					if(full.barcode!=null&&full.barcode!=''){//条码不为空
						return uuidInput+"<div class='yy-btn-actiongroup'>"
						+ "<shiro:hasPermission name='projectdetailSaveBarcode'><button  onclick='changeToSave(this);' "+btnAble+" rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info' data-rel='tooltip' title='修改'><i class='fa yy-btn-save'></i>修改</button>"
						+ "<button  onclick='saveNewBarcode(this);' "+btnAble+"  style='display: none;' rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info saveBcBtn' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button></shiro:hasPermission>"
						+unOutBtn
						+ "</div>";
					}else{//条码为空
						return uuidInput+"<div class='yy-btn-actiongroup'>"
						+ "<shiro:hasPermission name='projectdetailSaveBarcode'><button  onclick='saveNewBarcode(this);' "+btnAble+" rowUuid='"+full.newUuid+"'class='btn btn-xs btn-info saveBcBtn' data-rel='tooltip' title='保存'><i class='fa yy-btn-save'></i>保存</button></shiro:hasPermission>"
						+ "</div>";
					}
				},
				width : "30"
			}, {
				data : 'newBarcode',
				width : "200",
				className : "center",
				orderable : false,
				visible : false,
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
					if(full.limitCount==1){//唯一条码
						if(full.checkStatus=='30'){//错误的料号
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e02222;">'+data+'</span></a>';
						} else if(full.checkStatus=='20'){//通过的料号
							if(full.barcodeStatus=='30'){//条码长度不符
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
					}else{
						if(full.checkStatus=='30'){//错误的料号
							return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e02222;">'+data+'<br>数量：'+full.subAmount+'</span></a>';
						} else if(full.checkStatus=='20'){//通过的料号
							if(full.barcodeStatus=='30'){//条码长度不符
								return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e92810;">'+data+'<br>数量：'+full.subAmount+'</span></a>';
							}else{
								return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#319430;">'+data+'<br>数量：'+full.subAmount+'</span></a>';
							}
						}else{
							if(full.barcodeStatus=='30'){
								return '<a onclick="showBarcodeLog(\''+full.uuid+'\');"><span style="color:#e92810;">'+data+'<br>数量：'+full.subAmount+'</span></a>';
							}else{
								return '<a onclick="showBarcodeLog(\''+full.uuid+'\');">'+data+"<br>数量："+full.subAmount+"</a>";
							}
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
				data : "subReceiveType",
				width : "60",
				className : "center",
				render : function(data, type, full) {
					return "<a onclick=\"showReceiveLog(\'"+full.uuid+"\');\">"+YYDataUtils.getEnumName("ReceiveStatus", data)+"</a>";
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
				width : "30",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						var textStyle = "";
						if(full.planAmount<=full.actualAmount){
							textStyle = "color:#e02222;";
						}
						return "<a onclick=\"showReceiveLog(\'"+full.uuid+"\');\"><span style='"+textStyle+"'>"+data+"</span></a>";
					}else{
						return '';
					}
				}
			}, {
				data : 'receiveAmount',
				width : "80",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					if(data==null){
						data="";
					}
					if(full.firstRow=="1"){
						if(full.subReceiveType=="1"){
							return "<a onclick=\"showReceiveLog(\'"+full.uuid+"\');\">"+full.actualAmount+"</a>";
						}else{
							return '<input class="form-control" value="'+ data + '" name="receiveAmount"  onchange="changeReceiveAmount(this);"  onkeyup="keyUpRecieve(event,this);">';
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
						if(full.subReceiveType=="1"){
							return data;
						}else{
							return '<input class="form-control Wdate" value="${curDate}" name="receiveTime" onClick="WdatePicker()"  autocomplete="off">';
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
						if(full.subReceiveType=="1"){
							return data;
						}else{
							return '<input class="form-control Wdate" value="'+ data + '" name="warningTime" onClick="WdatePicker()"  autocomplete="off">';
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
						if(full.subReceiveType=="1"){
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
						if(full.subReceiveType=="1"){
							if(full.planAmount<=full.actualAmount){
								appendReceiveStr = '<shiro:hasPermission name="projectdetailAppendLog"><button class="btn btn-xs btn-info" onclick="appendLog(\''+data+'\');" data-rel="tooltip" title="修改收货记录"><i class="fa fa-edit"></i>修改收货记录</button></shiro:hasPermission>';
							}else{
								appendReceiveStr = '<shiro:hasPermission name="projectdetailAppendLog"><button class="btn btn-xs btn-info" onclick="appendLog(\''+data+'\');" data-rel="tooltip" title="添加收货记录"><i class="fa fa-edit"></i>添加收货记录</button></shiro:hasPermission>';
							}
						}else{
							appendReceiveStr = '<shiro:hasPermission name="projectdetailSaveSub"><button class="btn btn-xs btn-info saveSubReceiveCLs" onclick="saveSubReceive(this);"  data-rel="tooltip" title="确认收货"><i class="fa fa-edit"></i>确认收货</button></shiro:hasPermission>';
						}
						return "<div class='yy-btn-actiongroup'>"
						+ appendReceiveStr
						+ "<shiro:hasPermission name='projectdetailBoorrow'><button  onclick=\"toBorrowMaterital(\'"+data+"\');\" "+btnAble+" class='btn btn-xs btn-info' data-rel='tooltip' title='挪料'><i class='fa yy-btn-edit'></i>挪料</button></shiro:hasPermission>"
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
		
		//改变收货数量
		function changeReceiveAmount(t){
			if($(t).val()!=null&&$(t).val()!=''){
				var t_receiveTimeEle = $(t).closest("tr").find("input[name='receiveTime']");
				if(t_receiveTimeEle.val()==null||t_receiveTimeEle.val()==""){
					t_receiveTimeEle.val("${curDate}");
				}
			}
		}
		
		//回车确认收货
		function keyUpRecieve(e,t){
			if(e.keyCode == "13") {
				 $(t).closest("tr").find(".saveSubReceiveCLs").click();
	        }
		}
		
		//var _setOrder = [[5,'desc']];
			//分页页码
		$.fn.dataTable.defaults.aLengthMenu = [ [10, 50, 100, 200, 500 ],
			[ 10, 50, 100, 200, 500 ] ];
		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			bindListActions();
			//按回车查询
			$('#sweepCode').on('keyup', function(event){
				if(event.keyCode == "13") {
					matchMaterial();
		        }
			});
			serverPage('${serviceurl}/dataDetail?orderby=mid@desc;boxNum@asc');
			
			
			$("#yy-btn-toscan").bind('click', toSelProjectBox);
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
			$("#yy-btn-check-null").bind("click", function() {
				checkNullBarcode();
			});
			$("#yy-btn-check-repeat").bind("click", function() {
				checkRepeatBarcode();
			});
			$("#yy-btn-check-unequal").bind("click", function() {
				checkUnEqualAmount();
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
			
			$("#search_EQ_boxNum").select2({
		        theme: "bootstrap",
		        allowClear: true,
		        placeholder: "请选择",
		        ajax:{
		            url:"${ctx}/info/projectinfo/select2BoxNumQuery",
		            dataType:"json",
		            delay:250,
		            data:function(params){
		                return {projectId: $("#search_LIKE_mainId").val(),"boxNum":params.term};
		            },
		            cache:true,
		            processResults: function (res, params) {
		            	var t_projectId = $("#search_LIKE_mainId").val();
		    			if(t_projectId==null||t_projectId==''){
		    				return {
			                    results: []
			                };
		    			}else{
		    				console.info(res);
			            	console.info(params);
			                var options = [];
			                var records = res.records;
			                for(var i= 0, len=records.length;i<len;i++){
			                    var option = {"id":records[i].uuid, "text":records[i].name};
			                    options.push(option);
			                }
			                return {
			                    results: options
			                };
		    			}
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
		
		function getTableHeight(){
			console.info(window.screen.availHeight);
			return (window.screen.availHeight-425);
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
				"scrollY": getTableHeight,
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
					if(freshLoad != null) {
						layer.close(freshLoad);
					}
					layer.close(serverPageWaitLoad);//关闭加载等待ceng edit by liusheng
				}
			});
		}
		
		//扫码弹出框
		function toSelProjectBox(){
			layer.open({
				type : 2,
				title : '条码扫描',
				shadeClose : false,
				shade : 0.8,
				area : [ '800px', '60%' ],
				content : '${serviceurl}/toSelProjectBox'//iframe的url
			});
		}
		
		//跳转到扫码框
		function callBackToScanBarcode(projectId,boxNum){
			layer.open({
				type : 2,
				title : '条码扫描',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${serviceurl}/toScanBarcode?projectId='+projectId+'&boxNum='+boxNum//iframe的url
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
		
		function saveNewBarcodeXXXX(t){
			var newBarcodeVal = $(t).closest("tr").find("input[name='newBarcode']").val();
			console.info(newBarcodeVal.trim()+"====");
			if(newBarcodeVal==null||newBarcodeVal==''||newBarcodeVal.trim()==""){
				YYUI.promMsg("条码不能为空");
				return false;
			}
			var row = $(t).closest("tr");
			var tr_hwcode = _tableList.row(row).data().material.hwcode;
			var tr_planAmount = _tableList.row(row).data().planAmount;
			var tr_limitCount = _tableList.row(row).data().limitCount;
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
					layer.close(index);
					if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
						onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"),tr_planAmount,tr_limitCount);
					}else{
						layer.confirm("条码与华为物料编码不符合，确定要保存吗", function(index) {
							layer.close(index);
							onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"),tr_planAmount,tr_limitCount);
						});
					}
				});
			}else{
				if(newBarcodeVal!=null&&newBarcodeVal.indexOf(tr_hwcode)>=0){
					onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"),tr_planAmount,tr_limitCount);
				}else{
					layer.confirm("条码与华为物料编码不符合，确定要保存吗", function(index) {
						layer.close(index);
						onCheckBarCode(newBarcodeVal,$(t).attr("rowUuid"),tr_planAmount,tr_limitCount);
					});
				}
			}
		}
		
		
		function saveNewBarcode(t){
			var row = $(t).closest("tr");
			var tr_hwcode = _tableList.row(row).data().material.hwcode;
			var tr_planAmount = _tableList.row(row).data().planAmount;
			var tr_limitCount = _tableList.row(row).data().limitCount;
			var subId = $(t).attr("rowUuid");
			var newBarcodeVal = "";
			
			if(tr_limitCount==-1){//批次
				layer.open({
					type : 2,
					title : '保存条码',
					shadeClose : false,
					shade : 0.8,
					area : [ '600px', '300px' ],
					content : '${serviceurl}/toSaveBcBatch?subId='+subId+'&planAmount='+tr_planAmount+'&newBarcodeVal='+newBarcodeVal+'&hwcode='+tr_hwcode//iframe的url
				});
			}else{
				layer.open({
					type : 2,
					title : '保存条码',
					shadeClose : false,
					shade : 0.8,
					area : [ '600px', '300px' ],
					content : '${serviceurl}/toSaveBcUnique?subId='+subId+'&planAmount='+tr_planAmount+'&newBarcodeVal='+newBarcodeVal+'&hwcode='+tr_hwcode//iframe的url
				});
			}
		}
		
		function unOuntSub(newUuid){
			layer.confirm("撤销出库将恢复原出库记录，确定要撤销出库吗?", function() {
				$.ajax({
					type : "POST",
					data :{"newUuid": newUuid},
					url : "${serviceurl}/unOutBySub",
					async : true,
					dataType : "json",
					success : function(data) {
						if(data.success){
							YYUI.succMsg(data.msg);
							onQuery();
						}else{
							YYUI.promAlert(data.msg);
						}
					},
					error : function(data) {
						YYUI.promMsg("操作失败，请联系管理员");
					}
				});
			});
		}
		
		//编辑变保存按钮
		function changeToSave(t){
			/* $(t).closest("tr").find(".saveBcBtn").show();
			$(t).closest("tr").find(".newBarcodeInput").removeAttr("readonly");
			$(t).closest("tr").find(".newBarcodeInput").attr("readonly",false);
			$(t).hide(); */
			var row = $(t).closest("tr");
			var t_rowdata = _tableList.row(row).data();
			console.info(t_rowdata);
			layer.open({
				type : 2,
				title : '修改条码',
				shadeClose : false,
				shade : 0.8,
				area : [ '400px', '200px' ],
				content : '${serviceurl}/toModifyBarcode?projectSubId='+t_rowdata.uuid+'&barcodeUuid='+t_rowdata.barcodeUuid//iframe的url
			});
		}
		
		
		function onCheckBarCode(newBarcodeVal,subId,tr_planAmount,tr_limitCount){
			if(tr_limitCount==-1){//批次
			  /*layer.confirm("确定领料数量为："+tr_planAmount+"  吗？", function() {
					onComparetBarcode(newBarcodeVal,subId);
				}); */
				layer.open({
					type : 2,
					title : '保存条码',
					shadeClose : false,
					shade : 0.8,
					area : [ '600px', '300px' ],
					content : '${serviceurl}/toSaveBcBatch?subId='+subId+'&planAmount='+tr_planAmount+'&newBarcodeVal='+newBarcodeVal//iframe的url
				});
			}else{
				onComparetBarcode(newBarcodeVal,subId);
			}
		}
		
		function onComparetBarcode(newBarcodeVal,subId){
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
						//已存在条码
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
				data :{"newBarcode": newBarcodeVal,"newUuid":subId,"subAmount":1},
				url : "${serviceurl}/updateBarcode",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						YYUI.succMsg(data.msg);
						onQuery();
					}else{
						YYUI.promAlert(data.msg);
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
		//一键查空
		function checkNullBarcode(){
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
			//onReset();
			$("#checkVal").val("1");
			onQuery();
			$("#checkVal").val("");
		}
		
		//一键查重
		function checkRepeatBarcode(){
			console.info("checkRepeatBarcode>>>>>>>>>>>>>>>>");
			//onReset();
			$("#checkVal").val("2");
			onQuery();
			$("#checkVal").val("");
		}
		
		
		//欠料查询
		function checkUnEqualAmount(){
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
			//onReset();
			$("#checkVal").val("3");
			onQuery();
			$("#checkVal").val("");
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
			var result = true;
			for (var i = 0; i < rowList.length; i++) {
				if(_tableList.row(rowList[i]).data().firstRow=="1"&&!validateRowData(rowList[i],validator)){
					result = false;
				}
			}
			return result;
		}
		
		//表体校验
		function getRowValidatorTemp() {
			return [ {
				name : "receiveAmount",
				rules : {
					//required : true,
					//number :true,
					digits :true,
					min:1,
					maxlength:8
				},
				message : {
					//required : "必输",
					//number :"请输入合法的数字",
					digits :"只能输入整数",
					min:"收货数量必须大于0",
					maxlength : "最大长度为8"
				}
			}];
		}
		
		function getRowValidatorConfirm() {
			return [ {
				name : "receiveAmount",
				rules : {
					//required : true,
					//number :true,
					digits :true,
					min:1,
					maxlength:8
				},
				message : {
					//required : "必输",
					//number :"请输入合法的数字",
					digits :"只能输入整数",
					min:"收货数量必须大于0",
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
		
		//子表确认收货
		function saveSubReceive(t){
			//var newBarcodeVal = $(t).closest("tr").find("input[name='actualAmount']").val();
			var row = $(t).closest("tr");
			var rowData = _tableList.row(row).data();
			if(validateRowsData(row,getRowValidatorConfirm())==false){
				return false;
			}
			//if(_tableList.row(rowList[i]).data().firstRow=="1"&&!validateRowData(rowList[i],validator)){
			
			var trEle = $(t).closest("tr");
			$.ajax({
				type : "POST",
				data :{
					"subId": rowData.uuid,
					"receiveAmount":$(t).closest("tr").find("input[name='receiveAmount']").val()
				},
				url : "${receiveurl}/checkReceiveCount",
				async : true,
				dataType : "json",
				success : function(data) {
					if(data.success){
						$.ajax({
							type : "POST",
							data :{
								"subId": rowData.uuid,
								"receiveType":"1",
								"receiveAmount":trEle.find("input[name='receiveAmount']").val(),
								"receiveTime":trEle.find("input[name='receiveTime']").val(),
								"warningTime":trEle.find("input[name='warningTime']").val(),
								"memo":trEle.find("input[name='memo']").val()
							},
							url : "${receiveurl}/saveReceiveLog",
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
					}else{
						layer.confirm("收货数量已超出清单数量，是否保存", function(index) {
							$.ajax({
								type : "POST",
								data :{
									"subId": rowData.uuid,
									"receiveType":"1",
									"receiveAmount":trEle.find("input[name='receiveAmount']").val(),
									"receiveTime":trEle.find("input[name='receiveTime']").val(),
									"warningTime":trEle.find("input[name='warningTime']").val(),
									"memo":trEle.find("input[name='memo']").val()
								},
								url : "${receiveurl}/saveReceiveLog",
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
						});
					}
				},
				error : function(data) {
					YYUI.promMsg("操作失败，请联系管理员");
				}
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

