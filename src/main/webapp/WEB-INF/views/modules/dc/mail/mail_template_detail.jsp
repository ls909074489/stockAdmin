<%@ page contentType="text/html;charset=UTF-8"%>
<style type="text/css">
div.div2textarea {
	border:1px solid #ccc;
	background:#f2f2f2;
	padding:6px;
	overflow:auto;
}
</style>
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
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">关联单据</label>
								<div class="col-md-10">
									<select name="relevant_bill" class="yy-input-enumdata form-control" data-enum-group="RelevantBill"></select>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">模版编码</label>
								<div class="col-md-4"><input class="form-control" name="code"  type="text" value=""></div>
								<label class="control-label col-md-2">模版名称</label>
								<div class="col-md-4"><input class="form-control" name="name"  type="text" value="" style=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">标题</label>
								<div class="col-md-10">
									<input class="form-control" name="title"  type="text" value="" style="">
								</div>
							</div>
						</div>
				</div> 
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">收件人</label>
								<div class="col-md-10">
									<!-- <input class="form-control" name="receiver"  type="text" value="" style=""> -->
									<textarea id=""  class="form-control" name="receiver"  rows="1" cols=""></textarea>
								</div>
							</div>
						</div>
				</div>
				<!-- <div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">发件岗位</label>
								<div class="col-md-9"><input class="form-control" id="sendStationId" onclick="selectStation('sendStationId');" name="key"  type="text" value="提示短信" style="" readonly="readonly"></div>
								<div class="col-md-1">
									<a href="javascript:;"  onclick="selectStation('sendStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">主送岗位</label>
								<div class="col-md-9">
									<input class="form-control" id="mainStationId" onclick="selectStation('mainStationId');" name="key"  type="text" value="提示短信" style="" readonly="readonly">
								</div>
								<div class="col-md-1">
									<a href="javascript:;" onclick="selectStation('mainStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">抄送岗位</label>
								<div class="col-md-9"><input id="copyStationId" onclick="selectStation('copyStationId');" class="form-control" name="key" type="text" value="提示短信" style="" readonly="readonly"></div>
								<div class="col-md-1">
									<a href="javascript:;" onclick="selectStation('copyStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div> -->
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">模版内容</label>
								<div class="col-md-10">
									<div id="viewContentId" class="div2textarea"></div>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">备注</label>
								<div class="col-md-10">
								<textarea id="remarkId"  class="form-control" name="remark"  rows="" cols=""></textarea>
								</div>
							</div>
						</div>
				</div>
			</form>
		</div>
</div>