<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
    var _isNumber = true;
	var _tableCols = [ {
			data : null,
			orderable : false,
			className : "center",
			width : "30"
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "20",
			render : YYDataTableUtils.renderCheckCol
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "50",
			render : function(data, type, full) {
				return "<div class='yy-btn-actiongroup'>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				+ "</div>";
			}
		},{
			data : 'title',
			width : "250",
			className : "center",
			orderable : true
		}, {
			data : 'version',
			width : "50",
			className : "center",
			orderable : true
		}, {
			data : 'createtime',
			width : "100",
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
	function onAddAfter(){
		$("div[name='message']").val('');
		UM.getEditor('myEditor').setContent('', false);
	}
	
	$(document).ready(function() {
		 //服务器分页
		serverPage('${serviceurl}/query?orderby=createtime@desc');

		//按钮绑定事件
		bindButtonActions();
		initialFrame();
		
	});
	function initialFrame(){
		//初始化html编辑器start
		$opt={toolbar:[
		        'undo redo | bold italic underline strikethrough | forecolor backcolor | image |',
		        'insertorderedlist insertunorderedlist ' ,
		        '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize'
		],initialFrameWidth: '100%'};//
		
		var um = UM.getEditor('myEditor',$opt);
		UM.getEditor('myEditor').setWidth('900px');


		function getContent() {
		     return UM.getEditor('myEditor').getContent();
		}
	}
	 function showData(data) {
		
		$("input[name='uuid']").val(data.uuid);		
		$("input[name='title']").val(data.title);
		$("input[name='version']").val(data.version);
		$("div[name='message']").val(data.message);
		UM.getEditor('myEditor').setContent(data.message, false);

		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
	 }	 
</script>
