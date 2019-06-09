<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [{
			data : "uuid",
			orderable : false,
			className : "center",
			/* visible : false, */
			width : "20",
			render : YYDataTableUtils.renderCheckCol
		},{
			data : "uuid",
			className : "center",
			orderable : false,
			render : YYDataTableUtils.renderActionCol,
			width : "80"
		}, {
			data : 'name',
			width : "35%",
			className : "center",
			orderable : true
		}, {
			data : 'code',
			width : "30%",
			className : "center",
			orderable : true
		}, {
			data : 'relevant_bill',
			width : "10%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("RelevantBill", data);
			}
		}, {
			data : 'send_action',
			width : "10%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("SendAction", data);
			}
		}
	];

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
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"processing": true,//加载时间长，显示加载中
			"order" : []
		});

		$('input.global_filter').on( 'keyup click', function () {
	        filterGlobal();
	    } );
		
		
		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();
		
		//验证 表单
		validateForms();
	});

	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);		
		$("input[name='name']").val(data.name);
		$("input[name='code']").val(data.code);
		$("textarea[name='content']").val(data.content);
		$("textarea[name='remark']").val(data.remark);
		$("select[name='relevant_bill']").val(data.relevant_bill);
		$("select[name='send_action']").val(data.send_action);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
	 }	 
	 
	 function validateForms(){
			$('#yy-form-edit').validate({
				rules : {
					code : {required : true,maxlength:20},
					name : {required : true,maxlength:20},
					content : {required : true,maxlength:200},
					relevant_bill: {required : true},
					send_action: {required : true}
				}
			}); 
		}
</script>
