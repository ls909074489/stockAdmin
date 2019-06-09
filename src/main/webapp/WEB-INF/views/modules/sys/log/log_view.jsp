<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content" id="yy-page-detail">
<div class="row">
			<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden"/>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">操作人：${obj.creator}</label></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">操作时间：${obj.create_ts}</label></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">操作内容：
								<div style="height: 100px;">${obj.log_content}</div>
							</label></div>
						</div>
					</div>
				</div>
			</form>
		</div>
</div>