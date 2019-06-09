<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "15",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render : YYDataTableUtils.renderRemoveActionCol,
		width : "30"
	}, {
		data : 'title',
		width : "80",
		className : "center",
		orderable : true
	}, {
		data : 'msgtype',
		width : "50",
		className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("MsgType", data);
		}
	}, {
		data : 'sendername',
		width : "60",
		className : "center",
		orderable : true
	}, {
		data : 'sendtime',
		width : "60",
		className : "center",
		orderable : true
	}, {
		data : 'receivername',
		width : "60",
		className : "center",
		orderable : true
	}, {
		data : 'receivetime',
		width : "60",
		className : "center",
		orderable : true
	}, {
		data : 'isdeal',
		width : "60",
		className : "center",
		orderable : true,
		render : function(data, type, full) {
			if ("0" == data) {
				return '<span class="label label-sm label-warning">未处理</span>';
			} else if ("1" == data) {
				return '<span class="label label-sm label-info">已处理</span>';
			} else {
				return "";
			}
		}
	}, {
		data : 'dealtime',
		width : "60",
		className : "center",
		orderable : true
	} ];

	function onRefresh() {
		//非服务器分页
		loadList();
	}

	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				$('#global_regex').prop('checked'),
				$('#global_smart').prop('checked')).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}

	$(document)
			.ready(
					function() {
						_tableList = $('#yy-table-list').DataTable({
							"columns" : _tableCols,
							"createdRow" : YYDataTableUtils.setActions,
							"processing" : true,//加载时间长，显示加载中
							"order" : []
						});

						$('input.global_filter').on('keyup click', function() {
							filterGlobal();
						});

						//按钮绑定事件
						bindButtonActions();

						//查看用户
						$("#yy-user-select")
								.on(
										"click",
										function() {
											//type为2时则查询包括流程项
											layer
													.open({
														type : 2,
														title : '请选择用户',
														shadeClose : false,
														shade : 0.8,
														area : [ '90%', '90%' ],
														content : '${ctx}/sys/data/listUser?callBackMethod=window.parent.callBackSelectUser' //iframe的url
													});
										});
						//加载数据
						loadList();
					});

	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='title']").val(data.title);
		$("input[name='content']").val(data.content);
		$("select[name='msgtype']").val(data.msgtype);
		$("input[name='link']").val(data.link);
		$("input[name='isnew']").val(data.isnew);
		$("input[name='sender']").val(data.sender);
		$("input[name='receiver']").val(data.receiver);
		$("input[name='sendtime']").val(data.sendtime);
		$("input[name='receivetime']").val(data.receivetime);
	}

	//回调选择用户
	function callBackSelectUser(data) {
		$("#userId").val(data.uuid);
		$("#userName").val(data.username);
	}
</script>
