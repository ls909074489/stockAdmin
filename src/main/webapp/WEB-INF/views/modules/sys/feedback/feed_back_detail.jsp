<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
<div class="row yy-toolbar">
			
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-mail-reply"></i> 返回
			</button>
		</div>
		<div class="row">
				<div class="row">
					<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-1">反馈类型</label>
						<div class="col-md-11">
							<select class="form-control" name="feedbackType" disabled="disabled">
								<option value="0">建议</option>
								<option value="1">异常</option>
								<option value="2">其他</option>
							</select>
						</div>
					</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-1">反馈内容</label>
						<div class="col-md-11">
							<div id="viewContentId"></div>
						</div>
					</div>
					</div>
				</div>
		</div>
</div>