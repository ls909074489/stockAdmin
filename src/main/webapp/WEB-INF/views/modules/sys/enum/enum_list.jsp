<%@ page contentType="text/html;charset=UTF-8"%>

<div class="" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add" class="btn blue btn-sm">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		<button id="yy-btn-export" class="btn green btn-sm btn-info">
			<i class="fa fa-chevron-up"></i> 导出
		</button>
	</div>
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label for="search_LIKE_groupcode" class="control-label">所属模块</label>
			<select class="yy-input-enumdata form-control" name="search_EQ_modulecode" id="search_EQ_modulecode" data-enum-group="sys_moudule"></select>
				
			<label for="search_LIKE_groupcode" class="control-label">分组编码</label>
				<input type="text" autocomplete="on" name="search_LIKE_groupcode" id="search_LIKE_groupcode" class="form-control input-sm">
			<label for="search_LIKE_groupname" class=“control-label”>分组名称</label>
				<input type="text" autocomplete="on" name="search_LIKE_groupname" id="search_LIKE_groupname" class="form-control input-sm">
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
					<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/></th>
					<th>操作</th>
					<th>所属模块</th>
					<th>分组编码</th>
					<th>分组名称</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
	
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
</div>