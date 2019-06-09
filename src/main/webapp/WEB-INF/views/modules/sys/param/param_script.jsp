<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "20",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		//render : YYDataTableUtils.renderActionCol,
		render : function(data, type, full) {
			var str="<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			//+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
			return str+"<input type='hidden' name='ispreset' value='"+full.ispreset+"'>";
		},
		width : "60"
	}, {
		data : 'groudcode',
		width : "15%",
		className : "center",
		orderable : true,
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("sys_moudule", data);
		}
	}, {
		data : 'paramtercode',
		width : "20%",
		className : "center",
		orderable : true
	}, {
		data : 'paramtername',
		width : "20%",
		orderable : true
	}, {
		data : 'paramtervalue',
		width : "20%",
		orderable : true
	}, {
		data : 'paramtertype',
		width : "15%",
		orderable : true
	} ];

	function onRefresh() {
		//非服务器分页
		loadList();
	}

	/* function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='promptCode']").val(data.promptCode);
		$("input[name='promptName']").val(data.promptName);
		$("textarea[name='remarks']").val(data.remarks);
	}
	 */
	 
	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				$('#global_regex').prop('checked'),
				$('#global_smart').prop('checked')).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}
	 
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			 "scrollY" : '80vh',
			 "scrollCollapse": true,
			//"fixedHeader": true,//表头
			"createdRow" : YYDataTableUtils.setActions,
			//"dom" : '<"top">rt<"bottom"p><"clear">',
			"order" : [[2,"desc"]]
		});

		$('input.global_filter').on('keyup click', function() {
			filterGlobal();
		});

		
		$("#groudcodeList").change(function (){
			$('#yy-table-list').DataTable().column(2).search(
					$(this).val(), false, true).draw();
		});
		
		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();

		
		//验证 表单
		validateForms();
	});

	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("select[name='groudcode']").val(data.groudcode);
		$("input[name='paramtercode']").val(data.paramtercode);
		$("input[name='paramtername']").val(data.paramtername);
		$("input[name='paramtervalue']").val(data.paramtervalue);
		$("input[name='defaultvalue']").val(data.defaultvalue);
		$("input[name='paramtertype']").val(data.paramtertype);
		$("input[name='valuerange']").val(data.valuerange);
		//$("input[name='description']").val(data.description);
		$("textarea[name='description']").val(data.description);
		$("input[name='showorder']").val(data.showorder);
		$("input[name='sys']").val(data.sys);
		$("input[name='isshow']").val(data.isshow);

	}
	
	function onRemove() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeRemove(pks)) {
			var hasPreset='0';
			 $("input[name='chkrow']:checked").each(function(){
				 var ispreset=$(this).parents('tr').find('input[name=ispreset]').val();
			     if(ispreset!=null&&ispreset=='1'){
			    	 hasPreset='1';
			    	 return false;
			     }
			 });
			 if(hasPreset=='0'){
				 removeRecord('${serviceurl}/delete', pks, onRefresh);
			 }else{
				 YYUI.promAlert('删除项中有系统预置参数不能删除!');
				 return false;
			 }
		}
	}
	
	//行操作：删除   
	//@data 行数据
	//@rowidx 行下标
	function onRemoveRow(data, rowidx, row) {
		if(data.ispreset!=null&&data.ispreset=='1'){
			YYUI.promAlert('系统预置参数不能删除!');
			return false;
		}else{
			if (doBeforeRemoveRow(data)) {
				removeRecord('${serviceurl}/delete', [ data.uuid ], function() {
					_tableList.row(row).remove().draw(false);
				});
			}
		}
	}
	
	 //验证表单
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				groudcode : {required : true},
				paramtercode : {required : true,maxlength:50},
				paramtername : {required : true,maxlength:50},
				paramtervalue : {maxlength:100},
				paramtertype : {maxlength:50},
				valuerange : {maxlength:50},
				showorder : {maxlength:50},
				description : {maxlength:1000}
			}
		})
	}
</script>
