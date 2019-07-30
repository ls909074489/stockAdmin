<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/streamborrow"/>
<html>
<head>
<title>挪料</title>
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
							<label class="control-label col-md-4 required" >数量</label>
							<div class="col-md-8" >
								<input name="actualAmount" id="actualAmount" type="text" value="${entity.actualAmount}" class="form-control">
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
			}
		}

		//表单校验
		function validateForms(){
			validator = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'actualAmount' : {required : true,maxlength : 100}
				}
			});
		}
	</script>
</body>
</html>
