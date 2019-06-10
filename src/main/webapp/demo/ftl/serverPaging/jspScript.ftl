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
		//加载数据
		//loadList();
		//loadList(null,true);
		_tableList.draw(); //服务器分页
	}	

	 
	$(document).ready(function() {
		 //服务器分页
		serverPage(null);
		
		//按钮绑定事件
		bindButtonActions();
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
</script>
