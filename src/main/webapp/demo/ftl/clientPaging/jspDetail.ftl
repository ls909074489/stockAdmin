<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content hide" id="yy-page-detail">
	<div class="row yy-toolbar">
		<button id="yy-btn-backtolist" class="btn blue btn-sm" type="button">
			<i class="fa fa-mail-reply"></i> 返回
		</button>
	</div>
	<div class="row">
		<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden"/>
			<!-- <select class="yy-input-enumdata form-control" id="usertype" name="usertype" data-enum-group="UserType"></select> -->
		<#list fieldList as var>
			<#if var_index%3 == 0>
		<div class="row">
			</#if>
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">${var[1]}</label>
				<div class="col-md-8">
					<#if (var[6]=='select')>
					<select class="yy-input-enumdata form-control" id="${var[0]}" name="${var[0]}" data-enum-group="UserType"></select>
					<#elseif (var[6]=='date')>  
					<input class="Wdate form-control" id="${var[0]}" name="${var[0]}" type="text" onclick="WdatePicker();">
					<#elseif (var[6]=='textarea')>
					<textarea rows="" cols="" class="form-control" id="${var[0]}" name="${var[0]}" style="width: 100%;"></textarea>
					<#else>  
					<input class="form-control" id="${var[0]}" name="${var[0]}"  type="text">
					</#if>
				</div>
			</div>
			</div>	
	<#if (fieldList?size>=3) >
		<#if (fieldList?size==(var_index+1))>
			</div>
		</#if>
		<#if (fieldList?size!=(var_index+1))>
			<#if var_index%3 == 2>
			</div>
			</#if>
		</#if>					
	</#if>
	<#if (fieldList?size<3) >
		<#if (fieldList?size==var_index)>
			</div>
		</#if>
	</#if>
		</#list>
		</form>
	</div>
</div>