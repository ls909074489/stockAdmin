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
				url:"${ctx}/sys/department/getDeptByOrgId?orgId=${orgId}",
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
				//onDblClick: treeClick,
				onAsyncSuccess : zTreeOnAsyncSuccess,
				onClick : treeClick
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

	//界面初始化
	function showTable(treeNode) {
		$("#search_LIKE_name").val("");
		_queryData = $("#yy-form-query").serializeArray();
		var treeDeptWaitLoad=layer.load(2);
		$.ajax({
			type : 'post',
			url : '${serviceurl}/dataPersonByDeptId',//?search_EQ_rolegroup.uuid='+treeNode.id,
			dataType : 'json',
			data : _queryData,
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
				layer.close(treeDeptWaitLoad);
			},
			error: function(data){
				layer.close(treeDeptWaitLoad);
			}
		});
	}

	// _zTree 点击触发的事件
	function treeClick(event, treeId, treeNode) {
		if (!_isSelected) {
			alert("编辑状态，不能操作节点。");
			_zTree.selectNode(_selectedId);
			return false;
		}
		_selectedId = treeNode;
		_zTree.selectNode(treeNode);
		
		if(treeNode.type=='1'){
			//YYUI.promMsg('请点击业务部门',1000);
			$('#yy-btn-add').attr("disabled","disabled");
			//_tableList.clear();
			//_tableList.draw();
			
			$("#search_departmentId").val("");
			$("#search_deptId").val("");
			$("#search_orgId").val(treeNode.id);
			showTable(treeNode);
		}else{
			$("#search_departmentId").val(treeNode.id);
			$("#search_deptId").val(treeNode.id);
			$("#search_orgId").val("");
			
			$('#yy-btn-add').attr("disabled",false);
			showTable(treeNode);
		}
	}

	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
		/* if (_selectedId) {
			var node = _zTree.getNodeByParam("id", _selectedId);
			// 选中当前操作（新增/修改）后的节点
			var pNode = _zTree.getNodeByParam("id", node.pid);
			_zTree.expandNode(pNode, true);
			_zTree.selectNode(node);
			_selectedId = null;
		} */
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
		/* $('#yy-def-parentname').on('click', function() {
			layer.open({
				type : 2,
				title : '请选择父节点',
				shadeClose : false,
				shade : 0.8,
				area : [ '600px', '90%' ],
				content : '${ctx}/sys/department/selectDepartment?rootSelectable=true', //iframe的url
			});
		}); */
		$('#yy-org-select-btn').on('click', function() {
			layer.open({
				type : 2,
				title : '请选择业务单元',
				shadeClose : false,
				shade : 0.8,
				area : [ '800px', '90%' ],
				content : '${pageContext.request.contextPath}/sys/data/selectOrg?rootSelectable=true', //iframe的url
			});
		});
	}
	
	//选择父节点回调函数
	function callBackSelectOrg(node) {
		$("input[name='currentOrgId']").val(node.uuid);
		$("input[name='currentOrgName']").val(node.org_name);
		$("input[name='corp.uuid']").val(node.uuid);
		$("#orgId").val(node.uuid);
		YYFormUtils.clearForm('yy-form-department');
		_treeSetting.async.url = "${ctx}/sys/department/getDeptByOrgId?orgId=" +node.uuid;
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		
		showOrgPerson(node.uuid);//默认显示的人员
	}
	
	$(document).ready(function() {
		var yy_layout = $("body").layout({
			applyDefaultStyles : true,
			west : {
				size : 250
			}
		});
		//加载ztree
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		showOrgPerson('${orgId}');//默认显示的人员
		
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
		
		
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-func');
	});
	
	
	function showOrgPerson(orgId){
		$("#search_departmentId").val("");
		$("#search_deptId").val("");
		$("#search_orgId").val(orgId);
		showTable(null);
	}
</script>
