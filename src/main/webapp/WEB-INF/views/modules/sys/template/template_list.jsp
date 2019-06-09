<%@ page contentType="text/html;charset=UTF-8"%>

<div class="" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add" class="btn blue btn-sm">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn red btn-sm">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		<button  class="btn btn-sm btn-info"  data-target="#senior" data-toggle="modal">
				<i class="fa fa-search-plus"></i> 高级查询
		</button>
<!-- 		<input id="senior" name="" value="ed04ba0e-3992-4551-b748-930580e940a2" type="hidden">
 -->	</div>
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label for="search_LIKE_groupcode" class="control-label">模板名称 </label>
				<input type="text" autocomplete="on" name="search_LIKE_templateName" id="search_LIKE_groupcode" class="form-control input-sm">
			<label for="search_LIKE_groupname" class=“control-label”>说明</label>
				<input type="text" autocomplete="on" name="search_LIKE_instructions" id="search_LIKE_groupname" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询</button>
		</form>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/></th>
					<th>操作</th>
					<th>模板名称</th>
					<th>主表中文名</th>
					<th>主表表名</th>
					<th>说明</th>
					<th>编码</th>
					
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
</div>