<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">			
			<label for="search_LIKE_paramtername" class="control-label">用户名</label>
			<input type="text" autocomplete="on" name="search_LIKE_user.username" id="search_LIKEuserName" class="form-control input-sm">
			<label for="search_LIKE_paramtername" class="control-label">反馈类型</label>
			<!-- <input type="text" autocomplete="on" name="search_LIKE_isSuc" id="search_LIKEisSuc" class="form-control input-sm"> -->
			<select name="search_EQ_feedbackType" id="search_EQ_isSuc" class="form-control input-sm">
				<option value=""></option>
				<option value="0">建议</option>
				<option value="1">异常</option>
				<option value="2">其他</option>
			</select>
			<button id="yy-btn-search" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i>查询
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
					<th>序号</th>
					<th>操作</th>
					<th>用户名</th>
					<th>反馈类型</th>
					<th> 反馈时间</th>
					<th>IP</th>
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>