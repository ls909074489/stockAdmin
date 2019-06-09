<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	//查看-编辑
	doc = function(data, type, full) {
		return "<div class='yy-btn-actiongroup'>"
				+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				+ "</div>";
	};
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "5%",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render : doc,
		width : "7%"
	}

	, {
		data : 'documentType',
		width : "8%",
		className : "center",
		orderable : true
	}, {
		data : 'prefix',
		width : "7%",
		className : "center",
		orderable : true
	}, {
		data : 'documents',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'newSerialNumber',
		width : "10%",
		className : "center",
		orderable : true
	}, {
		data : 'zeroMark',
		width : "7%",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("ZeroMark", data);
		}
	}, {
		data : 'creationTime',
		width : "15%",
		className : "center",
		orderable : true
	},

	{
		data : 'serialNumber',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'isAadYears',
		width : "5%",
		//className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("isAdd", data);
		}
	}, {
		data : 'isAddMonth',
		width : "5%",
		//className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("isAdd", data);
		}
	}, {
		data : 'isAddDay',
		width : "5%",
		//className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("isAdd", data);
		}
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

	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"processing" : true,//加载时间长，显示加载中
			"order" : []
		});

		$('input.global_filter').on('keyup click', function() {
			filterGlobal();
		});
		validateForms();
		//按钮绑定事件
		bindButtonActions();

		$('#yy-btn-refresh-redis').click(function() {
			refreshToRedis();
		});
		$('#yy-btn-refresh-bill').click(function() {
			refreshToBill();
		});
		$('#yy-btn-clean-cache').click(function() {
			cleanAllRedisCache();
		});
		
		//加载数据
		loadList();
	});

	function refreshToRedis() {
		$.ajax({
			url : "${serviceurl}/refreshToRedis",
			type : "post",
			success : function(data) {
				YYUI.succMsg(data);
			}
		})
	}

	function refreshToBill() {
		$.ajax({
			url : "${serviceurl}/refreshToBill",
			type : "post",
			success : function(data) {
				YYUI.succMsg(data);
			}
		})
	}

	function cleanAllRedisCache() {
		$.ajax({
			url : "${serviceurl}/cleanAllRedisCache",
			type : "post",
			success : function(data) {
				YYUI.succMsg(data);
			}
		})
	}

	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='creationTime']").val(data.creationTime);
		$("input[name='documents']").val(data.documents);
		$("input[name='documentType']").val(data.documentType);
		$("input[name='prefix']").val(data.prefix);
		$("input[name='newSerialNumber']").val(data.newSerialNumber);
		$("select[name='zeroMark']").val(data.zeroMark);
		$("select[name='serialNumber']").val(data.serialNumber);
		$("select[name='isAadYears']").val(data.isAadYears);
		$("select[name='isAddMonth']").val(data.isAddMonth);
		$("select[name='isAddDay']").val(data.isAddDay);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
		$("input[name='jobs']").val(data.jobs);
	}

	$("#yy-btn-save-doc").bind("click", function() {
		onSaveDoc(true);
	});
	function doBeforeSaveDoc() {
		return true;
	}
	function onSaveDoc(isClose) {
		if (!$('#yy-form-edit').valid()) {
			return false;
		}
		doBeforeSaveDoc();
		var posturl = "${serviceurl}/add";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != "undefined")
			posturl = "${serviceurl}/update";
		var opt = {
			url : posturl,
			type : "post",
			//data :doc,
			success : function(data) {
				if (data.success) {
					onRefresh();
					if (isClose) {
						YYUI.setListMode();

					} else {
						onAdd();
					}
					YYUI.succMsg("保存成功 ");

					doAfterSaveSuccess(data);
				} else {
					//YYUI.failMsg("保存出现错误：" + data.msg)
					YYUI.promAlert(data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

	function genDocuments() {
		var doc = {
			"documentType" : $("#documentType").val()
		}
		$.ajax({
			url : "${serviceurl}/genDocuments",
			type : "post",
			data : doc,
			success : function(data) {
				YYUI.succMsg(data);
			}
		})
	}

	function batchBillcodes() {
		var doc = {
			"documentType" : $("#documentType").val()
		}
		for (var i = 0; i < 10; i++) {
			$.ajax({
				url : "${serviceurl}/batchBillcodes",
				type : "post",
				data : doc,
				success : function(data) {
					YYUI.succMsg(data);
				}
			})

		}
	}

	//校验
	function validateForms() {
		validata = $('#yy-form-edit').validate({
			onsubmit : true,
			rules : {
				'documentType' : {
					required : true
				},
				'prefix' : {
					required : true
				},
				'documents' : {
					required : true
				},
				'isAadYears' : {
					required : true
				},
				'isAddMonth' : {
					required : true
				},
				'isAddDay' : {
					required : true
				},
				/* 'zeroMark' : {required : true}, */
				'serialNumber' : {
					required : true
				}
			}
		});
	}
	$("input[name='documentType']").mouseout(
			function() {

				var doc = {
					"documentType" : $("#documentType").val(),
					"uuid" : $("input[name='uuid']").val()
				}
				$.ajax({
					url : "${serviceurl}/querydocumentType",
					type : "post",
					data : doc,
					success : function(data) {
						if (data == "success") {
							if ($("input[name='prefix']").val() == "") {
								$("input[name='prefix']").val(
										$("#documentType").val());
							}
						} else if (data == "error") {
							YYUI.promAlert('单据类型已存在');
							$("#documentType").val("");
							$("#prefix").val("");

						}

					}
				})

			});
	$("select[name='isAadYears']").mouseout(function() {
		if ($("select[name='isAadYears']").val() == "n") {
			$("#zeroy").detach();

		}

	});
	$("select[name='isAddMonth']").mouseout(function() {
		if ($("select[name='isAddMonth']").val() == "n") {
			$("#zerom").detach();
		}

	});
	$("select[name='isAddDay'").mouseout(function() {
		if ($("select[name='isAddDay']").val() == "n") {
			$("#zerod").detach();
		}

	});
</script>
