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
			<input id="fileList" name="files" type="text" class="hide" value="">
			<span id="fileSpan"></span>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">订单编号</label>
						<div class="col-md-8">
							<div class="input-group">
									<fieldset disabled="disabled">
										<input name="number" type="text" class="form-control" value="">
									</fieldset>
									<span class="input-group-btn">
										<button onclick="genBillCode();" class="btn blue btn-sm" type="button">
											<i class="fa fa-add"></i> 生成
										</button>
									</span>
							</div>
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
			<!-- <div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">使用现有库存</label>
						<div class="col-md-8">
							<input name="useStorageCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">材料用量</label>
						<div class="col-md-8">
							<input name="stuffCount" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
			</div> -->
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
						<label class="control-label col-md-4 required">交付时间</label>
						<div class="col-md-8">
							<input name="deliveryTime" type="text" class="form-control Wdate"  
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="">
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
		
		</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	<script type="text/javascript">
		var _fileUploadTool;//上传变量
	
		$(document).ready(function() {
			genBillCode();//生成订单号
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
							$("input[name='model']").val(json.obj.model);
							$("input[name='useStorageCount']").val(json.obj.useStorageCount);
							$("input[name='stuffCount']").val(json.obj.stuffCount);
							$("input[name='price']").val(json.obj.price);
							$("input[name='remark']").val(json.obj.remark);
							$("input[name='planCount']").val(json.obj.planCount);
							$("input[name='deliveryTime']").val(json.obj.deliveryTime);
							_fileUploadTool.loadFilsTableList(json.obj.files,'edit');
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
		
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'number' : {required : true,maxlength : 100},
					'customer' : {required : true,maxlength : 100},
					'model' : {required : true,maxlength : 100},
					'deliveryTime' : {required : true,maxlength : 100},
					'price' : {required : true,number:true,maxlength : 100},
					'planCount' : {required : true,number:true,digits:true,maxlength : 100},
					//'useStorageCount' : {required : true,number:true,digits:true,maxlength : 20},
					//'stuffCount' : {required : true,number:true,digits:true,maxlength : 20},
					'stuff' : {required : true},
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
				if(fileObj!=null&&fileObj.length>0){
					$("#fileList").val(JSON.stringify(data.obj));
					/* for(var i=0;i<fileObj.length;i++){
						$("#fileSpan").append('<input name="files" type="text" class="hide" value="'+fileObj[i]+'">');
					} */
				}
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
		
		
		//生成订单号
		function genBillCode(){
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :{},
				url : "${apiurl}/order/generateNumber",
				async : true,
				dataType : "json",
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				success : function(json) {
					layer.close(waitInfoLoading);
					console.info(json);
					if(json.flag==0){
						$("input[name='number']").val(json.obj);
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
