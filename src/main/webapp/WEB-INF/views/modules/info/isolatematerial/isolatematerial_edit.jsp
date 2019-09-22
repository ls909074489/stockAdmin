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
							<label class="control-label col-md-4 required">物料</label>
							<div class="col-md-8">
								<div class="input-group input-icon right">
										<input id="materialId" name="material.uuid" type="hidden" value="${entity.material.uuid}"> 
										<i class="fa fa-remove" onclick="cleanDef('materialId','materialHwcode');" title="清空"></i>
										<input id="materialHwcode" name="materialHwcode" type="text" class="form-control" readonly="readonly" 
											value="${entity.material.hwcode}">
										<span class="input-group-btn">
											<button id="material-select-btn" class="btn btn-default btn-ref" type="button">
												<span class="glyphicon glyphicon-search"></span>
											</button>
										</span>
									</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >条码</label>
							<div class="col-md-8" >
								<input name="barcode" id="barcode" type="text" value="${entity.barcode}" class="form-control">
							</div>
						</div>
					</div>
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
			
			$('#material-select-btn').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择仓库',
					shadeClose : false,
					shade : 0.8,
					area : [ '1000px', '90%' ],
					content : '${ctx}/sys/ref/refMaterial?callBackMethod=window.parent.callBackMaterial'
				});
			});
			
		});
		
		//回调选择
		function callBackMaterial(data){
			$("#materialId").val(data.uuid);
			$("#materialHwcode").val(data.hwcode);
		}
		
		 
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'barcode' : {required : true,maxlength : 100},
					'materialHwcode' : {required : true,maxlength : 100}
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
		
		//主子表保存
		function onSave22(isClose) {
			var mainValidate=$('#yy-form-edit').valid();
			if(!mainValidate){
				return false;
			}
			//保存新增的子表记录 
	        var _subTable = $("#yy-table-sublist").dataTable();
	        var subList = new Array();
	        var rows = _subTable.fnGetNodes();
	        for(var i = 0; i < rows.length; i++){
	            subList.push(getRowData(rows[i]));
	        }
	        if(subList.length==0){
	        	YYUI.promAlert("请添加明细");
	        	return false;
	        }
			var saveWaitLoad=layer.load(2);
			var opt = {
				url : "${serviceurl}/updatewithsub",
				type : "post",
				data : {"subList" : subList,"deletePKs" : _deletePKs},
				success : function(data) {
					layer.close(saveWaitLoad);
					if (data.success == true) {
						_deletePKs = new Array();
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
					} else {
						YYUI.promAlert("保存失败：" + data.msg);
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
	</script>
</body>
</html>
