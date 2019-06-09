<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-removeuser" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh">
			<i class="fa fa-refresh"></i> 刷新
		</button>
	</div>
	<div class="row yy-searchbar">
		<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_LIKE_sort_type" class="control-label">登录账号</label>
					<input type="text" class="form-control input-sm" id="search_loginname" name="search_loginname">
					
					
					<label for="search_LIKE_sort_type" class="control-label">用户名称</label>
					<input type="text" class="form-control input-sm" id="search_username" name="search_username">
					
					<!-- <label for="search_LIKE_sort_type" class="control-label">工号</label>
					<input type="text" class="form-control input-sm" id="search_jobnumber" name="search_jobnumber"> -->
					
					<label for="search_usertype" class="control-label">用户类型 </label>
					<select class="yy-input-enumdata form-control" id="search_usertype" name="search_usertype" data-enum-group="UserType"></select>
					
					<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
						<i class="fa fa-trash-o"></i> 清空
					</button>
				</form>
			</div>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">

			<thead>
				<tr>
					<th><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" /></th>
					<th>操作</th>
					<th>登录账号</th>
					<th>用户名</th>
					<!-- <th>工号</th> -->
					<th>性别</th>
					<th>最后登录时间</th>
					<th>状态</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>