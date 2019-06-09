<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/func" />
<c:set var="rootSelectable" value="${param.rootSelectable}" />
<html>
<head>
</head>
<body>
	<div class="container-fluid page-container page-content">
		<div class="yy-toolbar">
			<button id="yy-btn-func-sure" class="btn blue btn-sm">
				<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
		</div>
		<div class="page-area" id="yy-page-area-list">
			<div class="row-fluid">
				<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
					type="text" autocomplete="off" placeholder="查找...">
				</span>
			</div>
			<div id="treeFunc" class="ztree"></div>
		</div>
	</div>

	<script type="text/javascript">
		// _zTree 配置信息
		var _zTree, roleId;

		var _treeSetting = {
			check : {
				enable : false
			},
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
				fontCss : YyZTreeUtils.getFontCss
			},
			async : {
				enable : true,
				url : "${serviceurl}/getTreeNodes",
				dataFilter : ajaxDataFilter
			},
			callback : {
				onClick : zTreeOnClick,
				//onDblClick : zTreeOnDblClick,
				onAsyncSuccess : zTreeOnAsyncSuccess
			}
		};
		//成功加载树后
		function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			var nodes = _zTree.getNodes();
			_zTree.expandNode(nodes[0], true);
		}
		// _zTree 点击触发的事件
		function zTreeOnClick(event, treeId, treeNode) {
			if (treeId == "root")
				return false;
			_zTree.selectNode(treeNode);
		}
		//双击事件
		function zTreeOnDblClick(event, treeId, treeNode) {
			if (treeNode) {
				var rootSelectable = "${rootSelectable}";
				if (treeNode.id == 'root' && rootSelectable == 'false') {
					YYUI.promMsg('请选择节点！');
					return;
				} else {
					window.parent.callBackSelectFunc(treeNode);
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭 
					//window.parent.$.colorbox.close();
				}
			} else {
				YYUI.promMsg('请选择节点！');
			}
		}
		// zTree 当前选择的节点
		function getSelectedNodes() {
			return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
			//return _rapui.getZtreeSelectedNodes(_zTree);
		}
		// _zTree 返回数据进行预处理
		function ajaxDataFilter(treeId, parentNode, responseData) {
			var records = responseData.records;
			return records;
		}

		function onSearchTree() {
			var searchValue = $('#searchTreeNode').val();
			//RapZTreeUtils.searchNode(_zTree, searchValue);
		}

		$(document).ready(function() {
			_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
			//zTree的搜索事件绑定
			//$('#searchTreeNode').bind("propertychange", onSearchTree)
			//.bind("input", onSearchTree); 
			//$('#searchTreeNode').bind('keypress',function(event){
			//    if(event.keyCode == "13") {
			//   	onSearchTree();
			//    }
			//});
			$("#yy-btn-func-sure").bind("click", function() {
				zTreeOnDblClick(null, null, getSelectedNodes());
			});
		});
	</script>
</body>
</html>
