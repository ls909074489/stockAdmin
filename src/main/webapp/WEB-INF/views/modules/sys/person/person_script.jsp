<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _raplayout,_queryData;
	var _tableListAssUser,_tableListAssUserView;//角色下的用户列表
	var _pageType="edit";
	var validator;
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		//visible : false,
		width : "20",
		render : YYDataTableUtils.renderCheckCol
	},{
		data : "uuid",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderActionCol(data,type,row,meta);
         },
		width : "80"
	},{
		data : "relation_user",
		className : "left",
		orderable : false,
		"render": function (data,type,row,meta ) {
			if(data!=null){
				return data.loginname;
			}else{
				return '';
			}
         },
		width : "12%"
	}, {
		data : 'name',
		width : "12%",
		className : "left",
		orderable : false
	}, {
		data : 'job_number',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'mobile_phone',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'email',
		width : "20%",
		className : "left",
		orderable : false
	}];

	function onRefresh() {
		loadList();
	}
	
	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				$('#global_regex').prop('checked'),
				$('#global_smart').prop('checked')).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}
	
	 $(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : renderRowAction,
				//"dom" : '<"top">rt<"bottom"iflp><"clear">',
				"order": [] 
			});
			
			$('input.global_filter').on('keyup click', function() {
				filterGlobal();
			});
			$('input.column_filter').on('keyup click', function() {
				filterColumn($(this).parents('div').attr('data-column'));
			});
			
			//设置布局
			_raplayout=setBodyLayout();
			
			//加载数据
			
			$("#yy-btn-add").bind('click', onAdd);//新增
			$("#yy-btn-refresh").bind('click', onRefresh);//刷新
			
			$('#yy-btn-remove').bind('click', onRemove);//删除
			
			//$("#yy-btn-edit").bind('click', onEditDetail);//编辑
			
			$("#yy-btn-save").bind("click", function() {//点击保存角色按钮
				onSave(true);
			});
			$("#yy-btn-search").bind('click', onQuery);//查询
			$('#yy-btn-cancel').bind('click', onCancel);//编辑页面返回
			
			$('#yy-btn-backtolist').bind('click', onCancel);//查看页面返回
			
			
			
			$('#yy-relation-user').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择系统账号',
					shadeClose : false,
					shade : 0.8,
					area : [ '800px', '90%' ],
					content : '${serviceurl}/selectUser', //iframe的url
				});
			});
			
			
			//验证 表单
			validateForms();
		});
	 
	 function disableRef(){
		//$(".btn.btn-default.btn-ref").attr("disabled","disabled")// 参考弹出框不可选 add by liusheng
	 }
	 
	 //选择用户后
	 function callBackSelectUser(data){
		 $("#relation_user_id").val(data.uuid);
		 $("#relation_user_loginname").val(data.loginname);
	 }
	 
	 //定义行点击事件
	function renderRowAction(nRow, aData, iDataIndex) {
		$(nRow).dblclick(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-view-row', nRow).click(function() {
			_pageType="view";
			onViewDetailRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-edit-row', nRow).click(function() {
			_pageType="edit";
			onEditRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-remove-row', nRow).click(function() {
			removeRecord('${serviceurl}/delete', [ aData.uuid ], function() {
				_tableList.row(nRow).remove().draw(false);
			});
		});

		$('#yy-btn-grant-row', nRow).click(function() {
			if(aData.relation_user!=null&&aData.relation_user.uuid!=null){
				YYUI.promAlert('该人员已关联用户!');
			}else{
				layer.confirm('是否创建用户(将根据邮箱的前缀作为登录帐号)？', function() {
					$.ajax({
					       url: '${serviceurl}/relationUser',
					       type: 'post',
					       data:{'personId':aData.uuid},
					       dataType: 'json',
					       error: function(){
					    	   YYUI.promAlert('创建用户失败！');
					       },
					       success: function(json){
					    	   if(json.success){
					    		   YYUI.succMsg('创建用户成功！');
					    		   onRefresh();
					    	   }else{
					    		   YYUI.promAlert(json.msg);
					    	   }
					       }
					   });
				});
			}
		});
		//取消关联用户
		$('#yy-btn-cancelUser-row', nRow).click(function() {
			if(aData.relation_user==null||aData.relation_user.uuid==null){
				YYUI.promAlert('该人员未关联用户!');
			}else{
				layer.confirm('确定要取消关联用户吗？', function() {
					$.ajax({
					       url: '${serviceurl}/cancelUser',
					       type: 'post',
					       data:{'personId':aData.uuid},
					       dataType: 'json',
					       error: function(){
					    	   YYUI.promAlert('取消关联用户失败！');
					       },
					       success: function(json){
					    	   if(json.success){
					    		   YYUI.succMsg('取消关联用户成功！');
					    		   onRefresh();
					    	   }else{
					    		   YYUI.promAlert(json.msg);
					    	   }
					       }
					   });
				});
			}
		});
		
	};
	 
	 //显示自定义的行按钮
	  function renderActionCol(data, type, full) {
			var actionStr="";
			actionStr+="<div class='yy-btn-actiongroup'>"; 
			if(full.relation_user!=null&&full.relation_user.uuid!=null){
				actionStr+= "<button id='yy-btn-cancelUser-row' class='btn btn-xs btn-success red' data-rel='tooltip' title='取消关联用户'><i class='fa fa-group'></i></button>";
			}else{
				actionStr+= "<button id='yy-btn-grant-row' class='btn btn-xs btn-success' data-rel='tooltip' title='创建用户（将根据邮箱的前缀作为登录帐号）'><i class='fa fa-group'></i></button>";
			}
			actionStr+="<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				//+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
				+ "</div>";
			return actionStr;
		}
		
	 function renderPostCol(data, type, full) {
		 if(data!=null&&data.name!=null){
			 return data.name;
		 }
		return "";
	 }
	 //点击添加
	 function onAdd(){
		 var treeId = getSelectedTreeId();
			if (treeId==null||treeId == "") {
				layer.alert("请选择部门");
				return false;
			}
			validator.resetForm();
	        $(".error").removeClass("error");
			YYFormUtils.clearForm('yy-form-edit');
			$("input[name='department.uuid']").val(treeId);
			$("input[name='corp.uuid']").val($("#currentOrgId").val());
			YYUI.setEditMode();
			_raplayout.hide("west");
			
			$("select[name='job_status']").val('01');//在职状态默认 在职
	 }
	 
	 
	//取消编辑，返回列表视图
	function onCancel() {
		YYUI.setListMode();
		_raplayout.show("west");
		onRefresh();
	}
	 
	// zTree 当前选择的节点
	function getSelectedTreeId() {
		var treeId;
		var nodes = _zTree.getSelectedNodes();
		if (nodes.length > 0) {
			treeId = nodes[0].id;
		}
		return treeId;
	}
	
	//保存，isClose 是否保存后关闭视图，否为继续增加状态
	function onSave(isClose) {
		var flag = true;
		 if (!$('#yy-form-edit').valid())
			flag = false; 
		/* if(!checkRepeat($('#rap-form-edit input[name="roleCode"]'))){
			flag = false;
		} */
		if(flag==false){
			return false;
		}
		var posturl = "${serviceurl}/add";
		var pk = $("input[name='uuid']").val();
		
		var waitLoad=layer.load(2);
		
		if (pk != "" && typeof (pk) != "undefined")
			posturl = "${serviceurl}/update";
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				layer.close(waitLoad);
				if (data.success) {
					onRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
					//doAfterSaveSuccess(data);
				} else {
					YYUI.promAlert("保存出现错误："+data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	
	// _tableList: 表格对象， roleGroupId: 当前用户组ID
	function loadList() {
		_queryData= $("#yy-form-query").serializeArray();
		$.ajax({
			type : 'post',
			url : '${serviceurl}/dataPersonByDeptId',
			dataType : 'json',
			data : _queryData,
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
			}
		});
	}
	
	 function showData(data) {
		 
			$("input[name='uuid']").val(data.uuid);//
			$("input[name='department.uuid']").val(data.department.uuid);
			$("input[name='corp.uuid']").val(data.corp.uuid);
			if(data.relation_user!=null){
				$("input[name='relation_user.uuid']").val(data.relation_user.uuid);
			}
			//$("input[name='relation_user.uuid']").val(data.relation_user.uuid);
			//$("input[name='relation_user_loginname']").val(data.relation_user.loginname);
			
			$("input[name='name']").val(data.name);		
			$("input[name='job_number']").val(data.job_number);	
			$("select[name='sex']").val(data.sex);
			$("input[name='birth_date']").val(data.birth_date);	
			$("select[name='education']").val(data.education);
			$("input[name='entry_date']").val(data.entry_date);	
			$("input[name='departure_date']").val(data.departure_date);	
			if(data.post!=null&&data.post.name!=null){
				$("select[name='post.uuid']").val(data.post.uuid);	
			}
			$("input[name='wechat']").val(data.wechat);	
			$("input[name='mobile_phone']").val(data.mobile_phone);	
			$("input[name='email']").val(data.email);	
			$("input[name='work_years']").val(data.work_years);	
			$("select[name='is_train']").val(data.is_train);	
			$("select[name='is_supervise']").val(data.is_supervise);	
			$("select[name='job_status']").val(data.job_status);
			$("input[name='k3code']").val(data.k3code);
			$("input[name='k3name']").val(data.k3name);
			$("input[name='experience']").val(data.experience);
			$("textarea[name='memo']").val(data.memo);
	}
	
	 
	 function onQuery(){
		 var deptId = $("#search_departmentId").val();
			if(deptId==null||deptId.length==0){
				layer.alert("请选择部门");
				return false;
			}
			//获取查询数据，在表格刷新的时候自动提交到后台
			_queryData = $("#yy-form-query").serializeArray();
			loadList();
	 }
	 
	 //点击编辑按钮
	function onEditRow(aData, iDataIndex, nRow) {
		validator.resetForm();
        $(".error").removeClass("error");
		YYFormUtils.clearForm('yy-form-edit');
		showData(aData);
		YYUI.setEditMode();
	}
	 
	//点击查看按钮
	function onViewDetailRow(data, rowidx) {
		YYFormUtils.clearForm('yy-form-detail');
		showData(data);
		YYUI.setDetailMode();
	}

	 //验证表单
	function validateForms(){
		validator=$('#yy-form-edit').validate({
			rules : {
				name : {required : true,maxlength:10,minlength:2},
				job_number: {maxlength:36},
				email:{maxlength:50,required : true,email:true},
				wechat: {maxlength:30},
				mobile_phone:{isTel:true},
				work_years: {maxlength:10},
				//'post.uuid' :{required : true},
				experience: {maxlength:200},
				memo: {maxlength:200}
			}
		}); 
	}

</script>
