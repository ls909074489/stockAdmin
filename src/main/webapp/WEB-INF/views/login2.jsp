<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="Content-Language" content="zh-CN">
	<meta name="Keywords" content="YY2.0" />
	<meta name="Description" content="江西耀润磁电科技有限公司" />
	<meta name="author" content="ls2008" />
	<title>江西耀润磁电科技有限公司</title>
	
	<link href="${ctx}/assets/metronic/v4.5/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/css/bootstrap.min.css?v=20171101" rel="stylesheet" type="text/css" />
	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN THEME GLOBAL STYLES -->
	<link href="${ctx}/assets/metronic/v4.5/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
	<link href="${ctx}/assets/metronic/v4.5/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
	<!-- END THEME GLOBAL STYLES -->
	
	<!-- BEGIN slider CSS -->
	<link href="${ctx}/assets/slider/css/jquery.slider.css" rel="stylesheet" type="text/css"/>
	<!-- end slider CSS -->
	
	<!-- BEGIN PAGE LEVEL STYLES -->
	<link href="${ctx}/assets/yy/login/yy-login.css?v=20171101" rel="stylesheet" type="text/css" />
	<!-- END PAGE LEVEL STYLES -->
	
	<style type="text/css">
		.loginvalidate {
			width: 100%;
			height: 100%;
			float: left;
			border-radius: 4px;
			box-sizing: border-box;
			position: relative;
		}
	</style>
	<link rel="shortcut icon" href="favicon.ico" />
	<script type="text/javascript">
		var projectPath="${ctx}";
	</script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.min.js?v=20171101" type="text/javascript"></script>
	<script src="${ctx}/assets/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->

<body class="login" oncontextmenu="return false">
	<!-- BEGIN LOGO -->
	<div class="header clearfix" id="header" style="margin-top: 14px;">
		<!-- <h2 id="logo">YS云服务系统研发平台（3.0）</h2> -->
		<p class="topLink" id="loginLink">
			<!-- <a href="http://rj.baidu.com/soft/detail/14744.html?ald"
				target="_blank">推荐浏览器下载</a> |  -->
				
				<!-- <a href="#" target="_blank">帮助中心</a> | 
				<a id="addFavorite" href="javascript:addFavorite();"
				style="margin-right: 18px;">加入收藏夹</a> -->
		</p>
	</div>
	<!-- END LOGO -->
	<!-- BEGIN LOGIN -->
	<div class="main" id="main">
		<div class="leftcontent" style="width: 580px;">
			<h1 id="title">江西耀润磁电科技有限公司</h1>
			<ul>
				<li>多站点管理</li>
				<li>版本控制</li>
				<li>信息点表版本对比</li>
				<li>了解更多&gt;&gt;</li>
			</ul>
		</div>
		<div class="content">
			<!-- BEGIN LOGIN FORM -->
			<form class="login-form" name="login-form" th:action="@{/login}" method="post">
				<h3 class="form-title font-green">账户密码登录</h3>
				
				<div class="alert alert-danger display-hide">
					<button class="close" data-close="alert"></button>
					<span id="login-msg">请完成滑动验证，输入用户名和密码</span>
				</div>
				
				<div class="form-group">
					<div class="input-icon input-icon-lg">
						<i class="fa fa-user font-blue"></i>
						<input class="form-control placeholder-no-fix" type="text" placeholder="用户名" 
							id="username" name="username" value="shiao"/>
					</div>
				</div>
				<div class="form-group">
					<div class="input-icon input-icon-lg">
						<i class="fa fa-unlock-alt font-blue"></i>
						<input class="form-control placeholder-no-fix" 
							type="password" placeholder="密码" id="password" name="password"  value="123456"/>
					</div>
				</div>
				<input type="hidden" id="validatecode" name="validatecode" />
				<div class="loginvalidate">
					<div id="slider"></div>
				</div>
				<div class="form-actions">
					<button type="button" onclick="loginClickfuc();" id="yy-login" class="btn btn-primary btn-lg uppercase">登 录</button>
					<!-- <a href="javascript:;" id="forget-password" class="forget-password">忘记密码？</a> -->
				</div>
			</form>
			
			<!-- END LOGIN FORM -->
			<!-- BEGIN FORGOT PASSWORD FORM -->
			<form class="forget-form" action="index.html" method="post">
				<h3 class="font-blue">找回密码</h3>
				<p>输入您的手机号码重新设置您的密码。</p>
				<div class="form-group">
					<input class="form-control placeholder-no-fix" type="text"
						autocomplete="off" placeholder="Email" name="email" />
				</div>
				<div class="form-actions">
					<button type="button" id="back-btn" class="btn blue btn-outline">返回</button>
					<button type="submit" class="btn btn-primary uppercase pull-right">提交</button>
				</div>
			</form>
			<!-- END FORGOT PASSWORD FORM -->
			
			
			<!-- BEGIN FORGOT PASSWORD FORM -->
			<form class="cursys-form" action="${ctx}/sso/apiLogin" method="post">
				<input type="hidden" id="loginUserName" name="loginUserName" value=""/>
				<input type="hidden" id="loginPwd" name="loginPwd" value=""/>
			</form>
			<!-- END FORGOT PASSWORD FORM -->
		</div>
	</div>
	<div class="footer">
		Copyright © 2018 <a href="">ls2008</a> All Righ Reserved <br>
		<span>
			推荐使用
			<a href="${ctx}/assets/ChromeStandalone_63.exe"target="_blank">谷歌（Chrome）浏览器</a>
			访问系统，或者支持HTML5的浏览器。建议使用1600*900 及以上分辨率
		</span>
	</div>
	
	<!-- BEGIN CORE PLUGINS -->
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/js/bootstrap.min.js?v=20171101" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-validation/js/jquery.validate.js?v=20171101" type="text/javascript" ></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-validation/js/additional-methods.min.js?v=20171101" type="text/javascript" ></script>
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN THEME GLOBAL SCRIPTS -->
	<script src="${ctx}/assets/metronic/v4.5/global/scripts/app.min.js" type="text/javascript"></script>
	<!-- END THEME GLOBAL SCRIPTS -->
	
	<!-- BEGIN slider SCRIPTS -->		
	<script src="${ctx}/assets/slider/js/jquery.slider.min.js?v=20171101" type="text/javascript"></script>
	<!-- END slider SCRIPTS -->
	
	<script src="${ctx}/assets/md5/jquery.md5.js" type="text/javascript"></script>
	
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="${ctx}/assets/yy/login/yy-login.js?v=20171201" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	
<script type="text/javascript">

	if (window != top) {
		top.location.href = location.href;
	}if (window != top) {
		top.location.href = '${ctx}';
	}

	var errorMsg = '${errorMsg}';
	var rcode = '${rcode}';
	if(errorMsg !=null && errorMsg.length > 0){
		$('.alert-danger', $('.login-form')).show();
		$("#login-msg").html(errorMsg);
	};
	
	$(document).ready( function() {
		// 设置背景
		$.backstretch([
				"assets/yy/login/timg.jpg",
			], {
			fade : 1000, //渐变时间
			duration : 5000
		});
		Login.init();
		// 检查浏览器
		checkBrowser();
		
		var ssoLoginMsg='${ssoLoginMsg}';
		if(ssoLoginMsg!=null&&ssoLoginMsg.length>0){
			$('.alert-danger', $('.login-form')).show();
			$("#login-msg").html(ssoLoginMsg);
		}
	});
	
	//点击登录按钮
	function loginClickfuc(){
	   if ($('.login-form').validate().form()) {
			$.ajax({
				type : "POST",
				data :{"account": $("#username").val(),"password":$.md5($("#password").val())},
				url : "http://app.weishiao.com:8080/qjb/login",
				async : true,
				dataType : "json",
				success : function(data) {
					if (data.flag==0) {
						curSysLogin();
					}else {
						$('.alert-danger', $('.login-form')).show();
						$("#login-msg").html("登录失败，用户名或密码错误");
					}
				},
				error : function(data) {
					$("#login-msg").html("登录失败，请联系管理员");
				}
			});
       }
	}
	//当前系统登录
	function curSysLogin(){
		$("#loginUserName").val($("#username").val());
		$("#loginPwd").val($.md5($("#password").val()));
		$(".cursys-form").submit();
	}
</script>
</body>
</html>
