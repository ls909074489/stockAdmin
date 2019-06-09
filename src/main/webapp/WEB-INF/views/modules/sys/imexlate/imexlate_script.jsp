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
			render : function(data, type, full) {
				return "<div class='yy-btn-actiongroup'>"
				+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				+ "<button id='yy-btn-gen-row' class='btn btn-xs btn-info' data-rel='tooltip' title='生成模板'><i class='fa fa-file-excel-o'></i></button>"
				+ "</div>";
			},
			width : "14%"
		}, {
			data : 'templateName',
			width : "14%",
			className : "center",
			orderable : true
		} , {
			data : 'coding',
			width : "14%",
			className : "center",
			orderable : true
		}, {
			data : 'exportFileName',
			width : "14%",
			className : "center",
			orderable : true
		} , {
			data : 'iscreate',
			width : "10%",
			className : "center",
			orderable : true,
      		render : function(data, type, full) {
			       return YYDataUtils.getEnumName("BooleanType", data);
			}
		}
	];
	//生成模板 
	function  onYyBtnGenRow(aData, iDataIndex, nRow){
		$.ajax({
			url : '${serviceurl}/generate',
			data : {
				"coding" : aData.coding,
			},
			async : false,
			success : function(data) {
				if(data=="error"){
					YYUI.promAlert('模板生成失败!');
				}else{
					YYUI.succMsg('模板生成成功!');
				}
			}
		});
	}
	
	/* 子表操作 */
	var _subTableCols = [
	{
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "40",
		render : YYDataTableUtils.renderActionSubCol
	}, {
		data : 'exportCellNum',
		width : "40",
		className : "center",
		orderable : true
	}
			, {
			data : 'fieldName',
			width : "100",
			className : "center",
			orderable : true
		}
		, {
			data : 'chineseField',
			width : "100",
			className : "center",
			orderable : true
		}
		, {
			data : 'isMainField',
			width : "80",
			className : "center",
			orderable : true
		}
		, {
			data : 'isnotempty',
			width : "80",
			className : "center",
			orderable : true
		}
		, {
			data : 'enumdata',
			width : "80",
			className : "center",
			orderable : true
		}, {
			data : 'qualifiedValue',
			width : "80",
			className : "center",
			orderable : true
		}, {
			data : 'datatype',
			width : "80",
			className : "center",
			orderable : true
		}
	];
	
	
	//加载页面时初始化子表
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
			
			//按钮绑定事件
			bindButtonActions();
			//加载数据
			//loadList();
			
		table = $('#yy-table-sublist');
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false,
			
			"order" : [[1,"asc"]]
		});
		loadList();
		
		validateForms();
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();

			var newData = [ {
				 uuid : '',
				 exportCellNum:'',
				 fieldName : '',
				 chineseField : '' ,
				 isMainField : '',
				 isnotempty :'',
				 enumdata:'',
				 qualifiedValue:'',
				 datatype:''
			} ];
			var nRow = _subTableList.rows.add(newData).draw().nodes()[0];//获得第一个tr节点
			addRow(_subTableList, nRow);
			
		});
		
		
		
		
		
		//行操作：删除子表
		table.on('click', '.delete', function(e) {
			e.preventDefault();
			var nRow = $(this).closest('tr')[0];
			var row = _subTableList.row(nRow);
			var data = row.data();
			if (typeof (data) == null || data.uuid == '') {
				//新增的直接删除
				row.remove().draw();
				_addList = removeObjFromArr(_addList, nRow);
			} else {
				_deletePKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
				_addList = removeObjFromArr(_addList, nRow);
				row.remove().draw();
			}
		});
		//行操作：取消编辑
		table.on('click', '.cancel', function(e) {
			e.preventDefault();
			var nRow = $(this).closest('tr')[0];
			cancelEditRow(_subTableList, nRow);
		});
		//行操作：编辑	
		table.on('click', '.edit', function(e) {
			e.preventDefault();
			/* 获取点击事件所在的行 */
			var nRow = $(this).closest('tr')[0];
			editRow(_subTableList, nRow);

		});
		//$("#yy-btn-gen-row").bind('click',generate);//生成模板 

	});
	//校验
	function validateForms(){
		validata = $('#yy-form-edit').validate({
			onsubmit : true,
			rules : {
				'templateName' : {required : true},
				'coding' : {required : true},
				'exportFileName' : {required : true}
			    
				
			}			
		});
	}
	//添加行
	function addRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";
		jqTds[1].innerHTML = '<input type="text" name="exportCellNum"  value="' + aData.exportCellNum + '">';
		jqTds[2].innerHTML = '<input type="text"  name="fieldName"  value="' + aData.fieldName + '">';
		jqTds[3].innerHTML = '<input type="text" name="chineseField"  value="' + aData.chineseField + '">';
/* 		jqTds[3].innerHTML = '<input type="text"  name="isMainField"  value="' + aData.isMainField + '">';
 */		jqTds[4].innerHTML = '<input type="checkbox" class="checkboxes"  name="isMainField" value="' + aData.isMainField + '">';
		jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes"  name="isnotempty" value="' + aData.isnotempty + '">';
		jqTds[6].innerHTML = '<input type="text" name="enumdata"  value="' + aData.enumdata + '">';
		jqTds[7].innerHTML = '<input type="text" name="qualifiedValue"  value="' + aData.qualifiedValue + '">';
		jqTds[8].innerHTML = '<input type="text" name="datatype"  value="' + aData.datatype + '">';
		_addList.push(nRow);
	}
	//修改行  (oTable-->datatable，nRow-->tr对象，而不是datatable的row)
	function editRow(oTable, nRow) {
		//alert(oTable)
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = "<div class='btn-group rap-btn-actiongroup'>"
			+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger cancel' data-rel='tooltip' title='取消'><i class='fa fa-undo'></i></button>"
			+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
		jqTds[1].innerHTML = '<input type="text"  name="exportCellNum"  value="' + aData.exportCellNum + '">';
		jqTds[2].innerHTML = '<input type="text"  name="fieldName"  value="' + aData.fieldName + '">'
				+ '<input name="uuid" type="hidden"  value="' + aData.uuid + '">'
		jqTds[3].innerHTML = '<input type="text" name="chineseField"  value="' + aData.chineseField + '" >';
		if(aData.isMainField=="是"){
			jqTds[4].innerHTML = '<input type="checkbox" class="checkboxes"  name="isMainField" checked="' + aData.isMainField + '">';
		}else{
			jqTds[4].innerHTML = '<input type="checkbox" class="checkboxes"  name="isMainField">';
		}
		if(aData.isnotempty=="是"){
			jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes"  name="isnotempty" checked="' + aData.isnotempty + '">';

		}else{
			jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes"  name="isnotempty" >';
		}
		if(aData.enumdata){
			jqTds[6].innerHTML = '<input type="text" name="enumdata" value="' + aData.enumdata + '">';

		}else{
			jqTds[6].innerHTML = '<input type="text"  name="enumdata" >';
		}
		if(aData.qualifiedValue){
			jqTds[7].innerHTML = '<input type="text" name="qualifiedValue" value="' + aData.qualifiedValue + '">';

		}else{
			jqTds[7].innerHTML = '<input type="text"  name="qualifiedValue" >';
		}
		if(aData.datatype){
			jqTds[8].innerHTML = '<input type="text" name="datatype" value="' + aData.datatype + '">';

		}else{
			jqTds[8].innerHTML = '<input type="text"  name="datatype" >';
		}
 		_addList.push(nRow);
		rowNum++;
	}
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
		
		loadList('${serviceurl}/query?orderby=createtime@asc',false);
		//生成模板按钮绑定
	});
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		$.ajax({
			url : '${subserviceurl}/query',
			data : {
				"search_EQ_implate.uuid" : mainTableId,
				//"orderby" : "createtime@asc"
			},
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(data) {
				for(var i=0;i<data.records.length;i++){
					if(data.records[i].isMainField==true){
						data.records[i].isMainField="是";
					}else{
						data.records[i].isMainField="否";
					}
					if(data.records[i].isnotempty==true){
						data.records[i].isnotempty="是";
					}else{
						data.records[i].isnotempty="否";
					}
				}
				hasLoadSub = true;
				_subTableList.clear();
				_subTableList.rows.add(data.records);
				_subTableList.draw();
			}
		});
	}

	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);		
		$("input[name='templateName']").val(data.templateName);
		$("input[name='coding']").val(data.coding);
		$("select[name='iscreate']").val(data.iscreate);
		// $("input[name='startRowNum']").val(data.startRowNum);
		// $("input[name='startCellNum']").val(data.startCellNum);
		// $("input[name='ChildStartCellNum']").val(data.childStartCellNum);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
		$("input[name='exportFileName']").val(data.exportFileName);
	 }	
	 
	 //导入
	 function determineimport(path){
		 var Data = {
					"filePath" : path,
					 "coding" : "${coding}" 
				}; 
		  $.ajax({
				url : '${serviceurl}/importTest',
				 data : Data, 
				dataType : 'json',
				async : false,
				success : function(data) {
					
				}
			}); 
	 }
</script>
