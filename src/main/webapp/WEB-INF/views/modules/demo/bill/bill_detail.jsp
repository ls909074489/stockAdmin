<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/demo/bill" />
<html>
<head>
<title>单据--主子表--编辑</title>
</head>
<body>
	<div id="yy-page-detail"
		class="container-fluid page-container page-content">
			<div class="row yy-toolbar">
				<button id="yy-btn-backtolist" class="btn blue btn-sm">
					<i class="fa fa-rotate-left"></i> 返回
				</button>
				<button id="yy-btn-submit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-send"></i> 提交
				</button>
				<button id="yy-btn-unsubmit" class="btn yellow btn-sm btn-info">
					<i class="fa fa-undo"></i> 撤销提交
				</button>
				<button id="yy-btn-approve-x" class="btn yellow btn-sm btn-info">
					<i class="fa fa-check"></i> 审核
				</button>
				<button id="yy-btn-unapprove" class="btn yellow btn-sm btn-info">
					<i class="fa fa-reply"></i> 取消审核
				</button>
				
				<button id="yy-btn-approve-look" class="btn yellow btn-sm btn-info">
					<i class="fa fa-list"></i> 查看审批意见
				</button>
			
			</div>

			<div class="row">
				<form id="yy-form-detail" class="form-horizontal yy-form-edit">
					<input name="uuid" type="hidden" />
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">文本</label>
								<div class="col-md-8">
									<div class="input-icon right">
										<i class="fa"></i> <input name="texts" type="text" class="form-control">
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">数字</label>
								<div class="col-md-8">
									<div class="input-icon right">
										<i class="fa"></i> <input class="form-control " name="numbers" type="text">
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">整数</label>
								<div class="col-md-8">
									<input class="form-control" name="integers" type="text">
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">枚举</label>
								<div class="col-md-8">
									<select class="yy-input-enumdata form-control" id="enumerates" name="enumerates" data-enum-group="enumerates"></select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">日期</label>
								<div class="col-md-8">
									<!-- <input class="form-control date-picker" name="dates" type="text"> -->
									<input class="Wdate form-control" name="dates" type="text" onclick=" WdatePicker();">
								</div>
							</div>
						</div>
						<div class="col-md-8">
							<div class="form-group">
								<label class="control-label col-md-2">描述</label>
								<div class="col-md-10">
									<input class="form-control" name="longtexts" type="text">
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/detailscript.jsp"%>
	<%@include file="/WEB-INF/views/common/commonscript_approve.jsp"%>
	<%@include file="/WEB-INF/views/common/yy-map.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			//按钮绑定事件
			bindDetailActions();

			$("input[name='uuid']").val('${entity.uuid}');
			$("input[name='texts']").val('${entity.texts}');
			$("input[name='numbers']").val('${entity.numbers}');
			$("input[name='integers']").val('${entity.integers}');
			$("select[name='enumerates']").val('${entity.enumerates}');
			$("input[name='dates']").val('${entity.dates}');
			$("input[name='longtexts']").val('${entity.longtexts}');

		});
		
		//查看审批意见
		function onLookApprove(){
			var billtype = '${entity.billtype}';
			var billid = '${entity.uuid}';
			onApproveLook(billtype,billid);
		}
	</script>
</body>
</html>