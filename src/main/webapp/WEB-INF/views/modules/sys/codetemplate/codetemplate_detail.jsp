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
				<div class="row">
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">模板类型</label>
				<div class="col-md-8">
					<input class="form-control" id="templateType" name="templateType"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">java文件路径</label>
				<div class="col-md-8">
					<input class="form-control" id="javaWorkspace" name="javaWorkspace"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">包路径</label>
				<div class="col-md-8">
					<input class="form-control" id="packageName" name="packageName"  type="text">
				</div>
			</div>
			</div>	
			</div>
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">页面保存位置</label>
				<div class="col-md-8">
					<input class="form-control" id="jspWorkspace" name="jspWorkspace"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">访问根地址</label>
				<div class="col-md-8">
					<input class="form-control" id="controllerPath" name="controllerPath"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">页面路径</label>
				<div class="col-md-8">
					<input class="form-control" id="jspPath" name="jspPath"  type="text">
				</div>
			</div>
			</div>	
			</div>
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">表名注释</label>
				<div class="col-md-8">
					<input class="form-control" id="entityChinese" name="entityChinese"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">数据库表名</label>
				<div class="col-md-8">
					<input class="form-control" id="tableName" name="tableName"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">实体名称</label>
				<div class="col-md-8">
					<input class="form-control" id="entityName" name="entityName"  type="text">
				</div>
			</div>
			</div>	
			</div>
		<div class="row">
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">实体父类</label>
				<div class="col-md-8">
					<input class="form-control" id="extendsEntity" name="extendsEntity"  type="text">
				</div>
			</div>
			</div>	
			<div class="col-md-4">
			<div class="form-group">
				<label class="control-label col-md-4">模板名称</label>
				<div class="col-md-8">
					<input class="form-control" id="templateName" name="templateName"  type="text">
				</div>
			</div>
			</div>	
			</div>
		</form>
	</div>
</div>