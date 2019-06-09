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
									<button id="yy-btn-reset" type="reset" class="btn btn-sm btn-info">
										<i class="fa fa-undo"></i>情况
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
										<th>所属部门</th>
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
	var _tableCols = [ /* {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "5%",
		render : YYDataTableUtils.renderCheckCol
	}, */ {
		data : 'loginname',
		width : "15%",
		className : "center",
		orderable : true
	},{
   		data : 'jobnumber',
   		width : "15%",
   		className : "center",
   		orderable : true
   	}, {
		data : 'username',
		width : "10%",
		orderable : true
	}, {
		data : 'orgname',
		width : "15%",
		orderable : true
	},/*  {
		data : 'personname',
		width : "15%",
		orderable : true
	}, {
		data : 'last_time',
		width : "20%",
		orderable : true
	}, */{
		data : "uuid",
		className : "center",
		orderable : false,
		render : function (data,type,row,meta ) {
			return renderRelateUser(data,type,row,meta);
        },
		width : "5%"
	}
	];
	

	function onRefresh() {
		//非服务器分页
		loadList();
	}
	

	 //显示自定义的行按钮
	  function renderRelateUser(data, type, full) {
		 if(full.userrole=='undefined' ||full.userrole==undefined || full.userrole=="" || full.userrole==null){
			return "<div class='yy-btn-actiongroup'>" 
		        + "<button id='yy-btn-selUser-row' class='btn btn-xs btn-success' data-rel='tooltip' title='选择'>选择</button>"
				+ "</div>";
		 }else{
			 return "<div class='yy-btn-actiongroup'>" 
		        + "已选"
				+ "</div>";
		 }
	  }
		$(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				//"info":false,
				//"lengthChange":false,
				"columns" : _tableCols,
				"createdRow" : userRowAction,
				"processing": true,//加载时间长，显示加载中
				//"dom" : '<"top">rt<"bottom"p><"clear">',
				"order" : []
			});
			
			$("#yy-btn-search").bind('click', onRefresh);//快速查询
			
			//按钮绑定事件
			//bindButtonActions();
			//加载数据
			loadList();
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
		
		//选入用户
		function selUser(aData, iDataIndex, nRow){
			window.parent.callBackSelectUser(aData);
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
	</script>
</body>
</html>
