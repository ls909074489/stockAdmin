<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	var _selectedId;//选中节点
	//页面形态
	var _isSelected = true;
	
	var _treeSetting = {
		check : {
			enable : false
		},
		async: {
			enable: true,
			url:"${serviceurl}/getRoleGroup?roleId=${roleId}",
			autoParam:["id", "name=n", "level=lv"],
			otherParam:{"otherParam":"zTreeAsyncTest"},
			dataFilter: filter
		},
		view: {
			dblClickExpand: false,
			//ddDiyDom: addDiyDom,
			fontCss: getFontCss   //搜索结果高亮
		},
		data: {
			key: {
				title:"title"
			},
			simpleData: {
				enable: true
			}
		},
		callback: {
			onDblClick: showGroupRoles,
			onClick : showGroupRoles,
			onAsyncSuccess : expandNodes,
		}
	};
	

	// 展开
	function expandNodes(){
		var nodes = getSelectedNodes();
		if (typeof (nodes) == 'undefined') {
			_zTree.expandAll(true);
			return;
		}
		_zTree.expandNode(nodes, true, true, true);
	}
	
	// 折叠
	function collapseNodes(){
		var nodes = getSelectedNodes();
		if (typeof (nodes) == 'undefined') {
			_zTree.expandAll(false);
			return;
		}
		_zTree.expandNode(nodes, false, true, true);
	}
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	//查询树节点后高亮显示
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}

	//界面初始化
	function showRoleTable(treeNode) {
		$("#search_LIKE_name").val("");
		_queryData = $("#yy-form-query").serializeArray();
		$.ajax({
			type : 'post',
			url : '${serviceurl}/searchGroupRoles',//?search_EQ_rolegroup.uuid='+treeNode.id,
			dataType : 'json',
			data : _queryData,
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
			}
		});
	}

	// _zTree 点击触发的事件
	function showGroupRoles(event, treeId, treeNode) {
		if (!_isSelected) {
			alert("编辑状态，不能操作节点。");
			_zTree.selectNode(_selectedId);
			return false;
		}
		$("#search_rolegroupId").val(treeNode.id);
		//$("#currentGroupNameId").html("("+treeNode.name+")");
		_selectedId = treeNode;
		_zTree.selectNode(treeNode);
		showRoleTable(treeNode);
	}

	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}


	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}

	//选择父节点回调函数
/* 	function callBackSelectFunc(funcNode) {
		$("input[name='parentid']").val(funcNode.id);
		$("input[name='parentname']").val(funcNode.name);
		_changeParent = true;
	} */

	//选择节点图标回调函数
/* 	function callBackSelectIcon(iconStr) {
		$("input[name='iconcls']").val(iconStr);
	} */
	
	//显示列表的ToolBar
	function showListToolBar() {
		$('#yy-toolbar-edit').addClass("hide");
		$('#yy-toolbar-list').removeClass("hide");
		YYFormUtils.lockForm('yy-form-func');
		_isSelected = true;
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-func');
		_isSelected = false;
	}


	function onSearchTree(){
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree,searchValue);
	}
	//绑定按钮事件
 	function bindDefaultActions() {
		/* $('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		$("#yy-form-func input[name='func_url']").bind('focus', function() {
			if ($(this).val() == '') {
				$(this).val('@ctx@/');
			}
		}); */
		//zTree的搜索事件绑定
		$('#searchTreeNode').bind("propertychange", onSearchTree)
			.bind("input", onSearchTree); 
		$('#searchTreeNode').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onSearchTree();
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
		/* var yy_layout = $("body").layout({
			applyDefaultStyles : true,
			west : {
				size : 250
			}
		}); */
		//加载ztree
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		
		//折叠/展开
		$('#yy-expandSon').bind('click', function() {
			expandNodes();
		});
		
		$('#yy-collapseSon').bind('click', function() {
			collapseNodes();
		});

		
		$('#yy-treeRefresh').bind('click', function() {
			_zTree.reAsyncChildNodes(null, 'refresh', false);
		});
		
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		//bindDefActions();

		YYFormUtils.lockForm('yy-form-func');
		
	});
</script>
