<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
var _zTree;//树
var _changeParent;//是否变更了父节点
var _selectedId;//选中节点
//页面形态
var _isSelected = true;
var commontreeWaitLoad;//树刷新等待层
var _treeSetting = {
	data : {
		key : {
			name : "name"
		},
		simpleData : {
			enable : true,
			idKey : "uuid",
			pIdKey : "parentid"
		}
	},
	view : {
		selectedMulti : false,
		fontCss : YyZTreeUtils.getFontCss
	},
	async : {
		enable : true,
		url : "${serviceurl}/getTreeNodes",
		autoParam : [ "uuid=node" ],
		dataFilter : ajaxDataFilter
	},
	callback : {
		onClick : zTreeOnClick,
		onAsyncSuccess : zTreeOnAsyncSuccess
	}
};

// _zTree 点击触发的事件
function zTreeOnClick(event, treeId, treeNode) {
	if (!_isSelected) {
		YYUI.promMsg("编辑状态，不能操作节点。");
		_zTree.selectNode(_selectedId);
		return false;
	}
	_selectedId = treeNode;
	_zTree.selectNode(treeNode);
	showData(treeNode);
}

// _zTree 返回数据进行预处理
function ajaxDataFilter(treeId, parentNode, responseData) {
	var records = responseData.records;
	return records;
}

//成功加载树后
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	layer.close(commontreeWaitLoad);//关闭树刷新等待层
	var nodes = _zTree.getNodes();
	_zTree.expandNode(nodes[0], true);
	if (_selectedId) {
		var node;
		if(typeof(_selectedId.id) != "undefined"&&_selectedId.id!=''){
			node = _zTree.getNodeByParam("id", _selectedId.id);
		}else if(typeof(_selectedId.uuid) != "undefined"&&_selectedId.uuid!=''){
			node = _zTree.getNodeByParam("id", _selectedId.uuid);
		}else{
			node = _zTree.getNodeByParam("id", _selectedId);
		}
		// 选中当前操作（新增/修改）后的节点
		var pNode = _zTree.getNodeByParam("id", node.pid);
		_zTree.expandNode(pNode, true);
		_zTree.selectNode(node);
		showData(node);
		_selectedId = null;
	}
}

//当前选择的节点
function getSelectedNodes() {
	return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
}

//选择父节点回调函数
function callBackSelect(node) {
	$("input[name='parentid']").val(node.id);
	$("input[name='parentname']").val(node.name);
	_changeParent = true;
}

//选择节点图标回调函数
function callBackSelectIcon(iconStr) {
	$("input[name='iconcls']").val(iconStr);
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
}

//修改
function onEdit() {
	var node = getSelectedNodes();
	if (typeof (node) == 'undefined') {
		YYUI.promMsg("请选择节点");
		return;
	}
	if (node.level == 0) {
		YYUI.promMsg("不能修改根节点");
		return;
	}
	showData(node);
	showEditToolBar();
}

//保存
function onSave() {
	if (!$('#yy-form-edit').valid()){
		return false;   
	}
	var posturl = "${serviceurl}/add";
	var isAdd = true;
	pk = $("#yy-form-edit input[name='uuid']").val();
	if (pk != "") {
		posturl = "${serviceurl}/update";
		isAdd = false;
	}
	if (!$("#yy-form-edit").valid())
		return false;
	
	var treeCommonSaveWaitLoad=layer.load(2);
	var opt = {
		url : posturl,
		type : "post",
		success : function(data) {
			layer.close(treeCommonSaveWaitLoad);
			if (data.success == true) {
				onRefresh();
				showListToolBar();
				_selectedId = data.records[0];
				YYUI.succMsg("保存成功");
			} else {
				//YYUI.failMsg("保存失败：" + data.msg)
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
	
	YYFormValidate.cancelValidate();
}

//删除
function onRemove() {
	var node = getSelectedNodes();
	if(!node.nodeData.islast){
		YYUI.promMsg("不能删除父节点！");
		return;
	}
	if (typeof (node) == 'undefined' || node.level == 0) {
		return;
	}
	if(node.isParent){
		YYUI.promMsg("存在子节点，不能删除");
		return;
	}else{
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh, true, true);
	}
}

//刷新
function onRefresh() {
	_zTree.reAsyncChildNodes(null, 'refresh', false);
	_selectedId = null;
	YYFormUtils.clearForm('yy-form-edit');
}

//绑定按钮事件
function bindDefaultActions() {
	$('#yy-btn-add').bind('click', onAdd);
	$('#yy-btn-edit').bind('click', onEdit);
	$('#yy-btn-remove').bind('click', onRemove);
	$('#yy-btn-refresh').bind('click', onRefresh);
	$('#yy-btn-save').bind('click', onSave);
	$('#yy-btn-cancel').bind('click', onCancel);
	$("#yy-form-edit input[name='func_url']").bind('focus', function() {
		if ($(this).val() == '') {
			$(this).val('@ctx@/');
		}
	});
	$('#searchTreeNode').bind("propertychange", onSearchTree)
	.bind("input", onSearchTree); 
	$('#searchTreeNode').bind('keypress',function(event){
	if(event.keyCode == "13") {
		onSearchTree();
	}
	});
	$('.parent').children(".row").addClass("hide");
	$('.parent').find('input').attr("disabled",true);
	
	 $('.hos').bind('click',function(){ 
		 // 获取所谓的父行
		 if($('.hos').children(".fa").hasClass("fa-caret-right")){
			
			 $('.hos').children(".fa").removeClass("fa-caret-right");
			 $('.hos').children(".fa").addClass("fa-caret-down");
			 $('.parent').children(".row").removeClass("hide");
			// alert("enter");
		 }else{
			 $('.hos').children(".fa").removeClass("fa-caret-down");
			 $('.hos').children(".fa").addClass("fa-caret-right");
			
			 $('.parent').children(".row").addClass("hide");
		 } 
		
	});

}

//绑定参照事件
function bindDefActions() {
	$('#yy-def-parentname').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择父节点',
			shadeClose : false,
			shade : 0.8,
			area : [ '300px', '90%' ],
			content : '${serviceurl}/selectFunc?rootSelectable=true', //iframe的url
		});
	});
	
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
}

$(document).ready(function() {
	var yy_layout = $("body").layout({
		applyDefaultStyles : true,
		west : {
			size : 250
		}
	});
	//加载ztree
	_zTree = $.fn.zTree.init($("#tree"), _treeSetting);
	
	
	$("#expandAllBtn").bind("click", {type:"expandAll"}, function(){
		_zTree.expandAll(true);
	});//展开
	$("#collapseAllBtn").bind("click", {type:"collapseAll"}, function(){
		_zTree.expandAll(false);
	});//折叠
	
	//展开所有 edit by ls2008
	$('#yy-expandAll').bind('click', function() {
		_zTree.expandAll(true);
	});
	//折叠所有 edit by ls2008
	$('#yy-collapseAll').bind('click', function() {
		_zTree.expandAll(false);
	});
	
	//展开选中节点 edit by ls2008
	$('#yy-expandSon').bind('click', function() {
		var nodes = getSelectedNodes();
		if (typeof (nodes) == 'undefined') {
			_zTree.expandAll(true);
		}
		_zTree.expandNode(nodes, true, true, true);
	});
	
	//折叠选中节点 edit by ls2008
	$('#yy-collapseSon').bind('click', function() {
		var nodes = getSelectedNodes();
		if (typeof (nodes) == 'undefined') {
			_zTree.expandAll(false);
		}
		_zTree.expandNode(nodes, false, true, true);
	});
	
	//刷新树 edit by ls2008
	$('#yy-treeRefresh').bind('click', function() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		commontreeWaitLoad=layer.load(2);
	});
	
	//绑定按钮
	bindDefaultActions();
	//绑定参照事件
	bindDefActions();

	YYFormUtils.lockForm('yy-form-edit');
});


function onSearchTree(){
	var searchValue = $('#searchTreeNode').val();
	YyZTreeUtils.searchNode(_zTree,searchValue);
}

</script>