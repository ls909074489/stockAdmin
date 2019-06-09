<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	var _selectedId;//选中节点
	var treeWaitLoad;
	var validator;
	//页面形态
	var _isSelected = true;
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

	//界面初始化
	function showData(treeNode) {
		$("input[name='uuid']").val(treeNode.nodeData.uuid);
		//$("input[name='func_type']").val(treeNode.nodeData.func_type);
		$("select[name='func_type']").val(treeNode.nodeData.func_type);
		$("input[name='parentid']").val(treeNode.pid);
		$("input[name='parentname']").val(treeNode.parentname);

		$("input[name='func_code']").val(treeNode.nodeData.func_code);
		$("input[name='func_name']").val(treeNode.nodeData.func_name);
		$("input[name='func_url']").val(treeNode.nodeData.func_url);
		//$("input[name='hint']").val(treeNode.hint);
		$("input[name='help_code']").val(treeNode.help_code);
		//$("input[name='auth_type']").val(treeNode.auth_type);
		//$("input[name='permission_code']").val(treeNode.permission_code);
		$("input[name='iconcls']").val(treeNode.nodeData.iconcls);
		$("input[name='fun_css']").val(treeNode.nodeData.fun_css);
		$("input[name='showorder']").val(treeNode.nodeData.showorder);
		$("textarea[name='description']").val(treeNode.description);
		//$("input:checkbox[name='sys']").attr("checked", treeNode.sys);
		$("select[name='usestatus']").val(treeNode.nodeData.usestatus);
		$("input[name='islast']").val(treeNode.nodeData.islast);
	}

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
		showActionListToolBar();
		//如果是功能节点，加载按钮
		if(treeNode.nodeData.func_type=='func'){
			loadActioList(_selectedId);
		}
	}

	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}

	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		layer.close(treeWaitLoad);//关闭树刷新等待层
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
		/* if (_selectedId) {
			var node = _zTree.getNodeByParam("id", _selectedId);
			// 选中当前操作（新增/修改）后的节点
			var pNode = _zTree.getNodeByParam("id", node.pid);
			_zTree.expandNode(pNode, true);
			_zTree.selectNode(node);
			showData(node);
			_selectedId = null;
		} */
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
	function callBackSelectFunc(funcNode) {
		$("input[name='parentid']").val(funcNode.id);
		$("input[name='parentname']").val(funcNode.name);
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

	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		if (node.nodeData.func_type == 'module'
				|| node.nodeData.func_type == 'sys'
				|| node.nodeData.func_type == 'space')
			pid = node.id;
		else {
			pid = node.pid;
		}
		YYFormUtils.clearForm('yy-form-func');
		if (node.id == 'root') {
			$("select[name='func_type']").val("sys");
		} else if (node.nodeData.func_type == 'sys') {
			$("select[name='func_type']").val("module");
		} else if (node.nodeData.func_type == 'module') {
			$("select[name='func_type']").val("space");
		} else {
			$("select[name='func_type']").val("func");
		}
		$("input[name='func_code']").val(node.nodeData.func_code + "?");
		$("input[name='islast']").val(true);
		$("input[name='parentid']").val(pid);
		$("input[name='parentname']").val(node.name);
		$("select[name='usestatus']").val("1");
		showEditToolBar();
		
		_actionTableList.clear();
		_actionTableList.draw();
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
		var posturl = "${serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-func input[name='uuid']").val();
		if (pk != "") {
			posturl = "${serviceurl}/update";
			isAdd = false;
		}
		if (!$("#yy-form-func").valid())
			return false;
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
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
		$("#yy-form-func").ajaxSubmit(opt);
	}

	//取消
	function onCancel() {
		validator.resetForm();
	    $(".error").removeClass("error");
	    
		var node = getSelectedNodes();
		if (node) {
			showData(node);
		} else {
			YYFormUtils.clearForm('yy-form-func');
		}
		showListToolBar();
		//$('.rap-form .form-control.error').removeClass('error');
		//$('.rap-form span.error').remove();
	}

	//删除
	function onRemove() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		if (!node.nodeData.islast) {
			YYUI.promMsg("不能删除父节点！");
			return;
		}
		if (typeof (node) == 'undefined' || node.level == 0) {
			return;
		}
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh,
				true, true);
	}

	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-func');
	}
	function onSearchTree() {
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree, searchValue);
	}
	//绑定按钮事件
	function bindDefaultActions() {
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		
		$("#yy-btn-enable").bind('click', rowEnabled);//启用
		$("#yy-btn-disenable").bind('click', rowDisabled);//禁用
		
		$("#yy-form-func input[name='func_url']").bind('focus', function() {
			if ($(this).val() == '') {
				$(this).val('@ctx@/');
			}
		});

		//zTree的搜索事件绑定
		$('#searchTreeNode').bind("propertychange", onSearchTree).bind("input",
				onSearchTree);
		$('#searchTreeNode').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				onSearchTree();
			}
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
			}
			_zTree.expandNode(nodes, true, true, true);
		});
		
		//刷新
		$('#yy-treeRefresh').bind('click', function(){
			treeWaitLoad=layer.load(2);
			_zTree.reAsyncChildNodes(null, 'refresh', false);
			YYFormUtils.clearForm('yy-form-edit');
		});
		
		
		$('#yy-collapseSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(false);
			}
			_zTree.expandNode(nodes, false, true, true);
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
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-func');
		
		//验证 表单
		validateForms();
	});
	
	
	 //验证表单
	function validateForms(){
		validator=$('#yy-form-func').validate({
			rules : {
				func_code : {required : true,maxlength:20},
				func_name : {required : true,maxlength:20},
				parentname : {required : true,maxlength:20},
				func_type: {required : true,maxlength:20},
				func_url: {maxlength:100}
			}
		}); 
	}
	 
	 
	function upRecord(url, pks) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要操作的记录");
			return;
		}
		$.ajax({
			"dataType" : "json",
			"type" : "POST",
			"url" : url,
			"data" : {
				"pks" : pks.toString()
			},
			"success" : function(data) {
						YYUI.succMsg("成功", {icon: 1});
						onRefresh();
						//_selectedId = pks;
			},
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.failMsg("失败，HTTP错误。");
			}
		});
	};
	
	//启用
	function rowEnabled(){
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		var pks = node.id;
		if($("#usestatus").val()==1){
			YYUI.promAlert('该功能已启用!');
			return;
		}else{
			upRecord('${serviceurl}/rowEnabled', pks);
		}
	}
	//禁用
	function rowDisabled(){
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		var pks = node.id;
		if($("#usestatus").val()==0){
			YYUI.promAlert('该功能已禁用!');
			return;
		}else{
			upRecord('${serviceurl}/rowDisabled', pks);
		}
	}
</script>
