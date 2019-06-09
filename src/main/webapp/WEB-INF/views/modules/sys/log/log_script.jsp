<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "10",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : 'username',
		width : "30",
		className : "center",
		orderable : false
	}, {
		data : 'createtime',
		width : "50",
		orderable : false
	}, {
		data : 'ip',
		width : "30",
		className : "center",
		orderable : false
	}, {
		data : 'url',
		width : "60",
		orderable : false
	}, {
		data : "method",
		className : "center",
		orderable : false,
		width : "20"
	}, {
		data : 'params',
		width : "100",
		orderable : false
	}];

	function onRefresh() {
		//加载数据
		_tableList.draw(); //服务器分页
	}
	
	//分页页码
	$.fn.dataTable.defaults.aLengthMenu = [ [ 10, 50, 100, 1000 ],
			[ 10, 50, 100, 1000 ] ];
	
	$(document).ready(function() {
		 //服务器分页
		serverPage('${serviceurl}/query?orderby=createtime@desc');
		//按钮绑定事件
		bindButtonActions();
	});

</script>