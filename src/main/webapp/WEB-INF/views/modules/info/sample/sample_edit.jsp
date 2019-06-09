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
			<input name="uuid" type="hidden"  value="">
			<input id="fileList" name="files" type="hidden"  value="">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">客户名称</label>
						<div class="col-md-8">
							<input name="customer" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">样品料号</label>
						<div class="col-md-8">
							<input name="stuff" type="text" class="form-control" value="">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">样品型号</label>
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
						<label class="control-label col-md-4 required">索样数量</label>
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
							<input name="priceFac" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">客户报价</label>
						<div class="col-md-8">
							<input name="priceBiz" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">最终报价</label>
						<div class="col-md-8">
							<input name="price" type="text" class="form-control" value="" readonly="readonly">
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
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="" readonly="readonly" disabled="disabled">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">送样数量</label>
						<div class="col-md-8">
							<input name="sendCount" type="text" class="form-control" value="" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">实际送样时间</label>
						<div class="col-md-8">
							<input name="sendTime" type="text" class="form-control input-sm Wdate" 
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="" readonly="readonly" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">样品物流信息</label>
						<div class="col-md-8">
							<input name="transportNum" type="text" class="form-control" value="" readonly="readonly">
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
							<select name="result" class="form-control" disabled="disabled">
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
							<input id="content" name="reason" type="text" class="form-control" value="" disabled="disabled">
						</div>
					</div>
				</div>
			</div>
		</form>
		<!-- 附件上传 -->
		<tags:uploadFilesApi id="uploadFiles" />
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			//按钮绑定事件
			bindEditActions();
			validateForms();
			setValue();
			
			//附件用
			_fileUploadTool = new FileUploadTool("uploadFiles","noticeEntity");
			_fileUploadTool.init("edit");
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
			
			} else if ('${openstate}' == 'edit') {
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
						console.info(json);
						if(json.flag==0){
							//$("select[name='func_type']").val(treeNode.nodeData.func_type);
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
							var oldFiles=json.obj.files;
							if(oldFiles!=null){
								$("#fileList").val(JSON.stringify(oldFiles));
							}
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
					'customer' : {required : true,maxlength : 100},
					'model' : {required : true,maxlength : 100},
					'stuff' : {required : true,maxlength : 100},
					'remark' : {maxlength : 200},
					'reqCount' : {required : true,number:true,digits:true,maxlength : 10},
					//'price' : {required : true,number:true,maxlength : 10},
					'taxRate' : {maxlength : 200},
					'priceTypeName' : {maxlength : 200}
					/* ,
					'priceFac' : {required : true,number:true,maxlength : 10},
					'priceBiz' : {required : true,number:true,maxlength : 10},
					'price' : {required : true,number:true,maxlength : 10},
					'planTime' : {required : true,maxlength : 100},
					'sendTime' : {required : true,maxlength : 100},
					'transportNum' : {required : true,maxlength : 100} */
				}
			});
		}
		
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
		
			if(data.flag==0){
				var posturl = "${apiurl}/sample/create";
				var pk = $("input[name='uuid']").val();
				if (pk != "" && typeof (pk) != "undefined") {
					posturl = "${apiurl}/sample/update";
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
				
				var editview = layer.load(2);
				
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
	</script>
</body>
</html>
