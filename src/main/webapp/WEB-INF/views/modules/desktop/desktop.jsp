<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>个人桌面显示</title>
<script src="${ctx}/assets/sockjs/sockjs-0.3.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function seeMoreNotice() {
		parent.lsAddTab("${ctx}/sys/notice/showMoreNotice", "通知公告",
				"yyshowMoreNotice");
	}
	
	function seeMoreMsg() {
		parent.lsAddTab("${ctx}/sys/message/showMoreMsg", "我的消息",
				"yyshowMoreMsg");
	}
	
</script>
</head>
<body>
	<div class="container-fluid page-container">
		<div class="page-content">
			<div class="row">
				<h6></h6>
			</div>
			<!-- BEGIN DASHBOARD STATS 1-->
			<div class="row" style="display: none;">
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<div class="dashboard-stat blue">
						<div class="visual">
							<i class="fa fa-comments"></i>
						</div>
						<div class="details">
							<div class="number">
								<span id="noticeSpan" data-counter="counterup" data-value="0">0</span>
							</div>
							<div class="desc">最近一周通知</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<div class="dashboard-stat green">
						<div class="visual">
							<i class="fa fa-shopping-cart"></i>
						</div>
						<div class="details">
							<div class="number">
								<span id="messageSpan" data-counter="counterup" data-value="0">0</span>
							</div>
							<div class="desc">未读消息</div>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<div class="dashboard-stat purple">
						<div class="visual">
							<i class="fa fa-globe"></i>
						</div>
						<div class="details">
							<div class="number">
								<span id="needMsgSpan" data-counter="counterup" data-value="0">0</span>
							</div>
							<div class="desc">待办消息</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
					<div class="dashboard-stat red">
						<div class="visual">
							<i class="fa fa-bar-chart-o"></i>
						</div>
						<div class="details">
							<div class="number">
								<span data-counter="counterup" data-value="1">--</span>
							</div>
							<div class="desc">预警条数（未启用）</div>
						</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
			<!-- END DASHBOARD STATS 1-->
			<div class="row">
				<div class="col-md-12">
					<div class="portlet box blue tasks-widget">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-bell-o"></i>通知公告
							</div>
							<div class="tools">
								<a href="" class="reload" onclick="getNotice()"> </a>
							</div>
							<div class="actions">
								<div class="btn-group"></div>
							</div>
						</div>
						<div class="portlet-body">
							<div class="task-content">
								<div class="scroller" style="height: 300px;" data-always-visible="1" data-rail-visible1="0">

									<!-- START TASK LIST -->
									<ul class="task-list" id="noticeList">

									</ul>
									<!-- END START TASK LIST -->
								</div>
							</div>
							<div class="task-footer">
								<div class="btn-arrow-link pull-right">
									<div class="page-tabs-content">
										<a href="javascript:;" onclick="seeMoreNotice();" class="J_menuTab" id="notice_seemore">查看更多...</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		function showNoticeFrame(uuid) {
			layer.open({
				type : 2,
				title : '公告内容',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${ctx}/sys/notice/viewNotice?uuid=' + uuid //iframe的url
			});
		}

		//获取通知 
		function getNotice() {
			$("#noticeList").empty();
			var url = '${ctx}/sys/notice/getNoticeViewList';
			$.ajax({
						"dataType" : "json",
						"type" : "POST",
						"url" : url,
						"async" : false,
						"data" : {
							"limitAmt" : 100
						},
						"success" : function(data) {
							if (data.success) {
								var noticeList = data.records;
								var html = "";
								var ctg = "";
								var noticeTitle = "";
								var lastWeekTime = getLastWeek();
								var noticeTotal = 0;
								for (var i = 0; i < noticeList.length; i++) {
									//显示数量
									if (CompareDate(noticeList[i].issue_date,
											lastWeekTime)) {
										++noticeTotal;
									}
									//控制只能显示7个
									if (i > 7) {
										continue;
									}
									if (noticeList[i].notice_category == '1') {
										ctg = '<span class="label label-sm label-success">常规通知</span>';
									} else if (noticeList[i].notice_category == '2') {
										ctg = '<span class="label label-sm label-warning">重要公告</span>';
									} else if (noticeList[i].notice_category == '3') {
										ctg = '<span class="label label-sm label-danger">紧急通知</span>';
									}
									html += '<li style="height: 35px;">'
											+ '<div class="task-title" >'
											+ ctg
											+ '&nbsp;<span class="task-title-sp" style="font-size: 14px;" onclick="showNoticeFrame(\''
											+ noticeList[i].uuid
											+ '\')"><a href="javascript:;">'
									noticeTitle = noticeList[i].notice_title;
									if (noticeTitle != ''
											&& noticeTitle.length > 20) {
										html += noticeTitle.substring(0, 20)
												+ "...";
									} else {
										html += noticeTitle;
									}

									html += '</a></span><span style="float: right;">'
											+ noticeList[i].issue_date
											+ '</span>' + '</div></li>';
								}
								$("#noticeList").append(html);
								$("#noticeSpan").text(noticeTotal);
							} else {
								YYUI.promAlert("获取失败，原因：" + data.msg);
							}
						},
						"error" : function(XMLHttpRequest, textStatus,
								errorThrown) {
							YYUI.promAlert("HTTP错误。");
						}
					});
		}

		//获取待办消息
		function getMessage() {
			//var indexMsg = layer.load(2, {
			//	shade: [0.1,'#fff'] //0.1透明度的白色背景
			//});
			//alert(123);
			$("#messageList").empty();
			var url = '${ctx}/sys/message/getMessages';
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"async" : false,
				"data" : {
					"msgtype" : '1'
				},
				"success" : function(data) {
					if (data.success) {
						var messageList = data.records;
						var html = "";
						var ctg = "";
						var messageTotal = 0;//未读消息
						var needMsg = 0; //待办消息

						for (var i = 0; i < messageList.length; i++) {
							//显示数量
							if (messageList[i].isnew == '0') {
								++messageTotal;
							}

							//显示数量
							if (messageList[i].isdeal == '0') {
								++needMsg;
							}

							//控制只能显示7个
							if (i > 7) {
								continue;
							}
							if (messageList[i].msgtype == '1') {
								ctg = '<span class="label label-sm label-warning">审批消息</span>';
							} else if (messageList[i].msgtype == '2') {
								ctg = '<span class="label label-sm label-success">业务消息</span>';
							}

							var newMsg = '';
							if (messageList[i].isnew == '0') {
								newMsg = 'style="color:green;"';
							}
							var t_orgid=messageList[i].orgid;
							html += '<li style="height: 35px;">'
									+ '<div class="task-title" >'
									+ ctg
									+ '&nbsp;<span class="task-title-sp" style="font-size:14px;" onclick="showMessage(\''
									+ messageList[i].link + '\',\''+ messageList[i].uuid+ '\',\''+messageList[i].openType
									+ '\',\''+messageList[i].tabName+ '\',\''+messageList[i].tabDataIndex
									+ '\',\''+t_orgid+'\')"><a href="javascript:;" '+ newMsg +'>'
							var title = messageList[i].title;
							if (title != '' && title.length > 20) {
								html += title.substring(0, 20) + "...";
							} else {
								html += title;
							}

							html += '</a></span>';

							
							if (messageList[i].dealresult == '3' || messageList[i].dealresult == '5' ) {
								html += '<span class="label label-sm label-success">通过</span> &nbsp;';
							} else if (messageList[i].dealresult == '4' ) {
								html += '<span class="label label-sm label-danger">退回</span> &nbsp;';
							}

							html += '<span style="float: right;">'
									+ messageList[i].sendtime
									+ '</span>' + '</div></li>';
						}
						$("#messageList").append(html);
						$("#messageSpan").text(messageTotal);
						$("#needMsgSpan").text(needMsg);
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

		//展示消息链接
		function showMessage(link, id,openType,tabName,dataIndex,orgid) {
			console.info((orgid!=null)+"==="+orgid);
			if(link.length > 0){
				link = '${ctx}' + link;
				//判断是否以tab方式打开的
				if(openType!=null&&openType!=''&&openType=='1'){
					//var mStationId=parent.getMainStation();
					//如果点击的消息的厂站id和当前的session的不同，则切换
					if(orgid!='null'&&orgid!=null&&orgid!=''){
						console.info(111);
						var changeStationLoading = layer.load(2);
						$.ajax({
							type : "POST",
							data :{"stationId": orgid},
							url : "${ctx}/sys/org/changeSessionStation",
							async : true,
							dataType : "json",
							success : function(data) {
								layer.close(changeStationLoading);
								if (data.success) {
									console.info(data);
									parent.setCurrentOrgMsg(data);
									YYUI.succMsg('切换站点成功！');
									//先关闭tab（如果不关闭，只刷新页面，无法从首页中根据点击的获取相应的id值）
									parent.closeTabByDataId(dataIndex);
									//添加新的tab
									parent.lsAddTab(link, tabName,dataIndex);
								}else {
									YYUI.promAlert('切换站点失败：'+data.msg);
								}
							},
							error : function(data) {
								layer.close(changeStationLoading);
								YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
							}
						});
					}else{
						console.info(222);
						//先关闭tab（如果不关闭，只刷新页面，无法从首页中根据点击的获取相应的id值）
						parent.closeTabByDataId(dataIndex);
						//添加新的tab
						parent.lsAddTab(link, tabName,dataIndex);
					}
				}else{
					layer.open({
						type : 2,
						title : '待办消息处理',
						shadeClose : false,
						shade : 0.8,
						area : [ '100%', '100%' ],
						content : link
					//iframe的url
					});
				}
			} else {
				YYUI.promAlert("系统找不到关联的业务，可能是相关的单据已被删除。");
			}
			
			var url = '${ctx}/sys/message/setNoticeIsnew';
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"data" : {
					"uuid" : id
				},
				"success" : function(data) {
					getMessage();
					if (data.success) {
						
					} else {
						YYUI.promAlert("更新失败，原因：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.promAlert("HTTP错误。");
				}
			});

		}
		
		//获取上周时间
		function getLastWeek() {
			var now = new Date();
			var date = new Date(now.getTime() - 7 * 24 * 3600 * 1000);
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDate();
			var hour = date.getHours();
			var minute = date.getMinutes();
			var second = date.getSeconds();
			return (year + '-' + month + '-' + day + ' ' + hour + ':' + minute
					+ ':' + second);
		}

		//比较时间大小
		function CompareDate(d1, d2) {
			return ((new Date(d1.replace(/-/g, "\/"))) > (new Date(d2.replace(
					/-/g, "\/"))));
		}

		//刷新 - 主要刷新页面的信息
		function onRefresh(istrue) {
			if(istrue){
				getMessage();
			}
		}
		
		$(document).ready(function() {
			getNotice();
			getMessage();
		});
	</script>
</body>
</html>