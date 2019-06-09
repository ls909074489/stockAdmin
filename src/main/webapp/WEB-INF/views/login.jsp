\<%@ page contentType="text/html;charset=UTF-8"%>
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
	<meta name="Description" content="库存管理系统" />
	<meta name="author" content="KingLiu" />
	<title>库存管理系统</title>
	
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
	<link href="${ctx}/assets/yy/login/yy-login.css?v=20171124" rel="stylesheet" type="text/css" />
	<!-- END PAGE LEVEL STYLES -->
	
	<style type="text/css">
		.loginvalidate {
			width: 100%;
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

<body class="login" oncontextmenu="return false" style="background-image: url(${ctx}/assets/yy/login/timg.jpg)">
	<!-- BEGIN LOGO -->
	<div class="header clearfix" id="header" style="margin-top: 14px;">
		<!-- <h2 id="logo">YS云服务系统研发平台（3.0）</h2> -->
		<p class="topLink" id="loginLink">
			<a
				href="http://rj.baidu.com/soft/detail/14744.html?ald"
				target="_blank">推荐浏览器下载</a> | <a href="#" target="_blank">帮助中心</a> | <a
				id="addFavorite" href="javascript:addFavorite();"
				style="margin-right: 18px;">加入收藏夹</a>
		</p>
	</div>
	<!-- END LOGO -->
	<!-- BEGIN LOGIN -->
	<div class="main" id="main">
		<div class="leftcontent">
			<h1 id="title">库存管理系统</h1>
			<ul>
				<li>库存数据管理</li>
				<li>数据分析</li>
				<li>了解更多&gt;&gt;</li>
			</ul>
		</div>
		<div class="content">
			<!-- BEGIN LOGIN FORM -->
			<form class="login-form" name="login-form" th:action="@{/login}" method="post">
				<h3 class="form-title font-green">账户密码登录</h3>
				
				<div class="alert alert-danger display-hide">
					<button class="close" data-close="alert"></button>
					<span id="login-msg">请完成滑动验证，输入账号和密码</span>
				</div>
				
				<div class="form-group">
					<div class="input-icon input-icon-lg">
						<i class="fa fa-user font-blue"></i>
						<input class="form-control placeholder-no-fix" type="text" placeholder="用户名" 
							id="username" name="username" value="1"/>
					</div>
				</div>
				<div class="form-group">
					<div class="input-icon input-icon-lg">
						<i class="fa fa-unlock-alt font-blue"></i>
						<input class="form-control placeholder-no-fix" 
							type="password" placeholder="密码" id="password" name="password"  value="1"/>
					</div>
				</div>
				<input type="hidden" id="validatecode" name="validatecode" />
				<div class="loginvalidate">
					<div id="slider"></div>
				</div>
				<div class="form-actions">
					<button type="submit" id="yy-login" class="btn btn-primary btn-lg uppercase">登 录</button>
					<!-- <a href="javascript:;" id="forget-password" class="forget-password">忘记密码？</a> -->
					
					<div style="display:inline;float:right;font-size:14px;">
						<a href="#" onclick="javascript:showEnterAccount();">忘记密码?</a>
					</div> 
				</div>
				
				<!-- 
				<div class="login-options">
					<h4>其他登录方式</h4>
					<ul class="social-icons">
						<li><a class="social-icon-color facebook"
							data-original-title="facebook" href="javascript:;"></a></li>
						<li><a class="login_wechat" data-original-title="微信"
							href="javascript:;"></a></li>
					</ul>
				</div>
				 -->
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
		</div>
	</div>
	<div class="footer">
		Copyright © 2019-2020 <a href=""> King Liu</a> All Righ Reserved <br>
		<span>推荐使用谷歌（Chrome）浏览器访问系统，或者支持HTML5的浏览器。建议使用1600*900 及以上分辨率</span>
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
	<script src="${ctx}/assets/slider/js/jquery.slider.min.js" type="text/javascript"></script>
	<!-- END slider SCRIPTS -->
	
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="${ctx}/assets/yy/login/yy-login.js?v=2019" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<!-- BEGIN layer -->
	<script src="${ctx}/assets/layer/layer.js?v=20160801" type="text/javascript"></script>
	<script src="${ctx}/assets/layer/extend/layer.ext.js?v=20160801" type="text/javascript"></script>
	
<script type="text/javascript">

	if (window != top) {
		top.location.href = location.href;
	}if (window != top) {
		top.location.href = '${ctx}';
	}

	var errorMsg = '${errorMsg}';
	if(errorMsg !=null && errorMsg.length > 0){
		$('.alert-danger', $('.login-form')).show();
		$("#login-msg").html(errorMsg);
	};
	
	$(document).ready( function() {
		// 设置背景
		/* $.backstretch([
				"assets/yy/login/lvse.jpg",
			], {
			fade : 1000, //渐变时间
			duration : 5000
		}); */
		Login.init();
		// 检查浏览器
		checkBrowser();
	});
	
	//点击忘记密码，弹出对话框
	function showEnterAccount() {
		layer.open({
			type : 2,
			title : '重置密码(1/3)',
			shadeClose : false,
			shade : 0.8,
			area : [ '420px', '250px' ],
			content : '${ctx}/login/showEnterAccount'//iframe的url
		});
	}
</script>
</body>
</html>

