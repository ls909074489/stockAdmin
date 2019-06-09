<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	//var _zTree;//树
	var _changeParent;//是否变更了父节点
	//var _selectedId;//选中节点
	var validator;
	var treeWaitLoad;//树加载等待层
	//页面形态
	var _isSelected = true;
	/* var _treeSetting = {
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
			url : "${ctx}/sys/data/dataOrg",
			autoParam : [ "uuid=node" ],
			dataFilter : ajaxDataFilter
		},
		callback : {
			onClick : selfOnClick,
			onAsyncSuccess : zTreeOnAsyncSuccess
		}
	}; */

	//界面初始化
	function showData(treeNode) {
		$("input[name='uuid']").val(treeNode.nodeData.uuid);
		
		var parentNode = getSelectedNodes().getParentNode();
		
		//$("input[name='parentid']").val(treeNode.pid);
		//$("input[name='parentname']").val(treeNode.parentname);
		if(parentNode!=null){
			$("input[name='parentid']").val(parentNode.id);
			$("input[name='parentname']").val(parentNode.name);
		}

		

		$("input[name='org_code']").val(treeNode.nodeData.org_code);
		$("input[name='org_name']").val(treeNode.nodeData.org_name);
		$("input[name='creater']").val(treeNode.nodeData.creater);
		$("input[name='createdDate']").val(treeNode.nodeData.createdDate);
		$("input[name='verifier']").val(treeNode.nodeData.verifier);
		$("input[name='verifiedDate']").val(treeNode.nodeData.verifiedDate);
		$("select[name='active']").val(treeNode.nodeData.active);

		$("select[name='isCloudStock']").val(treeNode.nodeData.isCloudStock);
		$("select[name='isCenterStock']").val(treeNode.nodeData.isCenterStock);
		$("select[name='isCheckStock']").val(treeNode.nodeData.isCheckStock);
		$("select[name='isRepair']").val(treeNode.nodeData.isRepair);
		$("select[name='isOutlets']").val(treeNode.nodeData.isOutlets);
		$("textarea[name='description']").val(treeNode.nodeData.description);
		$("input[name='status']").val(treeNode.nodeData.status);
		$("input[name='islast']").val(treeNode.nodeData.islast);
		
		if(typeof (treeNode.nodeData.has_stock) != 'undefined'&&treeNode.nodeData.has_stock=='1'){//是否初始仓库
			$("#yy-btn-createStock").attr('disabled',"true");
		}else{
			$("#yy-btn-createStock").removeAttr("disabled");
		}
		
		$("input[name='creatorname']").val(treeNode.nodeData.creatorname);
		$("input[name='createtime']").val(treeNode.nodeData.createtime);
		$("input[name='modifiername']").val(treeNode.nodeData.modifiername);
		$("input[name='modifytime']").val(treeNode.nodeData.modifytime);
	}

	// _zTree 点击触发的事件
	function selfOnClick(event, treeId, treeNode) {
		if (!_isSelected) {
			YYUI.promMsg("编辑状态，不能操作节点。");
			_zTree.selectNode(_selectedId);
			return false;
		}
		_selectedId = treeNode;
		_zTree.selectNode(treeNode);
		showData(treeNode);
	}
	
	//成功加载树后
	function selfOnAsyncSuccess(event, treeId, treeNode, msg) {
		layer.close(treeWaitLoad);//关闭树刷新等待层
		
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
		if (_selectedId) {
			var node = _zTree.getNodeByParam("id", _selectedId.id);
			if (node && node != null) {
				// 选中当前操作（新增/修改）后的节点
				var pNode = _zTree.getNodeByParam("id", node.pid);
				_zTree.expandNode(pNode, true);
				_zTree.selectNode(node);
				showData(node);
				_selectedId = null;
			}
		}
	}

	// _zTree 返回数据进行预处理
	/* function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}


	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	} */

	//选择父节点回调函数
	function callBackSelectOrg(funcNode) {
		$("input[name='parentid']").val(funcNode.uuid);
		$("input[name='parentname']").val(funcNode.org_name);
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

	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		//if (node.nodeData.func_type == 'module'
		//		|| node.nodeData.func_type == 'sys'
		//		|| node.nodeData.func_type == 'space')
		pid = node.id;
		//else {
		//	pid = node.pid;
		//}
		YYFormUtils.clearForm('yy-form-edit');
		 validator.resetForm();
         $(".error").removeClass("error");
		//if (node.id == 'root') {
		//	$("select[name='func_type']").val("sys");
		//} else if (node.nodeData.func_type == 'sys') {
		//	$("select[name='func_type']").val("module");
		//} else if (node.nodeData.func_type == 'module') {
		//	$("select[name='func_type']").val("space");
		//} else {
		//	$("select[name='func_type']").val("func");
		//}
		$("input[name='islast']").val(true);
		$("input[name='parentid']").val(pid);
		$("input[name='parentname']").val(node.name);
		$("input[name='status']").val("1");
		$("select[name='active']").val("1");//是否启用
		showEditToolBar();
		initDataFromParent(node);//从上级初始化
	}
	//从上级节点初始化数据
	function initDataFromParent(node){
		if(node.nodeData.isCloudStock!=null&&node.nodeData.isCloudStock!='null'){
			$("select[name='isCloudStock']").val(node.nodeData.isCloudStock);//是否云分仓
		}
		if(node.nodeData.isCenterStock!=null&&node.nodeData.isCenterStock!='null'){
			$("select[name='isCenterStock']").val(node.nodeData.isCenterStock);//是否备件中心
		}
		if(node.nodeData.isCheckStock!=null&&node.nodeData.isCheckStock!='null'){
			$("select[name='isCheckStock']").val(node.nodeData.isCheckStock);//是否检测中心
		}
		if(node.nodeData.isRepair!=null&&node.nodeData.isRepair!='null'){
			$("select[name='isRepair']").val(node.nodeData.isRepair);//是否高维工厂
		}
		if(node.nodeData.isOutlets!=null&&node.nodeData.isOutlets!='null'){
			$("select[name='isOutlets']").val(node.nodeData.isOutlets);//是否网点机构
		}
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
		YYFormUtils.clearForm('yy-form-edit');
		 validator.resetForm();
         $(".error").removeClass("error");
		showData(node);
		showEditToolBar();
		
		$("#input[name='active']").attr('disabled',"true");
	}

	//保存
	function onSave() {
		if (!$('#yy-form-edit').valid()) return false;
		
		var posturl = "${serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-edit input[name='uuid']").val();
		if (pk != "") {
			posturl = "${serviceurl}/update";
			isAdd = false;
		}
		var waitLoad=layer.load(2);
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success == true) {
					layer.close(waitLoad);
					onRefresh();
					showListToolBar();
					//_selectedId = data.records[0].uuid;
					_selectedId={id:data.records[0].uuid,pId:data.records[0].parentid};
				} else {
					layer.close(waitLoad);
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

	//取消
	function onCancel() {
		var node = getSelectedNodes();
		validator.resetForm();
        $(".error").removeClass("error");
		if (node) {
			showData(node);
		} else {
			YYFormUtils.clearForm('yy-form-edit');
		}
		showListToolBar();
	}

	//删除
	function onRemove() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
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
		//YYFormUtils.clearForm('yy-form-edit');
	}

	//刷新
	function onRefresh() {
		/* _zTree.reAsyncChildNodes(null, 'refresh', false);
		//_selectedId = null;
		YYFormUtils.clearForm('yy-form-edit'); */
		
		YYFormUtils.clearForm('yy-form-edit');
		treeRefresh();
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
		//$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		$('#yy-btn-createStock').bind('click', createStock);//初始仓库
		
		$("#yy-form-func input[name='func_url']").bind('focus', function() {
			if ($(this).val() == '') {
				$(this).val('@ctx@/');
			}
		});

		
		//zTree的搜索事件绑定
/* 		$('#searchTreeNode').bind("propertychange", onSearchTree).bind("input",
				onSearchTree); */
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

		$('#yy-collapseSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(false);
			}
			_zTree.expandNode(nodes, false, true, true);
		});


		/* $('#yy-treeRefresh').bind('click', function() {
			_zTree.reAsyncChildNodes(null, 'refresh', false);
		}); */
	}

	//绑定参照事件
	function bindDefActions() {
		$('#yy-org-select-btn')
				.on(
						'click',
						function() {
							layer
									.open({
										type : 2,
										title : '请选择上级机构',
										shadeClose : false,
										shade : 0.8,
										area : [ '800px', '90%' ],
										content : '${pageContext.request.contextPath}/sys/data/selectOrg?rootSelectable=true', //iframe的url
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
		///_zTree = $.fn.zTree.init($("#treeOrg"), _treeSetting);
		treeWaitLoad=layer.load(2);
		
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-edit');
		
		validateForms();
	});
	
	//验证表单
	function validateForms(){
		validator=$('#yy-form-edit').validate({
			rules : {
				org_code : {required : true,maxlength:50},
				org_name : {required : true,maxlength:50},
				parentname : {required : true},
				creater:{maxlength:20},
				verifier:{maxlength:20},
				description :{maxlength:200}
			}
		}); 
	}
	
	//检测云分仓
	function checkClound(seleVal){
		if($("select[name='isCenterStock']").val()=='1'&&$(seleVal).val()=='1'){
			$("select[name='isCloudStock']").val(0);
			YYUI.promAlert('不能同时为云分仓和备件中心!');
		}
	}
	//检查备件中心
	function checkCenter(seleVal){
		if($("select[name='isCloudStock']").val()=='1'&&$(seleVal).val()=='1'){
			$("select[name='isCenterStock']").val(0);
			YYUI.promAlert('不能同时为云分仓和备件中心!');
		}
	}
	
	//初始仓库
	function createStock(){
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		
		if(typeof (node.nodeData.has_stock) != 'undefined'&&node.nodeData.has_stock=='1'){
			YYUI.promMsg("已初始仓库");
			return;
		}else{
			layer.confirm('确实要初始仓库吗？', function() {
				var waitLoadStock=layer.load(2);
				$.ajax({
				       url: '${ctx}/sys/outlets/createStock',
				       type: 'post',
				       data:{'pkCorp':node.id},
				       dataType: 'json',
				       error: function(){
				    	   layer.close(waitLoadStock);
				    	  YYUI.promAlert('初始仓库失败!');
				       },
				       success: function(json){
				    	  if(json.success){
				    		  layer.close(waitLoadStock);
				    		  YYUI.succMsg('初始仓库成功!');
				    		  _selectedId = node;
				    		  onRefresh();
					   		  $("#yy-btn-createStock").attr('disabled',"true");
				    	  }else{
				    		  YYUI.promAlert(json.msg);
				    	  }
				       }
				});
			});
		}
	}
</script>
