<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _raplayout,_queryData,_roleFuncTree,_roleFuncTreeView;
	var _tableListAssUser,_tableListAssUserView;//角色下的用户列表
	var _pageType="edit";
	var validator; 
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/*visible : false, */
		width : "20",
		render : YYDataTableUtils.renderCheckCol
	},{
		data : "uuid",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderRoleActionCol(data,type,row,meta);
         },
		width : "120"
	}, {
		data : 'code',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'name',
		width : "25%",
		className : "center",
		orderable : false
	}, {
		data : 'description',
		width : "40%",
		className : "center",
		orderable : false
	}];

	//角色下的用户列表表头 编辑
	var _tableColsAssUser = [{
		data : "uuid",
		className : "center",
		orderable : false,
		render : function(data, type, full) {
					return "<div class='btn-group rap-btn-actiongroup'>"  + 
							"<button id='rap-btn-remove-row-edit' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>" + "</div>";
				  },
		width : "5"
	},{
		data : 'loginname',
		width : "10%",
		orderable : true
	},{
		data : 'jobnumber',
		width : "25%",
		orderable : true
	}, {
		data : 'username',
		width : "10%",
		orderable : true
	}, {
		data : 'orgname',
		width : "20%",
		orderable : true
	}, {
		data : 'last_ip',
		width : "15%",
		orderable : true
	}, {
		data : 'last_time',
		width : "15%",
		orderable : true
	}];
	
	//角色下的用户列表表头 查看
	var _tableColsAssUserView = [{
		data : 'loginname',
		width : "10%",
		orderable : true
	},{
		data : 'jobnumber',
		width : "25%",
		orderable : true
	}, {
		data : 'username',
		width : "10%",
		orderable : true
	}, {
		data : 'orgname',
		width : "20%",
		orderable : true
	}, {
		data : 'last_ip',
		width : "15%",
		orderable : true
	}, {
		data : 'last_time',
		width : "15%",
		orderable : true
	}];
	
	// 角色所选择的权限树 配置信
	var _treeSettingFunc = {
		data : {
			key : {
				name : "name"
			},
			simpleData : {
				enable : true,
				idKey : "uuid",
				pIdKey : "parentId"
			}
		},
		async : {
			enable : true,
			dataFilter : AssFuncFilter
		},
		view: {
			dblClickExpand: false,
			//ddDiyDom: addDiyDom,
			fontCss: YyZTreeUtils.getFontCss   //搜索结果高亮
		},
		callback : {
			onClick : funcZTreeOnClick
		}
	};
	
	// 角色所选择的权限树  返回数据进行预处理
	function AssFuncFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		for(var i = 0; i < records.length; i++){
			if(records[i].id == 'root'){
				records[i].open = true;
			}
		}
		return records;
	}
	
	//角色所选的权限树点击事件
	function funcZTreeOnClick(event, treeId, treeNode){
		var functype = treeNode.func_type;
		if (functype == "func") {
			showActions(treeNode);
		} else{
			hideActions(treeNode);
		}
	}
	//显示菜单的操作功能
	function showActions(treeNode){
		$("#funcAction").show();
		$("#funcActionView").show();
		$("#funcActionTbody").html("");//编辑页面
  	    $("#funcActionTbodyView").html("");//查看页面   
		
		$("#rfaRoleId").val(getRoleId());
		$("#rfaFuncId").val(treeNode.uuid);
		var showActionsUrl = '${ctx}/sys/rolefuncaction/query?search_EQ_roleFunc.func.uuid='+treeNode.uuid
				+'&search_EQ_roleFunc.role.uuid='+getRoleId();
		$.ajax({
		       url: '${ctx}/sys/rolefuncaction/getRoleFuncActions',
		       type: 'post',
		       data:{'roleId':getRoleId(),'funcId':treeNode.uuid},
		       dataType: 'json',
		       error: function(){
		    	   $("#funcActionTbody").html('<tr><td></td><td></td><td></td></tr>');
		    	   layer.msg('获取数据失败', {
		    	        time: 3000
		    	    });
		       },
		       success: function(json){
		    	   var actionHtml="";
		    	   var viewPageHtml="";
		    	   var checkCount=0;
		    	   if(json.length>0){
		    		   for(var i=0; i<json.length; i++) { 
				    		  actionHtml+="<tr><td>";
				    		  if(_pageType=="view"){
				    			  viewPageHtml=" disabled='disabled' readonly='readonly'";
				    		  }else{
				    			  viewPageHtml="";
				    		  }
				    		  if(json[i].isSelect=='1'){
				    			  checkCount++;
				    	    	  actionHtml+="<input type='checkbox' name='funcActionIds' value='"+json[i].uuid+"' checked='checked' "+viewPageHtml+"/> ";
				    	      }else{
				    	    	  actionHtml+="<input type='checkbox' name='funcActionIds' value='"+json[i].uuid+"' "+viewPageHtml+"/> ";
				    	      }
				    	      actionHtml+="</td><td>"+json[i].actioncode+"</td><td>"+json[i].actionname+ "</td></tr>";
				    	   }
		    		   if(checkCount==json.length){
		    			   $("#selAllFunActionChk").prop("checked", true);
		    		   }else{
		    			   $("#selAllFunActionChk").prop("checked", false);
		    		   }
		    	   }else{
		    		   $("#selAllFunActionChk").prop("checked", false);
		    		   actionHtml="<tr><td colspan='3'>没有相关的按钮权限</td></tr>"; 
		    	   }
		    	   $("#funcActionTbody").html(actionHtml);//编辑页面
		    	   $("#funcActionTbodyView").html(actionHtml);//查看页面
		       }
		   });
	}
	
	//保存菜单的按钮
	function onSaveFuncActions(){
		var params=$("#roleFuncActionsForm").serializeArray();
		/* var hasSeleAction='0';
		for(var i=0;i<params.length;i++){
			if(params[i].name=="funcActionIds"){
				hasSeleAction=1;
				break;
			}
		} */
		hasSeleAction=1;//不勾选也能保存，为在曾选中过，取消所有 edit by ls2008
		
		
		if(hasSeleAction=='1'){
			$.ajax({
			       url: '${ctx}/sys/rolefuncaction/saveFuncActions',
			       type: 'post',
			       data:params,
			       dataType: 'json',
			       error: function(){
			    	   layer.msg('操作失败', {
			    	        time: 3000
			    	    });
			       },
			       success: function(json){
			    	   if(json.flag=='1'){
			    		   layer.msg('操作成功', {
				    	        time: 1000
				    	    });
			    	   }else{
			    		   layer.msg('操作失败', {
				    	        time: 3000
				    	    });
			    	   }
			       }
			   });
		}else{
			 layer.msg('请勾选下面按钮权限', {
	    	        time: 1000
	    	    });
		}
	}
	
	//隐藏菜单的操作功能
	function hideActions(treeNode){
		$("#funcAction").hide();
		$("#funcActionView").hide();
	}
	
	function onRoleRefresh() {
		loadRoleList();
	}
	function onRefresh() {
		loadRoleList();
	}
	
	//当前选择的节点
	function getSelectedNodesEdit() {
		return YyZTreeUtils.getZtreeSelectedNodes(_roleFuncTree);
	}
	
	function getSelectedNodesView() {
		return YyZTreeUtils.getZtreeSelectedNodes(_roleFuncTreeView);
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
				"createdRow" : roleRowAction,
				//"dom" : '<"top">rt<"bottom"iflp><"clear">',
				"order": [2,"asc"]
			});
			
			$('input.global_filter').on('keyup click', function() {
				filterGlobal();
			});
			$('input.column_filter').on('keyup click', function() {
				filterColumn($(this).parents('div').attr('data-column'));
			});
			
			//角色绑定的用户列表-编辑
			_tableListAssUser = $('#tableList-AssUser').DataTable({
				"columns": _tableColsAssUser,
				"createdRow" : function(nRow, aData, iDataIndex) {
					$('#rap-btn-remove-row-edit', nRow).click(function() {
						onRemoveRowEdit(aData, iDataIndex,nRow);
					});
				},
				"order": [] 
			});
			//角色绑定的用户列表-查看
			_tableListAssUserView = $('#tableList-AssUserView').DataTable({
				"columns": _tableColsAssUserView,
				"createdRow" : function(nRow, aData, iDataIndex) {
					$('#rap-btn-remove-row-edit', nRow).click(function() {
						onRemoveRowEdit(aData, iDataIndex,nRow);
					});
				},
				"order": [] 
			});
			
			
			//折叠/展开
			$('#yy-expandSon2').bind('click', function() {
				var nodes = getSelectedNodesEdit();
				if (typeof (nodes) == 'undefined') {
					_roleFuncTree.expandAll(true);
					return;
				}
				_roleFuncTree.expandNode(nodes, true, true, true);
			});
			
			$('#yy-collapseSon2').bind('click', function() {
				var nodes = getSelectedNodesEdit();
				if (typeof (nodes) == 'undefined') {
					_roleFuncTree.expandAll(false);
					return;
				}
				_roleFuncTree.expandNode(nodes, false, true, true);
			});
			$('#yy-treeRefresh2').bind('click', function() {
				_roleFuncTree.reAsyncChildNodes(null, 'refresh', false);
			});
			
			//折叠/展开
			$('#yy-expandSonView').bind('click', function() {
				var nodes = getSelectedNodesView();
				if (typeof (nodes) == 'undefined') {
					_roleFuncTreeView.expandAll(true);
					return;
				}
				_roleFuncTreeView.expandNode(nodes, true, true, true);
			});
			
			$('#yy-collapseSonView').bind('click', function() {
				var nodes = getSelectedNodesView();
				if (typeof (nodes) == 'undefined') {
					_roleFuncTreeView.expandAll(false);
					return;
				}
				_roleFuncTreeView.expandNode(nodes, false, true, true);
			});
			$('#yy-treeRefreshView').bind('click', function() {
				_roleFuncTreeView.reAsyncChildNodes(null, 'refresh', false);
			});

			
			//设置布局
			_raplayout=setBodyLayout();
			
			//按钮绑定事件
			bindButtonActions();
			//加载数据
			//loadList();
			
			$("#yy-btn-add").bind('click', onAdd);//新增
			$("#yy-btn-assign-func").bind('click', onRoleGrant);//分配功能按钮
			$("#yy-btn-relate-user").bind('click', onRoleUser);//分配角色的用户
			
			//$('#yy-btn-remove').bind('click', onRemove);//删除
			//$("#yy-btn-edit").bind('click', onEditDetail);//编辑
			
			$("#yy-btn-save").bind("click", function() {//点击保存角色按钮
				onSaveRole(true);
			});
			$("#yy-btn-search").bind('click', onQuery);//查询
			$('#yy-btn-cancel').bind('click', onCancel);//编辑页面返回
			
			$('#yy-btn-backtolist').bind('click', onCancel);//查看页面返回
			
			$('#yy-btn-save-funcaction').bind('click', onSaveFuncActions);//点击保存按钮权限
			
			//验证 表单
			validateForms();
			
			
			$("#selAllFunActionChk").change(function () {
				var checked = jQuery(this).is(":checked");
				$("#roleFuncActionsForm").find("input[name=funcActionIds]").each(function () {
			        if (checked) {
			            $(this).prop("checked", true);
			            $(this).parents('tr').addClass("active");
			        } else {
			            $(this).prop("checked", false);
			            $(this).parents('tr').removeClass("active");
			        }
			    });
			});
		});
	
	   //验证表单
		function validateForms(){
			validator =$('#yy-form-edit').validate({
				rules : {
					code : {required : true,maxlength:20,minlength:2},
					name: {required : true,maxlength:20,minlength:2},
					description: {maxlength:200}
				}
			}); 
		}
	 
	 //定义行点击事件
	function roleRowAction(nRow, aData, iDataIndex) {
		$(nRow).dblclick(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-view-row', nRow).click(function() {
			_pageType="view";
			$("#funcAction").hide();
			$("#funcActionView").hide();
			onViewDetailRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-edit-row', nRow).click(function() {
			_pageType="edit";
			$("#funcAction").hide();
			$("#funcActionView").hide();
			onEditRow(aData, iDataIndex, nRow);
		});
	
		$('#yy-btn-remove-row', nRow).click(function() {
			removeRecord('${serviceurl}/delRole', [ aData.uuid ], function() {
				_tableList.row(nRow).remove().draw(false);
			});
		});
		
		
		$('#yy-btn-grant-row', nRow).click(function() {
			layer.open({
				type : 2,
				title : '请选择权限',
				shadeClose : false,
				shade : 0.8,
				area : [ '300px', '90%' ],
				content : '${serviceurl}/selectFunc?rootSelectable=true&roleId='+aData.uuid, //iframe的url
			});
		});
	};
	 
	 //显示自定义的行按钮
	  function renderRoleActionCol(data, type, full) {
			/* return "<div class='yy-btn-actiongroup'>" 
			        + "<shiro:hasPermission name='role_grant_func'><button id='yy-btn-grant-row' class='btn btn-xs btn-success' data-rel='tooltip' title='授权'><i class='fa fa-group'></i></button></shiro:hasPermission>"
					+ "<shiro:hasPermission name='role_view'><button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button></shiro:hasPermission>"
					+ "<shiro:hasPermission name='role_edit'><button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button></shiro:hasPermission>"
					+ "<shiro:hasPermission name='role_dele'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></shiro:hasPermission>"
					+ "</div>"; */
			return "<div class='yy-btn-actiongroup'>" 
	        + "<button id='yy-btn-grant-row' class='btn btn-xs btn-success' data-rel='tooltip' title='授权'><i class='fa fa-group'></i></button>"
			+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
		}
		
	 
	 //点击添加
	 function onAdd(){
		 var treeId = getSelectedTreeId();
			if (treeId==null||treeId == "") {
				layer.alert("请选择角色组");
				return false;
			}
			//RapFormUtils.clearForm('rap-form-edit');
			//$("input[name='rolegroup.uuid']").val(treeId);
			//_rapui.setEditMode();
			//hideAss();
			//_raplayout.hide("west");
			
			hideAss();//隐藏关联用户和分配功能 
			$("#yy-btn-assign-func").hide();//隐藏分配功能按钮
			$("#yy-btn-relate-user").hide();//隐藏关联用户按钮
			
			YYFormUtils.clearForm('yy-form-edit');

			$("input[name='rolegroup.uuid']").val(treeId);
			//$("#yy-form-edit").validate().resetForm();
			validator.resetForm();
			$(".error").removeClass("error");
			
			YYUI.setEditMode();
			_raplayout.hide("west");
			/* if(!$('#yy-page-list').hasClass("hide")){
				$('#yy-page-list').addClass("hide");
			} */
	 }
	 
	 //角色授权功能
	 function onRoleGrant(){
		 layer.open({
				type : 2,
				title : '请选择权限',
				shadeClose : false,
				shade : 0.8,
				area : [ '300px', '90%' ],
				content : '${serviceurl}/selectFunc?rootSelectable=true&roleId='+getRoleId(), //iframe的url
			});
	 }
	 
	//角色分配用户
	 function onRoleUser(){
		 layer.open({
				type : 2,
				title : '请选择用户',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '96%' ],
				content : '${serviceurl}/selectUser?roleId='+getRoleId(), //iframe的url
				cancel: function(index){
					loadListAssUser();
			    }
			});
	 }
	 
	 //分配功能后回调
	 function callBackRoleFunc(){
		 createTreeAssFunc("edit");//刷新已选入的功能树
	 }
	 
	//取消编辑，返回列表视图
	function onCancel() {
		YYUI.setListMode();
		//hideAss();
		_raplayout.show("west");
		onRoleRefresh();
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
	function onSaveRole(isClose) {
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
		if (pk != "" && typeof (pk) != "undefined")
			posturl = "${serviceurl}/update";
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success) {
					onRoleRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
					//doAfterSaveSuccess(data);
				} else {
					YYUI.promAlert("操作失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	
	// _tableList: 表格对象， roleGroupId: 当前用户组ID
	function loadRoleList() {
		_queryData= $("#yy-form-query").serializeArray();
		$.ajax({
			type : 'post',
			url : '${serviceurl}/searchGroupRoles',
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
		    $("#yy-btn-assign-func").show();//显示分配功能按钮
		    $("#yy-btn-relate-user").show();//显示关联用户按钮
		    
			$("input[name='uuid']").val(data.uuid);//
			$("input[name='rolegroup.uuid']").val(data.rolegroup.uuid);
			$("input[name='name']").val(data.name);			
			$("input[name='code']").val(data.code);			
			$("textarea[name='description']").val(data.description);
	}
	
	 
	 function onQuery(){
		 var rolegroupId = $("#search_rolegroupId").val();
			if(rolegroupId==null||rolegroupId.length==0){
				layer.alert("请选择角色组");
				return false;
			}
			//获取查询数据，在表格刷新的时候自动提交到后台
			_queryData = $("#yy-form-query").serializeArray();
			loadRoleList();
	 }
	 
	 //点击编辑按钮
	function onEditRow(aData, iDataIndex, nRow) {
		YYFormUtils.clearForm('yy-form-edit');
		showData(aData);
		YYUI.setEditMode();
		assigned("edit");
	}
	 
	//点击查看按钮
	function onViewDetailRow(data, rowidx) {
		YYFormUtils.clearForm('yy-form-detail');
		showData(data);
		YYUI.setDetailMode();
		assigned("view");
		
		//_detailRecord = data;
		//_detailRecordIdx = rowidx;
		//showData(data);
		//_rapui.setDetailMode();
		//_raplayout.hide("west");
	}
	 
	function onSearchRoleFuncTree(){
		var searchValue = $('#searchTreeNodeEdit').val();
		YyZTreeUtils.searchNode(_roleFuncTree,searchValue);
	}
	
	function onSearchRoleFuncTreeView(){
		var searchValue = $('#searchTreeNodeView').val();
		YyZTreeUtils.searchNode(_roleFuncTreeView,searchValue);
	}
	
	//绑定按钮事件
 	function bindButtonActions() {
		/* $('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-edit').bind('click', onEdit);
		$('#yy-btn-remove').bind('click', onRemove);
		
		$('#yy-btn-save').bind('click', onSave);
		$('#yy-btn-cancel').bind('click', onCancel);
		$("#yy-form-func input[name='func_url']").bind('focus', function() {
			if ($(this).val() == '') {
				$(this).val('@ctx@/');
			}
		}); */
		
		$('#yy-btn-refresh').bind('click', onRefresh);
		
		//zTree的搜索事件绑定
		$('#searchTreeNodeEdit').bind("propertychange", onSearchRoleFuncTree)
			.bind("input", onSearchRoleFuncTree); 
		$('#searchTreeNodeEdit').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onSearchRoleFuncTree();
	        }
	    });
		
		$('#searchTreeNodeView').bind("propertychange", onSearchRoleFuncTreeView)
		.bind("input", onSearchRoleFuncTreeView); 
		$('#searchTreeNodeView').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onSearchRoleFuncTreeView();
	        }
	    });
	}
	
	 
	function assigned(operType) {
		if(operType=="view"){//查看
			loadListAssUserView();
			 createTreeAssFunc(operType);
			 showAss();
		}else{//编辑
			loadListAssUser();
			createTreeAssFunc(operType);
			showAss();
		}
	}
	
	//显示 关联用户和分配功能
	function showAss(){
		 $("#assDivIdEdit").show();
		 $("#assDivIdView").show();
	}
	//隐藏 关联用户和分配功能
	function hideAss(){
		 $("#assDivIdEdit").hide();
		 $("#assDivIdView").hide();
	}
	
	//角色下用户    编辑
	function loadListAssUser() {
		$.ajax({
			url : '${serviceurl}/findUserByRoleId',
			data : {
				'roleId' : getRoleId()
			},
			dataType : 'json',
			success : function(data) {
				_tableListAssUser.clear();
				_tableListAssUser.rows.add(data.records);
				_tableListAssUser.draw();
			}
		});
	}
	//角色下用户   查看
	function loadListAssUserView() {
		$.ajax({
			url : '${serviceurl}/findUserByRoleId',
			data : {
				'roleId' : getRoleId()
			},
			dataType : 'json',
			success : function(data) {
				_tableListAssUserView.clear();
				_tableListAssUserView.rows.add(data.records);
				_tableListAssUserView.draw();
			}
		});
	}
	
	
	//显示角色的权限
	function createTreeAssFunc(operType){
		var url = "${serviceurl}/findFuncByRoleId?roleId=";
		_treeSettingFunc.async.url = url + getRoleId();
		if(operType=="view"){
			_roleFuncTreeView=$.fn.zTree.init($("#roleFuncTreeView"), _treeSettingFunc);
		}else{
			_roleFuncTree = $.fn.zTree.init($("#roleFuncTree"), _treeSettingFunc);
		}
	}
	
	//获取当前角色的id
	function getRoleId(){
		return $("input[name='uuid']").val();
	}
	
	
	//行操作：删除   
	//@data 行数据
	//@rowidx 行下标
	function onRemoveRowEdit(data, rowidx,row) {
		//询问框
		layer.confirm('确实要删除吗？', {
		    btn: ['确定','取消'] //按钮
		}, function(){
		    var roleId = getRoleId();
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : "${ctx}/sys/userrole/deleteByUserIdsAndRoleIds",
				"data" : {
					"userIds" : [data.uuid].toString(),
					"roleId" : roleId
				},
				"success" : function(data) {
					if (data.success) {
							//row.remove();
							loadListAssUser();
							YYUI.succMsg('操作成功!');
					} else {
						 YYUI.promAlert('操作失败:'+ data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					 YYUI.promAlert('操作失败!');
				}
			});
		}, function(){
		    
		});
	}
</script>
