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
<link href="${ctx}/assets/component/useso/useso.css?v=20160801" rel="stylesheet" type="text/css"/>
<link href="${ctx}/assets/metronic/v4.5/global/plugins/font-awesome/css/font-awesome.min.css?v=20160801" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/simple-line-icons/simple-line-icons.min.css?v=20160801" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/css/bootstrap.min.css?v=20160801" rel="stylesheet" type="text/css" />
<%-- <link href="${ctx}/assets/metronic/v4.5/global/plugins/uniform/css/uniform.default.css?v=20160801" rel="stylesheet" type="text/css" /> --%>
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-toastr/toastr.min.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL PLUGINS -->
        
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="${ctx}/assets/metronic/v4.5/global/plugins/icheck/skins/all.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css?v=20160801" rel="stylesheet" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/select2/css/select2.min.css?v=20160801" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/select2/css/select2-bootstrap.min.css?v=20160801" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/datatables/datatables.min.css?v=20160801" />
<!--<link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css?v=20160801"/>-->
<%-- <link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css?v=20160801"/>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/metronic/v4.5/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css?v=20160801"/> --%>
<!-- END PAGE LEVEL STYLES -->

<!-- BEGIN THEME GLOBAL STYLES -->
<link href="${ctx}/assets/metronic/v4.5/global/css/components.min.css?v=20160801" rel="stylesheet" id="style_components" type="text/css" />
<link href="${ctx}/assets/metronic/v4.5/global/css/plugins.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- END THEME GLOBAL STYLES -->

<!-- BEGIN THEME LAYOUT STYLES -->
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/layout.min.css?v=20160801" rel="stylesheet" type="text/css" />
<!--<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/themes/darkblue.min.css?v=20160801" rel="stylesheet" type="text/css" id="style_color" />-->
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/themes/light2.css?v=20160801" rel="stylesheet" type="text/css" id="style_color" />
<link href="${ctx}/assets/metronic/v4.5/layouts/layout/css/custom.min.css?v=20160801" rel="stylesheet" type="text/css" />
<!-- BEGIN zTree -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/ztree/3.5.19/zTreeStyle/zTreeStyle.css?v=20160801">

<!-- BEGIN YY CSS AND JS -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/css/yy.css?v=20160801"/>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/css/yy_table.css?v=20160801"/>
<!-- end YY CSS AND JS -->

<!-- BEGIN YY Report -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/yy/report/superTables.css?v=20160801"/>
<!-- end YY Report -->


<!-- END THEME LAYOUT STYLES -->
<link rel="shortcut icon" href="favicon.ico" />

<script type="text/javascript">
	var projectPath="${ctx}";
</script>


<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.min.js?v=20160801" type="text/javascript"></script>

<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/scripts/datatable.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/datatables/datatables.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- zTree plugin scripts -->
<script src="${ctx}/assets/ztree/3.5.19/js/jquery.ztree.core-3.5.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/ztree/3.5.19/js/jquery.ztree.excheck-3.5.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/ztree/3.5.19/js/jquery.ztree.exedit-3.5.min.js?v=20160801" type="text/javascript"></script>

<!-- jquery.layout -->
<script src="${ctx}/assets/uilayout/1.4/jquery.layout-latest.js?v=20160801" type="text/javascript"></script>

<!-- BEGIN layer -->
<script src="${ctx}/assets/layer/layer.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/layer/extend/layer.ext.js?v=20160801" type="text/javascript"></script>

<!-- 表单相关 -->
<script src="${ctx}/assets/formjs/jquery.form.js?v=20160801" type="text/javascript" ></script>
<script type="text/javascript" src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-validation/js/jquery.validate.js?v=20160801"></script>
<script type="text/javascript" src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-validation/js/additional-methods.min.js?v=20160801"></script>
<script type="text/javascript" src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-validation/js/validate-methods.js?v=20160801"></script>

<!-- 图表相关  --> 
<script src="${ctx}/assets/echarts/echarts.min.js?v=20160801" type="text/javascript"></script>

<!-- BEGIN YY平台js -->
<script src="${ctx}/assets/yy/js/yy-msg-utils.js?v=20160801"></script> 
<script src="${ctx}/assets/yy/js/yy-utils-validate.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy-form-utils.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy-form-validate.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy-ztree-utils.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy-datatable-utils.js?v=20170221"></script>
<script src="${ctx}/assets/yy/js/yy-ui-utils.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy-data-utils.js?v=20160801"></script>
<script src="${ctx}/assets/yy/js/yy.js?v=20160801"></script>

<!-- BEGIN report-->
<script src="${ctx}/assets/yy/report/superTables.js?v=20160801"></script>
<script src="${ctx}/assets/yy/report/jquery.superTable.js?v=20160801"></script>
<!-- BEGIN report -->

<!-- 获取地址 -->
<%-- <script src="${ctx}/assets/yy/js/yy-address-utils.js?v=20160801"></script> --%>
<script src="${ctx}/assets/yy/js/yy-address-method-utils.js?v=20160801"></script>
<!-- END YY平台js -->

<sitemesh:write property='head' />
</head>
<!-- END HEAD -->


<!-- BEGIN BODY -->
<body class="page-sidebar-fixed page-footer-fixed page-content-white" >
<sitemesh:write property='body' />

<!--[if lt IE 9]>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/respond.min.js?v=20160801"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/excanvas.min.js?v=20160801"></script> 
<![endif]-->

<!-- BEGIN CORE PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap/js/bootstrap.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/js.cookie.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/jquery.blockui.min.js?v=20160801" type="text/javascript"></script>
<%-- <script src="${ctx}/assets/metronic/v4.5/global/plugins/uniform/jquery.uniform.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js?v=20160801" type="text/javascript"></script> --%>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-toastr/toastr.min.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
        
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/icheck/icheck.min.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
  
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/moment.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-daterangepicker/daterangepicker.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${ctx}/assets/metronic/v4.5/global/plugins/select2/js/select2.min.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${ctx}/assets/metronic/v4.5/global/scripts/app.min.js?v=20160801" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${ctx}/assets/metronic/v4.5/pages/scripts/components-date-time-pickers.min.js?v=20160801" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="${ctx}/assets/metronic/v4.5/layouts/layout/scripts/layout.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/layouts/layout/scripts/demo.min.js?v=20160801" type="text/javascript"></script>
<script src="${ctx}/assets/metronic/v4.5/layouts/global/scripts/quick-sidebar.min.js?v=20160801" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->


<!-- begin date script -->
<script src="${ctx}/assets/My97DatePicker/WdatePicker.js?v=20160801" type="text/javascript"></script>
<!-- end date script -->

<!-- Starts the upload file  -->
<script src="${ctx}/assets/uploadFile/ajaxfileupload.js?v=20160801" type="text/javascript"></script>

<!-- 复选框  -->
<script type="text/javascript" src="${ctx}/assets/tool/Popt.js?v=20160801"></script>

<!-- datatable 外部插件，主要解决子表加载问题  -->
<script src="${ctx}/assets/datatables/extensions/Scroller/js/dataTables.scroller.min.js?v=20160801"></script>

<script type="text/javascript">
	App.setAssetsPath("${ctx}/assets/metronic/v4.5/");
	App.setGlobalImgPath("${ctx}/assets/metronic/v4.5/global/img/");
	App.setGlobalPluginsPath("${ctx}/assets/metronic/v4.5/global/plugins/");
</script>
</body>
<!-- END BODY -->
</html>