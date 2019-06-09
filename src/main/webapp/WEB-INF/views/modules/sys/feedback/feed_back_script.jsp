<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
    var _isNumber = true;
	var _tableCols = [ {
			data : null,
			orderable : false,
			className : "center",
			width : "50"
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "20",
			render : YYDataTableUtils.renderViewActionCol
		},{
			data : 'user',
			width : "10%",
			className : "center",
			orderable : true,
			"render": function (data,type,row,meta ) {
				if(data!=null){
					return data.username;
				}
	            return "";
	         },
		}, {
			data : 'feedbackType',
			width : "25%",
			className : "center",
			orderable : true,
			"render": function (data,type,row,meta ) {
				if(data!=null&&data=='0'){
					return "建议";
				}else if(data!=null&&data=='1'){
					return "异常";
				}else if(data!=null&&data=='2'){
					return "其他";
				}else{
					return "否";
				}
	         }
		}, {
			data : 'createtime',
			width : "25%",
			className : "center",
			orderable : true
		}, {
			data : 'loginIp',
			width : "30%",
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
		$("select[name='feedbackType']").val(data.feedbackType); 
		$("#viewContentId").html(data.feedbackContent); 
		
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
