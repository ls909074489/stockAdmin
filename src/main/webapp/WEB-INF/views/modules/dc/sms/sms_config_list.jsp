<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		<!-- <button id="yy-btn-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove">
			<i class="fa fa-trash-o"></i> 删除
		</button> -->
		<button id="yy-btn-refresh">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		<!-- <button id="yy-btn-export">
			<i class="fa fa-file-excel-o"></i> 导出
		</button>	 -->
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			
			<thead>
				<tr>
					<!-- <th>
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
					</th> -->
					<th style="width: 120px;">操作</th>
					<th>接口名称</th>
					<th>接口地址</th>
					<th>Key</th>
					<th>Secret</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>