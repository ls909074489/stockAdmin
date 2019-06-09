<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _fileUploadTool;//上传变量
	var _fileUploadToolView;//上传变量
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "30",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render: function (data,type,row,meta ) {
			return renderNoticeActionCol(data,type,row,meta);
         },
		width : "50"
	}, {
		data : 'notice_title',
		width : "130",
		orderable : true
	}, {
		data : 'notice_category',
		width : "60",
		orderable : true,
		"render": function (data,type,row,meta ) {
			if(data==1){
				return "常规通知";
			}else if(data==2){
				return "重要公告";
			}else if(data==3){
				return "紧急通知";
			}
         }
	}, {
		data : 'notice_status',
		width : "60",
		orderable : true
	}, {
		data : 'publisher',
		width : "60",
		orderable : true
	}, {
		data : 'issue_date',
		width : "80",
		orderable : true
	}];

	
	function renderNoticeActionCol(data, type, full) {
		return "<div class='yy-btn-actiongroup'>" 
				+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				//+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
				+ "</div>";
	}
				
	function onRefresh() {
		//非服务器分页
		loadList();
	}

	function onAddAfter(){
		$("input[name='notice_status']").val("未发布");
		$("input[name='system_name']").val("");
		UM.getEditor('myEditor').setContent("", false);
		_fileUploadTool.clearFiles();
	}
	
	 //定义行点击事件
	function noticeRowAction(nRow, aData, iDataIndex) {
		$('#yy-btn-view-row', nRow).click(function() {
			_fileUploadToolView.loadFilsTableList(aData.uuid, "view");
			onViewDetailRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-edit-row', nRow).click(function() {
			//附件
			_fileUploadTool.loadFilsTableList(aData.uuid, "edit");
			onEditRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-remove-row', nRow).click(function() {
			onRemoveRow(aData, iDataIndex, nRow);
		});
	};
	
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : noticeRowAction,//YYDataTableUtils.setActions,
			"processing": true,//加载时间长，显示加载中
			//"dom" : '<"top">rt<"bottom"p><"clear">',
			"order" : []
		});

		$('input.global_filter').on( 'keyup click', function () {
	        filterGlobal();
	    } );

		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();
		//附件用
		_fileUploadTool = new FileUploadTool("uploadFiles","noticeEntity");
		_fileUploadToolView = new FileUploadTool("viewfiles","noticeEntity");
		
		_fileUploadTool.init("edit");
		_fileUploadToolView.init("view");
		
		$("#yy-btn-savefile").hide();//隐藏保存文件按钮
		
		//验证 表单
		validateForms();
	});
	function showData(data) {
		$("input[name='uuid']").val(data.uuid);	
		$("input[name='system_name']").val(data.system_name);			
		$("input[name='notice_title']").val(data.notice_title);
		$("select[name='notice_category']").val(data.notice_category);
		$("select[name='notice_type']").val(data.notice_type);
		$("input[name='notice_status']").val(data.notice_status);			
		$("input[name='publisher']").val(data.publisher);
		$("input[name='issue_date']").val(data.issue_date);
		
		UM.getEditor('myEditor').setContent(data.notice_content, false);
		$("#viewContentId").html(data.notice_content);
	}

	$("#yy-btn-publish").bind('click', function() {
		var pks = YYDataTableUtils.getSelectPks();
		if (pks.length < 1) {
			YYUI.promAlert("请选择需要发布的记录");
			return;
		}
		if (!window.confirm("确实要发布吗？")) {
			return;
		}
		var url = '${serviceurl}/publish';
		$.ajax({
			"dataType" : "json",
			"type" : "POST",
			"url" : url,
			"data" : {
				"pks" : pks.toString()
			},
			"success" : function(data) {
				if (data.success) {
					//if (isSuccess)
					YYUI.promAlert("发布成功");
					onRefresh();
					/* if (typeof (fnCallback) != "undefined")
						fnCallback(data); */
				} else {
					YYUI.promAlert("发布失败，原因：" + data.msg);
				}
			},
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.promAlert("发布失败，HTTP错误。");
			}
		});
	});

	$("#yy-btn-unpublish").bind('click', function() {
		var pks = YYDataTableUtils.getSelectPks();
		if (pks.length < 1) {
			YYUI.promAlert("请选择需要取消发布的记录");
			return;
		}
		if (!window.confirm("确实要取消发布吗？")) {
			return;
		}
		var url = '${serviceurl}/unpublish';
		$.ajax({
			"dataType" : "json",
			"type" : "POST",
			"url" : url,
			"data" : {
				"pks" : pks.toString()
			},
			"success" : function(data) {
				if (data.success) {
					//if (isSuccess)
					YYUI.promAlert("已取消发布");
					onRefresh();
					/* if (typeof (fnCallback) != "undefined")
						fnCallback(data); */
				} else {
					YYUI.promAlert("取消发布失败，原因：" + data.msg);
				}
			},
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.promAlert("取消发布失败，HTTP错误。");
			}
		});
	});

	//验证表单
	function validateForms() {
		$('#yy-form-edit').validate({
			rules : {
				notice_category : {
					required : true
				},
				notice_title : {
					required : true,
					maxlength : 200
				}
			}
		});
	}
</script>
