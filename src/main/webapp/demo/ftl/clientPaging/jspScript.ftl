<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [
	{
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "5%",
		render : YYDataTableUtils.renderCheckCol
	},{
		data : "uuid",
		className : "center",
		orderable : false,
		render : YYDataTableUtils.renderActionCol,
		width : "15%"
	}
	<#list colNameList as var>
		, {
			data : '${var}',
			width : "15%",
			className : "center",
			orderable : true
		}
	</#list>
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
		//表头验证
		validateForms();
	});

	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);		
	<#list fieldList as var>
		$("input[name='${var[0]}']").val(data.${var[0]});
	</#list>
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='create_time']").val(data.create_time);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modify_time']").val(data.modify_time);		
	 }
	 
	 //表头校验
	function validateForms(){
		validata = $('#yy-form-edit').validate({
			onsubmit : true,
			rules : {
				//'clientName':{required : true,maxlength:10},
				//'followConent':{required : true,maxlength:250}
			}			
		});
	}
</script>
