<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	_isNumber = true;//服务器分页序号
	var _fileUploadTool;//上传变量
	var _tableCols = [    
	{
		data : null,
		orderable : false,
		className : "center",
		width : "5%",
		render : function(data, type, full) {
			return  '';
		}
	}, {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "3%",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : 'texts',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'numbers',
		width : "10%",
		orderable : true
	}, {
		data : 'integers',
		width : "10%",
		orderable : true
	}, {
		data : 'enumerates',
		width : "10%",
		orderable : true
	}, {
		data : 'dates',
		width : "14%",
		orderable : true
	}, {
		data : 'longtexts',
		width : "15%",
		orderable : true
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render : YYDataTableUtils.renderActionCol,
		width : "8%"
	} ];

	function onRefresh() {
		loadList();
	}

	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='texts']").val(data.texts);
		$("input[name='numbers']").val(data.numbers);
		$("input[name='integers']").val(data.integers);
		$("select[name='enumerates']").val(data.enumerates);
		$("input[name='dates']").val(data.dates);
		$("input[name='longtexts']").val(data.longtexts);
	}

	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				false, true).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}

	$(document).ready(function() {
		//按钮绑定事件
		bindButtonActions();
		
		if(${isServerPage}){
			//服务器分页
			serverPage(null);	
		}else{
			//非服务器分页
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"processing" : true,//加载时间长，显示加载中
				//"dom" : '<"top">rt<"bottom"p><"clear">',
				"order" : []
			});
			//加载数据
			loadList(null,true);
		}
		
		//附件用
		_fileUploadTool = new FileUploadTool("uploadFiles", "user");
		_fileUploadTool.init();
		validateForms();
	});
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				texts : {required : true},
           		numbers : {number:true}
			},
            errorPlacement: YYFormValidate.errorPlacement,
            success: YYFormValidate.success
		}); 
	}
</script>
