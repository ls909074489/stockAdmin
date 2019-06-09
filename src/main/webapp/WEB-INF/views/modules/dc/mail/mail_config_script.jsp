<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [
		{
			data : "uuid",
			className : "center",
			orderable : false,
			"render": function (data,type,row,meta ) {
				return renderActionCol(data,type,row,meta);
	         },
			width : "60"
		},/* {
			data : 'smtpAddress',
			width : "55%",
			className : "center",
			orderable : true
		}, {
			data : 'port',
			width : "5%",
			className : "center",
			orderable : true
		},  */{
			data : 'sendAddress',
			width : "30%",
			className : "center",
			orderable : true
		}, {
			data : 'sendName',
			width : "30%",
			className : "center",
			orderable : true
		}, {
			data : 'userName',
			width : "30%",
			className : "center",
			orderable : true
		}, {
			data : 'anonymous',
			width : "5%",
			className : "center",
			orderable : true,
		    render : function(data, type, full) {
		       return YYDataUtils.getEnumName("BooleanType", data);
		    }
		}/* , {
			data : 'isSsl',
			width : "5%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			   return YYDataUtils.getEnumName("BooleanType", data);
		   }
		} */];

	function onRefresh() {
		//非服务器分页
		loadList();
	}

		
	function filterGlobal () {
	    $('#yy-table-list').DataTable().search(
	        $('#global_filter').val(),
	        $('#global_regex').prop('checked'),
	        $('#global_smart').prop('checked')
	    ).draw();
	}
	 
	 function filterColumn(i) {
			$('#yy-table-list').DataTable().column(i).search(
					$('#col' + i + '_filter').val(), false, true).draw();
		}
	 
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"ordering":false,
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"processing": true,//加载时间长，显示加载中
			"order" : []
		});

		$('input.global_filter').on( 'keyup click', function () {
	        filterGlobal();
	    } );
		
		$("#yy-btn-refresh").bind('click', loadList);//刷新
		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();
		
		//验证 表单
		validateForms();
	});
	
	function loadList(){
		$.ajax({
			url : '${ctx}/dc/mail/data_mailconfig',
			data : $("#yy-form-query").serializeArray(),
			dataType : 'json',
			type : 'post',
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
			}
		});
	}
	 //显示自定义的行按钮
	  function renderActionCol(data, type, full) {
			return "<div class='yy-btn-actiongroup'>" 
					+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
					+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
					+ "</div>";
		}
	  function onSave(isClose) {
			doBeforeSave();

			if (!$('#yy-form-edit').valid())
				return false;   

			var posturl = "${serviceurl}/update_mailconfig";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined")
				posturl = "${serviceurl}/update_mailconfig";
			var opt = {
				url : posturl,
				type : "post",
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
						YYUI.failMsg("保存出现错误：" + data.msg)
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
	 
	 function showData(data) {
			$("input[name='uuid']").val(data.uuid);	
			$("input[name='smtpAddress']").val(data.smtpAddress);
			$("input[name='port']").val(data.port);
			$("select[name='anonymous']").val(data.anonymous);
			$("input[name='sendAddress']").val(data.sendAddress);
			$("input[name='sendName']").val(data.sendName);
			$("input[name='userName']").val(data.userName);
			$("input[name='password']").val(data.password);
			$("select[name='isSsl']").val(data.isSsl);
			$("textarea[name='remark']").val(data.remark);
	}
	 
	  //验证表单
		function validateForms(){
			$('#yy-form-edit').validate({
				rules : {
					anonymous : {required : true,maxlength:20},
					sendAddress: {required : true,maxlength:50},
					sendName: {required : true,maxlength:50},
					userName: {required : true,maxlength:50},
					password: {required : true,maxlength:100},
				}
			}); 
		}
</script>
