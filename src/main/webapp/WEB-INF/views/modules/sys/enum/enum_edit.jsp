<%@ page contentType="text/html;charset=UTF-8"%>
<div class="hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">所属模块</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="modulecode" name="modulecode" data-enum-group="sys_moudule"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">分组编码</label>
						<div class="col-md-8">
							<input name="groupcode" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">分组名称</label>
						<div class="col-md-8">
							<input name="groupname" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">说明</label>
						<div class="col-md-10">
							<input name="description" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>