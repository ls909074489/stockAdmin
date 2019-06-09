<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/sample"/>
<html>
<head>
<title>样品信息</title>
</head>
<body>
	<div id="yy-page-detail" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-toedit" class="btn blue btn-sm">
				<i class="fa fa-edit"></i> 编辑
			</button>
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 返回
			</button>
		</div>
	<div>
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden" value="${entity.uuid}">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">客户名称</label>
						<div class="col-md-8">
							<input name="customer" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">样品料号</label>
						<div class="col-md-8">
							<input name="stuff" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">样品型号</label>
						<div class="col-md-8">
							<input name="model" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">样品备注</label>
						<div class="col-md-8">
							<input name="remark" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">索样数量</label>
						<div class="col-md-8">
							<input name="reqCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">货币类型</label>
						<div class="col-md-8">
							<input name="priceTypeName" type="text" class="form-control" value="" placeholder="不填写表示人民币">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">报价税率</label>
						<div class="col-md-8">
							<input name="taxRate" type="text" class="form-control" value="" placeholder="不填写表示报价为含税价">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">工厂报价</label>
						<div class="col-md-8">
							<input name="priceFac" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">客户报价</label>
						<div class="col-md-8">
							<input name="priceBiz" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">最终报价</label>
						<div class="col-md-8">
							<input name="price" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">计划送样时间</label>
						<div class="col-md-8">
							<input name="planTime" type="text" class="form-control input-sm Wdate" 
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">送样数量</label>
						<div class="col-md-8">
							<input name="sendCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">实际送样时间</label>
						<div class="col-md-8">
							<input name="sendTime" type="text" class="form-control input-sm Wdate" 
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">样品物流信息</label>
						<div class="col-md-8">
							<input name="transportNum" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">承认书状态</label>
						<div class="col-md-8">
							<input id="crszt" name="" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">反馈结果</label>
						<div class="col-md-8">
							<select name="result" class="form-control">
								<option></option>
								<option value="1">OK</option>
								<option value="2">NG</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">反馈内容</label>
						<div class="col-md-8">
							<input id="content" name="reason" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div>
		</form>
		<!-- 附件上传 -->
		<tags:uploadFilesApi id="uploadFiles" />
		
		<div style="font-size: 18px;margin-top: 15px;">
			预计送样调整列表
		</div>
		<div class="yy-tab" id="yy-page-sublist">
					<div class="tab-content">
						<div class="tab-pane active" id="tab0">
							<table id="yy-table-sublist" class="yy-table">
								<thead>
									<tr>
										<th>修改时间</th>	
										<th>调整人</th>
										<th>预计送样时间</th>
									</tr>
								</thead>
								<tbody id="subTbodyId">
								</tbody>
							</table>
						</div>
					</div>
			</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/detailscript.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			//按钮绑定事件
			bindDetailActions();
			//bindButtonAction();
			setValue();
			
			YYFormUtils.lockForm("yy-form-detail");
			
			//附件用
			_fileUploadTool = new FileUploadTool("uploadFiles","noticeEntity");
			_fileUploadTool.init("view");
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
			} else if ('${openstate}' == 'detail') {
				//$("input[name='uuid']").val('${entity.uuid}');
			}
			
			listPlanTime();
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :{"uuid": '${uuid}'},
				url : "${apiurl}/sample/getSample",
				async : true,
				dataType : "json",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(json) {
					layer.close(waitInfoLoading);
					if(json.flag==0){
						$("input[name='uuid']").val(json.obj.uuid);
						$("input[name='customer']").val(json.obj.customer);
						$("input[name='model']").val(json.obj.model);
						$("input[name='stuff']").val(json.obj.stuff);
						$("input[name='count']").val(json.obj.count);
						$("input[name='remark']").val(json.obj.remark);
						$("input[name='reqCount']").val(json.obj.reqCount);
						$("input[name='sendCount']").val(json.obj.sendCount);
						$("input[name='priceFac']").val(json.obj.priceFac);
						$("input[name='priceBiz']").val(json.obj.priceBiz);
						$("input[name='price']").val(json.obj.price);
						$("input[name='planTime']").val(json.obj.planTime);
						$("input[name='sendTime']").val(json.obj.sendTime);
						$("input[name='transportNum']").val(json.obj.transportNum);
						$("select[name='result']").val(json.obj.result);
						$("input[name='reason']").val(json.obj.reason);
						$("input[name='priceTypeName']").val(json.obj.priceTypeName);
						$("input[name='taxRate']").val(json.obj.taxRate);
						if(json.obj.recogStatus!=null){
						  if(json.obj.recogStatus==1){
							   $("#crszt").val("等待处理");
						   }else if(json.obj.recogStatus==2){
							   $("#crszt").val("承认书已提供");
						   }else if(json.obj.recogStatus==3){
							   $("#crszt").val("客户已接收");
						   }else{
							   $("#crszt").val("异常状态");
						   }
						}
						_fileUploadTool.loadFilsTableList(json.obj.files,'view');
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
		
		function  listPlanTime(){
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :{"uuid": '${uuid}'},
				url : "${apiurl}/sample/listPlanTime",
				async : true,
				dataType : "json",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(json) {
					layer.close(waitInfoLoading);
					console.info(json);
					if(json.flag==0){
						//"updateTime": "2018-10-17",
						//"userName": "工程部",
						//"planTime": "2018-10-24"
						console.info(json.obj);
						var tHtml="";
						var tObj=json.obj;
						if(tObj!=null&&tObj.length>0){
							for(var i=0;i<tObj.length;i++){
								tHtml+='<tr><td style="text-align: center;">'+tObj[i].updateTime+'</td><td style="text-align: center;">'+tObj[i].userName+'</td><td style="text-align: center;">'+tObj[i].planTime+'</td>';
							}
						}
						$("#subTbodyId").html(tHtml);
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
	</script>
</body>
</html>
