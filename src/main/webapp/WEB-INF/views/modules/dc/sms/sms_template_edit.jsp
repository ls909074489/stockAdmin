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
								<label class="control-label col-md-2">关联单据</label>
								<div class="col-md-10">
									<select name="relevant_bill" class="yy-input-enumdata form-control" data-enum-group="RelevantBill"></select>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">模版编码</label>
								<div class="col-md-10"><input class="form-control" name="code"  type="text" value=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">模版名称</label>
								<div class="col-md-10"><input class="form-control" name="name"  type="text" value=""></div>
							</div>
						</div>
				</div>
				
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">模版内容</label>
								<div class="col-md-10">
									<textarea  class="form-control" name="content"  rows="" cols=""></textarea>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-10">
							<div class="form-group">
								<label class="control-label col-md-2">发送触发动作</label>
								<div class="col-md-10">
									<select name="send_action" class="yy-input-enumdata form-control" data-enum-group="SendAction"></select>
								</div>
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
