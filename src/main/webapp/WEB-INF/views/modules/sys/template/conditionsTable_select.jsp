<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="rootSelectable" value="${param.rootSelectable}" />
<html>
<head>
</head>
<body>
	<div class="container-fluid page-container page-content">
		<div class="yy-toolbar">
			<button id="yy-btn-org-sure" class="btn blue btn-sm">
				<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
		</div>
		<div class="page-area" id="yy-page-area-list">
			<div class="row-fluid">
				<div class="row-fluid" align="center">
					<div class="btn-group btn-group-solid">
						<!-- <button id="yy-expandAll" type="button" class="btn btn-sm blue">
							全展开
						</button>
						<button  id="yy-collapseAll" type="button" class="btn btn-sm green ">
							全折叠
						</button> -->
						<button id="yy-expandSon" type="button" class="btn btn-sm blue">
							展开
						</button>
						<button id="yy-collapseSon" type="button" class="btn btn-sm green ">
							折叠
						</button>
						<button id="yy-treeRefresh" type="button" class="btn btn-sm blue">
							刷新
						</button>
					</div>
				</div>
				<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
					type="text" autocomplete="off" placeholder="查找...">
				</span>
			</div>
			<div id="treeOrg" class="ztree"></div>
		</div>
	</div>

	<script type="text/javascript">
		// _zTree 配置信息
		var _zTree;
		
		
		var _treeSetting = {
				check : {
					enable : false
				},
				async: {
					enable: true,
					url : "${ctx}/sys/template/selectConsTab?coding=${coding}",
					autoParam:["id", "name=n", "level=lv"],
					otherParam:{"otherParam":"zTreeAsyncTest"},
					dataFilter: ajaxDataFilter
				},
				view: {
					dblClickExpand: false,
					showTitle : true,
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
					onDblClick: zTreeOnDblClick,
					onClick : zTreeOnClick,
					onAsyncSuccess : zTreeOnAsyncSuccess
				}
			};
		
		//查询树节点后高亮显示
		function getFontCss(treeId, treeNode) {
			return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
		}
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
		function zTreeOnDblClick(event, treeId, treeNode,num) {
			if (treeNode) {
				var rootSelectable = "${rootSelectable}";
				if (treeNode.id == 'root' && rootSelectable == 'false') {
					YYUI.promMsg('请选择节点！');
					return;
				} else {
					var _method='${tableTree}';
					if(_method){
						//window.parent._method(aData);
			        	eval(_method+"(treeNode)"); 
					}else{
						//window.parent.callBackSelectTable(treeNode,num);
						//edit by liusheng  避免直接双击选择，而不是点击确定按钮
						window.parent.callBackSelectTable(treeNode,"${rowNum}");
					}
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭 
				}
			} else {
				YYUI.promMsg('请选择节点！');
			}
		}
		
		
		// zTree 当前选择的节点
		function getSelectedNodes() {
			return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
		}
		// _zTree 返回数据进行预处理
		function ajaxDataFilter(treeId, parentNode, responseData) {
			if (!responseData) return null;
			for (var i=0, l=responseData.length; i<l; i++) {
				responseData[i].name = responseData[i].name.replace(/\.n/g, '.');
			}
			return responseData;
		}

		function onSearchTree() {
			var searchValue = $('#searchTreeNode').val();
			YyZTreeUtils.searchNode(_zTree,searchValue);
		}

		$(document).ready(function() {
			_zTree = $.fn.zTree.init($("#treeOrg"), _treeSetting);
			//zTree的搜索事件绑定
			$('#searchTreeNode').bind("propertychange", onSearchTree).bind("input", onSearchTree); 
			$('#searchTreeNode').bind('keypress',function(event){
			    if(event.keyCode == "13") {
			   		onSearchTree();
			    }
			});
			$("#yy-btn-org-sure").bind("click", function() {
				zTreeOnDblClick(null, null, getSelectedNodes(),"${rowNum}");
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
					/* YYUI.promMsg("请选择节点");
					return; */
					_zTree.expandAll(true);
				}else{
					_zTree.expandNode(nodes, true, true, true);
				}
			});
			
			$('#yy-collapseSon').bind('click', function() {
				var nodes = getSelectedNodes();
				if (typeof (nodes) == 'undefined') {
					/* YYUI.promMsg("请选择节点");
					return; */
					_zTree.expandAll(false);
				}else{
					_zTree.expandNode(nodes, false, true, true);
				}
			});
			
			$('#yy-treeRefresh').bind('click', function() {
				_zTree.reAsyncChildNodes(null, 'refresh', false);
			});

		});
		
	</script>
</body>
</html>
