<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">

	//绑定按钮事件
	function bindDefaultActions() {
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
	}
	

	
	//显示列表的ToolBar
	function showListToolBar() {
		$('#yy-toolbar-edit').addClass("hide");
		$('#yy-toolbar-list').removeClass("hide");
		YYFormUtils.lockForm('yy-form-edit');
		_isSelected = true;
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-edit');
		_isSelected = false;
	}

	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}else{
			YYFormUtils.clearForm('yy-form-edit');
			pid = node.id;
			$("input[name='parent.uuid']").val(pid);
			//$("input[name='parentname']").val(node.name);
			//$("input[name='status']").val("1");
			//$("input[name='parentid']").val(node.id);//设置上级部门或者业务单元
			$("input[name='coding']").val(node.nodeData.coding);
			if(node.nodeData.parent != null){
				$("input[name='parcoding']").val(node.nodeData.parent.coding);
			}
			jQvaliAdd();
			
		}
		
		showEditToolBar();
		findtablefile(node.nodeData.tableName,null,false);
	}
	function findtablefile(tableName,value,ispare){
		var doc = {"tableName":tableName}
		$.ajax({
			url : "${serviceurl}/queryField",
			type : "post",
			data :doc,
			success : function(data) {
				if(data.length==0){
					YYUI.promMsg("请正确填写表名 ");
					return;
				}
				if(ispare){
					$("select[name='fieldName']").html("");
					$("#fieldName").append("<option value=''></option>")
				}else{
					$("select[name='parefieldName']").html("");
					$("#parefieldName").append("<option value=''></option>")
				}
				for(var i=0;i<data.length;i++){
					if("status"==data[i].columnName){
					}else if("creatorname"==data[i].columnName){
					}else if("createtime"==data[i].columnName){
					}else if("createtime"==data[i].columnName){
					}else if("modifier"==data[i].columnName){
					}else if("modifiername"==data[i].columnName){
					}else if("modifytime"==data[i].columnName){
					}else if("modifytime"==data[i].columnName){
					}else {
						if(ispare){
								$("select[name='fieldName']").append("<option value='"+data[i].columnName+"'>"+data[i].columnName+"</option>");
							}else{
								$("select[name='parefieldName']").append("<option value='"+data[i].columnName+"'>"+data[i].columnName+"</option>");
							}
						}
					}
				if(value != null){
					if(ispare){
						$("select[name='fieldName']").val(value);
					}else{
						$("select[name='parefieldName']").val(value);
					}

				}
			}
	})
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
		findtablefile(node.nodeData.parent.tableName,node.nodeData.parefieldName,false);
		findtablefile(node.nodeData.tableName,node.nodeData.fieldName,true);
		$("input[name='parcoding']").val(node.nodeData.parent.coding);
		jQvaliAdd();
	}
	function jQvaliAdd(){
		jQuery.validator.addMethod("iscoding", function (value, element) {
			if(value==null || value==""){
				return false;
			}
			var parcoding = $("input[name='parcoding']").val();

			if(parcoding=="root") {
				return true;
			}
			if(value.length < parcoding.length){
				return false;
			}else if(value.length == parcoding.length){
				return false;
			}else{
				var cod = value.substring(0, parcoding.length);
				if(cod != parcoding){
					return false;
				}else{
					return true;
				}
			}
			
	    }, "编码必须以上节点编码开头");
	}
	//保存
	function onSave() {
		var posturl = "${serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-edit input[name='uuid']").val();
		if (pk != "") {
			posturl = "${serviceurl}/update";
			isAdd = false;
		}
		if (!$("#yy-form-edit").valid())
			return false;
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success == true) {
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
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh, true, true);
		YYFormUtils.clearForm('yy-form-edit');
	}

	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-edit');
	}

	//绑定参照事件
	function bindDefActions() {
	}
	
	//界面初始化
	function showData(treeNode) {		
		$("input[name='uuid']").val(treeNode.nodeData.uuid);
		$("input[name='coding']").val(treeNode.nodeData.coding);
		if(treeNode.nodeData.parent!=null && treeNode.nodeData.parent.uuid!=null){
			$("input[name='parent.uuid']").val(treeNode.nodeData.parent.uuid);
			//alert(treeNode.nodeData.coding);
			$("input[name='parcoding']").val(treeNode.nodeData.coding);
		}else{
			$("input[name='parent.uuid']").val('');
		}
		
		
		$("input[name='tableName']").val(treeNode.nodeData.tableName);
		$("input[name='parentName']").val(treeNode.nodeData.parentName);
 		$("select[name='fieldName']").append("<option value="+treeNode.nodeData.fieldName+">"+treeNode.nodeData.fieldName+"</option>")
		$("select[name='fieldName']").val(treeNode.nodeData.fieldName);
 		$("select[name='parefieldName']").append("<option value="+treeNode.nodeData.parefieldName+">"+treeNode.nodeData.parefieldName+"</option>")
		$("select[name='parefieldName']").val(treeNode.nodeData.parefieldName);
		$("input[name='ChineseTable']").val(treeNode.name);
		$("input[name='englishAbbreviations']").val(treeNode.nodeData.englishAbbreviations);
		$("input[name='creatorname']").val(treeNode.nodeData.creatorname);
		$("input[name='createtime']").val(treeNode.nodeData.createtime);
		$("input[name='modifiername']").val(treeNode.nodeData.modifiername);
		$("input[name='modifytime']").val(treeNode.nodeData.modifytime);
		
	}
	
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
		
		//绑定按钮
		bindDefaultActions();
		
		
		validateForms();
		
		YYFormUtils.lockForm('yy-form-edit');
		
	});
	function queryField(uuid){
		
	}
	
		$("select[name='fieldName']").focus(function(){
			 if($("input[name='tableName']").val()==""){
				 YYUI.promMsg('请先填写表名',2000)
			 }
		});
		$("input[name='tableName']").change(function(){
			findtablefile($("input[name='tableName']").val(),null,true);
		 })
		//校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					
					'tableName' : {required : true},
					'ChineseTable' : {required : true},
					'fieldName' : {required : true},
					'parefieldName' : {required : true},
					'coding' : {iscoding:$("input[name='coding']").val()},
				}			
			});
		}
</script>
