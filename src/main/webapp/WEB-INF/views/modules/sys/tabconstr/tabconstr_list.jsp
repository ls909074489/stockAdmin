<%@ page contentType="text/html;charset=UTF-8"%>

<div class="" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		<button id="yy-btn-extract" class="btn blue btn-sm btn-info">
			<i class="fa fa-plus"></i> 获取外键信息
		</button>
	</div>
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<div class="col-md-3 form-inline">
				<div id="div_col3_filter" data-column="3">
					数据库名 <input type="text" class="column_filter form-control input-sm" id="col3_filter">
				</div>
				
			</div>
			<div class="col-md-3 form-inline">
				<div id="div_col4_filter" data-column="4">
					表名<input type="text" class="column_filter form-control input-sm" id="col4_filter">
				</div>
			</div>
			<div class="col-md-3 form-inline">
				<div id="div_col5_filter" data-column="5">
					外键名  <input type="text" class="column_filter form-control input-sm" id="col5_filter">
				</div>
			</div>
			<div class="col-md-3 form-inline">
				<div class="dataTables_filter" id="yy-table-list_filter">
					<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder=""></label>
				</div>
			</div>
		</form>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th>序号</th>
					<th class="th_checkbox_width">
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" /></th>
					<th class="th_operation_width">操作</th>
					<th>数据库名</th>
					<th>表名</th>
					<th>外键名</th>
					<th>外键字段</th>
					<th>参考表</th>
					<th>参考字段</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>
