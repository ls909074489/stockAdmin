<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div class="row yy-toolbar">
		
		<button id="yy-btn-refresh" class="btn blue btn-sm">
			<i class="fa fa-refresh"></i> 刷新
		</button>
		
		<button id="yy-btn-remove" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 删除
		</button>
		
	</div>

	<!-- 查询开始 -->
	<div role="form" class="row yy-searchbar form-inline">
		 <form id="yy-form-query">
			 
			<label for="search_GTE_createtime" class="control-label">执行日期</label>
			<input id="search_GTE_createtime" name="search_GTE_createtime" class="form-control date-picker" type="text"/>   
			<label for="search_LTE_createtime" class="control-label">到</label>
			<input id="search_LTE_createtime" name="search_LTE_createtime" class="form-control date-picker" type="text"/>   
			
			<label for="search_EQ_result" class="control-label">是否成功</label>
			<select class="yy-input-enumdata form-control" id="search_EQ_result" name="search_EQ_result" data-enum-group="timedResult"></select>
			<label for="search_LIKE_description" class="control-label">接口描述</label>
			<input type="text" autocomplete="on" name="search_LIKE_description" id="search_LIKE_description" class="form-control input-sm" />
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
			<button id="yy-searchbar-reset"  type="button"  class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 清空
			</button>
			
		</form> 
	</div>
	<!-- 查询结束 -->
	
	<!-- 列表   --> 
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes"/></th>
					<th>操作</th>
					<th>执行日期</th>
					<th>接口地址</th>
					<th>接口描述</th>
					<th>是否成功</th>
					<th>失败原因</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>


