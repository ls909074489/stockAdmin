<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-list">
	<div role="form" class="row yy-searchbar form-inline">
		<form id="yy-form-query">			
			<label for="search_LIKE_paramtername" class="control-label">登录帐号 </label>
			<input type="text" autocomplete="on" name="search_LIKE_loginame" id="search_LIKEloginame" class="form-control input-sm">
			<label for="search_LIKE_paramtername" class="control-label">用户名 </label>
			<input type="text" autocomplete="on" name="search_LIKE_userName" id="search_LIKEuserName" class="form-control input-sm">
			
			<!-- <input type="text" autocomplete="on" name="search_LIKE_isSuc" id="search_LIKEisSuc" class="form-control input-sm"> -->
			
			<label class="control-label">登录时间</label> 
			<input type="text" autocomplete="on" name="search_GTE_createtime" style="width: 95px;"
			id="search_GTE_createtime" class="form-control input-sm Wdate" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LTE_createtime\')}'});"> 
			到 
			<input type="text" autocomplete="on" name="search_LTE_createtime" style="width: 95px;"
			id="search_LTE_createtime" class="form-control input-sm Wdate" onclick="WdatePicker({minDate:'#F{$dp.$D(\'search_GTE_createtime\')}'});">
						
			<label for="search_LIKE_paramtername" class="control-label">是否成功</label>	
			<select name="search_EQ_isSuc" id="search_EQ_isSuc" class="form-control input-sm">
				<option value=""></option>
				<option value="1">是</option>
				<option value="0">否</option>
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
					<th>登录帐号</th>
					<th>用户名</th>
					<th>是否成功</th>
					<th>登录时间</th>
					<th>登录IP</th>
					<th>登录浏览器</th>
				</tr>
			</thead>
			<tbody>				
				
			</tbody>
		</table>
	</div>
</div>