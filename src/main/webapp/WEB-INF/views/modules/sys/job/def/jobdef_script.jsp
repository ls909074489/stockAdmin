<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/*visible : false, */
		width : "5%",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : 'jobcode',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'jobname',
		width : "15%",
		className : "center",
		orderable : true
	},{
		data : 'jobclass',
		width : "15%",
		orderable : true
	}, {
		data : 'jobbeanId',
		width : "15%",
		orderable : true
	}, {
		data : 'description',
		width : "15%",
		orderable : true
	},{
		data : "uuid",
		className : "center",
		orderable : false,
		render : YYDataTableUtils.renderActionCol,
		width : "15%"
	}];

	function onRefresh() {
		//非服务器分页
		loadList();
	}

	
	 $(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : YYDataTableUtils.setActions,
				"order": [] 
			});
			//加载数据
			loadList();
			//按钮绑定事件
			bindButtonActions();
		});
	 
	 function showData(data) {
			$("input[name='uuid']").val(data.uuid);//
			$("input[name='jobcode']").val(data.jobcode);			
			$("input[name='jobname']").val(data.jobname);			
			$("input[name='jobclass']").val(data.jobclass);
			$("input[name='jobbeanId']").val(data.jobbeanId);
			$("input[name='description']").val(data.description);
		}
	 
</script>
