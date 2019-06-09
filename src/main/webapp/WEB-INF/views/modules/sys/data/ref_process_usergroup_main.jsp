<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<title>机构选择</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

	<div class="page-content" id="yy-page-list">
			<div class="row yy-searchbar">
					<div class="col-md-4 form-inline"  style="float: left;">
						<div id="div_col1_filter" data-column="1">
							编码 <input type="text" class="column_filter form-control input-sm" id="col1_filter">
						</div>
						
					</div>
					<div class="col-md-4 form-inline" style="float: left;">
						<div id="div_col2_filter" data-column="2">
							名称<input type="text" class="column_filter form-control input-sm" id="col2_filter">
						</div>
					</div>
					<div class="col-md-4 form-inline" style="float: right;">
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
							<th>编码</th>
							<th>名称</th>
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
				data : 'code',
				width : "40%",
				className : "center",
				orderable : false
			}, {
				data : 'name',
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
				   $(nRow).dblclick(function() {
					   onSelect(aData, iDataIndex, nRow);
					});
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
					"paging" : true,
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
					url : '${ctx}/sys/data/dataProcessUserGroup',
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