<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add" class="btn blue btn-sm">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn blue btn-sm">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		
		<button id="yy-btn-export" class="btn green btn-sm">
			<i class="fa fa-file-excel-o"></i> 导出
		</button>
		
	</div>
	
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label for="search_LIKE_loginname" class="control-label">任务编码</label>
				<input type="text" autocomplete="on" name="search_LIKE_jobcode" id="search_LIKE_jobcode" class="form-control input-sm">
			<label for="search_LIKE_username" class="control-label">任务名称</label>
				<input type="text" autocomplete="on" name="search_LIKE_jobname" id="search_LIKE_jobname" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询</button>
		</form>
	</div>
	
	<div class="row">
		<table id="yy-table-list" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#yy-table.checkboxes"/></th>
					<th>任务编码</th>
					<th>任务名称</th>
					<th>任务执行类名</th>
					<th>任务实例id</th>
					<th>任务描述</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>