<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>督导</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 查看页面 -->
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar">
			
				<div class="col-md-3 form-inline">
					<div id="div_col1_filter" data-column="1">
						姓名 <input type="text" class="column_filter form-control input-sm" id="col1_filter" style="width: 150px;">
					</div>
				</div>
				<div class="col-md-3 form-inline">
					<div id="div_col2_filter" data-column="2">
						员工号<input type="text" class="column_filter form-control input-sm" id="col2_filter" style="width: 150px;">
					</div>
				</div>
				<div class="col-md-6 form-inline">
					<div class="dataTables_filter" id="yy-table-list_filter">
						<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder=""></label>
					</div>
				</div>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					
					<thead>
						<tr>
							<th>操作</th>
							<th>姓名</th>
							<th>员工号</th>
							<th>部门</th>
							<th>移动电话</th>
							<th>邮箱</th>	
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>

		<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>

		<!-- 功能脚本 -->
		<script type="text/javascript">
			var _tableCols = [{
				data : "uuid",
				className : "center",
				orderable : false,
				"render": function (data,type,row,meta ) {
					return renderActionCol(data,type,row,meta);
		         },
				width : "5%"
			} ,{
				data : 'name',
				width : "10%",
				className : "center",
				orderable : false
			}, {
				data : 'job_number',
				width : "10%",
				className : "center",
				orderable : false
			},{
				data : 'deptname',
				width : "10%",
				className : "center",
				orderable : false
			}, {
				data : 'mobile_phone',
				width : "15%",
				className : "center",
				orderable : false
			}, {
				data : 'email',
				width : "15%",
				className : "center",
				orderable : false
			}];
		
			function onRefresh() {
				//非服务器分页
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
		
			 //显示自定义的行按钮
			  function renderActionCol(data, type, full) {
					return "<div class='yy-btn-actiongroup'>" 
							+'<button id="yy-btn-selPerson-row" class="btn btn-xs btn-success" data-rel="tooltip" title="选入">选入</button>'
							+ "</div>";
		       }
			  //定义行点击事件
			   function renderRowAction(nRow, aData, iDataIndex) {
					$('#yy-btn-selPerson-row', nRow).click(function() {
						onSelPerson(aData, iDataIndex, nRow);
					});
					$(nRow).dblclick(function() {
						onSelPerson(aData, iDataIndex, nRow);
					});
				};
				
				function onSelPerson(aData, iDataIndex, nRow){
					var _method='${callBackMethod}';
					if(_method){
						//window.parent._method(aData);
			        	eval(_method+"(aData)"); 
					}else{
						window.parent.callBackSelectPerson(aData);
					}
					
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭 
				 }	
			
			
			$(document).ready(function() {
				_tableList = $('#yy-table-list').DataTable({
					"columns" : _tableCols,
					"createdRow" : renderRowAction,
					"processing" : true,//加载时间长，显示加载中
					"order" : []
				});
		
				$('input.global_filter').on('keyup click', function() {
					filterGlobal();
				});
		
				//按钮绑定事件
				bindButtonActions();
				//加载数据
				loadList();
		
			});
			
			
			function loadList(){
				var listWaitLoad=layer.load(2);
				$.ajax({
					url : '${ctx}/sys/data/dataHeadquartersList?orgId=${orgId}',
					data : {
						//'roleId' : getRoleId()
					},
					dataType : 'json',
					success : function(data) {
						_tableList.clear();
						_tableList.rows.add(data.records);
						_tableList.draw();
						layer.close(listWaitLoad);
					},
					error:function(data){
						layer.close(listWaitLoad);
					}
				});
			}
		</script>

	</div>
</body>
</html>