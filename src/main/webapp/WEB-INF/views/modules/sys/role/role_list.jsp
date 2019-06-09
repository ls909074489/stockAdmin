<%@ page contentType="text/html;charset=UTF-8"%>

<div class="rap-page-area" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add" class="btn blue btn-sm">
			<i class="fa fa-plus"></i> 新增
		</button>
		  <button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		 </button> 
		<!-- <button id="yy-btn-remove" class="btn blue btn-sm">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-export" class="btn green btn-sm">
			<i class="fa fa-file-excel-o"></i> 导出
		</button>-->
	</div>
	
	<!-- <div role="form" class="row yy-searchbar form-inline"> -->
		<form id="yy-form-query">
			<input type="hidden" name = "search_EQ_rolegroup.uuid" id ="search_rolegroupId">
			<!-- <label for="search_LIKE_username" class=“control-label”>
				角色名称
			</label>
			<input type="text" autocomplete="on" name="search_LIKE_name" id="search_LIKE_name" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
			<button id="rap-searchbar-reset" type="reset">
				<i class="fa fa-undo"></i> 清空
			</button> -->
		</form>
	<!-- </div> -->
	<div class="row yy-searchbar" style="margin-bottom: 1px;">
		<div class="row">
		<div class="col-md-4 form-inline">
			<div id="div_col2_filter" data-column="2">
				角色编码 <input type="text" class="column_filter form-control input-sm" id="col2_filter">
			</div>

		</div>
		<div class="col-md-4 form-inline">
			<div id="div_col3_filter" data-column="3">
				角色名称 <input type="text" class="column_filter form-control input-sm" id="col3_filter">
			</div>
		</div>
		<div class="col-md-4 form-inline">
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
					<th class="table-checkbox">
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
					</th>
					<th>操作</th>
					<th>角色编码</th>
					<th>角色名称</th>
					<th>角色描述</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
</div>