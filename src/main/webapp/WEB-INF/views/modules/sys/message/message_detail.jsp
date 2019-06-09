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
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">消息标题</label>
							<div class="col-md-8"><input class="form-control " name="title"  type="text"></div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">消息内容</label>
							<div class="col-md-8"><input class="form-control " name="content"  type="text"></div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">URL链接</label>
							<div class="col-md-8"><input class="form-control " name="link"  type="text"></div>
						</div>
						</div>	
				</div>
				<div class="row">
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否已读</label>
							<div class="col-md-8"><input class="form-control " name="isnew"  type="text"></div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">发送者</label>
							<div class="col-md-8"><input class="form-control " name="sender"  type="text"></div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">接收者</label>
							<div class="col-md-8"><input class="form-control " name="receiver"  type="text"></div>
						</div>
						</div>	
				</div>
				<div class="row">
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">发送时间</label>
							<div class="col-md-8"><input class="form-control " name="sendtime"  type="text"></div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">读取时间</label>
							<div class="col-md-8"><input class="form-control " name="receivetime"  type="text"></div>
						</div>
						</div>	
				</div>
			</form>
		</div>
</div>