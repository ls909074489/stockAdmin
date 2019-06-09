<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-searchbar">
	
		<div class="col-md-4 form-inline"  style="float: left;">
			<div id="div_col1_filter" data-column="1">
				角色组 <input type="text" class="column_filter form-control input-sm" id="col1_filter">
			</div>
			
		</div>
		<div class="col-md-4 form-inline" style="float: left;">
			<div id="div_col2_filter" data-column="2">
				角色名称<input type="text" class="column_filter form-control input-sm" id="col2_filter">
			</div>
		</div>
		<div class="col-md-4 form-inline" style="float: right;">
			<div class="dataTables_filter" id="yy-table-list_filter">
				<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder=""></label>
			</div>
		</div>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			
			<thead>
				<tr>
					<th>操作</th>
					<th>角色组</th>
					<th>角色名称</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
</div>