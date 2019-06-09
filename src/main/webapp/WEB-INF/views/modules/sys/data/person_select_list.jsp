<%@ page contentType="text/html;charset=UTF-8"%>

<div class="rap-page-area" id="yy-page-list">
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<input type="hidden" name = "search_EQ_department.uuid" id ="search_departmentId">
			<input type="hidden" name = "deptId" id ="deptId">
			<!-- <label for="search_LIKE_username" class=“control-label”>
				姓名
			</label>
			<input type="text" autocomplete="on" name="search_LIKE_name" id="search_LIKE_name" class="form-control input-sm">
			<label for="search_LIKE_job_number" class=“control-label”>
				员工号
			</label>
			<input type="text" autocomplete="on" name="search_LIKE_job_number" id="search_LIKE_job_number" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
			<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 清空
			</button> -->
		</form>
		<div class="col-md-4 form-inline">
			<div id="div_col1_filter" data-column="1">
				姓名<input type="text" class="column_filter form-control input-sm" id="col1_filter" style="width: 150px;">
			</div>
			
		</div>
		<div class="col-md-4 form-inline">
			<div id="div_col2_filter" data-column="2">
				员工号<input type="text" class="column_filter form-control input-sm" id="col2_filter" style="width: 150px;">
			</div>
		</div>
		<div class="col-md-4 form-inline">
			<div class="dataTables_filter" id="yy-table-list_filter">
				<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder="" style="width: 150px;"></label>
			</div>
		</div>
	</div>
	
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th>操作</th>
					<th>姓名</th>
					<th>员工号</th>
					<th>岗位</th>
					<th>移动电话</th>
					<th>邮箱</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
</div>