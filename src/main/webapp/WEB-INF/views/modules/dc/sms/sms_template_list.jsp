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
		<button id="yy-btn-export">
			<i class="fa fa-file-excel-o"></i> 导出
		</button>	
	</div>
	<div class="row yy-searchbar">
		<div class="col-md-3 form-inline">
			<div id="div_col2_filter" data-column="2">
				模版名称 <input type="text" name="name" class="column_filter form-control input-sm" id="col2_filter">
			</div>			
		</div>
		<div class="col-md-3 form-inline">
			<div id="div_col3_filter" data-column="3">
				模版编码 <input type="text" name="code" class="column_filter form-control input-sm" id="col3_filter">
			</div>			
		</div>
		<div class="col-md-6 form-inline">
			<div class="dataTables_filter" id="yy-table-list_filter">
				<label>快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search" placeholder=""></label>
			</div>
		</div>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			
			<thead>
				<tr>
					<th style="width:30px;">
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
					</th>
					<th>操作</th>
					<th>模版名称</th>
					<th>模版编码</th>
					<th>关联单据</th>
					<th>发送触发动作</th>
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>