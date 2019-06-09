<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _zTree;//树
	//页面形态
	var _isSelected = true;

	var _selectedId;//选中节点
	
	var treeWaitLoad;//树刷新等待层

	function getTreeDataUrl() {
		var treeUrl = '';
		treeUrl = '${param.dataTreeUrl}';
		if (!treeUrl) {
			treeUrl = "${param.serviceurl}/dataTreeList";
		}
		return treeUrl;
	}

	var _treeSetting = {
		check : {
			enable : false
		},
		async : {
			enable : true,
			url : getTreeDataUrl(),
			autoParam : [ "id", "name=n", "level=lv" ],
			otherParam : {
				"otherParam" : "zTreeAsyncTest"
			},
			dataFilter : filter
		},
		view : {
			dblClickExpand : false,
			showTitle : false,
			fontCss : YyZTreeUtils.getFontCss
		},
		data : {
			key : {
				title : "title"
			},
			simpleData : {
				enable : true
			}
		},
		callback : {
			onDblClick : zTreeOnDblClick,
			onClick : zTreeOnClick,
			onAsyncSuccess : zTreeOnAsyncSuccess
		}
	};

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}

	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}

	function onSearchTree() {
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree, searchValue);
	}

	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}

	// _zTree 点击触发的事件
	function zTreeOnClick(event, treeId, treeNode) {
		var _method = '${param.onClickMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode)");
		} else {
			if (!_isSelected) {
				YYUI.promMsg("编辑状态，不能操作节点。");
				_zTree.selectNode(_selectedId);
				return false;
			}
			_selectedId = treeNode;
			_zTree.selectNode(treeNode);
			showData(treeNode);
		}
	}

	//_zTree 双击触发的事件
	function zTreeOnDblClick(event, treeId, treeNode) {
		var _method = '${param.onDblClickMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode)");
		} else {
			if (!_isSelected) {
				YYUI.promMsg("编辑状态，不能操作节点。");
				_zTree.selectNode(_selectedId);
				return false;
			}
			_selectedId = treeNode;
			_zTree.selectNode(treeNode);
			showData(treeNode);
		}
	}

	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		layer.close(treeWaitLoad);//关闭树刷新等待层
		var _method = '${param.onAsyncSuccessMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode, msg)");
		} else {
			var nodes = _zTree.getNodes();
			_zTree.expandNode(nodes[0], true);
			if (_selectedId) {
				var node = _zTree.getNodeByParam("id", _selectedId);
				// 选中当前操作（新增/修改）后的节点
				if(node!=null){
					var pNode = _zTree.getNodeByParam("id", node.pid);
					_zTree.expandNode(pNode, true);
				}
				_zTree.selectNode(node);
				if(node!=null){
					showData(node);
				}
				_selectedId = null;
			}
		}
	}

	//刷新
	function treeRefresh() {
		treeWaitLoad=layer.load(2);
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		YYFormUtils.clearForm('yy-form-edit');
	}

	$(document).ready(function() {
				
		treeWaitLoad=layer.load(2);
		//加载ztree
		_zTree = $.fn.zTree.init($("#ztree"), _treeSetting);

		treeDefaultActions();
		bindDefaultActions();

	});
	
	//绑定树按钮事件
	function treeDefaultActions(){
		$("#yy-btn-org-sure").bind("click", function() {
			zTreeOnDblClick(null, null, getSelectedNodes());
		});

		//折叠/展开
		$('#yy-expandAll').bind('click', function() {
			_zTree.expandAll(true);
		});
		$('#yy-collapseAll').bind('click', function() {
			_zTree.expandAll(false);
		});
		$('#yy-expandSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(true);
			} else {
				_zTree.expandNode(nodes, true, true, true);
			}
		});

		$('#yy-collapseSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(false);
			} else {
				_zTree.expandNode(nodes, false, true, true);
			}
		});

		$('#yy-treeRefresh').bind('click', treeRefresh);

		var t_treeSearchType='${param.treeSearchType}';
		if(t_treeSearchType!=null&&t_treeSearchType=='1'){
			//不绑定输入框改变事件
		}else{
			//zTree的搜索事件绑定
			$('#searchTreeNode').bind("propertychange", onSearchTree).bind(
					"input", onSearchTree);
		}
		$('#searchTreeNode').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				onSearchTree();
			}
		});
	}
	
	//绑定默认按钮事件
	function bindDefaultActions(){
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
	}
	
	// 树点击事件
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

	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-edit');
	}
	
	//删除
	function onRemove() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		var cNode = node.children;
		if (typeof (cNode) != 'undefined'&&cNode.length>0) {
			YYUI.promMsg("不能删除父节点！");
			return;
		}
		YYDataUtils.removeRecord("${param.serviceurl}/delete", node.id, onRefresh, true, true);
		//YYFormUtils.clearForm('yy-form-edit');
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
			validator.resetForm();
	        $(".error").removeClass("error");
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
		var posturl = "${param.serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-edit input[name='uuid']").val();
		if (pk != "") {
			posturl = "${param.serviceurl}/update";
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
					YYUI.promAlert("操作失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

</script>