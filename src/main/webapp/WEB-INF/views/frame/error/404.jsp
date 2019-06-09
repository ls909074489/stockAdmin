<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
<meta charset="utf-8" />
<title>404 页面</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${ctx}/assets/component/useso/useso.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet"
	type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet"
	type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME GLOBAL STYLES -->
<link href="${ctx}/assets/metronic/v4.5/global/css/components.min.css" rel="stylesheet" id="style_components"
	type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/css/plugins.css" rel="stylesheet" type="text/css" />
<!-- END THEME GLOBAL STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="${ctx}/assets/metronic/v4.5/pages/css/error.min.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL STYLES -->

<link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->

<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
	<div class="container-fluid page-container page-content">
		<!-- BEGIN PAGE TITLE-->
		<h3 class="page-title">
			404 <small>I'm sorry!</small>
		</h3>
		<!-- END PAGE TITLE-->
		<!-- END PAGE HEADER-->
		<div class="row">
			<div class="col-md-12 page-404">
				<div class="number font-green">404</div>
				<div class="details">
					<h3>功能正在拼命的研发中，稍后开放...</h3>
					<p>
						我们找不到您要找的页面，内容不存在或者该功能正在拼命的研发中。 <br /> <a href=""> 重新加载页面试一下</a>
					</p>

				</div>
			</div>
		</div>
	</div>
	<!-- BEGIN CORE PLUGINS -->
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/js.cookie.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
		type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js"
		type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN THEME GLOBAL SCRIPTS -->
	<script src="${ctx}/assets/metronic/v4.5/global/scripts/app.min.js" type="text/javascript"></script>
	<!-- END THEME GLOBAL SCRIPTS -->
</body>

</html>