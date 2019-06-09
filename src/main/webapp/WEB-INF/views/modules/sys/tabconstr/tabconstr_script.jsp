<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	_isNumber = true;

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
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render : YYDataTableUtils.renderViewEditActionCol,
		width : "60"
	},{
		data : "constraintSchema",
		orderable : false,
		className : "center",
		width : "10%",
	}, {
		data : 'tableName',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'constraintName',
		width : "20%",
		orderable : true
	}, {
		data : 'columnName',
		width : "15%",
		className : "center",
		orderable : true,
	}, {
		data : 'referencedTableName',
		width : "15%",
		className : "center",
		orderable : true,
	}, {
		data : 'referencedColumnName',
		width : "15%",
		className : "center",
		orderable : true,
	}];

	
	
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"order" : [ 2, "asc" ]
		});

		//按钮绑定事件
		bindButtonActions();
		$("#yy-btn-extract").bind('click', extractConstr);//拉取外键信息

		loadList("${serviceurl}/query?orderby=tableName@asc", _isNumber);
		
		validateForms();
	});


	//显示表头数据
	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
		$("input[name='dr']").val(data.dr);
		$("input[name='ts']").val(data.ts);

		$("input[name='constraintSchema']").val(data.constraintSchema);
		$("input[name='tableName']").val(data.tableName);
		$("input[name='tableNameDes']").val(data.tableNameDes);
		$("input[name='constraintName']").val(data.constraintName);
		$("input[name='columnName']").val(data.columnName);
		$("input[name='columnNameDes']").val(data.columnNameDes);
		$("input[name='referencedTableName']").val(data.referencedTableName);
		$("input[name='referencedTableDes']").val(data.referencedTableDes);
		$("input[name='referencedColumnName']").val(data.referencedColumnName);
		$("input[name='referencedColumnDes']").val(data.referencedColumnDes);
		
		$(".control-disabled").attr("disabled", true);
	}
	
	
	function onAddAfter() {
		$("select[name='is_use']").val("1");
	}
	
	function extractConstr() {
		layer.confirm("你确实要获取外键信息吗？", function(index) {
			layer.close(index);
			var extractWaitLoad=layer.load(2);
			$.ajax({
			       url: '${ctx}/sys/tabconstr/extractConst',
			       type: 'post',
			       data:{},
			       dataType: 'json',
			       error: function(json){
			    	  layer.close(extractWaitLoad);
			    	  YYUI.promAlert('获取外键信息失败!');
			       },
			       success: function(json){
			    	   layer.close(extractWaitLoad);
			    	   if(json.success){
				    		  if(json.msg=='0'){
				    			  YYUI.promAlert('没有需要获取新增的外键信息!');
				    		  }else{
				    			 confirmToSaveConstr(json);
				    		  }
			    	   }else{
			    		  YYUI.promAlert('获取外键信息失败!');
			    	   }
			       }
			   });	
		});
	}

	//确定保存拉取的外键信息
	function confirmToSaveConstr(json){
		 layer.confirm("共获取"+json.msg+"个外键，确定要保存外键信息吗?", function(index2) {
			  layer.close(index2);
			  var saveExWaitLoad=layer.load(2);
			  $.ajax({
			       url: '${ctx}/sys/tabconstr/saveConst',
			       type: 'post',
			       data:{},
			       dataType: 'json',
			       error: function(json){
			    	  layer.close(extractWaitLoad);
			    	  YYUI.promAlert('保存外键信息失败!');
			       },
			       success: function(json){
			    	   layer.close(saveExWaitLoad);
			    	   if(json.success){
			    		   YYUI.succMsg('操作成功:共保存'+json.msg+'个外键信息');
			    		   onRefresh();
			    	   }else{
			    		  YYUI.promAlert('保存外键信息失败!');
			    	   }
			       }
			   });
		  });
	}
	
	//刷新
	function onRefresh() {
		loadList(); //非服务器分页
	}

	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				false, true).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}



	//validate
	function validateForms() {
		$('#yy-form-edit').validate({
			rules : {
				constraintSchema : {
					required : true,
					maxlength : 50
				},
				tableName : {
					required : true,
					maxlength : 50
				},
				tableNameDes : {
					required : true,
					maxlength : 50
				},
				columnName : {
					required : true,
					maxlength : 50
				},
				constraintName : {
					required : true,
					maxlength : 50
				},
				columnNameDes : {
					required : true,
					maxlength : 50
				}/* ,
				referencedTableName : {
					required : true,
					maxlength : 50
				},
				referencedTableDes : {
					required : true,
					maxlength : 50
				},
				referencedColumnName : {
					required : true,
					maxlength : 50
				},
				referencedColumnDes : {
					required : true,
					maxlength : 50
				} */
			}
		});
	}
	
</script>
