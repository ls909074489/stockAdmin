<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
	<div class="row yy-toolbar">

		<button id="yy-btn-backtolist" class="btn blue btn-sm">
			<i class="fa fa-mail-reply"></i> 返回
		</button>
	</div>
	<div class="row">
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
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