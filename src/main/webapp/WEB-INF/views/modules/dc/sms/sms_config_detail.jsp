<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
<div class="row yy-toolbar">
			
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-mail-reply"></i> 返回
			</button>
		</div>
		<div class="row">
			<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
				<input name="uuid" type="hidden"/>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">接口名称</label>
								<div class="col-md-10"><input class="form-control" name="name"  type="text" value="" disabled="disabled"></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">接口地址</label>
								<div class="col-md-10"><input class="form-control" name="address"  type="text" value="" disabled="disabled"></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">Key</label>
								<div class="col-md-10"><input class="form-control" name="key"  type="text" value="" disabled="disabled"></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">Secret</label>
								<div class="col-md-10"><input class="form-control" name="secret"  type="text" value="" disabled="disabled"></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">ext</label>
								<div class="col-md-10"><input class="form-control" name="ext"  type="text" value=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">备注</label>
								<div class="col-md-10">
								<textarea  class="form-control" name="remark"  rows="" cols="" disabled="disabled"></textarea>
								</div>
							</div>
						</div>
				</div>
			</form>
		</div>
</div>