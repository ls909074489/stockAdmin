<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/material"/>
<html>
<head>
<title>物料</title>
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
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="text" class="hide" value="${entity.uuid}">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">物料编码</label>
							<div class="col-md-8" >
								<input name="code" id="code" type="text" value="${entity.code}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">华为物料编码</label>
							<div class="col-md-8" >
								<input name="hwcode" id="hwcode" type="text" value="${entity.hwcode}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">物料名称</label>
							<div class="col-md-8" >
								<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">是否风险物料</label>
							<div class="col-md-8" >
								<select name="hasRisk" id="hasRisk" data-enum-group="BooleanType" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div> -->
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">物料单位</label>
							<div class="col-md-8" >
								<!-- <select name="unit" id="unit" data-enum-group="MaterialUnit" class="yy-input-enumdata form-control"></select> -->
								<input name="unit" id="unit" type="text" value="${entity.unit}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >条码类型</label>
							<div class="col-md-8" >
								<select name="limitCount" id="limitCount" data-enum-group="MaterialLimitCount" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">采购模式</label>
							<div class="col-md-8" >
								<select name="purchaseType" id="purchaseType" data-enum-group="PurchaseType" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div>
				</div>
				<div>
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >领域</label>
							<div class="col-md-10" >
								<input name="position" id="position" type="text" value="${entity.position}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">分类描述</label>
							<div class="col-md-10" >
								<input name="classDesc" id="classDesc" type="text" value="${entity.classDesc}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">物料描述</label>
							<div class="col-md-10" >
								<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
							</div>
						</div>
					</div>
				</div>
		</form>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>

	<script type="text/javascript">

		$(document).ready(function() {
			//按钮绑定事件
			bindEditActions();
			//bindButtonAction();
			validateForms();
			setValue();
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
			} else if ('${openstate}' == 'edit') {
				//$("select[name='hasRisk']").val('${entity.hasRisk}');
				$("select[name='unit']").val('${entity.unit}');
				$("select[name='limitCount']").val('${entity.limitCount}');
				$("select[name='purchaseType']").val('${entity.purchaseType}');
			}
		}

		//表单校验
		function validateForms(){
			validator = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					//'code' : {required : true,maxlength : 100},
					//'hwcode' : {required : true,maxlength : 50},
					'name' : {required : true,maxlength : 100},
					//'hasRisk' : {required : true,maxlength : 100},
					'limitCount' : {required : true,maxlength : 100},
					'unit' : {required : true,maxlength : 100},
					'purchaseType' : {required : true,maxlength : 100},
					'classDesc' : {maxlength : 100},
					'memo' : {maxlength : 100}
				}
			});
		}
		
		function onSave(isClose) {
			$("#code").rules("remove");
			$("#hwcode").rules("remove");
			$('#yy-form-edit div.control-group').removeClass('error');
			
			addSubListValid();
			if (!$('#yy-form-edit').valid()) return false;
			doBeforeSave();
			if (!validOther()) return false;
			
			if($("#purchaseType").val()=='CS'){//华为
				$("#code").rules("remove");
	            $("#hwcode").rules("add", { required : true,maxlength : 100});
			}else{
				$("#hwcode").rules("remove");
	            $("#code").rules("add", { required : true,maxlength : 100});
			}
            if (!$('#yy-form-edit').valid()) return false;
			
			var editview = layer.load(2);
			
			var posturl = "${serviceurl}/add";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined") {
				posturl = "${serviceurl}/update";
			}
			var opt = {
				url : posturl,
				type : "post",
				success : function(data) {
					if (data.success) {
						layer.close(editview);
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							//window.parent.onDetailRow(pk);跳转到编辑页面
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
						doAfterSaveSuccess(data.records);
					} else {
						//window.parent.YYUI.failMsg("保存出现错误：" + data.msg);
						window.parent.YYUI.failMsg("保存失败：" + data.msg);
						layer.close(editview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("保存失败，HTTP错误。");
					layer.close(editview);
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		} 
	</script>
</body>
</html>
