<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var validator;
	var currentNodeId;
	//绑定按钮事件
	function bindDefaultActions() {
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
	}
	

	
	//显示列表的ToolBar
	function showListToolBar() {
		$('#yy-toolbar-edit').addClass("hide");
		$('#yy-toolbar-list').removeClass("hide");
		YYFormUtils.lockForm('yy-form-edit');
		_isSelected = true;
		setEditMode('0');
	}

	//显示编辑的ToolBar
	function showEditToolBar() {
		$('#yy-toolbar-edit').removeClass("hide");
		$('#yy-toolbar-list').addClass("hide");
		YYFormUtils.unlockForm('yy-form-edit');
		_isSelected = false;
		setEditMode('1');
	}


	//修改
	function onEdit() {
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请选择节点");
			return;
		}
		YYFormUtils.clearForm('yy-form-edit');
		showData(node);
		showEditToolBar();
	}
	//设置为编辑状态
	function setEditMode(tVal){
		if(tVal=='1'){
			$("#contentEditDiv").show();
			$("#contentViewDiv").hide();
		}else{
			$("#contentEditDiv").hide();
			$("#contentViewDiv").show();
		}
	}
	//保存
	function onSave() {
		var posturl = "${serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-edit input[name='uuid']").val();
		if (pk != "") {
			posturl = "${serviceurl}/update";
			isAdd = false;
		}
		if (!$("#yy-form-edit").valid())
			return false;
		
		if(hasContent()){
			var opt = {
					url : posturl,
					type : "post",
					success : function(data) {
						if (data.success == true) {
						 	onRefresh();
							showListToolBar();
							_selectedId = data.records[0].funcId;
						} else {
							YYUI.promAlert("保存失败：" + data.msg);
						}
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
		 }else{
			 YYUI.promMsg('请输入内容',1000);
		 }
	}

	//取消
	function onCancel() {
		var node = getSelectedNodes();
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
		 var delId= $("#instructionsUuid").val();
		 if(delId==null||delId==''){//未保存过帮助手册
			 YYUI.promMsg("未保存过帮助手册,不需要删除");
			 return;
		 }else{
			 YYDataUtils.removeRecord("${serviceurl}/delete", delId, onDelRefresh, true, true);
			 currentNodeId=node.id;
			 YYFormUtils.clearForm('yy-form-edit');
		 }
	}

	//刷新
	function onDelRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = currentNodeId;
		YYFormUtils.clearForm('yy-form-edit');
	}
	
	//刷新
	function onRefresh() {
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		_selectedId = null;
		YYFormUtils.clearForm('yy-form-edit');
	}

	//绑定参照事件
	function bindDefActions() {
	}
	
	//界面初始化
	function showData(treeNode) {
		$("input[name='funcId']").val(treeNode.id);
		$("input[name='func_name']").val(treeNode.name);
		UM.getEditor('myEditor').setContent("", false);
		$("#contentViewDiv").html("");
		$("textarea[name='remark']").val("");
		$.ajax({
		       url: '${serviceurl}/findByFuncId',
		       type: 'post',
		       data:{'funcId':treeNode.id},
		       dataType: 'json',
		       error: function(){
		    	  //YYUI.promAlert('片区负责人失败!');
		       },
		       success: function(json){
		    	 if(json!=null){
		    		 $("input[name='uuid']").val(json.uuid);
		    		 $("input[name='title']").val(json.title);
		    		 UM.getEditor('myEditor').setContent(json.content, false);
		    		 $("#contentViewDiv").html(json.content);
		    		 $("textarea[name='remark']").val(json.remark);
		    	 }
		       }
		   });	
	}
	
	
	$(document).ready(function() {
		var yy_layout = $("body").layout({
			applyDefaultStyles : true,
			west : {
				size : 250
			}
		});
		
		//绑定按钮
		bindDefaultActions();
		//绑定参照事件
		bindDefActions();

		YYFormUtils.lockForm('yy-form-edit');
		
		//初始化html编辑器start
		$opt={toolbar:[
		        'undo redo | bold italic underline strikethrough | forecolor backcolor | image |',
		        'insertorderedlist insertunorderedlist ' ,
		        '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize',
		        ' | fullscreen'
		],initialFrameWidth: '100%'};//
		var um = UM.getEditor('myEditor',$opt);
		UM.getEditor('myEditor').setWidth('98%');
		//初始化html编辑器end
		
		//验证 表单
		validateForms();
	});
	
	 //验证表单
	 function validateForms(){
		validator=$('#yy-form-edit').validate({
			rules : {
				title : {required : true,maxlength:50},
				remark: {maxlength:200}
			}
		}); 
	} 
	//加载树成功
	function selfOnAsyncSuccess(event, treeId, treeNode, msg){
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
		if (_selectedId) {
			var node = _zTree.getNodeByParam("id", _selectedId);
			// 选中当前操作（新增/修改）后的节点
			var pNode = _zTree.getNodeByParam("id", node.pId);
			_zTree.expandNode(pNode, true);
			_zTree.selectNode(node);
			showData(node);
			_selectedId = null;
		}
	}
	
	function hasContent() {
        return UM.getEditor('myEditor').hasContents();
 	}
</script>
