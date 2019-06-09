<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
			data : 'loginname',
			width : "10%",
			className : "center",
			orderable : true
		}, {
			data : 'userName',
			width : "10%",
			className : "center",
			orderable : true
		}, {
			data : 'isSuc',
			width : "10%",
			className : "center",
			orderable : true,
			"render": function (data,type,row,meta ) {
				if(data!=null&&data=='1'){
					return "是";
				}else{
					return "否";
				}
	         },
		}, {
			data : 'createtime',
			width : "10%",
			className : "center",
			orderable : true
		}, {
			data : 'requestIp',
			width : "15%",
			className : "center",
			orderable : true
		}, {
			data : 'userAgent',
			width : "50%",
			className : "center",
			orderable : true
		}
	];

	function onRefresh() {
		//加载数据
		//loadList();
		//loadList(null,true);
		_tableList.draw(); //服务器分页
	}	

	 
	$(document).ready(function() {
		 //服务器分页
		serverPage('${serviceurl}/query?orderby=createtime@desc');
		//loadList('${serviceurl}/query?orderby=modifytime@desc');
		//按钮绑定事件
		bindButtonActions();
	});

	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);		
		$("input[name='userName']").val(data.userName);
		$("input[name='isSuc']").val(data.isSuc);
		$("input[name='requestIp']").val(data.requestIp);
		$("input[name='user_agent']").val(data.user_agent);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
	 }	 
</script>
