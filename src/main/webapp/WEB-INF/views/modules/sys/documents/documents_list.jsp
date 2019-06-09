<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		<button id="yy-btn-add">
			<i class="fa fa-plus"></i> 新增
		</button>
		<button id="yy-btn-remove" class="btn red btn-sm">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		<button id="yy-btn-refresh">
			<i class="fa fa-refresh"></i> 刷新
		</button>

		<button id="yy-btn-clean-cache" class="btn red btn-sm">
			<i class="fa fa-trash-o"></i> 清除所有的缓存
		</button>
		
		<button id="yy-btn-refresh-redis">
			<i class="fa fa-refresh"></i> 同步到缓存
		</button>
		
		<button id="yy-btn-refresh-bill">
			<i class="fa fa-refresh"></i> 缓存同步到单据号
		</button>
	</div>

	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label for="search_LIKE_documentType" class=“control-label”>单据类型</label> <input type="text" autocomplete="on"
				name="search_LIKE_documentType" id="search_LIKE_documentType" class="form-control input-sm"> <label
				for="search_LIKE_prefix" class=“control-label”>前缀</label> <input type="text" autocomplete="on"
				name="search_LIKE_prefix" id="search_LIKE_prefix" class="form-control input-sm"> <label
				for="search_LIKE_documents" class=“control-label”>单据</label> <input type="text" autocomplete="on"
				name="search_LIKE_documents" id="search_LIKE_documents" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
		</form>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">

			<thead>
				<tr>
					<th style="width: 30px;"><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
					</th>
					<th>操作</th>

					<th>单据类型</th>
					<th>前缀</th>
					<th>单据</th>
					<!-- <th>岗位</th> -->
					<th>最新流水号</th>
					<th>归零标志</th>
					<th>流水号上次归零时间</th>
					<th>流水号位数</th>
					<th>年</th>
					<th>月</th>
					<th>日</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>
</div>