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
		}
		
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
		if(!node.nodeData.islast){
			YYUI.promMsg("不能删除父节点！");
			return;
		}
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
		if(treeNode.nodeData.parent!=null&&treeNode.nodeData.parent.uuid!=null){
			$("input[name='parent.uuid']").val(treeNode.nodeData.parent.uuid);
		}else{
			$("input[name='parent.uuid']").val('');
		}
	<#list fieldList as var>
		$("input[name='${var[0]}']").val(treeNode.nodeData.${var[0]});
	</#list>
		$("input[name='creatorname']").val(treeNode.nodeData.creatorname);
		$("input[name='create_time']").val(treeNode.nodeData.create_time);
		$("input[name='modifiername']").val(treeNode.nodeData.modifiername);
		$("input[name='modify_time']").val(treeNode.nodeData.modify_time);
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
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-edit');
	});
</script>
