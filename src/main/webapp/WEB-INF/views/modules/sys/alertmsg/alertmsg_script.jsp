<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
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
		render : YYDataTableUtils.renderActionCol,
		width : "50"
	}, {
		data : 'mcode',
		width : "50",
		className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("sys_moudule", data);
		}
	}, {
		data : 'acode',
		width : "60",
		orderable : true
	}, {
		data : 'aname',
		width : "70",
		orderable : true
	}, {
		data : 'alertmsg',
		width : "120",
		orderable : true
	}, {
		data : 'alanguage',
		width : "80",
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

		$("#groudcodeList").change(function (){
			$('#yy-table-list').DataTable().column(2).search(
					$(this).val(), false, true).draw();
		});
		
		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();

		//验证 表单
		validateForms();
	});

	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("select[name='mcode']").val(data.mcode);
		$("input[name='acode']").val(data.acode);
		$("input[name='aname']").val(data.aname);
		$("input[name='alertmsg']").val(data.alertmsg);
		$("input[name='alanguage']").val(data.alanguage);
	}

	//验证表单
	function validateForms() {
		$('#yy-form-edit').validate({
			rules : {
				mcode : {
					required : true
				},
				acode : {
					required : true,
					maxlength : 100
				},
				aname : {
					maxlength : 100
				},
				alertmsg : {
					required : true,
					maxlength : 500
				},
				alanguage : {
					maxlength : 500
				}
			}
		});
	}
</script>
