<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>

	<div class="row">
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden" />
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">所属模块</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="mcode" name="mcode" data-enum-group="sys_moudule"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">提示编码</label>
						<div class="col-md-8">
							<input class="form-control " name="acode" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">提示名称</label>
						<div class="col-md-8">
							<input class="form-control " name="aname" type="text">
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">提示语</label>
						<div class="col-md-10">
							<input class="form-control " name="alertmsg" type="text">
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">多语提示</label>
						<div class="col-md-10">
							<input class="form-control " name="alanguage" type="text">
						</div>
					</div>
				</div>
			</div>

		</form>
	</div>
</div>
