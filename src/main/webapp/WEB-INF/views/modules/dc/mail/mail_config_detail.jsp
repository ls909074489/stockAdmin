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
				<!-- <div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">SMTP服务器地址</label>
								<div class="col-md-7">
									<input class="form-control" name="smtpAddress"  type="text" value="">
								</div>
								<div class="col-md-3">
									<label class="control-label col-md-4">端口</label>
									<div class="col-md-8">
									<input class="form-control" name="port"  type="text" value="" style="width: 112%;">
									</div>
								</div>
							</div>
						</div>
				</div> -->
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">匿名发送</label>
								<div class="col-md-10">
									<select name="anonymous" class="yy-input-enumdata form-control" data-enum-group="BooleanType"></select>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">发件人地址</label>
								<div class="col-md-10">
									<input class="form-control" name="sendAddress"  type="text" value="">
									</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">发件人显示名称</label>
								<div class="col-md-10">
									<input class="form-control" name="sendName"  type="text" value="">
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">用户名</label>
								<div class="col-md-10">
									<input class="form-control" name="userName"  type="text" value="">
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">密码</label>
								<div class="col-md-10">
									<input class="form-control" name="password"  type="password" value="">
								</div>
							</div>
						</div>
				</div>
				<!-- <div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">是否启用SSL加密</label>
								<div class="col-md-10">
									<select name="isSsl" class="yy-input-enumdata form-control" data-enum-group="BooleanType"></select>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">备注</label>
								<div class="col-md-10">
								<textarea  class="form-control" name="remark"  rows="" cols="">这是忘记密码接口</textarea>
								</div>
							</div>
						</div>
				</div> -->
			</form>
		</div>
</div>