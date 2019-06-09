<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row navbar-fixed-top yy-toolbar">
		<button id="yy-btn-add" class="btn blue btn-sm">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		</button>
	</div>
	
	<div class="yy-emptyToolbar"></div>
	
	<div class="row yy-searchbar">
		<div class="row">
		<div class="col-md-2 form-inline">
			<div id="div_col2_filter" data-column="2">
				参数组 <select class="yy-input-enumdata-kv form-control" id="groudcodeList" data-enum-group="sys_moudule"></select>
			</div>

		</div>
		<div class="col-md-3 form-inline">
			<div id="div_col4_filter" data-column="4">
				参数名称 <input type="text" class="column_filter form-control input-sm" id="col4_filter">
			</div>
		</div>
		<div class="col-md-6 form-inline" style="float: right;">
			<div class="dataTables_filter" id="yy-table-list_filter">
				<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm"
					aria-controls="yy-table-list" type="search" placeholder=""></label>
			</div>
		</div>
		</div>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th class="table-checkbox"><input type="checkbox" class="group-checkable"
						data-set="#yy-table-list .checkboxes" /></th>
					<th>操作</th>
					<th>参数组</th>
					<th>参数编码</th>
					<th>参数名称</th>
					<th>参数值</th>
					<th>参数类型</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>