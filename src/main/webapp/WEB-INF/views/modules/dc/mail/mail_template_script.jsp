<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var selectELeId;
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
		},/*  {
			data : 'relevant_bill',
			width : "20%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("RelevantBill", data);
			}
		}, */ {
			data : 'title',
			width : "20%",
			className : "center",
			orderable : true
		}, {
			data : 'code',
			width : "20%",
			className : "center",
			orderable : true
		}, {
			data : 'name',
			width : "45%",
			className : "center",
			orderable : true
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
		$("#yy-btn-savemail").bind("click", function() {
			saveMail();
		});
		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();
		
		//验证 表单
		validateForms();
	});

	function onAddBefore() {
		UM.getEditor('myEditor').setContent("", false);
	}
	
	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);		
		$("select[name='relevant_bill']").val(data.relevant_bill);
		$("input[name='code']").val(data.code);
		$("input[name='name']").val(data.name);
		$("input[name='title']").val(data.title);
		$("textarea[name='receiver']").val(data.receiver);
		//$("textarea[name='content']").val(data.content);
		UM.getEditor('myEditor').setContent(data.content, false);
		$("#viewContentId").html(data.content);
		
		$("textarea[name='remark']").val(data.remark);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
	 }	 
	 
	 function selectStation(inputId){
		 selectELeId=inputId;
		 layer.open({
				type : 2,
				title : '请选择岗位',
				shadeClose : false,
				shade : 0.8,
				area : [ '1000px', '90%' ],
				content : '${serviceurl}/selectStation'/* , 
				cancel: function(index){
					loadListAssUser();
			    } */
			});
	 }
	 //设置到文本框
	 function setPosition(stationsSel){
		 $("#"+selectELeId).val(stationsSel);
	 }
	 
	 //验证表单
	 function validateForms(){
			$('#yy-form-edit').validate({
				rules : {
					//relevant_bill : {required : true},
					receiver: {maxlength:1000},
					title : {required : true,maxlength:50},
					code : {required : true,maxlength:20},
					name : {required : true,maxlength:50},
					content : {required : true,maxlength:2000},
					remark : {maxlength:200}
				}
			}); 
	}
	 
	 function saveMail(){
		 if(hasContent()){
			 onSave(true);
		 }else{
			 YYUI.promMsg('请输入模版内容',1000);
		 }
	 }
	 
	function hasContent() {
	        return UM.getEditor('myEditor').hasContents();
	 }
</script>
