<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-content" id="yy-page-detail">
	<div class="row">
		<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden"/>
			<br>
			<div class="row" style="height: 40px;">				
				<div class="col-md-10">
					<div class="form-group">
							<div class="col-md-10">
								<label class="control-label" style="float: left;width: 10%;text-align: center;">通知分类</label>
								<input id="noticeId" value="${notice.uuid}" type="hidden"></input>
								<div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered"
								 style="float: left;width: 90%;padding-top: 7px;padding-bottom: 3px;padding-left: 5px;">
									 <c:if test="${notice.notice_category=='1'}">常规通知</c:if>
									 <c:if test="${notice.notice_category=='2'}">重要公告</c:if>
									 <c:if test="${notice.notice_category=='3'}">紧急通知</c:if>
								</div>
							</div>
							<%-- <div class="col-md-8">
							<input class="form-control" value="${notice.notice_category}" disabled="disabled"></input>
						    </div> --%>
						</div>
				</div>
			</div>
			<div class="row" style="height: 40px;">
				<div class="col-md-10">
					<div class="form-group">
						<div class="col-md-10">
							<label class="control-label" style="float: left;width: 10%;text-align: center;">标　　题</label>
							<div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered"
							 style="float: left;width: 90%;padding-top: 7px;padding-bottom: 3px;padding-left: 5px;">
							 	${notice.notice_title}
							 </div>
						</div>
						<%-- <div class="col-md-8"><span>${notice.notice_title}</span></div> --%>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10">
					<div class="form-group">
						<div class="col-md-10">
							<label class="control-label" style="float: left;width: 10%;text-align: center;">内　　容</label>
							<div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered"
							 style="float: left;width: 90%;padding-top: 7px;padding-bottom: 3px;padding-left: 5px;">
								${notice.notice_content}
                  			</div>
						</div>
						<%-- <div class="col-md-8" >
							<div id="viewContentId">
								${notice.notice_content}
							</div>
						</div> --%>
					</div>
				</div>	
			</div>
		</form>
		<tags:OssUploadTable id="uploadFiles" />
		<div style="height: 20px;"></div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		
		var uuid = $("#noticeId").val();
		//附件用
		_fileUploadTool = new FileUploadTool("uploadFiles","noticeEntity");
		_fileUploadTool.init();
		_fileUploadTool.loadFilsTableList(uuid, "view");
		
	});
	
	
</script>
