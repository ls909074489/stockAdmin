<%@ page contentType="text/html;charset=UTF-8"%>
<div class="" id="yy-page-list">
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
		<!-- <button  class="btn green btn-sm btn-info" id="yy-btn-import" data-target="#draggable" data-toggle="modal">
				<i class="fa fa-chevron-down"></i> 导入
		</button>
		<button id="yy-btn-export" class="btn green btn-sm btn-info">
				<i class="fa fa-chevron-up"></i> 导出
		</button> -->
		<input type="hidden" value="inportTest" id="export-coding">	
	</div>
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label for="search_LIKE_templateName" class="control-label">模板名称 </label>
				<input type="text" autocomplete="on" name="search_LIKE_templateName" id="search_LIKE_templateName" class="form-control input-sm">
			<label for="search_LIKE_coding" class=“control-label”>模板编码</label>
				<input type="text" autocomplete="on" name="search_LIKE_coding" id="search_LIKE_coding" class="form-control input-sm">
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i> 查询
			</button>
			<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
						<i class="fa fa-trash-o"></i> 清空
			</button>	
		</form>
	</div>
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			
			<thead>
				<tr>
					<th style="width:30px;">
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
					</th>
					<th>操作</th>
					<th>模板名称</th>
					<th>模板编码</th>
					<th>导出文件名</th>
					<th>是否创建模板</th>
					
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>