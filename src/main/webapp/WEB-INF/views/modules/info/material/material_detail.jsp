<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/material"/>
<html>
<head>
<title>物料</title>
</head>
<body>
	<div id="yy-page-detail" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<c:if test="${isShowBtn eq '1'}">
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 返回
			</button>
			</c:if>
		</div>
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
			<input name="uuid" type="text" class="hide" value="${entity.uuid}">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >物料编码</label>
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
							<label class="control-label col-md-4" >物料名称</label>
							<div class="col-md-8" >
								<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >是否风险物料</label>
							<div class="col-md-8" >
								<select name="hasRisk" id="hasRisk" data-enum-group="BooleanType" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div> -->
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >物料单位</label>
							<div class="col-md-8" >
								<!-- <select name="unit" id="unit" data-enum-group="MaterialUnit" class="yy-input-enumdata form-control"></select> -->
								<input name="unit" id="unit" type="text" value="${entity.unit}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4" >条码类型</label>
							<div class="col-md-8" >
								<select name="limitCount" id="limitCount" data-enum-group="MaterialLimitCount" class="yy-input-enumdata form-control"></select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">采购模式</label>
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
				<div>
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >分类描述</label>
							<div class="col-md-10" >
								<input name="classDesc" id="classDesc" type="text" value="${entity.classDesc}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div>
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >物料描述</label>
							<div class="col-md-10" >
								<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
							</div>
						</div>
					</div>
				</div>
		</form>
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
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
			} else if ('${openstate}' == 'detail') {
				//$("select[name='hasRisk']").val('${entity.hasRisk}');
				$("select[name='unit']").val('${entity.unit}');
				$("select[name='limitCount']").val('${entity.limitCount}');
				$("select[name='purchaseType']").val('${entity.purchaseType}');
			}
		}

	</script>
</body>
</html>
