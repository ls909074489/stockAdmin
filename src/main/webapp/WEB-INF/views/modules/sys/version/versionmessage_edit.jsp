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
						<label class="control-label col-md-4 required">版本标题</label>
						<div class="col-md-8">
							<input class="form-control " name="title" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">版本</label>
						<div class="col-md-8">
							<input class="form-control " name="version" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">版本内容</label>
						<div class="col-md-10">
							<script type="text/plain" id="myEditor" style="width:900px;height:600px;" name="message"></script>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
