<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/job"/>
<html>
<head>
<title>立即执行</title>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
		<div class="row">
			<form class="form-horizontal" name="yy-form-changepwd" id="yy-form-changepwd">
				<table>
					<tr style="height: 10px;"><td></td><td></td></tr>
					<tr style="height: 40px;">
						<td style="width: 25%;"><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;开始时间：</label></td>
						<td style="width: 55%;">
							<input id="startTime" class="Wdate form-control" style="width:280px;" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')}'})"/>   
						</td>
					</tr>
					
					<tr style="height: 40px;">
						<td><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;结束时间：</label></td>
						<td>
							<input id="endTime" class="Wdate form-control" type="text" style="width:280px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}'})"/>
						</td>
					</tr>
				</table>

				<div class="row form-actions yy-toolbar" style="margin-top: 10px;text-align: center;background-color: white;">
					<button id="yy-btn-process" type="button">
						<i class="fa fa-save"></i> 执行
					</button>
					<button id="yy-btn-reset" type="reset" class="btn blue btn-sm">
						<i class="fa fa-rotate-left"></i> 清空
					</button>
					<button id="yy-btn-processCancel" type="button" class="btn blue btn-sm">
						<i class="fa icon-key"></i> 关闭
					</button>
				</div>
			</form>
		</div>
	</div>
	
	<%@include file="job_script_common.jsp"%>
	<script type="text/javascript">
	
	//页面加载函数	
	$(document).ready(function() {
		// 验证
		validateForms();
		
		//绑定按钮事件
		$("#yy-btn-process").bind('click', onProcess);
		$("#yy-btn-processCancel").bind('click', onProcessCancel);
		$("#yy-btn-reset").bind('click', reset);
	});
	
	
	// 表单验证 validate
 	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				startTime:{required : true}
			}
		}); 
	}
	
	
	//立即执行
	function onProcess(){
		validateForms();
		//要取出值 拼接成Json
		var startTime = $("#startTime").val();
		var endTime = $("#endTime").val();
		var parameterJson = "{'startTime':'"+startTime +"','endTime':'"+endTime+"'}";
		var jobId = '${jobId}';
		run(jobId,parameterJson);//立即执行
	}
	
	
	</script>
</body>
</html>