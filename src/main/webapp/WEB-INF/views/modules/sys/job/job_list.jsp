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
	
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th>序号</th>
					<th>
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/>
					</th>
					<th>操作</th>
					<th>任务名称</th>
					<th>任务分组</th>
					<th>执行方式</th>
					<th>任务表达式</th>
					<th>任务实例ID</th>
					<th>任务状态</th>
					<th>描述</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>



