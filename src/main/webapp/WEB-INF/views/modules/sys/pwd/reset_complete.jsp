<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link href="${ctx}/assets/yy/css/login_style.css?v=20160801" rel="stylesheet" type="text/css" />
<script src="${ctx}/assets/layer/layer.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/layer/extend/layer.ext.js?v=20160801" type="text/javascript"></script>
<div class="page-content" id="yy-page-detail">
	<div class="row">
		<form id="yy-form-detail"  class="form-horizontal yy-form-detail" action="${ctx}/validateUserName" method="post">
			
			<table style="text-align: center;">
				<tr  style="height: 50px;"><td style="font-size: 18px;"><label class="control-label">您的密码已经成功修改为：${newPwd}</label></td></tr>
				<tr style=""><td>
						<a href="#" id="embed-submit" class="button orange" style="width: 120px;margin-left: 100px;">返回首页</a><!-- 发送验证邮件 -->
				</td></tr>
			</table>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#embed-submit").click(function(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
		});
	});
</script>

<style type="text/css">
	.login-txt {
		border: 1px solid #c2cad8;
		font-family: verdana;
		width: 250px;
		line-height: 21px;
		color: #34495e;
		font-size: 14px;
		padding: 7px 0;
		outline: none;
	}
	.row{
		width : 305px;
		margin-left: 50px;
		margin-top: 10px;
	}
	.button{
		box-shadow : none;
	}
	.button:hover{
		text-decoration:none;
	}
</style>

