<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/demo/bill" />
<html>
<head>
<title>单据--主子表--编辑</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">

		<div class="page-content" id="yy-page-edit">
			<div class="row yy-toolbar">
				<button id="yy-btn-save">
					<i class="fa fa-save"></i> 保存
				</button>
				<button id="yy-btn-cancel" class="btn blue btn-sm">
					<i class="fa fa-rotate-left"></i> 取消
				</button>
			</div>

			<div class="row">
				<form id="yy-form-edit" class="form-horizontal yy-form-edit">
					<input name="uuid" type="hidden" />
					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">文本</label>
								<div class="col-md-8">
									<div class="input-icon right">
										<i class="fa"></i> <input name="texts" type="text" class="form-control">
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">数字</label>
								<div class="col-md-8">
									<div class="input-icon right">
										<i class="fa"></i> <input class="form-control " name="numbers" type="text">
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">整数</label>
								<div class="col-md-8">
									<input class="form-control" name="integers" type="text">
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">枚举</label>
								<div class="col-md-8">
									<select class="yy-input-enumdata form-control" id="enumerates" name="enumerates" data-enum-group="enumerates"></select>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">日期</label>
								<div class="col-md-8">
									<!-- <input class="form-control date-picker" name="dates" type="text"> -->
									<input class="Wdate form-control" name="dates" type="text" onclick=" WdatePicker();">
								</div>
							</div>
						</div>
						<div class="col-md-8">
							<div class="form-group">
								<label class="control-label col-md-2">描述</label>
								<div class="col-md-10">
									<input class="form-control" name="longtexts" type="text">
								</div>
							</div>
						</div>
					</div>
					
					
					
					<div class="yy-tab" id="yy-page-sublist">
						<div class="tabbable-line">
							<ul class="nav nav-tabs ">
								<li id="tabl1" class="active"><a href="#yy-tab-1" data-toggle="tab">子表1 </a></li>
								<li id="tabl2"><a href="#yy-tab-2" data-toggle="tab">子表2 </a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="yy-tab-1">
									<table id="yy-table-1" class="yy-table-x">
										<thead>
											<tr>
												<th>序号</th>
												<th><button id='yy-btn-add-row' class='btn btn-xs btn-success plus' data-rel='tooltip' title='添加'>
														<i class='fa fa-plus'></i></button>
													&nbsp;操作</th>
												<th>文本</th>
												<th>数字</th>
												<th>整数</th>
												<th>枚举</th>
												<th>日期</th>
												<th>大文本</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
		
								<div class="tab-pane" id="yy-tab-2">
									<table id="yy-table-2" class="yy-table">
										<thead>
											<tr>
												<th>序号</th>
												<th><button id='yy-btn-add-row2' class='btn btn-xs btn-success plus' data-rel='tooltip' title='添加'>
														<i class='fa fa-plus'></i></button>
													&nbsp;操作</th>
												<th>文本</th>
												<th>数字</th>
												<th>整数</th>
												<th>枚举</th>
												<th>日期</th>
												<th>大文本</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
		
							</div>
						</div>
					</div>
					
					
				</form>
			</div>

			

		</div>


	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	<script type="text/javascript">
		var rowNumber = 0;
		var _subTableCols1 = [
				{
					data : "rowViewStatus",
					orderable : false,
					className : "center",
					width : "50",
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].rowViewStatus" type="hidden" value="1">';
					}
				},
				{
					data : "uuid",
					className : "center",
					orderable : false,
					render : YYDataTableUtils.renderAddRemoveActionCol,
					width : "100"
				},
				{
					data : 'texts',
					width : "250",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].texts" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'numbers',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].numbers" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'integers',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].integers" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'enumerates',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].enumerates" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'dates',
					width : "240",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input class="Wdate form-control" name="aList[' + rowNumber + '].dates" type="text" onclick=" WdatePicker();" value="'
								+ data + '">';
					}
				},
				{
					data : 'longtexts',
					width : "500",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="aList[' + rowNumber + '].longtexts" type="text" class="form-control" value="' + data + '">';
					}
				}
				];

		var newData1 = [ {
			rowViewStatus : '1',
			uuid : '',
			texts : '',
			numbers : '',
			integers : '',
			enumerates : '',
			dates : '',
			longtexts : ''
		} ];
		
		
		//子表2
		var rowNumber2 = 0;
		var _subTableCols2 = [
				{
					data : "rowViewStatus",
					orderable : false,
					className : "center",
					width : "50",
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].rowViewStatus" type="hidden" value="1">';
					}
				},
				{
					data : "uuid",
					className : "center",
					orderable : false,
					render : YYDataTableUtils.renderAddRemoveActionCol,
					width : "100"
				},
				{
					data : 'texts',
					width : "250",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].texts" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'numbers',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].numbers" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'integers',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].integers" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'enumerates',
					width : "200",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].enumerates" type="text" class="form-control" value="' + data + '">';
					}
				},
				{
					data : 'dates',
					width : "240",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input class="Wdate form-control" name="bList[' + rowNumber2 + '].dates" type="text" onclick=" WdatePicker();" value="'
								+ data + '">';
					}
				},
				{
					data : 'longtexts',
					width : "500",
					className : "center",
					orderable : true,
					render : function(data, type, full) {
						return '<input name="bList[' + rowNumber2 + '].longtexts" type="text" class="form-control" value="' + data + '">';
					}
				}
				];
		var newData2 = [ {
			rowViewStatus : '1',
			uuid : '',
			texts : '',
			numbers : '',
			integers : '',
			enumerates : '',
			dates : '',
			longtexts : ''
		} ];
		
		
		
		$(document).ready(function() {
			//按钮绑定事件
			bindEditActions();
			var _subTableList1 = $('#yy-table-1').DataTable({
				"columns" : _subTableCols1,
				"columnDefs": [ {
		            "searchable": false,
		            "orderable": false,
		            "targets": 0
		        } ],
				//"dom" : '<"top">rt<"bottom"iflp><"clear">',
				"paging" : false,
				"scrollX" : true,
				"targets": 0,
				"order" : []
			});
			
			//子表2
			var _subTableList2 = $('#yy-table-2').DataTable({
				"columns" : _subTableCols2,
				"columnDefs": [ {
		            "searchable": false,
		            "orderable": false,
		            "targets": 0
		        } ],
				"paging" : false,
				"scrollX" : true,
				"targets": 0,
				"order" : []
			});
			
			if ('${openstate}' == 'add') {
				_subTableList1.clear();
				onAddRowA(_subTableList1, newData1);
				_subTableList2.clear();
				onAddRowB(_subTableList2, newData2);
			}

			if ('${openstate}' == 'edit') {
				$("input[name='uuid']").val('${entity.uuid}');
				$("input[name='texts']").val('${entity.texts}');
				$("input[name='numbers']").val('${entity.numbers}');
				$("input[name='integers']").val('${entity.integers}');
				$("select[name='enumerates']").val('${entity.enumerates}');
				$("input[name='dates']").val('${entity.dates}');
				$("input[name='longtexts']").val('${entity.longtexts}');
				_subTableList1.clear();
				var jsonResp = jQuery.parseJSON('${aList}');
				for(var i = 0; i < jsonResp.length; i++) {
					onAddEditRow(_subTableList1, jsonResp[i]);
					rowNumber++;
				}
				_subTableList2.clear();
				var jsonResp02 = jQuery.parseJSON('${bList}');
				for(var i = 0; i < jsonResp02.length; i++) {
					onAddEditRow(_subTableList2, jsonResp02[i]);
					rowNumber2++;
				}
				//onAddRowB(_subTableList2, jQuery.parseJSON('${bList}'));
			}
			
			//子表1 行操作：添加
			_subTableList1.on('click', '.plus', function(e) {
				e.preventDefault();
				onAddRowA(_subTableList1, newData1);
				
			});
			
			//子表2 行操作：添加
			_subTableList2.on('click', '.plus', function(e) {
				e.preventDefault();
				onAddRowB(_subTableList2, newData2);
				
			});
			
			$("#yy-btn-add-row").on('click', function(e) {
				e.preventDefault();
				onAddRowA(_subTableList1, newData1);
			});
			
			$("#yy-btn-add-row2").on('click', function(e) {
				e.preventDefault();
				onAddRowB(_subTableList2, newData2);
			});
			
			//子表1 行操作：删除子表
			_subTableList1.on('click', '.delete', function(e) {
				e.preventDefault();
				var nRow = $(this).closest('tr')[0];
				$(nRow).find("input[name$=rowViewStatus]").val("-1").end().hide();
				_subTableList1.row(nRow).draw();
			}); 
			
			//子表2 行操作：删除子表
			_subTableList2.on('click', '.delete', function(e) {
				e.preventDefault();
				var nRow = $(this).closest('tr')[0];
				$(nRow).find("input[name$=rowViewStatus]").val("-1").end().hide();
				_subTableList2.row(nRow).draw();
			}); 
			
			// 多dataTable显示问题
			$("#tabl1").on('click', function(e) {
				$("#yy-tab-2").css('display', 'none');
			});
			$("#tabl2").on('click', function(e) {
				$("#yy-tab-2").css('display', 'inline');
				_subTableList2.columns.adjust().draw();
			});
			
		});
		
		function onAddRowA(_subTableList, newData) {
			onAddRowx(_subTableList, newData);
			rowNumber++;
		}
		
		function onAddRowB(_subTableList, newData) {
			onAddRowx(_subTableList, newData);
			rowNumber2++;
		}
		
		function onAddRowx(_subTableList, newData) {
			_subTableList.rows.add(newData);
			_subTableList.draw();
			//添加序号
			_subTableList.on('order.dt search.dt',
				    function() {
						var rowNum = 1;
						_subTableList.column(0, {
				            search: 'applied',
				            order: 'applied'
				        }).nodes().each(function(cell, i) {
				        	var htm = cell.innerHTML;
				        	if(htm.indexOf("-1") < 0) {
					        	htm = htm.substring(htm.indexOf("<input"), htm.length);
					            cell.innerHTML = (rowNum) + htm;
					            rowNum++;
				        	}
				        });
			}).draw();
		}
		
		function onAddEditRow(_subTableList, newData) {
			_subTableList.row.add(newData);
			_subTableList.draw();
			//添加序号
			_subTableList.on('order.dt search.dt',
				    function() {
						var rowNum = 1;
						_subTableList.column(0, {
				            search: 'applied',
				            order: 'applied'
				        }).nodes().each(function(cell, i) {
				        	var htm = cell.innerHTML;
				        	if(htm.indexOf("-1") < 0) {
					        	htm = htm.substring(htm.indexOf("<input"), htm.length);
					            cell.innerHTML = (rowNum) + htm;
					            rowNum++;
				        	}
				        });
			}).draw();
		}
		
		
	</script>
</body>
</html>