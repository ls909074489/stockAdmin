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
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">			
		<#list fieldList as var>
			<#if (var_index<2) >
			<label for="search_LIKE_paramtername" class=“control-label”>${var[1]} ：</label>
			<input type="text" autocomplete="on" name="search_LIKE_${var[0]}" id="search_LIKE${var[0]}" class="form-control input-sm">
			</#if>
		</#list>

			<button id="rap-searchbar-reset" type="reset">
				<i class="fa fa-undo"></i> 清空
			</button>	
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
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
					<#list fieldList as var>
					<#if (var[4]=='1')><th>${var[1]}</th></#if>
					</#list>					
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>