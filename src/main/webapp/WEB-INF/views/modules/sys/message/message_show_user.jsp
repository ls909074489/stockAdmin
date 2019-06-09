<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/message" />
<html>
<head>
<title>我的消息</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="row yy-searchbar">
			<form id="yy-form-query">
				<div class="row hide">
					<div class="col-md-3 form-inline">
						<div id="" data-column="2">
							未读消息 <input type="text" class="form-control input-sm" id="search_EQ_isnew" name="search_EQ_isnew">
						</div>
					</div>
					<div class="col-md-3 form-inline">
						<div id="" data-column="3">
							待办消息 <input type="text" class="form-control input-sm" id="search_EQ_msgtype" name="search_EQ_msgtype">
						</div>
					</div>
					<div class="col-md-3 form-inline">
						<div id="" data-column="4">
							消息类型 <input type="text" class="form-control input-sm" id="search_EQ_isdeal" name="search_EQ_isdeal">
						</div>
					</div>
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
						<i class="fa fa-trash-o"></i> 清空
					</button>
				</div>
			</form>
			<div class="btn-group" data-toggle="buttons">
				<label class="btn btn-default active" onclick="dealMsg('1');"> <input type="radio" class="toggle"
					id="nodealMsg"> 待办消息
				</label> <label class="btn btn-default" onclick="dealMsg('2');"> <input type="radio" class="toggle" id="newMsg">
					未读消息
				</label> <label class="btn btn-default" onclick="dealMsg('3');"> <input type="radio" class="toggle" id="dealMsg">
					已办审批消息
				</label> <label class="btn btn-default" onclick="dealMsg('4');"> <input type="radio" class="toggle" id="workMsg">
					已办业务消息
				</label>
			</div>
		</div>

		<div class="page-content" id="yy-page-list">
			<div class="row">
				<table id="yy-table-list" class="yy-table">

					<thead>
						<tr>
							<th>操作</th>
							<th>消息类型</th>
							<th>消息标题</th>
							<th>消息内容</th>
							<th>发送人</th>
							<th>送达时间</th>
							<th>办理状态</th>
							<th>办理时间</th>
							<th>处理结果/意见</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<script type="text/javascript">
		var _tableCols = [
				{
					data : null,
					orderable : false,
					className : "center",
					width : "15",
					render : function(data, type, full) {
						if (data.isnew == '0' || data.isdeal == '0') {
							return "<div class='yy-btn-actiongroup'>"
									+ "<button id='yy-btn-deal-row' class='btn btn-xs btn-success' data-rel='tooltip' title='办理'>办理</button>"
									+ "</div>";
						} else {
							return "<div class='yy-btn-actiongroup'>"
									+ "<button id='yy-btn-deal-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'>查看</button>"
									+ "</div>";
						}
					}
				}, {
					data : 'msgtype',
					width : "30",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return YYDataUtils.getEnumName("MsgType", data);
					}
				}, {
					data : 'title',
					width : "40",
					className : "center",
					orderable : false
				}, {
					data : 'content',
					width : "90",
					className : "left",
					orderable : false
				}, {
					data : 'sendername',
					width : "30",
					className : "center",
					orderable : false
				}, {
					data : 'sendtime',
					width : "55",
					className : "center",
					orderable : true
				}, {
					data : 'isdeal',
					width : "35",
					className : "center",
					orderable : false,
					render : function(data, type, full) {
						if ("0" == data) {
							return '未处理';
						} else if ("1" == data) {
							return '已处理';
						} else {
							return "";
						}
					}
				}, {
					data : 'dealtime',
					width : "55",
					className : "center",
					orderable : true
				}, {
					data : 'suggestion',
					width : "115",
					className : "left",
					orderable : false
				} ];

		var mtype = "1";// 设置消息类型为1

		//刷新
		function onRefresh() {
			_tableList.draw(); //服务器分页
		}

		//绑定按钮事件
		function bindButtonActions() {
		}

		//消息展示
		function dealMsg(dealType) {
			if ("1" == dealType) {
				$("input[name='search_EQ_isnew']").val("");
				$("input[name='search_EQ_msgtype']").val("");
				$("input[name='search_EQ_isdeal']").val("0");
			} else if ("2" == dealType) {
				$("input[name='search_EQ_isnew']").val("0");
				$("input[name='search_EQ_msgtype']").val("");
				$("input[name='search_EQ_isdeal']").val("");
			} else if ("3" == dealType) {
				$("input[name='search_EQ_isnew']").val("");
				$("input[name='search_EQ_msgtype']").val("1");
				$("input[name='search_EQ_isdeal']").val("1");
			} else if ("4" == dealType) {
				$("input[name='search_EQ_isnew']").val("");
				$("input[name='search_EQ_msgtype']").val("2");
				$("input[name='search_EQ_isdeal']").val("1");
			}
			_queryData = $("#yy-form-query").serializeArray();
			_tableList.draw(); //服务器分页
		}

		/**
		 * 添加行操作事件
		 */
		YYDataTableUtils.setActions = function(nRow, aData, iDataIndex) {
			$(nRow).dblclick(function() {
				//onViewDetailRow(aData, iDataIndex, nRow);
			});

			$('#yy-btn-deal-row', nRow).click(function() {
				onMsgDealRow(aData, iDataIndex, nRow);
			});
		};

		//消息处理
		function onMsgDealRow(aData, iDataIndex, nRow) {
			showMessage(aData.link, aData.uuid, aData.openType, aData.tabName,
					aData.dataIndex);
		}

		//展示消息链接
		function showMessage(link, id, openType, tabName, dataIndex) {
			if(link!=null&&link.length > 0){
				link = '${ctx}' + link;
				//判断是否以tab方式打开的
				if (openType != null && openType != '' && openType == '1') {
					//先关闭tab（如果不关闭，只刷新页面，无法从首页中根据点击的获取相应的id值）
					parent.closeTabByDataId(dataIndex);
					//添加新的tab
					parent.lsAddTab(link, tabName, dataIndex);
				} else {
					if(link == null){
						YYUI.promAlert("没有找到url：" + link);
					} else {
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
					onRefresh();
					if (data.success) {

					} else {
						YYUI.promAlert("更新失败：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.promAlert("HTTP错误。");
				}
			});

		}

		$(document).ready(function() {
			//按钮绑定事件
			bindButtonActions();
			//服务器分页
			serverPage(null);
		});

		//服务器分页
		function serverPage(url) {
			doBeforeServerPage();
			if (url == null) {
				url = '${serviceurl}/query';
			}
			$("input[name='search_EQ_isnew']").val("");
			$("input[name='search_EQ_msgtype']").val("");
			$("input[name='search_EQ_isdeal']").val("0");
			_queryData = $("#yy-form-query").serializeArray();

			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order" : [],
				"processing" : true,
				"searching" : false,
				"serverSide" : true,
				"showRowNumber" : true,
				"pagingType" : "bootstrap_full_number",
				"pageLength" : 15,
				"paging" : true,
				"fnDrawCallback" : fnDrawCallback,
				"ajax" : {
					"url" : url,
					"type" : 'POST',
					"data" : function(d) {
						d.orderby = getOrderbyParam(d);
						if (_queryData == null)
							return;
						$.each(_queryData, function(index) {

							if (this['value'] == null || this['value'] == "")
								return;

							d[this['name']] = this['value'];

						});
					},
					"dataSrc" : function(json) {
						_pageNumber = json.pageNumber;
						return json.records == null ? [] : json.records;
					}
				}
			});
		}
		
		//服务器分页，排序
		function getOrderbyParam(d) {
			var orderby = d.order[0];
			if (orderby != null && null != _tableCols) {
				var dir = orderby.dir;
				var orderName = _tableCols[orderby.column].data;
				return orderName + "@" + dir;
			}
			
			return "sendtime@desc";
		}
	</script>
</body>
</html>