<%@ page contentType="text/html;charset=UTF-8"%>
<div  id="yy-imexlate-page">
	<div class="row yy-toolbar">
			<button id="yy-import-btn-confirm" class="btn blue btn-sm">
						<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
			<button id="yy-import-btn-cancel" class="btn blue btn-sm">
						<i class="fa fa-rotate-left"></i> 取消
			</button>
	</div>
	<div style="margin-top:20px;padding-left:10px;">
	  <form id="yy-import-file">
		 <input type="file" id="file" name="file" />
	  </form>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#yy-import-btn-confirm").bind('click', confirmImport);//确定导入
		$("#yy-import-btn-cancel").bind('click', imexlateUploadfile);//取消导入
	});
	$('#file').change(function(){
	    var file = this.files[0];
	    name = file.name;
	    size = file.size;
	    type = file.type;
	    //your validation
	});
	//确定导入
	function confirmImport(){
		var url = "${pageContext.request.contextPath}/sys/imexlate/conport";
		 $.ajaxFileUpload({
	            url: url, 
	            type: 'post',
	            fileElementId: 'file', // 上传文件的id、name属性名
	            success: function(data,status){
	            	console.info(data);
	            	var result = data.activeElement.firstChild.data;
	            	result = result.substring(1,result.length-2);
	            	imexlateUploadfile();
	            	determineimport(result);
	            },
	            error: function (data, status, e){
	            	console.info(data);
	            }
	        });
		
		
	}
	//取消导入
	function cancelExport(){
		
	}

</script>