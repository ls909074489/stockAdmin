<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<link href="${ctx}/assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.min.js"></script>
  <script type="text/javascript" src="${ctx}/assets/umeditor/zh-cn.js"></script>
  
<div class="page-content hide" id="yy-page-edit">
		<div class="row yy-toolbar">
			<button id="yy-btn-savenotice">
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
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">通知分类</label></div>
							<div class="col-md-8"><select class="yy-input-enumdata form-control"  id="noticeCategory"
								name="notice_category" data-enum-group="NoticeCategory" style="width:900px;"></select></div>
						</div>
					</div>
				</div>
				<div class="row">				
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">接收用户类型</label></div>
							<div class="col-md-8"><select class="yy-input-enumdata form-control"  id="notice_type"
								name="notice_type" data-enum-group="UserType" style="width:900px;"></select></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">标题</label></div>
							<div class="col-md-8"><input style="width:900px;" class="form-control" name="notice_title"  type="text"></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<div class="col-md-4"><label class="control-label">内容</label></div>
							<div class="col-md-8">
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<script type="text/plain" id="myEditor" style="width:900px;height:300px;" name="notice_content">
							</script>
							</div>
						</div>
					</div>	
				</div>
				<div style="display:none;">
					<div class="col-md-4"><label class="control-label">通知状态</label></div>
					<div class="col-md-8"><input class="form-control" name="notice_status" defaultValue="未发布" type="text"></div>
					<div class="col-md-4"><label class="control-label">所属系统</label></div>
					<div class="col-md-8"><input class="form-control" name="system_name" defaultValue="" type="text"></div>
				</div>
			</form>
				<!-- 附件上传 -->
			<tags:OssUploadTable id="uploadFiles" />
			
			<!--<input type="button" value="上传文件" onclick="saveFile();"/> -->
		</div>
</div>



<script type="text/javascript">
//实例化编辑器
//var um = UM.getEditor('myEditor');

//实例化编辑器，设置显示的工具栏
$opt={toolbar:[
        'undo redo | bold italic underline strikethrough | forecolor backcolor | image |',
        'insertorderedlist insertunorderedlist ' ,
        '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize',
        ' | fullscreen'
]};
var um = UM.getEditor('myEditor',$opt);
//UM.getEditor('myEditor').setWidth('98%');


function getContent() {
     return UM.getEditor('myEditor').getContent();
}


$("#yy-btn-savenotice").bind("click", function() {
	var noticeContent=getContent();
	
	if(noticeContent!=null&&noticeContent!=''&&noticeContent.length>0){
		if (!$('#yy-form-edit').valid())
			return false;
		
		var posturl = "${serviceurl}/add";
		var pk = $("input[name='uuid']").val();
		if (pk != ""&&typeof(pk) != "undefined" )
			posturl = "${serviceurl}/update";
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success) {
					/* onRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
					doAfterSaveSuccess(data); */
					saveFile(data.records[0].uuid);
				} else {
					YYUI.promAlert("保存出现错误：" + data.msg)
				}
			}
		}
		 $("#yy-form-edit").ajaxSubmit(opt); 
	}else{
		YYUI.promAlert('请填写内容!');
	}
});


	function saveFile(objId){
		//附件用
		_fileUploadTool.saveFiles(objId);
		onRefresh();
		YYUI.setListMode();
	}
	
	//上传之后需要回调的方法，也就是你上传之后需要执行的方法
	function fnCallback(data){
		console.info(data);
	}
</script>