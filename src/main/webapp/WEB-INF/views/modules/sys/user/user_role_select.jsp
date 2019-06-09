<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
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
							<div class="col-md-6 form-inline"  style="float: left;">
								<div id="div_col0_filter" data-column="0">
									角色组<input type="text"  style="width: 100px;"
									class="column_filter form-control input-sm" id="col0_filter">
								</div>
								
							</div>
							<div class="col-md-6 form-inline" style="float: left;">
								<div id="div_col1_filter" data-column="1">
									角色名称<input type="text"  style="width: 100px;"
									class="column_filter form-control input-sm" id="col1_filter">
								</div>
							</div>
						</div>
						<div class="row">
							<table id="yy-table-list" class="yy-table">
								<thead>
									<tr>
										<th>角色组名称</th>
										<th>角色名称</th>
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
							<div class="col-md-6 form-inline"  style="float: left;">
								<div id="div_col0_filter" data-column="0">
									角色组 <input type="text"  style="width: 100px;"
									class="column_filter2 form-control input-sm" id="col0_filter2">
								</div>
								
							</div>
							<div class="col-md-6 form-inline" style="float: left;">
								<div id="div_col1_filter" data-column="1">
									角色名称<input type="text"  style="width: 100px;"
									class="column_filter2 form-control input-sm" id="col1_filter2">
								</div>
							</div>
						</div>
						<div class="row">
							<table id="yy-table-listSelect" class="yy-table">
								<thead>
									<tr>
										<th>角色组名称</th>
										<th>角色名称</th>
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
	var _tableCols = [{
		data : 'roleGroupName',
		width : "15%",
		className : "center",
		orderable : true
	}, {
		data : 'name',
		width : "15%",
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
	           		data : 'roleGroupName',
	           		width : "15%",
	           		className : "center",
	           		orderable : true
	           	},{
	           		data : 'name',
	           		width : "15%",
	           		className : "center",
	           		orderable : true
	           	}, {
	           		data : "uuid",
	           		className : "center",
	           		orderable : false,
	           		render : function (data,type,row,meta ) {
	           			return renderselObj(data,type,row,meta);
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
		        + "<button id='yy-btn-selObj-row' class='btn btn-xs btn-success' data-rel='tooltip' title='选入'>选入</button>"
				+ "</div>";
		 }else{
			 return "<div class='yy-btn-actiongroup' style='color: red;'>" 
		        + "已选"
				+ "</div>";
		 }
	  }
	  
	  //显示自定义的行按钮
	    function renderselObj(data, type, full) {
			return "<div class='yy-btn-actiongroup'>" 
			        + "<button id='yy-btn-delObj-row' class='btn btn-xs btn-success' data-rel='tooltip' title='移除'>移除</button>"
					+ "</div>";
		}
	  
	  
		function filterColumn(i) {
			$('#yy-table-list').DataTable().column(i).search(
					$('#col' + i + '_filter').val(), false, true).draw();
		}
		
		function filterColumnSel(i) {
			$('#yy-table-listSelect').DataTable().column(i).search(
					$('#col' + i + '_filter2').val(), false, true).draw();
		}
		
		
		$(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				/* "info":false,
				"lengthChange":false,
				"columns" : _tableCols,
				"createdRow" : selRowAction,
				"processing": true,//加载时间长，显示加载中
				"order" : [] */
				"columns" : _tableCols,
				"createdRow" : selRowAction,
				"processing" : true,//加载时间长，显示加载中
				"paging" :false,
				"order" : []
			});
			
			_tableListSelect = $('#yy-table-listSelect').DataTable({
				/* "info":false,
				"lengthChange":false,
				"columns" : _tableColsSelect,
				"createdRow" : unSelRowAction,
				"processing": true,//加载时间长，显示加载中
				"order" : [] */
				"columns" : _tableColsSelect,
				"createdRow" : unSelRowAction,
				"processing" : true,//加载时间长，显示加载中
				"paging" :false,
				"order" : []
			});
			
			//$("#yy-btn-selObj-row").bind('click', selObj);//
			$("#yy-btn-search").bind('click', onRefresh);//快速查询
			$("#yy-btn-searchSelect").bind('click', onRefreshSelect);//快速查询
			
			$('input.column_filter').on('keyup click', function() {
				filterColumn($(this).parents('div').attr('data-column'));
			});
			$('input.column_filter2').on('keyup click', function() {
				filterColumnSel($(this).parents('div').attr('data-column'));
			});
			
			
			//按钮绑定事件
			//bindButtonActions();
			//加载数据
			loadList();
			//已选入的用户
			loadListSelect();
		});
		
		 //用户列表定义行点击事件
		function selRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-selObj-row', nRow).click(function() {
				selObj(aData, iDataIndex, nRow);
			});
		};
		
		//角色下的用户列表行点击事件
		function unSelRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-delObj-row', nRow).click(function() {
				delObj(aData, iDataIndex, nRow);
			});
		}
		
		function loadList(){
			var listWaitLoad=layer.load(2);
			$.ajax({
				url : '${ctx}/sys/role/dataUnSelRoles?selUserId=${selUserId}',
				data : $("#yy-form-query").serializeArray(),
				dataType : 'json',
				type : 'post',
				success : function(data) {
					layer.close(listWaitLoad);
					_tableList.clear();
					_tableList.rows.add(data.records);
					_tableList.draw();
				}
			});
		}
		
		function loadListSelect(){
			var listWaitLoad2=layer.load(2);
			$.ajax({
				url : '${ctx}/sys/role/dataSelRoles?selUserId=${selUserId}',
				data : $("#yy-form-querySelect").serializeArray(),
				dataType : 'json',
			    type: 'post',
				success : function(data) {
					layer.close(listWaitLoad2);
					_tableListSelect.clear();
					_tableListSelect.rows.add(data.records);
					_tableListSelect.draw();
				}
			});
		}
		//选入用户
		function selObj(aData, iDataIndex, nRow){
			$.ajax({
			       url: '${ctx}/sys/userrole/selecRoleUser',
			       type: 'post',
			       data:{'roleId':aData.uuid,'userId':'${selUserId}'},
			       dataType: 'json',
			       error: function(){
			       },
			       success: function(json){
				        if(json.success){
				        	//$(nRow).find("div.yy-btn-actiongroup").html("<span style='color: red;'>已选</span>");
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
		//移除用户
		function delObj(aData, iDataIndex, nRow){
			$.ajax({
			       url: '${ctx}/sys/userrole/delRoleUser',
			       type: 'post',
			       data:{'roleId':aData.uuid,'userId':'${selUserId}'},
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
