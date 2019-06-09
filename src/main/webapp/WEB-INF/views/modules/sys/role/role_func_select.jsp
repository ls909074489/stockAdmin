<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/role" />
<c:set var="rootSelectable" value="${param.rootSelectable}" />
<c:set var="roleId" value="${param.roleId}" />
<html>
<head>
</head>
<body>
	<div class="container-fluid page-container page-content" style="height: 400px;">
		<div class="yy-toolbar">
			<button id="yy-btn-func-sure" class="btn blue btn-sm">
				<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
		</div>
		<div class="page-area" id="yy-page-area-list">
			<!-- <div class="row-fluid">
				<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
					type="text" autocomplete="off" placeholder="查找...">
				</span>
			</div> -->
			<div class="row-fluid">
				<div style="text-align: center;">
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
				</div>
				<span class="span12"> <input name="searchTreeNode"
					id="searchTreeNode" class="search-query form-control" type="text"
					autocomplete="off" placeholder="查找...">
				</span>
			</div>
			<div id="treeFunc" class="ztree"></div>
		</div>
	</div>

	<script type="text/javascript">
		// _zTree 配置信息
		var _zTree, roleId;

		/* var _treeSetting = {
			check : {
				enable : true
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
		}; */
		var _treeSetting = {
				check : {
					enable : true
				},
				async: {
					enable: true,
					url:"${serviceurl}/getRoleFuncs?roleId=${roleId}",
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
					//onDblClick: onDblClickTree
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
			YyZTreeUtils.searchNode(_zTree,searchValue);
		}

		//绑定按钮事件
	 	function bindButtonActions() {
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
		$(document).ready(function() {
			_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
			
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

			//按钮绑定事件
			bindButtonActions();
			
			$("#yy-btn-func-sure").bind("click", function() {
				var _checkNodes=_zTree.getCheckedNodes();
				/* if (_checkNodes&&_checkNodes.length>0) { */
					var nodes = new Array();
				     for(i = 0; i < _checkNodes.length; i++) {
				          nodes[i] = _checkNodes[i].id;
				     }
				    var checkedIds=nodes.join(",");
				    var saveWaitLoad=layer.load(2);
					$.ajax({
					       url: '${ctx}/sys/role/save_permission',
					       type: 'post',
					       data:{roleId:"${roleId}",checkedIds:checkedIds},
					       dataType: 'json',
					       error: function(){
					    	   layer.close(saveWaitLoad);
					    	   //YYUI.failMsg("保存失败!");
					    	   YYUI.promAlert("保存失败：");
					       },
					       success: function(json){
					    	  layer.close(saveWaitLoad);
					    	 //window.parent.callBackSelectFunc(treeNode);
					    	 window.parent.callBackRoleFunc();
							 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							 parent.layer.close(index); //再执行关闭 
							 //window.parent.$.colorbox.close();
					       }
					   });
				/* }else {
					YYUI.promMsg('请选择节点！');
				} */
			});
		});
	</script>
</body>
</html>
