<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
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
							<div class="col-md-1"><label class="control-label">通知分类</label></div>
							<div class="col-md-11"><select class="yy-input-enumdata form-control"  id="noticeCategory"
								name="notice_category" data-enum-group="NoticeCategory"></select></div>
						</div>
				</div>
			</div>
			<div class="row">				
				<div class="col-md-12">
					<div class="form-group">
							<div class="col-md-1"><label class="control-label">接收用户类型</label></div>
							<div class="col-md-11">
								<select class="yy-input-enumdata form-control"  id="notice_type"
									name="notice_type" data-enum-group="UserType"></select>
							</div>
						</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<div class="col-md-1"><label class="control-label">标题</label></div>
						<div class="col-md-11"><input class="form-control" name="notice_title" type="text"></div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">
						<div class="col-md-1"><label class="control-label">内容</label></div>
						<div class="col-md-11" >
							<div id="viewContentId"></div>
						</div>
					</div>
				</div>	
			</div>
		</form>
		<tags:OssUploadTable id="viewfiles" />
	</div>
</div>

