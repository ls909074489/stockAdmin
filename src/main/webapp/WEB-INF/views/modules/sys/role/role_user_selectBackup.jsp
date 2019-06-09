<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/user" />
<c:set var="rootSelectable" value="${param.rootSelectable}" />
<c:set var="roleId" value="${param.roleId}" />
<html>
<head>
</head>
<body>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
	<div class="container-fluid page-container page-content">
		<div class="row">
					<div class="col-md-6" style="padding-left: 0px;">
						<div class="row yy-searchbar">
							<div role="form" class="col-md-12 form-inline">
								<form id="yy-form-query">
									<label for="search_LIKE_loginname" class="control-label">登录账号</label>
										<input type="text" autocomplete="on" name="loginname" id="search_LIKE_loginname" 
										class="form-control input-sm" style="width: 100px;">
									<label for="search_LIKE_username" class="control-label">用户名</label>
										<input type="text" autocomplete="on" name="username" id="search_LIKE_username"
										 class="form-control input-sm" style="width: 100px;">
									<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
										<i class="fa fa-search"></i>查询
									</button>
								</form>
							</div>
						</div>
						<div class="row">
							<table id="yy-table-list" class="yy-table">
								<thead>
									<tr>
										<!-- <th>
											<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
										</th> -->
										<th>登录账号</th>
										<th>工号</th>
										<th>用户名</th>
										<th>所属单元</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="col-md-6" style="padding-left: 0px;">
						<div class="row yy-searchbar">
							<div role="form" class="col-md-12 form-inline">
								<form id="yy-form-querySelect">
									<label for="search_LIKE_loginname" class="control-label">登录账号</label>
										<input type="text" autocomplete="on" name="loginname" id="search_LIKE_loginname" 
										class="form-control input-sm" style="width: 100px;">
									<label for="search_LIKE_username" class="control-label">用户名</label>
										<input type="text" autocomplete="on" name="username" id="search_LIKE_username"
										 class="form-control input-sm" style="width: 100px;">
									<button id="yy-btn-searchSelect" type="button" class="btn btn-sm btn-info">
										<i class="fa fa-search"></i>查询
									</button>
								</form>
							</div>
						</div>
						<div class="row">
							<table id="yy-table-listSelect" class="yy-table">
								<thead>
									<tr>
										<!-- <th>
											<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
										</th> -->
										<th>登录账号</th>
										<th>工号</th>   
										<th>用户名</th>
										<th>所属单元</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
	</div>

	<script type="text/javascript">
	var _tableCols = [ {
		data : 'loginname',
		width : "20%",
		className : "center",
		orderable : true
	},{
   		data : 'jobnumber',
   		width : "20%",
   		className : "center",
   		orderable : true
   	}, {
		data : 'username',
		width : "20%",
		orderable : true
	}, {
		data : 'orgname',
		width : "35%",
		orderable : true
	},{
		data : "uuid",
		className : "center",
		orderable : false,
		render : function (data,type,row,meta ) {
			return renderRelateUser(data,type,row,meta);
        },
		width : "5%"
	}
	];
	
	var _tableColsSelect = [ {
	           		data : 'loginname',
	           		width : "20%",
	           		className : "center",
	           		orderable : true
	           	},{
	           		data : 'jobnumber',
	           		width : "20%",
	           		className : "center",
	           		orderable : true
	           	}, {
	           		data : 'username',
	           		width : "20%",
	           		orderable : true
	           	}, {
	           		data : 'orgname',
	           		width : "35%",
	           		orderable : true
	           	},{
	           		data : "uuid",
	           		className : "center",
	           		orderable : false,
	           		render : function (data,type,row,meta ) {
	           			return renderSelUser(data,type,row,meta);
	                   },
	           		width : "5%"
	           	}
	   ];

	function onRefresh() {
		//非服务器分页
		loadList();
	}
	
	function onRefreshSelect() {
		//非服务器分页
		loadListSelect();
	}

	 //显示自定义的行按钮
	  function renderRelateUser(data, type, full) {
		 if(full.userrole=='undefined' ||full.userrole==undefined || full.userrole=="" || full.userrole==null){
			return "<div class='yy-btn-actiongroup'>" 
		        + "<button id='yy-btn-selUser-row' class='btn btn-xs btn-success' data-rel='tooltip' title='选入'>选入</button>"
				+ "</div>";
		 }else{
			 return "<div class='yy-btn-actiongroup' style='color: red;'>" 
		        + "已选"
				+ "</div>";
		 }
	  }
	  
	  //显示自定义的行按钮
	  function renderSelUser(data, type, full) {
			return "<div class='yy-btn-actiongroup'>" 
			        + "<button id='yy-btn-delUser-row' class='btn btn-xs btn-success' data-rel='tooltip' title='移除'>移除</button>"
					+ "</div>";
		}
		$(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				"info":false,
				"lengthChange":false,
				"columns" : _tableCols,
				"createdRow" : userRowAction,
				"processing": true,//加载时间长，显示加载中
				//"dom" : '<"top">rt<"bottom"p><"clear">',
				"order" : []
			});
			
			_tableListSelect = $('#yy-table-listSelect').DataTable({
				"info":false,
				"lengthChange":false,
				"columns" : _tableColsSelect,
				"createdRow" : roleUserRowAction,
				"processing": true,//加载时间长，显示加载中
				"order" : []
			});
			
			//$("#yy-btn-selUser-row").bind('click', selUser);//
			$("#yy-btn-search").bind('click', onRefresh);//快速查询
			$("#yy-btn-searchSelect").bind('click', onRefreshSelect);//快速查询
			
			//按钮绑定事件
			//bindButtonActions();
			//加载数据
			loadList();
			//已选入的用户
			loadListSelect();
		});
		
		 //用户列表定义行点击事件
		function userRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-selUser-row', nRow).click(function() {
				selUser(aData, iDataIndex, nRow);
			});
		};
		
		//角色下的用户列表行点击事件
		function roleUserRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-delUser-row', nRow).click(function() {
				delUser(aData, iDataIndex, nRow);
			});
		}
		
		function loadList(){
			$.ajax({
				url : '${ctx}/sys/role/findAllUserByRoleId?roleId=${roleId}',
				data : $("#yy-form-query").serializeArray(),
				dataType : 'json',
				type : 'post',
				success : function(data) {
					_tableList.clear();
					_tableList.rows.add(data.records);
					_tableList.draw();
				}
			});
		}
		
		function loadListSelect(){
			$.ajax({
				url : '${ctx}/sys/role/findUserByRoleId?roleId=${roleId}',
				data : $("#yy-form-querySelect").serializeArray(),
				dataType : 'json',
			    type: 'post',
				success : function(data) {
					_tableListSelect.clear();
					_tableListSelect.rows.add(data.records);
					_tableListSelect.draw();
				}
			});
		}
		//选入用户
		function selUser(aData, iDataIndex, nRow){
			var userId=aData.uuid;
			var roleId='${roleId}';
			$.ajax({
			       url: '${ctx}/sys/userrole/selecRoleUser',
			       type: 'post',
			       data : {
						'roleId' : roleId,
						'userId':userId
					},
			       dataType: 'json',
			       error: function(){
			       },
			       success: function(json){
				        if(json.success){
				        	$(nRow).find("div.yy-btn-actiongroup").html("<span style='color: red;'>已选</span>");
				        	loadListSelect();
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }else{
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }
			       }
			});
		}
		//移除用户
		function delUser(aData, iDataIndex, nRow){
			var userId=aData.uuid;
			var roleId='${roleId}';
			$.ajax({
			       url: '${ctx}/sys/userrole/delRoleUser',
			       type: 'post',
			       data : {
						'roleId' : roleId,
						'userId':userId
					},
			       dataType: 'json',
			       error: function(){
			       },
			       success: function(json){
				        if(json.success){
				        	loadList();
				        	loadListSelect();
				        	 layer.msg(json.msg, {
				        	        time: 1000
				        	    });
				        }else{
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }
			       }
			});
		}
		
		
	</script>
</body>
</html>
