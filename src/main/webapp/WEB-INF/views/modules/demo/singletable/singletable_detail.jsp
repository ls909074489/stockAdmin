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
						<label class="control-label col-md-4">文本</label>
						<div class="col-md-8">
							<input class="form-control" name="texts" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">数字</label>
						<div class="col-md-8">
							<input class="form-control " name="numbers" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">整数</label>
						<div class="col-md-8">
							<input class="form-control" name="integers" type="text">
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">枚举</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="enumerates" name="enumerates" data-enum-group="enumerates"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">日期</label>
						<div class="col-md-8">
							<input class="form-control date-picker" name="dates" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">描述</label>
						<div class="col-md-10">
							<input class="form-control" name="longtexts" type="text">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>