<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		<button id="yy-btn-search">
			<i class="fa fa-search"></i> 查询
		</button>

		<button id="yy-btn-submit" class="btn purple btn-sm">
			<i class="fa fa-share"></i> 提交
		</button>
		<button id="yy-btn-check" class="btn purple btn-sm">
			<i class="fa fa-check"></i> 审核
		</button>
		<button id="yy-btn-back" class="btn purple btn-sm">
			<i class="fa fa-reply"></i> 退回
		</button>

		<button id="yy-btn-import" class="btn green btn-sm">
			<i class="fa fa-file"></i> 导入
		</button>
		<button id="yy-btn-export">
			<i class="fa fa-file-excel-o"></i> 导出
		</button>
		<button id="yy-btn-other" class="btn green btn-sm">
			<i class="fa fa-square-o"></i> 其他
		</button>
	</div>
	<div class="row yy-searchbar">
		<div class="col-md-9 form-inline">
			<div id="div_col1_filter" data-column="1">
				文本 <input type="text" class="column_filter form-control input-sm" id="col1_filter">
			</div>
		</div>
		<div class="col-md-3 form-inline dataTables_filter" >
			快速筛选<input id="global_filter" class="global_filter form-control input-sm" aria-controls="yy-table-list" type="search"
				placeholder="">
		</div>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">

			<thead>
				<tr>
					<th>序号</th>
					<th><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" /></th>
					<th>文本</th>
					<th>数字</th>
					<th>整数</th>
					<th>枚举</th>
					<th>日期</th>
					<th>大文本</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>