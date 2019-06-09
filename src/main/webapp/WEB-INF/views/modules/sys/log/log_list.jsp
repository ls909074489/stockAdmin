<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content" id="yy-page-list">

	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">
			<label class="control-label">登录名 </label> <input type="text" autocomplete="on" name="search_EQ_username"
				id="search_EQ_username" class="form-control input-sm"> <label class="control-label">IP </label> <input
				type="text" autocomplete="on" name="search_EQ_ip" id="search_EQ_ip" class="form-control input-sm"> 
				
				<label
				class="control-label">URL </label> <input type="text" autocomplete="on" name="search_LIKE_url" id="search_LIKE_url"
				class="form-control input-sm"> 
				
				<label class="control-label">时间</label> <input type="text" autocomplete="on"
				name="search_GTE_createtime" style="width: 150px;" id="search_GTE_createtime" class="form-control input-sm Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});"> 到 <input type="text"
				autocomplete="on" name="search_LTE_createtime" style="width: 150px;" id="search_LTE_createtime"
				class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00',minDate:'#F{$dp.$D(\'search_GTE_createtime\')}'});">

			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
			</button>
			<button id="yy-searchbar-reset" type="button" class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 清空
			</button>
		</form>
	</div>

	<div class="row">
		<table id="yy-table-list" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<th class="table-checkbox"><input type="checkbox" class="group-checkable"
						data-set="#yy-table-list .checkboxes" /></th>
					<th>登录名</th>
					<th>时间</th>
					<th>IP</th>
					<th>Url</th>
					<th>类型</th>
					<th>传递参数</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
