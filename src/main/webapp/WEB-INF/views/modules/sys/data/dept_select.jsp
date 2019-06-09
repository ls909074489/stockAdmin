<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="rootSelectable" value="${param.rootSelectable}" />
<html>
<head>
<style type="text/css">
.ztree li span.button.iconSkinOrg_ico_open, .ztree li span.button.iconSkinOrg_ico_close{margin-right:2px; background: url(${ctx}/assets/ztree/3.5.19/zTreeStyle/img/diy/org.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.iconSkinDept_ico_open, .ztree li span.button.iconSkinDept_ico_close{margin-right:2px; background: url(${ctx}/assets/ztree/3.5.19/zTreeStyle/img/diy/dept.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.iconSkinOrg_ico_docu{margin-right:2px; background: url(${ctx}/assets/ztree/3.5.19/zTreeStyle/img/diy/org.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
.ztree li span.button.iconSkinDept_ico_docu{margin-right:2px; background: url(${ctx}/assets/ztree/3.5.19/zTreeStyle/img/diy/dept.png) no-repeat scroll 0 0 transparent; vertical-align:top; *vertical-align:middle}
</style>
</head>
<body>
	<div class="container-fluid page-container page-content">
		<div class="yy-toolbar">
			<button id="yy-btn-org-sure" class="btn blue btn-sm">
				<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
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
		<div class="page-area" id="yy-page-area-list">
			<div class="row-fluid">
				<!-- <div class="row-fluid" align="center">
					<div class="btn-group btn-group-solid">
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
				</div> -->
				<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
					type="text" autocomplete="off" placeholder="查找...">
				</span>
			</div>
			<div id="treeDomId" class="ztree"></div>
		</div>
	</div>

	<script type="text/javascript">
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	//页面形态
	var _isSelected = true;

	var _selectedId;//选中节点

	var _treeSetting = {
			check : {
				enable : false
			},
			async: {
				enable: true,
				url : "${ctx}/sys/data/dataDept?pk_corp=${pk_corp}",
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
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
		
		
		
		// _zTree 返回数据进行预处理
		function ajaxDataFilter(treeId, parentNode, responseData) {
			var records = responseData.records;
			return records;
		}

		function onSearchTree(){
			var searchValue = $('#searchTreeNode').val();
			YyZTreeUtils.searchNode(_zTree,searchValue);
		}

		// _zTree 点击触发的事件
		function zTreeOnClick(event, treeId, treeNode) {
			/* if (!_isSelected) {
				YYUI.promMsg("编辑状态，不能操作节点。");
				_zTree.selectNode(_selectedId);
				return false;
			}
 			*/
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
					if(treeNode.type == '1'){
						YYUI.promMsg('请选择部门节点！');
						return;
					}
					var _method='${callBackMethod}';
					if(_method){
						//window.parent._method(aData);
			        	eval(_method+"(treeNode)"); 
					}else{
						window.parent.callBackSelectDept(treeNode);
					}
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭 
					//window.parent.$.colorbox.close();
				}
			} else {
				YYUI.promMsg('请选择节点！');
			}
		}
		
		//成功加载树后
		function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
			var nodes = _zTree.getNodes();
			_zTree.expandNode(nodes[0], true);
		}
		
		
		//当前选择的节点
		function getSelectedNodes() {
			return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
		}


		//刷新
		function onRefresh() {
			_zTree.reAsyncChildNodes(null, 'refresh', false);
			_selectedId = null;
			YYFormUtils.clearForm('yy-form-department');
		}

		
		$(document).ready(function() {
			//加载ztree
			_zTree = $.fn.zTree.init($("#treeDomId"), _treeSetting);
			
			$("#yy-btn-org-sure").bind("click", function() {
				zTreeOnDblClick(null, null, getSelectedNodes());
			});
			
			//折叠/展开
			$('#yy-expandSon').bind('click', function() {
				var nodes = getSelectedNodes();
				if (typeof (nodes) == 'undefined') {
					_zTree.expandAll(true);
					return;
				}
				_zTree.expandNode(nodes, true, true, true);
			});
			
			$('#yy-collapseSon').bind('click', function() {
				var nodes = getSelectedNodes();
				if (typeof (nodes) == 'undefined') {
					_zTree.expandAll(false);
					return;
				}
				_zTree.expandNode(nodes, false, true, true);
			});
			
			$('#yy-treeRefresh').bind('click', function() {
				_zTree.reAsyncChildNodes(null, 'refresh', false);
			});

			//zTree的搜索事件绑定
			$('#searchTreeNode').bind("propertychange", onSearchTree)
				.bind("input", onSearchTree); 
			$('#searchTreeNode').bind('keypress',function(event){
		        if(event.keyCode == "13") {
		        	onSearchTree();
		        }
		    });
			
			$('#yy-def-parentname').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择父节点',
					shadeClose : false,
					shade : 0.8,
					area : [ '300px', '90%' ],
					content : '${serviceurl}/selectDepartment?rootSelectable=true', //iframe的url
				});
			});

		});
	</script>
</body>
</html>
