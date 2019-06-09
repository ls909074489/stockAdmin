<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
var _zTree;//树
//页面形态
var _isSelected = true;

var _selectedId;//选中节点
var validator;

var _treeSetting = {
		check : {
			enable : false
		},
		async: {
			enable: true,
			url:"${serviceurl}/getDeptByOrgId?orgId=${orgId}",//
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
			//onDblClick: zTreeOnClick,
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
	}

	
	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
		if (_selectedId) {
			var node = _zTree.getNodeByParam("id", _selectedId);
			// 选中当前操作（新增/修改）后的节点
			var pNode = _zTree.getNodeByParam("id", nodes.pid);
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

	
	//显示列表的ToolBar
	function showListToolBar() {
		$('#yy-toolbar-edit').addClass("hide");
		$('#yy-toolbar-list').removeClass("hide");
		YYFormUtils.lockForm('yy-form-department');
		_isSelected = true;
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-department');
		_isSelected = false;
	}

	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}else{
			validator.resetForm();
	        $(".error").removeClass("error");
			YYFormUtils.clearForm('yy-form-department');
			if(node.type=='1'){//业务单位
				$("input[name='status']").val("1");
				$("input[name='corp.uuid']").val(node.id);
				$("input[name='parentid']").val(node.id);//设置上级部门或者业务单元
			}else{
				pid = node.id;
				$("input[name='islast']").val(true);
				$("input[name='parentid']").val(pid);
				$("input[name='parentname']").val(node.name);
				$("input[name='status']").val("1");
				/* if(node.type=='1'){//点击单位
					$("input[name='isDirect']").val("1");
					$("input[name='corp.uuid']").val("1");
				}else{
					$("input[name='isDirect']").val("0");
				} */
				$("input[name='corp.uuid']").val(node.nodeData.corp.uuid);
				$("input[name='parentid']").val(node.id);//设置上级部门或者业务单元
			}
		}
		
		showEditToolBar();
	}

	//修改
	function onEdit() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		if(node.type=='1'){
			YYUI.promMsg("业务单位不能编辑");
			return;
		}
		/*if (node.level == 0) {
			YYUI.promMsg("不能修改根节点");
			return;
		} */
		YYFormUtils.clearForm('yy-form-department');
		 validator.resetForm();
         $(".error").removeClass("error");
		showData(node);
		showEditToolBar();
	}

	//保存
	function onSave() {
		var posturl = "${serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-department input[name='uuid']").val();
		if (pk != "") {
			posturl = "${serviceurl}/update";
			isAdd = false;
		}
		if (!$("#yy-form-department").valid())
			return false;
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success == true) {
				 	onRefresh();
					showListToolBar();
					_selectedId = data.records[0].uuid;
				} else {
					//YYUI.failMsg("保存失败：" + data.msg);
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-department").ajaxSubmit(opt);
	}

	//取消
	function onCancel() {
		var node = getSelectedNodes();
		 validator.resetForm();
         $(".error").removeClass("error");
		if (node) {
			showData(node);
		} else {
			YYFormUtils.clearForm('yy-form-department');
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
		if(node.type=='1'){
			YYUI.promMsg("不能删除业务单元！");
			return;
		}
		if(!node.nodeData.islast){
			YYUI.promMsg("不能删除父节点！");
			return;
		}
/* 		if (typeof (node) == 'undefined' || node.level == 0) {
			return;
		} */
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh, true, true);
		YYFormUtils.clearForm('yy-form-department');
	}

	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-department');
	}

	//绑定参照事件
	function bindDefActions() {
		$('#yy-def-parentname').on('click', function() {
			layer.open({
				type : 2,
				title : '请选择业务单元',
				shadeClose : false,
				shade : 0.8,
				area : [ '800px', '90%' ],
				//content : '${serviceurl}/selectDepartment?rootSelectable=true', //iframe的url
				content : '${pageContext.request.contextPath}/sys/data/selectOrg?rootSelectable=true'//iframe的url		
			});
		});
	}
	//选择父节点回调函数
	function callBackSelectOrg(node) {
		$("input[name='currentOrgId']").val(node.uuid);
		$("input[name='currentOrgName']").val(node.org_name);
		$("#orgId").val(node.uuid);
		YYFormUtils.clearForm('yy-form-department');
		_treeSetting.async.url = "${serviceurl}/getDeptByOrgId?orgId=" +node.uuid;
		_zTree = $.fn.zTree.init($("#treeDepartment"), _treeSetting);
	}
	
	//界面初始化
	function showData(treeNode) {
		if(treeNode!=null){
			if(treeNode.type=='1'){//点击单位
				$('#yy-btn-edit').attr("disabled","disabled");
				$('#yy-btn-remove').attr("disabled","disabled");
			}else{
				$('#yy-btn-edit').attr("disabled",false);
				$('#yy-btn-remove').attr("disabled",false);
				$("input[name='uuid']").val(treeNode.nodeData.uuid);
				$("input[name='parentid']").val(treeNode.nodeData.parentid);
				$("input[name='parentname']").val(treeNode.parentname);
				$("input[name='code']").val(treeNode.nodeData.code);
				$("input[name='name']").val(treeNode.nodeData.name);
				$("input[name='creater']").val(treeNode.nodeData.creater);
				$("input[name='createdDate']").val(treeNode.nodeData.createdDate);
				$("input[name='verifier']").val(treeNode.nodeData.verifier);
				$("input[name='verifiedDate']").val(treeNode.nodeData.verifiedDate);
				$("select[name='active']").val(treeNode.nodeData.active);
				$("input[name='status']").val(treeNode.nodeData.status);
				$("input[name='islast']").val(treeNode.nodeData.islast);
				$("textarea[name='memo']").val(treeNode.nodeData.memo);
				$("input[name='corp.uuid']").val(treeNode.nodeData.corp.uuid);
				
				$("input[name='creatorname']").val(treeNode.nodeData.creatorname);
				$("input[name='createtime']").val(treeNode.nodeData.createtime);
				$("input[name='modifiername']").val(treeNode.nodeData.modifiername);
				$("input[name='modifytime']").val(treeNode.nodeData.modifytime);
			}
		}else{
			YYFormUtils.clearForm('yy-form-department');
		}
	}
	
	
	$(document).ready(function() {
		var yy_layout = $("body").layout({
			applyDefaultStyles : true,
			west : {
				size : 250
			}
		});
		//加载ztree
		_zTree = $.fn.zTree.init($("#treeDepartment"), _treeSetting);
		
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
		
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-department');
		
		//验证 表单
		validateForms();
	});
	
	
	  //验证表单
	function validateForms(){
		   validator=$('#yy-form-department').validate({
			rules : {
				code : {required : true,maxlength:20,minlength:2},
				name : {required : true,maxlength:20,minlength:2},
				memo: {maxlength:200}
			}
		}); 
	}
	  
	function disableRef(){
		//$(".btn.btn-default.btn-ref").attr("disabled","disabled")// 参考弹出框不可选 add by liusheng
	}
</script>
