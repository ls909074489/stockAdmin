<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
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
	</div>
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">			
			<label for="search_LIKE_paramtername" class="control-label">版本标题</label>
			<input type="text" autocomplete="on" name="search_LIKE_title" id="search_LIKE_title" class="form-control input-sm">
			
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
			<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 清空
			</button>
		</form>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			
			<thead>
				<tr>
					<th>序号</th>
					<th><input type="checkbox"
								class="group-checkable" data-set="#yy-table-list .checkboxes" /></th>
					<th>操作</th>
					<th>版本标题</th>
					<th>版本号</th>
					<th>版本时间</th>
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>