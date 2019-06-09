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
			<form id="yy-form-edit"  class="form-horizontal yy-form-edit">
				<input name="uuid" type="hidden"/>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">接口名称</label>
								<div class="col-md-10"><input class="form-control" name="name"  type="text" value=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">接口地址</label>
								<div class="col-md-10"><input class="form-control" name="address"  type="text" value=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">Key</label>
								<div class="col-md-10"><input class="form-control" name="key"  type="text" value=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">Secret</label>
								<div class="col-md-10"><input class="form-control" name="secret"  type="text" value=""></div>
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
								<textarea  class="form-control" name="remark"  rows="" cols=""></textarea>
								</div>
							</div>
						</div>
				</div>
			</form>
		</div>
</div>
