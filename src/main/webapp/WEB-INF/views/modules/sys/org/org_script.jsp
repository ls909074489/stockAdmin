<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/assets/yy/js/preview_image.js" type="text/javascript"></script>
	
<script type="text/javascript">
	jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
</script>
<script type="text/javascript">
	var _files=new Array();
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	var _selectedId;//选中节点
	//页面形态
	var _isSelected = true;

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

		$("input[name='org_index']").val(treeNode.nodeData.org_index);
		$("input[name='org_code']").val(treeNode.nodeData.org_code);
		$("input[name='org_name']").val(treeNode.nodeData.org_name);

		$("select[name='active']").val(treeNode.nodeData.active);
		$("textarea[name='description']").val(treeNode.nodeData.description);
		$("input[name='status']").val(treeNode.nodeData.status);
		$("input[name='islast']").val(treeNode.nodeData.islast);
		$("select[name='orgtype']").val(treeNode.nodeData.orgtype);
		if(treeNode.nodeData.usergroup!=null){
			$("#usergroupId").val(treeNode.nodeData.usergroup.uuid);
			$("#usergroupName").val(treeNode.nodeData.usergroup.name);
		}else{
			$("#usergroupId").val('');
			$("#usergroupName").val('');
		}

		
		if(treeNode.nodeData.sketchUrl!=null&&treeNode.nodeData.sketchUrl!=''){
			$("#imgHeadPhoto").attr("src","${ctx}/"+treeNode.nodeData.sketchUrl);
		}else{
			$("#imgHeadPhoto").attr("src","");
		}
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



	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}

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
		YYFormUtils.lockForm('yy-form-org');
		_isSelected = true;
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-org');
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
		pid = node.id;
		YYFormUtils.clearForm('yy-form-org');
		 validator.resetForm();
         $(".error").removeClass("error");
		$("input[name='islast']").val(true);
		$("input[name='parentid']").val(pid);
		$("input[name='parentname']").val(node.name);
		$("input[name='status']").val("1");
		$("select[name='active']").val("1");//是否启用
		$("#imgHeadPhoto").attr("src","");
		showEditToolBar();
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
		YYFormUtils.clearForm('yy-form-org');
		 validator.resetForm();
         $(".error").removeClass("error");
		showData(node);
		showEditToolBar();
	}

	//保存
	function onSave() {
		if (!$("#yy-form-org").valid())
			return false;
		
		var editview = layer.load(2);
		
		var posturl = "${serviceurl}/addOrg";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != "undefined") {
			posturl = "${serviceurl}/updateOrg";
		}
		
		var formData = new FormData($('#yy-form-org')[0]);
		//附件
	        $.each(_files, function(i, file) {
            formData.append("attachment[]", file,file.name);
        });
		
        $.ajax( {
        	url : posturl,
			data: formData,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',     
			success : function(data) {
				if (data.success) {
					layer.close(editview);
					onRefresh();
					showListToolBar();
					_selectedId = data.records[0].uuid;
				} else {
					window.parent.YYUI.failMsg("操作失败：" + data.msg);
					layer.close(editview);
				}
			},
			error: function(data){
				window.parent.YYUI.promAlert("操作失败，HTTP错误。");
				layer.close(editview);
			}
		});
	}

	//取消
	function onCancel() {
		var node = getSelectedNodes();
		if (node) {
			showData(node);
		} else {
			YYFormUtils.clearForm('yy-form-org');
		}
		validator.resetForm();
        $(".error").removeClass("error");
		showListToolBar();
		//$('.rap-form .form-control.error').removeClass('error');
		//$('.rap-form span.error').remove();
	}

	//删除
	function onRemove() {
		var node = getSelectedNodes();
		if (!node.nodeData.islast) {
			YYUI.promMsg("不能删除父节点！");
			return;
		}
		if (typeof (node) == 'undefined' || node.level == 0) {
			return;
		}
		YYDataUtils.removeRecord("${serviceurl}/delete", node.id, onRefresh,
				true, true);
		YYFormUtils.clearForm('yy-form-org');
	}

	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-org');
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

		$('#yy-treeRefresh').bind('click', function() {
			_zTree.reAsyncChildNodes(null, 'refresh', false);
		});
		
		$("#yy-btn-findfile").bind('click', onfindfileFile);
		$("#multifile").bind('change', onQueryFile);
		
		$(".pimg").click(function(){
			var _this = $(this);//将当前的pimg元素作为_this传入函数
			imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
		});
	}

	//绑定参照事件
	function bindDefActions() {
		$('#yy-org-select-btn').on('click',function() {
			layer.open({
				type : 2,
				title : '请选择上级机构',
				shadeClose : true,
				shade : 0.8,
				area : [ '80%', '90%' ],
				content : '${pageContext.request.contextPath}/sys/data/selectOrg?rootSelectable=true&callBackMethod=window.parent.callBackSelectOrg', //iframe的url
			});
		});

		$('#yy-def-iconcls').on('click', function() {
			layer.open({
				type : 2,
				title : '选择图标',
				shadeClose : true,
				shade : 0.8,
				area : [ '70%', '90%' ],
				content : '${serviceurl}/selectIcon', //iframe的url
			});
		});
		
		$('#yy-usergroup-select-btn').on('click',function() {
			layer.open({
				type : 2,
				title : '请选择用户组',
				shadeClose : true,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '${pageContext.request.contextPath}/sys/ref/refUserGroup?callBackMethod=window.parent.callBackUsergroup', //iframe的url
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
		//_zTree = $.fn.zTree.init($("#treeOrg"), _treeSetting);

		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-org');
		
		validateForms();
	});
	
	//验证表单
	function validateForms(){
		validator=$('#yy-form-org').validate({
			rules : {
				org_index : {required : true,maxlength:50},
				org_code : {required : true,maxlength:50},
				org_name : {required : true,maxlength:50},
				parentname : {required : true},
				creater:{maxlength:20},
				verifier:{maxlength:20},
				description :{maxlength:200}
			}
		}); 
	}
	
	//选择文件后
	function onQueryFile(){
		var fileName = this.files[0].name;
		var prefix = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
		$("#fileName").val(this.files[0].name);
		_files=new Array();
		_files.push(this.files[0]);
		
		prefix= prefix.toUpperCase();
		if(prefix=='JPG'||prefix=='JPEG'||prefix=='PNG'||prefix=='BMP'){
			//$("#fileName").val(this.files[0].name);
			PreviewImage(this,'imgHeadPhoto','divPreview');
		}else{
			$("#fileSpanId").html('<input type="file" id="multifile" name="attachment"  class="btn" style=""/>');
			$("#multifile").bind('change', onQueryFile);
			YYUI.failMsg("请上传jpg、jpep、png、bmp文件格式的图片");
		}
	}
	
	//点击浏览
	function onfindfileFile(){
		$("#multifile").click();
	}
	
	function showFilePic(){
		var file=_files[0];
		if(file!=null&&typeof(file) != "undefined"){
			//建立一個可存取到該file的url
				var url = null ; 
				try{
					if (window.createObjectURL!=undefined) { // basic
						url = window.createObjectURL(file) ;
					} else if (window.URL!=undefined) { // mozilla(firefox)
						url = window.URL.createObjectURL(file) ;
					} else if (window.webkitURL!=undefined) { // webkit or chrome
						url = window.webkitURL.createObjectURL(file) ;
					}
				} catch(err) {
					url=null;
				}
			if(url){
				layer.open({
					type : 2,//type : 1,
					title : '图片预览',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					//content : '<img width="100%" height="100%" src="'+url+'"  alt="'+data.fileName+'" />' //iframe的url
					content: '${ctx}/frame/attachment/toViewImg?imgurl='+url
				});
			}else{
				YYUI.promAlert("该浏览器不支持未上传图片预览功能");				
			}	
		}else{
			layer.open({
				type : 2,//type : 1,
				title : '图片预览',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content: '${ctx}/frame/attachment/toViewImg?imgurl='+encodeURI(encodeURI($("#imgHeadPhoto").attr("src")))
			});
		}
	}
	
	//回调选择用户组
	function callBackUsergroup(data){
		$("#usergroupId").val(data.uuid);
		$("#usergroupName").val(data.name);
	}
</script>
