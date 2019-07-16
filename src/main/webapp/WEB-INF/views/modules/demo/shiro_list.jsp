<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>发送邮件</title>
  <link href="${ctx}/assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.min.js"></script>
  <script type="text/javascript" src="${ctx}/assets/umeditor/zh-cn.js"></script>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
		<div class="row">
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="complainWorkId" id="complainWorkId" type="hidden" value="${complainWorkId}"/>
				<div class="row">
				<table style="width: 100%;">
					<tr style="height: 40px;">
						<td style="text-align: right;width: 8%;">
							<div class="">收件人&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td style="width: 95%;">
							<%-- <input name="receiver" id="receiver" type="text" class="form-control" style="width: 97%;" value="${template.receiver}"> --%>
							
							
							<div class="form-group">
								<div class="col-md-12">
									<div class="input-group">
										<!-- <input name="receiver" id="receiver" type="text" class="form-control" style="width: 95%;" value=""> -->
										
										<select class="combox form-control" id="receiver" name="receiver" style="float: left;">
											<option value=""></option>
										</select>
										
										
										<button class="btn blue btn-sm editMailSender" style="" type="button">
													<i class="fa fa-plus"></i>
										</button>
										<!-- 加上两个才能排版对齐 -->
										<span class="input-group-btn" style="">
											<button class="btn btn-sm white editMailSender" type="button">
													<i class=""></i>
											</button>
										</span>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>
				</div>
			</form>
		</div>
		<script type="text/javascript">
		
			$(document).ready(function() {
				/* $('#receiver').select2({
					placeholder: "",
					tags:true,
					width:'95%'
				}); */ 
				
				$("#receiver").select2({
			        theme: "bootstrap",
			        allowClear: true,
			        placeholder: "请选择",
			        ajax:{
			            url:"${ctx}/info/projectinfo/select2Query",
			            dataType:"json",
			            delay:250,
			            data:function(params){
			                return {
			                    codeOrName: params.term
			                };
			            },
			            cache:true,
			            processResults: function (res, params) {
			            	console.info(res);
			            	console.info(params);
			                var options = [];
			                var records = res.records;
			                for(var i= 0, len=records.length;i<len;i++){
			                    var option = {"id":records[i].uuid, "text":records[i].name+"("+records[i].code+")"};
			                    options.push(option);
			                }
			                return {
			                    results: options
			                };
			            },
			            escapeMarkup: function (markup) { return markup; },
			            minimumInputLength: 1
			        }
			    });
				
			});

		</script>
	</div>
</body>
</html>