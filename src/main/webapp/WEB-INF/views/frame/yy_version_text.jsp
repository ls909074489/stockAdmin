<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/sys/versionmessage"/>
<html>
<head>
<title>版本更新日志</title>
<style type="text/css">
	body {
	    background-color: #ffffff;
	}
	.message{
		margin-left: 50px;
	}
</style>
</head>
<body>
	<div id="message" class="message">

	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			loadVersionMessage();
			
		});
		//加载最新版本数据
		function loadVersionMessage() {
			
			$.ajax({
				url : '${serviceurl}/query',
				data : {
					"orderby" : "createtime@desc"
				},
				dataType : 'json',
				type : 'post',
				async : false,
				success : function(data) {
					if(data.records!=null && data.records.length>0){
						var message = '';
						if(data.records.length<3){
							for(var i=0;i<data.records.length;i++){
								message = message+data.records[i].message;
								if(i!=data.records.length-1){
									message = message+'<div class="row" style="border-top: 3px solid #F1F2F2; padding-top: 5px; padding-bottom: 5px;"></div>';
								}
							}
						}else{
							for(var i=0;i<3;i++){
								message = message+data.records[i].message;
								if(i!=2){
									message = message+'<div class="row" style="border-top: 3px solid #F1F2F2; padding-top: 5px; padding-bottom: 5px;"></div>';
								}
							}
						}
						
						$("#message").html(message);
					}
					
				}
			});
		};
	</script>
</body>

</html>