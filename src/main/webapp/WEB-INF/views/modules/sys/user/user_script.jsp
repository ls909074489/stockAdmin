<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		/* visible : false, */
		width : "20",
		render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderUserActionCol(data,type,row,meta);
         },
		width : "80"
	} , {
		data : 'loginname',
		width : "100",
		className : "center",
		orderable : true
	}, {
		data : 'username',
		width : "100",
		orderable : true
	}/* , {
		data : 'jobnumber',
		width : "100",
		className : "center",
		orderable : true
	} */, {
		data : 'sex',
		width : "50",
		className : "center",
		orderable : true,
		render : function(data, type, full) {
		       return YYDataUtils.getEnumName("sys_sex", data);
		}
	},{
		data : 'last_time',
		width : "100",
		orderable : true
	}, {
		data : 'is_use',
		width : "60",
		"render": function (data,type,row,meta ) {
			if(data!=null&&data=='1'){
				return "已启用";
			}else{
				return "已禁用";
			}
         },
		orderable : true
	}];

	
	function onRefresh() {
		//非服务器分页
		//loadList('${serviceurl}/query?orderby=modifytime@asc');
		_queryData = $("#yy-form-query").serializeArray();
		_tableList.draw(); //服务器分页
	}

	/* function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				$('#global_regex').prop('checked'),
				$('#global_smart').prop('checked')).draw();
	} */

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}
	//绑定参照事件
	function bindDefActions() {
		$('#yy-org-select-btn').on('click', function() {
			/* layer.open({
				type : 2,
				title : '请选择所属单位',
				shadeClose : false,
				shade : 0.8,
				area : [ '800px', '90%' ],
				content : '${pageContext.request.contextPath}/sys/data/selectOrg?callBackMethod=window.parent.callBackSelectOrg&rootSelectable=true', //iframe的url
			}); */
			layer.open({
				type : 2,
				title : '请选择所属单位',
				shadeClose : true,
				shade : 0.8,
				area : [ '300px', '90%' ],
				//content : '${pageContext.request.contextPath}/sys/data/selectOrg?rootSelectable=true', //iframe的url
				content : '${pageContext.request.contextPath}/sys/data/toOrgTree?rootSelectable=true'
			});
		});
		
		$('#yy-userref-select-btn').on('click', function() {
			var tUserType=$("#usertype").val();
		});
		
		
		$('#yy-dept-select-btn').on('click', function() {
			layer.open({
				type : 2,
				title : '请选择业务部门',
				shadeClose : false,
				shade : 0.8,
				area : [ '300px', '90%' ],
				content : '${pageContext.request.contextPath}/sys/data/selectDept?rootSelectable=true', //iframe的url
			});
		});
		
		//带部门树的选择方式
		$('#yy-person-select-btn').on('click', function() {
			layer.open({
				type : 2,
				title : '请选择业务人员',
				shadeClose : false,
				shade : 0.8,
				area : [ '1000px', '90%' ],
				content : '${pageContext.request.contextPath}/sys/data/selectPerson?rootSelectable=true', //iframe的url
			});
		});
		
		//列表显示方式
		$('#person-select-btn').on('click', function() {
			var selOrgId=$("#selOrgId").val();
			if(selOrgId!=null&&selOrgId!=''){
				layer.open({
					type : 2,
					title : '请选择业务人员',
					shadeClose : false,
					shade : 0.8,
					area : [ '1000px', '90%' ],
					content : '${pageContext.request.contextPath}/sys/data/listPerson?orgId='+selOrgId
				});
			}else{
				YYUI.promAlert('请先选择所属单位!');
			}
		});
		
		//查询绑定回车start
		$('#search_loginname').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onQuery();
	        }
	    });
		$('#search_username').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onQuery();
	        }
	    });
		$('#search_orgname').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onQuery();
	        }
	    });
	}

	//选择单位回调函数
/* 	function callBackSelectOrg(data) {
		var oldPersonOrg=$("#selOrgId").val();
		if(oldPersonOrg!=null&&oldPersonOrg!=''&&$("#selPersonId").val()!=''&&data.uuid!=oldPersonOrg){
			YYUI.promAlert('选择的单位和关联的人员所属单位不相符!');			
			return;
		}
		$("input[name='orgid']").val(data.uuid);
		$("input[name='orgname']").val(data.org_name);
		_changeParent = true;
	} */
	
	//选择父节点回调函数
	function callBackSelectOrg(funcNode) {
		$("input[name='orgid']").val(funcNode.id);
		$("input[name='orgname']").val(funcNode.name);
		_changeParent = true;
	}
	
	//选择部门回调函数
	function callBackSelectDept(funcNode) {
		$("input[name='deptid']").val(funcNode.id);
		$("input[name='deptname']").val(funcNode.name);
		//_changeParent = true;
		var pNode=getFirstOrg(funcNode,1);
		$("input[name='orgid']").val(pNode.id);
		$("input[name='orgname']").val(pNode.name);
	}
	
	//选择业务人员回调函数
	function callBackSelectPerson(personData) {
		if(personData.loginname!=null&&personData.loginname!=''){
			if($("#selPersonName").val()!=null&&$("#selPersonName").val()==personData.name){
				//编辑时可以选择原来的人员
				$("#selPersonId").val(personData.uuid);
				$("#selPersonName").val(personData.name);
				
				$("input[name='deptid']").val(personData.deptid);
				$("input[name='deptname']").val(personData.deptname);
				if(personData.orgid!=null&&personData.orgid!=''){
					$("input[name='orgid']").val(personData.orgid);
					$("input[name='orgname']").val(personData.orgname);
				}
			}else{
				YYUI.promAlert('人员'+personData.name+'已关联登录账号'+personData.loginname+',不能再选择关联!');
			}
		}else{
			$("#selPersonId").val(personData.uuid);
			$("#selPersonName").val(personData.name);
			
			$("input[name='deptid']").val(personData.deptid);
			$("input[name='deptname']").val(personData.deptname);
			if(personData.orgid!=null&&personData.orgid!=''){
				$("input[name='orgid']").val(personData.orgid);
				$("input[name='orgname']").val(personData.orgname);
			}
		}
	}
	
	//选择学生回调方法
	function callBackSelRef(data){
		$("input[name='user_refid']").val(data.uuid);
		$("input[name='user_refname']").val(data.name);
	}
	
	function getFirstOrg(treeNode,stepCount){
		if (treeNode==null || treeNode.type=='1') {//单位
			return treeNode;
		}else{
			if(stepCount>10){//如果10级都没找到跳出，避免死循环
				return null;
			}
			stepCount++;
			return getFirstOrg(treeNode.getParentNode(),stepCount);
		}
	}
	
	//行的按钮
	function renderUserActionCol(data, type, full) {
		var actionStr="<div class='yy-btn-actiongroup'>";
			    //+ "<button id='yy-btn-grant-row' class='btn btn-xs btn-success' data-rel='tooltip' title='授权'><i class='fa fa-group'></i></button>"
			    //+ "<button id='yy-btn-resetpwd-row' class='btn btn-xs btn-info' data-rel='tooltip' title='重置密码'><i class='fa fa-link'></i></button>";
		var btnGroup='<div class="btn-group" style="height:22px;">'+
                '<a class="btn green"  style="height:22px;padding:0px 6px;" href="javascript:;" data-toggle="dropdown"'+
                   ' <i class="fa fa-user"></i>'+
                   '<i class="fa fa-angle-down"></i>'+
                '</a>'+
               ' <ul class="dropdown-menu">'+
	               '<li>'+
		               '<a id="yy-btn-grant-row" href="javascript:;"><i class="fa fa-group"></i>单元授权</a>'+
		           '</li>'+
		           '<li>'+
		               '<a id="yy-btn-role-row" href="javascript:;"><i class="fa fa-group"></i>角色授权</a>'+
		           '</li>'+
		           '<li>'+
	                   '<a id="yy-btn-resetpwd-row" href="javascript:;"><i class="fa fa-link"></i>重置密码</a>'+
	               '</li>';
		if(full.is_use!=null&&full.is_use=='1'){
			//actionStr+= "<button id='yy-btn-use-row' class='btn btn-xs btn-success' data-rel='tooltip' title='禁用'><i class='fa fa-th-large'></i></button>"
			btnGroup+='<li>'+
            '<a id="yy-btn-use-row" href="javascript:;"><i class="fa fa-th-large"></i>禁用用户</a>'+
            '</li>';
		}else{
			//actionStr+= "<button id='yy-btn-use-row' class='btn btn-xs btn-info' data-rel='tooltip' title='启用'><i class='fa fa-th-large'></i></button>"
			btnGroup+='<li>'+
            '<a id="yy-btn-use-row" href="javascript:;"><i class="fa fa-th-large"></i>启用用户</a>'+
            '</li>';
		}	   
		btnGroup+= '</ul></div>';
		
		actionStr+=  btnGroup+"<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
				//+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
				+ "</div>";
		return actionStr;		
	};
	
	
	
	$(document).ready(function() {
		$("#yy-btn-removeuser").bind('click', onRemoveUser);//删
		
		_queryData = $("#yy-form-query").serializeArray();

		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : roleRowAction,
			"order" : [],
			"processing" : true,
			"searching" : false,
			"serverSide" : true,
			"showRowNumber" : true,
			"pagingType" : "bootstrap_full_number",
			"paging" : true,
			"fnDrawCallback" : fnDrawCallback,
			"ajax" : {
				"url" : '${serviceurl}/query',
				"type" : 'POST',
				"data" : function(d) {
					d.orderby = getOrderbyParam(d);
					if (_queryData == null)
						return;
					$.each(_queryData, function(index) {
						if (this['value'] == null || this['value'] == "")
							return;
						d[this['name']] = this['value'];
					});
				},
				"dataSrc" : function(json) {
					_pageNumber = json.pageNumber;
					return json.records == null ? [] : json.records;
				}
			}
		});
		
		//按钮绑定事件
		bindButtonActions();
		bindDefActions();
		//加载数据
		//loadList('${serviceurl}/query?orderby=modifytime@desc');
		//serverPage();

		//验证 表单
		validateForms();
		
	});
	
	
	
	function onAddAfter() {
		$('input[name=personname]').attr("readonly","readonly");
		$('input[name=deptname]').attr("readonly","readonly");
		$('input[name=orgname]').attr("readonly","readonly");
		$("#d4311").val('${nowDate}');
		return true;
	}
	
	function onAfterEditRow() {
		$('input[name=personname]').attr("readonly","readonly");
		$('input[name=deptname]').attr("readonly","readonly");
		$('input[name=orgname]').attr("readonly","readonly");
		return true;
	}
	
	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		//$("select[name='status']").val(data.status);
		$("input[name='loginname']").val(data.loginname);
		$("input[name='username']").val(data.username);
		$("input[name='password']").val(data.password);
		$("input[name='jobnumber']").val(data.jobnumber);
		$("select[name='usertype']").val(data.usertype);
		$("select[name='sex']").val(data.sex);
		$("input[name='mobilephone']").val(data.mobilephone);
		$("input[name='showorder']").val(data.showorder);
		$("input[name='validdate']").val(data.validdate);
		$("textarea[name='description']").val(data.description);
		$("input[name='invaliddate']").val(data.invaliddate);

		
		$("input[name='orgid']").val(data.orgid);
		/* if(data.corp!=null){
			$("input[name='orgname']").val(data.corp.org_name);
		}else{
			$("input[name='orgname']").val('');
		} */
		$("input[name='orgname']").val(data.orgname);
		
		$("input[name='deptid']").val(data.deptid);
		/* if(data.department!=null){
			$("input[name='deptname']").val(data.department.name);
		}else{
			$("input[name='deptname']").val('');			
		} */
		$("input[name='deptname']").val(data.deptname);
		
		$("input[name='personid']").val(data.personid);
		/* if(data.person){
			$("input[name='personname']").val(data.person.name);
		}else{
			$("input[name='personname']").val('');
		} */
		$("input[name='personname']").val(data.personname);

	}
	
	 //定义行点击事件
	function roleRowAction(nRow, aData, iDataIndex) {
		$(nRow).dblclick(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-view-row', nRow).click(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-edit-row', nRow).click(function() {
			onEditRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-remove-row', nRow).click(function() {
			onRemoveRow(aData, iDataIndex, nRow);
		});
		
		$('#yy-btn-grant-row', nRow).click(function() {
			layer.open({
				type : 2,
				title : '请选择业务单元',
				shadeClose : false,
				shade : 0.8,
				area : [ '400px', '90%' ],
				content : '${serviceurl}/selectOrgTree?callBackMethod=window.parent.callBackSeleUserOrg&userId='+aData.uuid, //iframe的url
			});
		});
		
		$('#yy-btn-resetpwd-row', nRow).click(function() {
			layer.confirm('确实要重置密码吗？', function() {
				$.ajax({
				       url: '${serviceurl}/resetpwd',
				       type: 'post',
				       data:{'userId':aData.uuid},
				       dataType: 'json',
				       error: function(){
				    	   layer.msg('重置密码失败', {
				    	        time: 3000
				    	    });
				       },
				       success: function(json){
				    	   YYUI.succMsg('重置密码成功!');
				       }
				   });
			});
		});
		
		$('#yy-btn-use-row', nRow).click(function() {
			var tval="确实要启用吗？";
			var is_use=1;
			if(aData.is_use!=null&&aData.is_use=='1'){
				tval="确实要禁用吗？";
				is_use=0;
			}
			layer.confirm(tval, function() {
				$.ajax({
				       url: '${serviceurl}/setIsuse',
				       type: 'post',
				       data:{'userId':aData.uuid,'is_use':is_use},
				       dataType: 'json',
				       error: function(){
				    	   layer.msg('操作失败', {
				    	        time: 3000
				    	    });
				       },
				       success: function(json){
				    	   loadList('${serviceurl}/query?orderby=modifytime@asc');
				    	   YYUI.succMsg('操作成功!');
				       }
				   });
			});
		});
		
		//角色授权
		$('#yy-btn-role-row', nRow).click(function() {
			layer.open({
				type : 2,
				title : '请选择角色',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '96%' ],
				content : '${pageContext.request.contextPath}/sys/user/listRole?callBackMethod=updateUserRole&selUserId='+aData.uuid //iframe的url
			});
		});
	};
	
	//行操作：删除   
	//@data 行数据
	//@rowidx 行下标
	function onRemoveRow(data, rowidx, row) {
		if (doBeforeRemoveRow(data)) {
			removeRecord('${serviceurl}/deleUser', [ data.uuid ], function() {
				_tableList.row(row).remove().draw(false);
			});
		}
	}
	//工具栏删除动作，可批量
	function onRemoveUser() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeRemove(pks)) {
			removeRecord('${serviceurl}/deleUser', pks, onRefresh);
		}
	}
	
	 //验证表单
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				loginname : {required : true,maxlength:20},
				username : {required : true,maxlength:30},
				sex : {required : true},
				orgname : {required : true},
				usertype : {required : true},
				description : {maxlength:200}
			}
		}); 
	}
	 
	 //单元授权
	 function callBackSeleUserOrg(data){
		 if(data.success){
			 YYUI.succMsg('操作成功!');
		 }else{
			 YYUI.failMsg('操作失败!');
		 }
	 }
	 
	 //清空参照
	function cleanDef(defId,defName){
		$("#"+defId).val("");
		$("#"+defName).val("");
	}
</script>
