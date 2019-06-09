YyZTreeUtils = {};

/**
 * 高亮显示并展开树
 * 
 * @param zTree
 * @param nodeList
 *            高亮显示的节点
 */
YyZTreeUtils.hightLightShowNodes = function(zTree, nodeList) {
	for (var i = 0, l = nodeList.length; i < l; i++) {
		nodeList[i].highlight = true;
		zTree.updateNode(nodeList[i]);
		YyZTreeUtils.expandParent(zTree, nodeList[i]);
	}
}

// zTree 当前选择的节点
YyZTreeUtils.getZtreeSelectedNodes = function(ztreeObj) {
	var curNode;
	var nodes = ztreeObj.getSelectedNodes();
	if (nodes.length > 0) {
		curNode = nodes[0];
	}
	return curNode;
}

// 清除高亮显示
YyZTreeUtils.setAllNodeDefault = function(zTree) {
	var nodes = zTree.transformToArray(zTree.getNodes());
	var nodeLength = nodes.length;
	for (var i = 0; i < nodeLength; i++) {
		nodes[i].highlight = false;
		zTree.updateNode(nodes[i]);
	}
}
// 根据节点id选中某节点并展开所有上级节点
YyZTreeUtils.selectAndShowNodeById = function(zTree, nodeId) {
	var node = zTree.getNodeByTId(nodeId);
	YyZTreeUtils.selectAndShowNode(zTree, node);
}
// 选中某节点并展开所有上级节点
YyZTreeUtils.selectAndShowNode = function(zTree, node) {
	YyZTreeUtils.expandParent(zTree, node);
	zTree.selectNode(node, false);
}
// 递归zTree展开node的所有上级节点
YyZTreeUtils.expandParent = function(zTree, node) {
	var pNode = node.getParentNode();
	if (pNode != null) {
		zTree.expandNode(pNode, true, false, false);
		YyZTreeUtils.expandParent(zTree, pNode);
	}
}
// 设置高亮样式和普通样式
YyZTreeUtils.getFontCss = function(treeId, treeNode) {
	return (!!treeNode.highlight) ? {
		color : "#A60000",
		"font-weight" : "bold"
	} : {
		color : "#333",
		"font-weight" : "normal"
	};
}
YyZTreeUtils.filter = function(node) {
	return !node.isParent && node.isFirstNode;
}
// 收起树，只显示根节点的下一层节点
YyZTreeUtils.close_ztree = function(treeObj) {
	var nodes = treeObj.transformToArray(treeObj.getNodes());
	var nodeLength = nodes.length;
	for (var i = 0; i < nodeLength; i++) {
		if (nodes[i].id == 'root') {
			// 根节点：展开
			treeObj.expandNode(nodes[i], true, false, false);
		} else {
			// 非根节点：收起
			treeObj.expandNode(nodes[i], false, false, false);
		}
	}
}

/**
 * 搜索树
 * 
 * @param zTree
 * @param value
 *            搜索的关键字 逻辑： 1.清除上次的高亮样式 2.获取匹配的节点 3.收起所有节点，只展示搜索到的节点（包含父节点）
 *            4.刷新树的显示
 */
YyZTreeUtils.searchNode = function(zTree, value) {
	YyZTreeUtils.setAllNodeDefault(zTree);// 清掉上一次的颜色
	if (value != null && value.length > 0) {
		var nodeList = zTree.getNodesByParamFuzzy("name", value);
		if (nodeList != null && nodeList.length > 0) {
			if(typeof($("#"+nodeList[0].tId).offset()) != "undefined"){
				//$("#"+devicesSelect.selectNodeId).offset().top-300
				 $("#leftdiv").animate({scrollTop:$("#"+nodeList[0].tId).offset().top-200},1000);
			}
			YyZTreeUtils.close_ztree(zTree);
			YyZTreeUtils.hightLightShowNodes(zTree, nodeList, true);
		}
		zTree.refresh();// 刷新树的显示
	}
}
/**
 * 高亮显示并展示【指定节点s】
 * 
 * @param treeId
 * @param highlightNodes
 *            需要高亮显示的节点数组
 */
/*
 * function highlightAndExpand_ztree(treeObj, highlightNodes){ //<1>.
 * 先把全部节点更新为普通样式 YyZTreeUtils.setAllNodeDefault(treeObj); //<2>.收起树,
 * 只展开根节点下的一级节点 YyZTreeUtils.close_ztree(treeObj); //<3>.把指定节点的样式更新为高亮显示，并展开
 * YyZTreeUtils.hightLightShowNodes(treeObj,highlightNodes,true); }
 */