<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<title>${systitle}</title>

<!-- BEGIN CSS tab -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/tabs/css/style.css" />
<%-- <script src="${ctx}/assets/yy/js/yy-address-utils.js"></script> --%>
<%-- <script src="${ctx}/assets/yy/js/yy-address-utils-page.js"></script> --%>
<style type="text/css">
#dropdown-menu-pull-right-menu {
	width: 140px;
}
/*sidebar-toggler-wrapper*/
.menu-toggler.sidebar-toggler {
	margin-top: 8px;
	margin-bottom: 8px;
}

/*给导航条设置 margin*/
.page-container-bg-solid .page-bar, .page-content-white .page-bar {
	background-color: #fff;
	margin: -25px 0 5px -10px;
	padding: 0 20px;
	position: relative;
}

.roll-right.J_tabRight {
	right: 90px;
}

.roll-right.btn-group {
	right: 10px;
}

nav.page-tabs {
	margin-left: 20px;
}

.mainrow {
	margin-left: -10px;
	margin-right: -10px;
}

.page-logo {
	width: 400px;
}

.dropdown-menu.pull-right {
	left: -90px;
}

.page-sidebar-fixed .page-footer {
	padding: 0px 0px 0px;
}

.page-footer .page-footer-inner {
	padding: 8px 20px 5px;
	float: right;
}

/*foot的快捷方式*/
.page-footer .page-footer-menu {
	color: #FFFFFF;
	display: inline-block;
	float: left;
	font-size: 13px;
	padding: 1px 5px 2px 10px;
	
}
.page-footer .page-footer-menu .btn {
	font-size: 14px;
}

</style>
<script type="text/javascript">
	var ws = null;
	var url = 'ws://' + window.location.host
			+ "${pageContext.request.contextPath}/websocket";
	var transports = [];

	function connect() {
		disconnect();
		ws = (url.indexOf('sockjs') != -1) ? new SockJS(url, undefined, {
			protocols_whitelist : transports
		}) : new WebSocket(url);
		ws.onopen = function() {
			//开辟链接执行
		};
		ws.onmessage = function(event) {
			//alert(123);
			if (event.data == "brush") {
				//5秒钟后更新页面
				setTimeout(function() {
					//清除消息
					window.frames["desktopFrame"].getMessage();
				}, 5000);
			} else {
				showNewMsg(event.data);
				//5秒钟后更新页面
				setTimeout(function() {
					//刷新指点页签的  方法
					window.frames["desktopFrame"].getMessage();
				}, 5000);
			}
			//$(window.parent.document).contents().find("#frame1")[0].contentWindow.getMessage();
		};
		ws.onclose = function(event) {
			//端口连接执行
		};
	}

	//取消链接
	function disconnect() {
		if (ws != null) {
			ws.close();
			ws = null;
		}
	}
</script>
</head>
<body>
	<!-- 如果是首次登录则修改密码 -->
	<c:if test="${empty user.changepwd or user.changepwd eq 0}">
		<script type="text/javascript">
			layer.open({
				title : '密码修改',
				type : 2,
				area : [ '450px', '280px' ],
				fix : false, //不固定
				content : '${ctx}/sys/user/pwd',
				closeBtn : 0,
				/* btn: ['提交','清空']
				  ,btn1: function(index, layero){ 
					  alert(11);
					  console.info(layer.close(index));
					  return false;
				  },btn2: function(index){
				    alert(2);
				 }, */
				cancel : function(index) {
					//YYUI.promMsg('首次登录请修改默认密码!',3000);
					//return false;
				}
			});
		</script>
	</c:if>
	<!-- BEGIN HEADER -->
	<div class="page-header navbar navbar-fixed-top">
		<!-- BEGIN HEADER INNER -->
		<div class="page-header-inner ">
			<!-- BEGIN LOGO -->
			<div class="page-logo">
				<label class="yy-logo-title" style="font-size: 22px;">${yy_logo_title}</label>
			</div>

			<span style="display: none;"> <a class="J_menuItem lsDbClickTabMenu" data-index="" href="" id="newTabHrefId"></a>
			</span> <span style="display: none;"> <a class="lsCloseTabMenu" data-index="" href="" id="closeTabHrefId"></a>
			</span>
			<!-- END LOGO -->
			<!-- BEGIN RESPONSIVE MENU TOGGLER -->
			<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
			</a>
			<!-- END RESPONSIVE MENU TOGGLER -->
			<!-- BEGIN TOP NAVIGATION MENU -->
			<div class="top-menu">
				<ul class="nav navbar-nav pull-right">
					<!-- 反馈意见start -->
					<li class="dropdown dropdown-extended dropdown-notification" id="yjfk"><a title="意见反馈" class="dropdown-toggle"
						data-toggle="dropdown" onclick="Feedback();" data-hover="dropdown" data-close-others="true"> <i
							class="icon-speech font-green"></i>
					</a></li>
					<!-- 反馈意见end -->

					<!-- 使用说明start -->
					<!-- <li class="dropdown dropdown-extended dropdown-notification" id="bzsc"><a title="帮助手册" class="dropdown-toggle"
						data-toggle="dropdown" onclick="openHelpDoc();" data-hover="dropdown" data-close-others="true"> <i
							class="icon-question font-yellow"></i>
					</a></li> -->
					<!-- 使用说明end -->

					<!-- BEGIN 个人信息 -->
					<li class="dropdown dropdown-user"><a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown"
						data-hover="dropdown" data-close-others="true"> <img alt="" class="img-circle"
							<%-- $src="${ctx}/assets/metronic/v4.5/layouts/layout/img/avatar3_small.jpg"  --%>
							src="${ctx}/assets/yy/img/user.png" />
							<span class="username username-hide-on-mobile"> <c:if test="${not empty user.orgname}">${user.orgname}-</c:if>${user.username}
						</span> <i class="fa fa-angle-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-menu-default">
							<li><a onclick="onUserProfile();"> <i class="icon-user"></i> 个人设置
							</a></li>
							<li><a onclick="onCalendar();"> <i class="icon-calendar"></i> 我的日历
							</a></li>
							<li class="divider"></li>
							<li><a onclick="lsAddTab('${ctx}/version','版本更新日志','f431561e-228e-41ed3-31da-96f3611232132')"> <i
									class="fa fa-file-text-o"></i> 版本更新日志
							</a></li>
							<li><a onclick="onRevisePassword();"> <i class="icon-lock"></i> 修改密码
							</a></li>
							<li><a onclick="onBack();" title="退出系统"> <i class="icon-key"></i> 退出系统
							</a></li>
						</ul></li>
					<!-- END 个人信息 -->

					<!-- BEGIN 退出系统 -->
					<li class="dropdown dropdown-quick-sidebar-toggler"><a href="#" onclick="onBack();" class="dropdown-toggle"
						title="退出系统"> <i class="icon-logout font-red"></i>
					</a></li>
					<!-- END 退出系统 -->
				</ul>
			</div>
			<!-- END TOP NAVIGATION MENU -->
		</div>
		<!-- END HEADER INNER -->
	</div>
	<!-- END HEADER -->
	<!-- BEGIN HEADER & CONTENT DIVIDER -->
	<div class="clearfix"></div>
	<!-- END HEADER & CONTENT DIVIDER -->

	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<div class="page-sidebar-wrapper">
			<!-- BEGIN SIDEBAR -->
			<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
			<!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
			<div class="page-sidebar navbar-collapse collapse">
				<!-- BEGIN SIDEBAR MENU -->
				<!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
				<!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
				<!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
				<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
				<!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
				<!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
				<ul class="page-sidebar-menu" data-auto-scroll="true" data-slide-speed="200">
					<li class="sidebar-toggler-wrapper">
						<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
						<div class="menu-toggler sidebar-toggler"></div>
					</li>

					<!-- BEGIN FUNCTIONS MENU -->
					<c:forEach items="${functreeList}" var="cur" varStatus="cishu">
						<c:if test="${cur.nodeData.func_type=='module'}">
							<li class="nav-item"><a href="javascript:;" class="nav-link nav-toggle" id="yy-link${cishu.index}"> <c:if
										test="${ empty cur.nodeData.iconcls }">
										<i class="fa fa-th-large"></i>
									</c:if> <c:if test="${ not empty cur.nodeData.iconcls }">
										<i class="${cur.nodeData.iconcls}"></i>
									</c:if> <span class="title">${cur.nodeData.func_name}</span> <span class="arrow"></span>
							</a> <c:if test="${not empty cur.children }">
									<!-- 如果有childen -->
									<c:set var="functreeList" value="${cur.children}" scope="request" />
									<!-- 注意此处，子列表覆盖treeList，在request作用域 -->
									<ul class="sub-menu">
										<c:import url="subfunc.jsp" />
										<!-- 这就是递归了 -->
									</ul>
								</c:if>
						</c:if>

					</c:forEach>

				</ul>
				<!-- END SIDEBAR MENU -->
			</div>
			<!-- END SIDEBAR -->
		</div>
		<!-- END SIDEBAR -->
		<!-- BEGIN CONTENT -->
		<div class="page-content-wrapper">
			<!-- BEGIN CONTENT BODY -->
			<div class="page-content">
				<!-- BEGIN PAGE tabs-->
				<div class="content-tabs page-bar">
					<button class="roll-nav roll-left J_tabLeft">
						<i class="fa fa-backward"></i>
					</button>
					<nav class="page-tabs J_menuTabs">
						<div class="page-tabs-content">
							<a href="javascript:;" class="active J_menuTab" data-id="${ctx}/desktop">首页</a>
						</div>
					</nav>
					<button class="roll-nav roll-right J_tabRight">
						<i class="fa fa-forward"></i>
					</button>
					<div class="btn-group roll-nav roll-right">
						<button class="dropdown J_tabClose" data-toggle="dropdown">
							菜单操作<span class="caret"></span>
						</button>
						<ul role="menu" class="dropdown-menu pull-right" id="dropdown-menu-pull-right-menu">
							<li><a onclick="addUserMenu();"><i class="fa fa-plus-circle"></i>添加到快捷菜单</a></li>
							<li class="J_tabShowActive"><a><i class="fa icon-pointer"></i>定位当前选项卡</a></li>
							<li class="divider"></li>
							<li class="J_tabCloseAll"><a><i class="fa fa-times-circle"></i>关闭全部选项卡</a></li>
							<li class="J_tabCloseOther"><a><i class="fa fa-times"></i>关闭其他选项卡</a></li>
						</ul>
					</div>
				</div>

				<div id="content-main" class="J_mainContent mainrow">
					<iframe class="J_iframe" id="desktopFrame" name="desktopFrame" width="100%" height="100%" src="${ctx}/desktop"
						data-id="${ctx}/desktop" frameborder="0"></iframe>
				</div>
				<!-- end PAGE tabs-->
			</div>
			<!-- END CONTENT BODY -->
		</div>
		<!-- END CONTENT -->

		<!-- END QUICK SIDEBAR -->
	</div>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER <button type="button" class="btn  btn-sm purple btn-outline">Purple</button>-->
	<div class="page-footer">
		<div class="page-footer-menu" id="page-footer-menu">
			
		</div>
		
		<div class="page-footer-inner">
			${yy_footer_title}
			<!-- 
			<a href="http://www.flyrise.cn/" title="技术支持QQ:348296009" target="_blank">飞企互联提供技术支持!</a>
			 -->
		</div>
		<!-- 
		<div class="scroll-to-top">
			<i class="icon-arrow-up"></i>
		</div>
		-->
	</div>
	<script type="text/javascript">
		var tCurrentUserId = '${user.uuid}';
	</script>
	<script src="${ctx}/assets/tabs/js/contabs.min.js" type="text/javascript"></script>
	<script src="${ctx}/assets/tabs/js/layer.min.js" type="text/javascript"></script>
	<script>
		//var adminArr = new Array();
		//退出登录
		function onBack() {
			layer.confirm('确定退出登录？', function() {
				url = '${ctx}/logout';
				window.location = url;
				//layer.msg('确定退出登录？'
			});
		}

		//个人设置弹出窗口
		function onUserProfile() {
			layer.open({
				title : '个人设置',
				type : 2,
				area : [ '400px', '450px' ],
				fix : false, //不固定
				// maxmin: true,
				content : 'userProfile'
			});
		}

		function onSaveUserProfile() {
			layer.msg("保存成功 ", {
				icon : 1
			});
		}

		//修改密码
		function onRevisePassword() {
			layer.open({
				title : '密码修改',
				type : 2,
				area : [ '450px', '280px' ],
				fix : false, //不固定
				// maxmin: true,
				content : '${ctx}/sys/user/pwd'
			});
		}

		//我的日历-万年历
		function onCalendar() {
			layer.open({
				title : '我的日历',
				type : 2,
				area : [ '700px', '530px' ],
				fix : false, //不固定
				// maxmin: true,
				content : '${ctx}/assets/tool/calendar.html'
			});
		}

		//打开一个iframe,tDataIndex是唯一的标识
		function lsAddTab(tabUrl, tabName, tDataIndex) {
			$("#newTabHrefId").attr("data-index", tDataIndex);
			//判断是否已经带有参数的url，添加时间戳，避免双击tab进入事件
			if (tabUrl.indexOf("?") > 0) {
				tabUrl += '&yyClickTime=' + new Date().getTime();
			} else {
				tabUrl += '?yyClickTime=' + new Date().getTime();
			}

			$("#newTabHrefId").attr("href", tabUrl);
			$("#newTabHrefId").html(
					'<i class="fa fa-angle-right"></i>' + tabName);
			$("#newTabHrefId").click();
		}
		
		//根据data-id关闭tab
		function closeTabByDataId(dId) {
			$("#closeTabHrefId").attr("data-index", dId);
			$("#closeTabHrefId").click();
		}

		/**
		 * 加载枚举数据到本地缓存中 xuechen
		 */
		function loadEnumData() {
			var url = '${ctx}/sys/enumdata/getEnumDataMap';
			$.ajax({
				"dataType" : "json",
				"url" : url,
				"success" : function(data) {
					if (data.success) {
						var map = data.records[0];
						localStorage
								.setItem("yy-enum-map", JSON.stringify(map));
					} else {
						YYUI.failMsg("加载枚举数据失败" + data.msg);
					}
				}
			});
		}

		//计算ifame高度
		function setIframeHeight() {
			var content = $('.page-content');
			var sidebar = $('.page-sidebar');
			var body = $('body');
			var height;

			var iframe = $('.J_iframe');
			var header_height = $('.page-header').outerHeight(true);
			var pagebar_height = $('.page-bar').outerHeight(true);

			if (body.hasClass('page-sidebar-fixed')) {
				height = _calculateFixedSidebarViewportHeight();
				if (body.hasClass('page-footer-fixed') === false) {
					height = height - $('.page-footer').outerHeight();
				}
			} else {
				var headerHeight = $('.page-header').outerHeight();
				var footerHeight = $('.page-footer').outerHeight();

				if (App.getViewPort().width < resBreakpointMd) {
					height = App.getViewPort().height - headerHeight
							- footerHeight;
				} else {
					height = sidebar.height() + 20;
				}

				if ((height + headerHeight + footerHeight) <= App.getViewPort().height) {
					height = App.getViewPort().height - headerHeight
							- footerHeight;
				}
			}
			//content.attr('style', 'min-height:' + height + 'px');
			//计算高度
			iframe_height = height - 25 - pagebar_height;
			iframe.attr('style', 'min-height:' + iframe_height + 'px');
		};

		var _calculateFixedSidebarViewportHeight = function() {
			var sidebarHeight = App.getViewPort().height
					- $('.page-header').outerHeight(true);
			if ($('body').hasClass("page-footer-fixed")) {
				sidebarHeight = sidebarHeight - $('.page-footer').outerHeight();
			}
			return sidebarHeight;
		};

		//加载省市区
		function loadAdmin() {
			$.ajax({
				url : '${ctx}/sys/adminis/getAllAdmin',
				type : 'post',
				data : {},
				dataType : 'json',
				error : function() {

				},
				success : function(json) {
					var t_adminObj;
					var str = '{"adminArr":[';
					for (var i = 0; i < json.length; i++) {
						//t_adminObj = {id:json[i].uuid,pid:json[i].parentId,name:json[i].admin_name};
						//str+="{id:"+json[i].uuid+",pid:"+json[i].parentId+",name:"+json[i].admin_name+"},";
						str += '{"id":"' + json[i].uuid + '","pid":"'
								+ json[i].parentId + '","name":"'
								+ json[i].admin_name + '"},';
					}
					if (str.lastIndexOf(",") > 0) {
						str = str.substring(0, str.lastIndexOf(","));
					}
					str += "]}";
					localStorage.setItem("yy-adminis-arr", str);
				}
			});
		}

		/**
		 * 加载提示信息到本地缓存中 xuechen
		 */
		function loadAlertMsg() {
			var url = '${ctx}/sys/alertmsg/getAlertMsg';
			$.ajax({
				"dataType" : "json",
				"url" : url,
				"success" : function(data) {
					if (data.success) {
						var map = data.records[0];
						localStorage.setItem("yy-alertmsg-map", JSON
								.stringify(map));
					} else {
						YYUI.failMsg("加载提示信息失败" + data.msg);
					}
				}
			});
		}

		//意见反馈
		function Feedback() {
			layer.open({
				title : '意见反馈',
				type : 2,
				area : [ '1000px', '600px' ],
				fix : false, //不固定
				// maxmin: true,
				content : '${ctx}/sys/feedback'
			});
		}

		var iframe_height;
		$(document).ready(function() {
			localStorage.clear();
			setIframeHeight();
			loadEnumData();
			loadAlertMsg();
			// loadAdmin();
			showUserMenu(); //加载快捷菜单
			// connect();
			//测试还有多少的缓存
			//if(window.localStorage)
			//{  var aaaaa = 1024 * 1024 * 5 - unescape(encodeURIComponent(JSON.stringify(localStorage))).length;
			// 	alert(aaaaa);
			//}
			//$("#yy-link").click();
		});

		window.onload = function() {
			//如果只有一个模块，默认打开节点
			//if ('1' == '${countModule}') {
				$("#yy-link0").trigger("click");
			//}
		}

		//发送新消息提醒
		function showNewMsg(msgData) {
			toastr.options = {
				"closeButton" : true,
				"debug" : false,
				"positionClass" : "toast-bottom-right",
				"onclick" : null,
				"showDuration" : "1000",
				"hideDuration" : "1000",
				"timeOut" : "20000",
				"extendedTimeOut" : "1000",
				"showEasing" : "swing",
				"hideEasing" : "linear",
				"showMethod" : "fadeIn",
				"hideMethod" : "fadeOut"
			}
			var $toast = toastr['info'](msgData, '系统消息【首页处理】');
		}

		// 打开帮助文档
		function openHelpDoc(msgData) {
			window.open(projectPath+"/sys/instructions/view?funcId="+$($(".J_menuTab.active")[0]).attr('data-id'));     
		}
		
		
		//显示快捷菜单
		function showUserMenu() {
			$("#page-footer-menu").empty();
			var url = '${ctx}/sys/usermenu/queryUserMenu';
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"async" : false,
				"success" : function(data) {
					if (data.success) {
						var userMenuList = data.records;
						var userMenuTotal = 0;//快捷菜单
						var html = "";
						for (var i = 0; i < userMenuList.length; i++) {
							if(i == 0){
								//html = html + '<a href="javascript:;" class="btn btn-sm btn-icon-only red"><i class="fa fa-edit"></i></a>';
								html = html + '<a onclick="closeUserMenu();" title="管理快捷链接" aria-expanded="false"><i class="icon-settings font-white"></i></a>';
							}
							++userMenuTotal;
							//控制只能显示8个
							if (i > 9) {
								continue;
							}
							
							html = html + ' <button type="button" class="btn btn-link" onclick="openUserMenu(\''
								+ userMenuList[i].funcurl+'\',\''+userMenuList[i].funcname+'\',\''+userMenuList[i].funcid+'\');">'+ userMenuList[i].funcname +'</button> ';
						}
						if(userMenuTotal>0){
							$("#page-footer-menu").append(html);
						}
					} else {
						YYUI.promAlert("获取失败，原因：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.promAlert("HTTP错误。");
				}
			});
			//layer.close(indexMsg);
		}
		
		//添加快捷方式
		function addUserMenu() {
			var funcid = $($(".J_menuTab.active")[0]).attr('data-id');
			if(funcid.length>0){
				if(funcid.indexOf("desktop") > -1){
					YYUI.failMsg("不能添加 <首页> 到快捷菜单");
					return;
				}
			} else {
				YYUI.failMsg("添加快捷菜单失败，请重试");
				return;
			}
			
			var url = '${ctx}/sys/usermenu/addUserMenu';
			$.ajax({
				"dataType" : "json",
				"url" : url,
				"type" : "POST",
				"data": {"funcid" : funcid },
				"success" : function(data) {
					if (data.success) {
						YYUI.succMsg("添加快捷菜单成功");
						showUserMenu();
					} else {
						YYUI.failMsg("添加快捷菜单失败，请重试");
					}
				}, "error" : function(XMLHttpRequest, textStatus,
						errorThrown) {
					YYUI.promAlert("HTTP错误。");
				}
			});
		}
		
		//删除快捷方式
		function closeUserMenu(){
			//alert("管理快捷菜单");
		}
		
		//打开快捷方式
		function openUserMenu(url, funcname,funcid) {
			url = url.replace('@ctx@','${ctx}');
			lsAddTab(url, funcname,funcid);
		}
		
	</script>
</body>
</html>