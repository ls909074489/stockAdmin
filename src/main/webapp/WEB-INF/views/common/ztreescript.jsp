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
		//搜索结果高亮
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
				showData(node);
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

	$(document).ready(
			function() {
				
				treeWaitLoad=layer.load(2);
				//加载ztree
				_zTree = $.fn.zTree.init($("#ztree"), _treeSetting);

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
						//YYUI.promMsg("请选择节点");
						//return;
						_zTree.expandAll(true);
					} else {
						_zTree.expandNode(nodes, true, true, true);
					}
				});

				$('#yy-collapseSon').bind('click', function() {
					var nodes = getSelectedNodes();
					if (typeof (nodes) == 'undefined') {
						//YYUI.promMsg("请选择节点");
						//return;
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
			});
</script>