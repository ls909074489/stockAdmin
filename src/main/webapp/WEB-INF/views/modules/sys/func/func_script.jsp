<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var validator;
	var map = YYDataUtils.getEnumMap();//枚举map
	/* 子表操作 */
	var _subTableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "20",
	    render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render :YYDataTableUtils.renderActionSubCol,
		width : "60"
	}, {
		data : 'actioncode',
		width : "40%",
		orderable : true
	}, {
		data : 'actionname',
		width : "50%",
		orderable : true
	} ];
	

	
	//显示列表的ToolBar
	function showListToolBar() {
		$('#yy-toolbar-edit').addClass("hide");
		$('#yy-toolbar-list').removeClass("hide");
		$("#yy-page-sublist").find("div.yy-toolbar").hide();
		$("#yy-page-sublist").find("#yy-btn-edit-row,#yy-btn-remove-row").hide();
		YYFormUtils.lockForm('yy-form-edit');
		$("#yy-form-sub").find("button").hide();
		$("#yy-form-sub").find("input[type='text']").hide();
		_isSelected = true;
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-edit');
		$("#yy-page-sublist").find("div.yy-toolbar").show();
		$("#yy-page-sublist").find("#yy-btn-edit-row,#yy-btn-remove-row").show();
		$("#yy-form-sub").find("button").prop("disabled", false);
		$("#yy-form-sub").find("input[type='text']").prop("disabled", false);
		_isSelected = false;
	}
	
	//取消
	function onCancel() {
		var node = getSelectedNodes();
		if (node) {
			showData(node);
		} else {
			YYFormUtils.clearForm('yy-form-edit');
		}
		showListToolBar();
	}

	
 	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		YYFormUtils.clearForm('yy-form-edit');
		validator.resetForm();
        $(".error").removeClass("error");
		pid = node.id;
		$("input[name='uuid']").val('');
		$("input[name='parentid']").val(pid);
		$("select[name='usestatus']").val("1");//设置计算方式为常规
		
		_subTableList.clear().draw();			//datetable 清空
		$("#yy-page-sublist").find("div.yy-toolbar").show();
		$("#yy-page-sublist").find("#yy-btn-edit-row,#yy-btn-remove-row").show();
		showEditToolBar();
	}
	

	//修改
	function onEdit() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		YYFormUtils.clearForm('yy-form-edit');
		showData(node);
		showEditToolBar();
	}

	//保存
	function onSave() {
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

		var saveWaitLoad=layer.load(2);
		var posturl = "${serviceurl}/addwithsub";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != null)
			posturl = "${serviceurl}/updatewithsub";
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			error: function(json){
				layer.close(saveWaitLoad);
		    	  YYUI.promAlert('保存失败!');
		    },
			success : function(data) {
				layer.close(saveWaitLoad);
				if (data.success == true) {
					_deletePKs = new Array();
					_addList = new Array();
					hasLoadSub = false;
					onRefresh();
					showListToolBar();
					_selectedId = data.records[0].uuid;
				} else {
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

	//删除
	function onRemove() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		/* if(!node.nodeData.islast){
			YYUI.promMsg("不能删除父节点！");
			return;
		} */
		var cNode = node.children;
		if (typeof (cNode) != 'undefined'&&cNode.length>0) {
			YYUI.promMsg("不能删除父节点！");
			return;
		}
		
		//YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh, true, true);
		var pNode=node.getParentNode();
		if(pNode!=null&&pNode.id!=null&&pNode.id!=''){
			_selectedId=pNode.id;//删除后跳到父节点
		}
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onDelRefresh, true, true);
		
		/* YYFormUtils.clearForm('yy-form-edit');
		_subTableList.clear();
		_subTableList.draw(); */
	}

	//删除后刷新
	function onDelRefresh(){
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		//_selectedId = null;
		YYFormUtils.clearForm('yy-form-edit');
	}
	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		//YYFormUtils.clearForm('yy-form-edit');
		
		YYFormUtils.clearForm('yy-form-edit');
		_subTableList.clear();
		_subTableList.draw();
	}
	
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		$.ajax({
			url : '${subserviceurl}/query',
			data : {
				"search_EQ_func.uuid" : mainTableId,
				"orderby" : "showorder@asc"
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
	
	
	//界面初始化
	function showData(treeNode) {
		$("input[name='uuid']").val(treeNode.nodeData.uuid);
		$("select[name='func_type']").val(treeNode.nodeData.func_type);
		$("input[name='parentid']").val(treeNode.nodeData.parentid);
		$("input[name='parentname']").val(treeNode.parentname);

		$("input[name='func_code']").val(treeNode.nodeData.func_code);
		$("input[name='func_name']").val(treeNode.nodeData.func_name);
		$("input[name='func_url']").val(treeNode.nodeData.func_url);
		$("input[name='help_code']").val(treeNode.help_code);
		$("input[name='iconcls']").val(treeNode.nodeData.iconcls);
		$("input[name='fun_css']").val(treeNode.nodeData.fun_css);
		$("input[name='showorder']").val(treeNode.nodeData.showorder);
		$("textarea[name='description']").val(treeNode.description);
		$("select[name='usestatus']").val(treeNode.nodeData.usestatus);
		$("input[name='islast']").val(treeNode.nodeData.islast);
		
		loadSubList(treeNode.nodeData.uuid);
		showListToolBar();
	}
	//树点击事件
	function selfOnClick(event, treeId, treeNode){
		if (!_isSelected) {
			YYUI.promMsg("编辑状态，不能操作节点。");
			_zTree.selectNode(_selectedId);
			return false;
		}
		_selectedId = treeNode;
		_zTree.selectNode(treeNode);
		showData(treeNode);
	}
	
	
	
	$(document).ready(function() {
		var yy_layout = $("body").layout({
			applyDefaultStyles : true,
			west : {
				size : 250
			}
		});
		
		table = $('#yy-table-sublist');
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false,
			
			"order" : [[2,"asc"]]
		});
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();

			var newData = [ {
				uuid : '',
				actioncode : '',
				actionname : ''
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
		//绑定按钮
		bindDefaultActions();

		YYFormUtils.lockForm('yy-form-edit');
		
		//验证 表单
		validateForms();
	});
	
	//绑定按钮事件
	function bindDefaultActions() {
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		
		$('#yy-def-iconcls').on('click', function() {
			layer.open({
				type : 2,
				title : '选择图标',
				shadeClose : false,
				shade : 0.8,
				area : [ '70%', '90%' ],
				content : '${serviceurl}/selectIcon', //iframe的url
			});
		});
		
		$("#yy-btn-enable").bind('click', rowEnabled);//启用
		$("#yy-btn-disenable").bind('click', rowDisabled);//禁用
	}
	
	//添加行
	function addRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		$(nRow).attr("rowType",'edit');//编辑状态需要验证
		jqTds[0].innerHTML = '<input type="checkbox" class="checkboxes" value="' + aData.uuid + '">';
		jqTds[1].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";
		jqTds[2].innerHTML = '<input type="text" id="wegwae" name="actioncode" class="form-control {required:true}" value="">';
		jqTds[3].innerHTML = '<input type="text" name="actionname" class="form-control {required:true}"  value="">';
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
		jqTds[2].innerHTML = '<input type="hidden"  name="uuid"  value="' + aData.uuid + '">'+
							 '<input type="text"  name="actioncode" class="form-control {required:true}"  value="' + aData.actioncode + '">';
	    jqTds[3].innerHTML = '<input type="text"  name="actionname" class="form-control"  value="' + aData.actionname + '">';
		
		$("td input[value='null']", nRow).val("");
		_addList.push(nRow);
	}
	
	
	
	 //验证主表单
	function validateForms(){
		validator=$('#yy-form-edit').validate({
			rules : {
				func_code : {required : true,maxlength:20},
				func_name : {required : true,maxlength:20},
				parentname : {required : true,maxlength:20},
				func_type: {required : true,maxlength:20},
				func_url: {maxlength:100}
			}
		}); 
	}
	 
	//验证子表 
	function validOther() {
		if (validateRowsData($("#yy-table-sublist tbody tr:visible[role=row][rowType=edit]"), getRowValidator()) == false) {
			return false;
		}
		return true;
	}
	
	//表体校验
	function getRowValidator() {
		return [ {
			name : "actioncode",
			rules : {
				required : true,
				maxlength : 20
			},
			message :{
				required : "请填写按钮编码",
				maxlength : "按钮编码不能超过20个字符"
			}
			}, {
			name : "actionname",
			rules : {
				required : true,
				maxlength : 50
			},
			message : {
				required : "请填写按钮名称",
				maxlength : "按钮名称不能超过50个字符"
			}
		} ];
	}
	 
	//选择节点图标回调函数
	function callBackSelectIcon(iconStr) {
		$("input[name='iconcls']").val(iconStr);
	}
	
	//启用
	function rowEnabled(){
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		var pks = node.id;
		_selectedId=pks;
		if($("#usestatus").val()==1){
			YYUI.promAlert('该功能已启用!');
			return;
		}else{
			upRecord('${serviceurl}/rowEnabled', pks);
		}
	}
	
	//禁用
	function rowDisabled(){
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		var pks = node.id;
		_selectedId=pks;
		if($("#usestatus").val()==0){
			YYUI.promAlert('该功能已禁用!');
			return;
		}else{
			upRecord('${serviceurl}/rowDisabled', pks);
		}
	}
	
	function upRecord(url, pks) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要操作的记录");
			return;
		}
		$.ajax({
			"dataType" : "json",
			"type" : "POST",
			"url" : url,
			"data" : {
				"pks" : pks.toString()
			},
			"success" : function(data) {
						YYUI.succMsg("成功", {icon: 1});
						onRefresh();
						_selectedId = pks;
			},
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.failMsg("失败，HTTP错误。");
			}
		});
	};
</script>
