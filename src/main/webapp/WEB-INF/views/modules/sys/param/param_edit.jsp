<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>

<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
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
						<label class="control-label col-md-4 required">参数组</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="groudcode" name="groudcode" data-enum-group="sys_moudule"></select>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">参数编码</label>
						<div class="col-md-8">
							<input class="form-control " name="paramtercode" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">参数名称</label>
						<div class="col-md-8">
							<input class="form-control" name="paramtername" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">参数值</label>
						<div class="col-md-8">
							<input class="form-control" name="paramtervalue" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">参数类型</label>
						<div class="col-md-8">
							<input class="form-control" name="paramtertype" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">取值范围</label>
						<div class="col-md-8">
							<input class="form-control" name="valuerange" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">显示顺序</label>
						<div class="col-md-8">
							<input class="form-control" name="showorder" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">描述</label>
						<div class="col-md-10">
							<textarea rows="" cols="" name="description" class="form-control"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>

	</div>
</div>

