<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>机构选择</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<!-- 查看页面 -->
		<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar">
						<div class="form-inline" style="float: left;">
							<div id="div_col1_filter" data-column="1">
								机构代码<input type="text" class="column_filter form-control input-sm" id="col1_filter">
							</div>
				
						</div>
						<div class="form-inline" style="float: left;">
							<div id="div_col2_filter" data-column="2">
								机构名称 <input type="text" class="column_filter form-control input-sm" id="col2_filter">
							</div>
						</div>
						<div class="form-inline" style="float: right;">
							<div class="dataTables_filter" id="yy-table-list_filter">
								快速筛选<input id="global_filter"
									class="global_filter form-control input-sm"
									aria-controls="yy-table-list" type="search" placeholder="">
							</div>
						</div>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th>操作</th>
							<th>机构代码</th>
							<th>机构名称</th>
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
			var _tableCols = [ {
				data : "uuid",
				className : "center",
				orderable : false,
				"render": function (data,type,row,meta ) {
					return renderActionCol(data,type,row,meta);
		         },
				width : "20"
			} ,{
				data : 'org_code',
				width : "40%",
				className : "center",
				orderable : false
			}, {
				data : 'org_name',
				width : "60%",
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
							+'<button id="yy-btn-select-row" class="btn btn-xs btn-success" data-rel="tooltip" title="选入">选入</button>'
							+ "</div>";
		       }
			  //定义行点击事件
			   function renderRowAction(nRow, aData, iDataIndex) {
					$('#yy-btn-select-row', nRow).click(function() {
						onSelect(aData, iDataIndex, nRow);
					});
				
				};
				function onSelect(aData, iDataIndex, nRow){
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
					"paging" : false,
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
				$.ajax({
					url : '${ctx}/sys/data/${dataMethod}',
					data : {
						//'roleId' : getRoleId()
					},
					dataType : 'json',
					success : function(data) {
						_tableList.clear();
						_tableList.rows.add(data.records);
						_tableList.draw();
					}
				});
			}
		</script>

	</div>
</body>
</html>