<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/isolateMaterial"/>
<html>
<head>
<title>订单</title>
</head>
<body>
<div id="yy-page-edit" class="container-fluid page-container page-content">
	
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
				<input name="uuid" id="uuid" type="hidden" value="${entity.uuid}"/>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-3 required" >条码</label>
							<div class="col-md-8" >
								<input name="barcode" type="text" value="${entity.barcode}" class="form-control">
							</div>
							<div class="col-md-1" >
								<button class="btn blue btn-sm" type="button" onclick="addRow();">
									<i class="fa fa-plus"></i> 添加
								</button>
							</div>
						</div>
					</div>
				</div>
				<div id="rowSpan">
				</div>
			</form>
		</div>
	</div>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	
	
	<script type="text/javascript">

		 
		$(document).ready(function() {
			
			bindEditActions();//綁定平台按鈕
			
			validateForms();
			
			setValue();
			
		});
		
		function addRow(){
			var str='<div class="row newrow">'+
						'<div class="col-md-4">'+
						'<div class="form-group">'+
							'<label class="control-label col-md-3 required" >条码</label>'+
							'<div class="col-md-8" >'+
								'<input name="barcode" type="text" value="${entity.barcode}" class="form-control barcodecls">'+
							'</div>'+
							'<div class="col-md-1" >'+
								'<button id="yy-btn-remove" class="btn red btn-sm btn-info" type="button"  onclick="delRow(this);">'+
									'<i class="fa fa-trash-o"></i> 删除'+
								'</button>'+
							'</div>'+
						'</div>'+
					'</div>'+
				'</div>';
			$("#rowSpan").append(str);
            $(".barcodecls").rules("add", { required : true,maxlength : 100});
            
		}
		
		function delRow(t){
			$(t).closest(".newrow").remove();
		}
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'barcode' : {required : true,maxlength : 100}
				}
			});
		}


		//设置默认值
		function setValue(){
			if('${openstate}'=='add'){
				//$("input[name='billdate']").val('${billdate}');
			}else if('${openstate}'=='edit'){
				//$("#orderType").val('${entity.orderType}');
			}
		}
		
		
	 	function onSave(isClose) {
			addSubListValid();
			if (!$('#yy-form-edit').valid()) return false;
			doBeforeSave();
			if (!validOther()) return false;
			var editview = layer.load(2);
			
			var posturl = "${serviceurl}/adds";
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
