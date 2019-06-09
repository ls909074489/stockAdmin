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
						<label class="control-label col-md-4 required">消息类型</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="msgtype" name="msgtype" data-enum-group="MsgType"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">接收人</label>
						<div class="col-md-8">
							<div class="input-group">
									<input id="userId" name="receiver" type="hidden"> 
									<input id="userName" name="userName" type="text" class="form-control" readonly="readonly" disabled="disabled">
									<span class="input-group-btn">
										<button id="yy-user-select" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">消息标题</label>
						<div class="col-md-10">
							<input class="form-control " name="title" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">消息内容</label>
						<div class="col-md-10">
							<input class="form-control " name="content" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">URL链接</label>
						<div class="col-md-10">
							<input class="form-control " name="link" type="text">
						</div>
					</div>
				</div>
			</div>

		</form>
	</div>
</div>
