<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8"/>
<title><sitemesh:write property='title' default="YY"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description"/>
<meta content="YY" name="author"/>
<meta content="YY框架，YY平台，YY" name="keywords" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${ctx}/assets/component/useso/useso.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/assets/metronic/v4.5/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN THEME GLOBAL STYLES -->
<link href="${ctx}/assets/metronic/v4.5/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
<!-- END THEME GLOBAL STYLES -->

<!-- BEGIN THEME LAYOUT STYLES -->
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
<!--<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color" />-->
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/themes/blue.min.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />

<!-- BEGIN YY CSS AND JS -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/css/yy.css"/>
<!-- end YY CSS AND JS -->

<!-- END THEME LAYOUT STYLES -->
<link rel="shortcut icon" href="favicon.ico" />

<!-- BEGIN CORE PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<script type="text/javascript">
	var YY_PATH = '${ctx}';
</script>
     
<sitemesh:write property='head' />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<!-- DOC: Apply "page-header-fixed-mobile" and "page-footer-fixed-mobile" class to body element to force fixed header or footer in mobile devices -->
<!-- DOC: Apply "page-sidebar-closed" class to the body and "page-sidebar-menu-closed" class to the sidebar menu element to hide the sidebar by default -->
<!-- DOC: Apply "page-sidebar-hide" class to the body to make the sidebar completely hidden on toggle -->
<!-- DOC: Apply "page-sidebar-closed-hide-logo" class to the body element to make the logo hidden on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-hide" class to body element to completely hide the sidebar on sidebar toggle -->
<!-- DOC: Apply "page-sidebar-fixed" class to have fixed sidebar -->
<!-- DOC: Apply "page-footer-fixed" class to the body element to have fixed footer -->
<!-- DOC: Apply "page-sidebar-reversed" class to put the sidebar on the right side -->
<!-- DOC: Apply "page-full-width" class to the body element to have full width page without the sidebar menu -->
<!-- <body class="page-header-fixed page-sidebar-fixed page-footer-fixed page-content-white" > -->
<body class="page-header-fixed page-sidebar-fixed page-footer-fixed page-content-white" >
<sitemesh:write property='body' />

<!--[if lt IE 9]>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/respond.min.js"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/excanvas.min.js"></script> 
<![endif]-->

<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${ctx}/assets/metronic/v4.5/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${ctx}/assets/metronic/v4.5/layouts/layout/scripts/layout.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/layouts/layout/scripts/demo.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->

<script type="text/javascript">
	App.setAssetsPath("${ctx}/assets/metronic/v4.5/");
	App.setGlobalImgPath("${ctx}/assets/metronic/v4.5/global/img/");
	App.setGlobalPluginsPath("${ctx}/assets/metronic/v4.5/global/plugins/");
</script>
</body>
<!-- END BODY -->
</html>