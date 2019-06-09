<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [
		/* {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "5%",
			render : YYDataTableUtils.renderCheckCol
		}, */{
			data : "uuid",
			className : "center",
			orderable : false,
			"render": function (data,type,row,meta ) {
				return renderActionCol(data,type,row,meta);
	         },
			width : "10%"
		},{
			data : 'name',
			width : "20%",
			className : "center",
			orderable : true
		}, {
			data : 'address',
			width : "40%",
			className : "center",
			orderable : true
		}, {
			data : 'key',
			width : "15%",
			className : "center",
			orderable : true
		}, {
			data : 'secret',
			width : "15%",
			className : "center",
			orderable : true
		}];

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
	});
	
	function loadList(){
		$.ajax({
			url : '${ctx}/dc/sms/data_smsconfig',
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
			//_validator.form();
			if (!$('#yy-form-edit').valid())
				return false;   
			//RapFormUtils.setCheckBoxNotCheckedValue('rap-form-edit');
			//$('#yy-form-edit').validate();
			var posturl = "${serviceurl}/add_smsconfig";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined")
				posturl = "${serviceurl}/update_smsconfig";
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
			$("input[name='name']").val(data.name);
			$("input[name='address']").val(data.address);
			$("input[name='key']").val(data.key);
			$("input[name='secret']").val(data.secret);
			$("input[name='ext']").val(data.ext);
			$("textarea[name='remark']").val(data.remark);
	}
	 
</script>
