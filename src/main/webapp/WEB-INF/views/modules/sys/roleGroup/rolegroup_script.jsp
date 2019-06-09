<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">

	//界面初始化
	function showData(treeNode) {
		$("input[name='uuid']").val(treeNode.nodeData.uuid);
		//$("input[name='func_type']").val(treeNode.nodeData.func_type);
		//$("select[name='func_type']").val(treeNode.nodeData.func_type);
		$("input[name='parentid']").val(treeNode.pid);
		$("input[name='parentname']").val(treeNode.parentname);

		$("input[name='rolegroup_code']").val(treeNode.nodeData.rolegroup_code);
		$("input[name='rolegroup_name']").val(treeNode.nodeData.rolegroup_name);
		//$("input[name='func_url']").val(treeNode.nodeData.func_url);
		//$("input[name='hint']").val(treeNode.hint);
		//$("input[name='help_code']").val(treeNode.help_code);
		//$("input[name='auth_type']").val(treeNode.auth_type);
		//$("input[name='permission_code']").val(treeNode.permission_code);
		$("input[name='iconcls']").val(treeNode.nodeData.iconcls);
		//$("input[name='fun_css']").val(treeNode.nodeData.fun_css);
		//$("input[name='showorder']").val(treeNode.nodeData.showorder);
		$("textarea[name='description']").val(treeNode.nodeData.description);
		//$("input:checkbox[name='sys']").attr("checked", treeNode.sys);
	//$("input[name='status']").val(treeNode.nodeData.status);
		$("input[name='islast']").val(treeNode.nodeData.islast);
		//$("select[name='status']").val(treeNode.status);
	}


	//新增
	function onAdd() {
		var pid;
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		/* if (node.nodeData.func_type == 'module'
				|| node.nodeData.func_type == 'sys'
				|| node.nodeData.func_type == 'space')
			pid = node.id;
		else { */
			pid = node.id;
	//	}
		YYFormUtils.clearForm('yy-form-edit');
		/* if (node.id == 'root') {
			$("select[name='func_type']").val("sys");
		} else if (node.nodeData.func_type == 'sys') {
			$("select[name='func_type']").val("module");
		} else if (node.nodeData.func_type == 'module') {
			$("select[name='func_type']").val("space");
		} else {
			$("select[name='func_type']").val("func");
		} */
		$("input[name='rolegroup_code']").val(node.nodeData.rolegroup_code+"?");
		$("input[name='islast']").val(true);
		$("input[name='parentid']").val(pid);
		//$("input[name='parentname']").val(node.name);
		//$("input[name='status']").val("1");
		//$("select[name='status']").val("1");
		showEditToolBar();
	}

	$(document).ready(function() {
		$('#yy-btn-remove').bind('click', onRemoveRoleGroup);
		
		//验证 表单
		validateForms();
	});
	
	   //验证表单
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				rolegroup_code : {required : true,maxlength:20,minlength:2},
				rolegroup_name : {required : true,maxlength:20,minlength:2}
			}
		}); 
	}
	   
	function onRemoveRoleGroup(){
			//删除
			var node = getSelectedNodes();
			if(!node.nodeData.islast){
				YYUI.promMsg("不能删除父节点！");
				return;
			}
			if (typeof (node) == 'undefined' || node.level == 0) {
				return;
			}
			YYDataUtils.removeRecord("${serviceurl}/delRoleGroup", node.id, onRefresh, true, true);
	}
</script>
