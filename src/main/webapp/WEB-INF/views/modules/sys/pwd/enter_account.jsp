<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<link href="${ctx}/assets/yy/css/login_style.css?v=20160801" rel="stylesheet" type="text/css" />
<script src="${ctx}/assets/layer/layer.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/layer/extend/layer.ext.js?v=20160801" type="text/javascript"></script>
<div class="page-content" id="yy-page-detail">
	<div class="row">
		<form id="yy-form-detail"  class="form-horizontal yy-form-detail" action="${ctx}/validateUserName" method="post">
			
			<div class="row" style="font-size: 20px;">				
				<div class="col-md-10">
					<div class="form-group">
							<div class="col-md-10">
								<label class="control-label">输入您的教师编号或学号</label>
							</div>
						</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10" style="margin-left: 40px;">
					<div class="form-group">
						<div class="col-md-10">
							<input id="userName" name="userName" type="text" class="login-txt"></input>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10" style="margin-left: 40px;">
					<div class="form-group">
						<div class="col-md-10">
							<div style="float:left;">
								<a href="#" id="embed-submit" class="button orange">下一步</a><!-- 下一步 -->
							</div>
							<div style="float:right;">
								<a href="#" id="embed-cancle" class="button" style="background: #aeb7d2;">取消</a><!-- 取消 -->
							</div>
						</div>
					</div>
				</div>	
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#embed-cancle").click(function(){
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
			parent.layer.close(index);
		});
		$("#embed-submit").click(function(){
			var isValidated = checkInput();
			if(!isValidated){
				YYUI.promMsg('请输入登录账号');
				return;
			}
			var result = validateUserName();
			if(result == "error"){
				YYUI.promAlert('http错误');
				return;
			}
			if(result == "notExisted"){
				YYUI.promAlert('您输入的登录账号不存在！');
				return;
			}
			if(result == "disabled"){
				YYUI.promAlert('您输入的登录账号异常，请联系管理员！');
				return;
			}
			parent.layer.open({//打开一个新的层
				type : 2,
				title : '重置密码(2/3)',
				shadeClose : false,
				shade : 0.8,
				area : [ '420px', '250px' ],
				content : '${ctx}/login/showUserName'//iframe的url
			});
			$("#embed-cancle").click();//先关闭当前层
		});
	});
	
	function validateUserName(){
		var userName = $('#yy-form-detail input[name="userName"]').val();
		var result = "";
		$.ajax({
			type : "POST",
	    	async : false,
	    	url : "${ctx}/login/validateLoginName",
	    	data : {"userName" : userName},
	    	error: function(xhr, textStatus, errorThrown) {
	    		result = "error";
	    	},
	    	success: function(data) {
	    		result = data;
	    	}
	    });
		return result;
	}
	
	function checkInput(){
		var userName = $('#yy-form-detail input[name="userName"]').val();
		if(userName == null || userName.trim() == "")
			return false;
		return true;
	}
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
		margin-left: 20px;
		margin-top: 10px;
	}
	.button{
		box-shadow : none;
	}
	.button:hover{
		text-decoration:none;
	}
</style>
