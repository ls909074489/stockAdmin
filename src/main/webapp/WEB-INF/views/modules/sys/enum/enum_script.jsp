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
		render : YYDataTableUtils.renderViewEditActionCol,//YYDataTableUtils.renderActionCol,
		width : "30"
	} , {
		data : 'modulecode',
		width : "80",
		orderable : true,
		className : "center",
		render : function(data, type, full) {
			return YYDataUtils.getEnumName("sys_moudule", data);
		}
	}, {
		data : 'groupcode',
		width : "120",
		orderable : false
	}, {
		data : 'groupname',
		width : "160",
		orderable : false
	}];

	/* 子表操作 */
	
	
	var _subTableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "20",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "60",
		render :YYDataTableUtils.renderActionSubCol
	}, {
		data : 'enumdatakey',
		width : "100",
		orderable : false
	}, {
		data : 'enumdataname',
		width : "200",
		orderable : true
	}, {
		data : 'icon',
		width : "200",
		orderable : true
	}, {
		data : 'showorder',
		width : "100",
		orderable : true
	}, {
		data : 'isdefault',
		width : "100",
		className : "center",
		render : function(data, type, full) {
            //return YYDataUtils.getEnumName("BooleanType", data);
            if(data||data=='true'){
            	return '是';
            }else{
            	return '否';
            }
        },
		orderable : true
	}, {
		data : 'description',
		width : "200",
		orderable : true
	}];
	
	//加载页面时初始化子表
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"order" : [[2,"asc"]]
		});
		
		//按钮绑定事件
		bindButtonActions();
		
		/* $("#yy-btn-save").bind("click", function() {
			onSave(true);
		}); */
		
		table = $('#yy-table-sublist');
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false,
			"order" : [[5,"asc"]]
		});
		
		//查询绑定回车start
		$('#search_LIKE_groupcode').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onQuery();
	        }
	    });
		$('#search_LIKE_groupname').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onQuery();
	        }
	    });
		//查询绑定回车start
		
		loadList();
		
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();

			var newData = [ {
				uuid : '',
				enumdatakey : '',
				enumdataname : '',
				icon : '',
				showorder : '',
				isdefault : 'false',
				description : ''
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
		

		//验证 表单
		validateForms();
	});
	
	//添加行
	function addRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		$(nRow).attr("rowType",'edit');//编辑状态需要验证
		jqTds[0].innerHTML = '<input type="checkbox" class="checkboxes" value="' + aData.uuid + '">';
		jqTds[1].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";
		jqTds[2].innerHTML = '<input type="text" class="form-control" name="enumdatakey"  value="' + aData.enumdatakey + '">';
		jqTds[3].innerHTML = '<input type="text" class="form-control" name="enumdataname"  value="' + aData.enumdataname + '">';
		jqTds[4].innerHTML = '<input type="text" class="form-control" name="icon"  value="' + aData.icon + '">';
		jqTds[5].innerHTML = '<input type="text" class="form-control" name="showorder"  value="' + aData.showorder + '">';
		jqTds[6].innerHTML = '<input type="checkbox" class="checkboxes"  name="isdefault" value="' + aData.isdefault + '">';
		jqTds[7].innerHTML = '<input type="text" class="form-control" name="description"  value="' + aData.description + '">';
		//setRowStyle(nRow);
		_addList.push(nRow);
	}
	//修改行  (oTable-->datatable，nRow-->tr对象，而不是datatable的row)
	function editRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		$(nRow).attr("rowType",'edit');//编辑状态需要验证
		
		jqTds[0].innerHTML = '<div class="checker" ><span><input type="checkbox" class="checkboxes" value="' + aData.uuid + '"></span></div>';
		jqTds[1].innerHTML = "<div class='btn-group rap-btn-actiongroup'>"
			+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger cancel' data-rel='tooltip' title='取消'><i class='fa fa-undo'></i></button>"
			+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
		jqTds[2].innerHTML = '<input type="text" class="form-control" name="enumdatakey"  value="' + aData.enumdatakey + '">'
				+ '<input name="uuid" type="hidden"  value="' + aData.uuid + '">';
		jqTds[3].innerHTML = '<input type="text" class="form-control" name="enumdataname"  value="' + aData.enumdataname + '">';
		jqTds[4].innerHTML = '<input type="text" class="form-control" name="icon"  value="' + aData.icon + '">';
		jqTds[5].innerHTML = '<input type="text" class="form-control" name="showorder"  value="' + aData.showorder + '">';
		if(aData.isdefault){
			jqTds[6].innerHTML = '<input type="checkbox" name="isdefault" checked="'+ aData.isdefault +'">';
		}else{
			jqTds[6].innerHTML = '<input type="checkbox" name="isdefault">';
		}
		jqTds[7].innerHTML = '<input type="text" class="form-control" name="description"  value="' + aData.description + '">';
		
		$("td input[value='null']", nRow).val("");
		//YYFormUtils.setCheckBox("yy-table-sublist", "edit");//调整checkbox样式
		//setRowStyle(nRow);
		$("select[name='enumType']", nRow).val(aData.enumType);
		_addList.push(nRow);
	}
	//显示表头数据
	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("select[name='modulecode']").val(data.modulecode);
		$("input[name='groupcode']").val(data.groupcode);
		$("input[name='groupname']").val(data.groupname);
		$("textarea[name='description']").val(data.description);
	}
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		$.ajax({
			url : '${subserviceurl}/query',
			data : {
				"search_EQ_enumdata.uuid" : mainTableId,
				"orderby" : "createtime@asc"
			},
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(data) {
				hasLoadSub = true;
				_subTableList.clear();
				_subTableList.rows.add(data.records);
				_subTableList.draw();
			}
		});
	}
	//刷新
	function onRefresh() {
		loadList(); //非服务器分页
	}
	
	
	 //验证表单
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				modulecode : {required : true,maxlength:50},
				groupcode : {required : true,maxlength:50},
				groupname : {required : true,maxlength:50},
				description : {maxlength:200}
			}
		}); 
	}
	 
	
	//主子表保存
	function onSave(isClose) {
		var subValidate=validOther();
		var mainValidate=$('#yy-form-edit').valid();
		if(!subValidate||!mainValidate){
			return false;
		}
			
		//保存新增的子表记录 
		YYFormUtils.setCheckBoxNotCheckedValue('yy-form-edit');
		YYFormUtils.setCheckBoxNotCheckedValue('secondform');
		var subList = getToSaveList();
		var subData = null;

		//所有需要保存的参数
		subData = {
			"subList" : subList,
			"deletePKs" : _deletePKs
		};

		var posturl = "${serviceurl}/addwithsub";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != null)
			posturl = "${serviceurl}/updatewithsub";
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			success : function(data) {
				if (data.success == true) {
					_deletePKs = new Array();
					_addList = new Array();
					hasLoadSub = false;
					onRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
				} else {
					//YYUI.failMsg("保存失败：" + data.msg);
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	
	//校验
	function validOther(){
		if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row][rowType=edit]"),getRowValidator())==false){
			return false;
		}
		else{
			return true;
		} 
		return true;
	}
	
	
	//表体校验
	function getRowValidator() {
		return [ {
					name : "enumdatakey",
					rules : {
						required : true,
						maxlength:50
					},
					message : {
						required : "枚举编码必输",
						maxlength : "枚举编码最大长度为50"
					}
				},
				{
					name : "enumdataname",
					rules : {
						required : true,
						maxlength:50
					},
					message : {
						required : "显示名称",
						maxlength : "显示名称最大长度为50"
					}
				},
				{
					name : "icon",
					rules : {
						maxlength:50
					},
					message : {
						maxlength : "显示图标最大长度为50"
					}
				},
				{
					name : "showorder",
					rules : {
						maxlength:3
					},
					message : {
						required : "显示顺序最大长度为3"
					}
				},
				{
					name : "description",
					rules : {
						maxlength:100
					},
					message : {
						maxlength : "说明最大长度为100"
					}
				}
		];
	}
	
</script>
