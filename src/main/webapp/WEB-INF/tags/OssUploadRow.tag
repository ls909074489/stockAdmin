<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
tr{height:25px;}
a{
text-decoration:none;
}
</style>
<!-- BEGIN PAGE CONTENT-->
<div id="${id}" class="page-area">
	<!-- <div class="hide">
			<form action="#" id="fileuploadForm">
				<input type="file" id="multifile" multiple size="80" />
			</form>
	</div> -->
	<div class="hide">
		<!-- <input type="file" id="multifile" multiple size="80" /> -->
		<input type="file" id="multifile" size="80" />
	</div>
	<span id="btnSpan${id}">
		<button id="yy-btn-selectfile${id}" class="btn green btn-sm btn-info" type="button">
			<i class="fa fa-file-o"></i> 选择文件
		</button>
	</span>
			<!-- <button id="yy-btn-selectfile" class="btn green btn-sm btn-info">
				<i class="fa fa-file-o"></i> 选择文件
			</button> -->
			<span id="yy-upload-file-div" class="" style=""></span>
<!-- 	
	<div class="">
		<div id="yy-upload-file-div" class="" style="">
		</div>
	</div>
	 -->

</div>
<!-- END PAGE CONTENT-->
<script type="text/javascript">
function FileUploadTool(id,entityType){
	var _deleteFiles=new Array(),_files=new Array();
	var _fileSize=4194304;//10485760;//上传文件的大小默认10m
	var _fileType;//上传文件的类型
	var _vfileCount=5;//上传文件的个数
	var _showParentMsg = false;
	
	function renderViewCol(data) {
	    var extStart = data.fileName.lastIndexOf(".");
        var ext = data.fileName.substring((extStart+1), data.fileName.length).toUpperCase();
        
        var tfileName=data.fileName;
        if(tfileName!=null&&tfileName.length>5){
        	tfileName=tfileName.substring(0,5)+"..."+tfileName.substring(tfileName.lastIndexOf("."),tfileName.length);
        }
        if(ext=='JPG'||ext=='JPEG'||ext=='PNG'||ext=='BMP'){
        	return '<a><span id="picOnly-file-span" class="pic-file-span" fileuuid="'+data.uuid+'" fileurl="'+data.url+'" attatype="'+data.attaType+'" title="'+data.fileName+'">'+tfileName+'</span></a>';
        }
		//return data.fileName;
		return '<a><span id="pic-file-span" class="pic-file-span" fileuuid="'+data.uuid+'" fileurl="'+data.url+'" attatype="'+data.attaType+'" title="'+data.fileName+'">'+tfileName+'</span></a>';
	}
	
	function showFilePic(nRow){
		var spanObj=$(nRow).find(".pic-file-span");
		var file=getFileByName(_files,$(spanObj).html());
		if($(spanObj).attr("fileuuid")=='0'){
			//建立一個可存取到該file的url
				var url = null ; 
				try{
					if (window.createObjectURL!=undefined) { // basic
						url = window.createObjectURL(file) ;
					} else if (window.URL!=undefined) { // mozilla(firefox)
						url = window.URL.createObjectURL(file) ;
					} else if (window.webkitURL!=undefined) { // webkit or chrome
						url = window.webkitURL.createObjectURL(file) ;
					}
				} catch(err) {
					url=null;
		        　	}
			if(url){
				layer.open({
					type : 1,
					title : '图片预览',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					content : '<img width="100%" height="100%" src="'+url+'"  alt="'+$(spanObj).html()+'" />' //iframe的url
				});
			}else{
				YYUI.promAlert("该浏览器不支持未上传图片预览功能");				
			}	
		}else{
			
			if($(spanObj).attr("attatype")=='1'){
				//oss上传的附件
				layer.open({
					type : 1,
					title : '图片预览',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					//content : '<img width="100%" height="100%" src="'+$(spanObj).attr("filepreurl")+"/"+$(spanObj).attr("fileurl")+'"  alt="'+$(spanObj).html()+'" />' //iframe的url
					content : '<img width="100%" height="100%" src="${ctx}/frame/attachment/downloadOssFile?pk='+$(spanObj).attr("fileuuid")+'"  alt="'+$(spanObj).html()+'" />'
				});
			}else{
				layer.open({
					type : 1,
					title : '图片预览',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					content : '<img width="100%" height="100%" src="'+projectPath+"/"+$(spanObj).attr("fileurl")+'"  alt="'+$(spanObj).html()+'" />' //iframe的url
				});
			}
		}
	}
	
	//@param entityUuid 所属实体id
	//@param entityType 所属实体类型
	//@param editType 查看类型 编辑或查看 edit/view
	this.loadFilsTableList=function(entityUuid,editType){
		if(editType=="edit"){//编辑页面
			$("#btnSpan"+id).show();
		}else{
			$("#btnSpan"+id).hide();
		}
		//清空原来的缓存
		_files=new Array();
		_deleteFiles=new Array();
		
		//$('#'+id+' #fileuploadForm')[0].reset();
		
		if(entityUuid==null||entityUuid==""){
			if(editType=="view"){
				$("#"+id+" .yy-toolbar").hide();
				$("#"+id+" #yy-upload-file-div .delete").hide();
			}else{
				$("#"+id+" .yy-toolbar").show();
				$("#"+id+" #yy-upload-file-div .delete").show();
			}
			return false;
		}
	
		$("#yy-upload-file-div").html("");
		//加载文件列表 
		var queryData={
				"search_EQ_entityType":entityType,
				"search_EQ_entityUuid":entityUuid,
				"orderby":"modifytime@desc"};
		$.ajax({
			url : '${ctx}/frame/attachment/query',
			data : queryData,
			dataType : 'json',
			success : function(data) {
				if(data.records!=null&&data.records.length>0){
					var fileStr="";
					for(var i=0;i<data.records.length;i++){
						fileStr+='<span style="padding-right: 10px;display:inline-block;" class="fileclass">'+renderViewCol(data.records[i])+'&nbsp;&nbsp;'+
						'<button id="yy-btn-downloadfile-row" class="btn btn-xs btn-info downloadfile" data-rel="tooltip" title="下载">'+
						'<i class="fa fa-download"></i></button>&nbsp;'+
						'<button id="yy-btn-removefile-row"  class="btn btn-xs btn-danger delete removefile" data-rel="tooltip" title="删除">'+
						'<i class="fa fa-trash-o"></i></button></span>';
					}
					$("#yy-upload-file-div").html(fileStr);
					
					setTrAction();//设置行点击事件
					
				}
				if(editType=="view"){
					$("#"+id+" .yy-toolbar").hide();
					$("#"+id+" #yy-upload-file-div .delete").hide();
				}else{
					$("#"+id+" .yy-toolbar").show();
					$("#"+id+" #yy-upload-file-div .delete").show();
				}
			}
		});
	}
	//点击选择文件按钮事件
	function onSelectFile(){
		$("#"+id+" #multifile").click();
	}
	//选择文件后触发事件
	function onSelectedFiles(){
		showAddedFiles();
	}
	function showAddedFiles(){ 
	    var file; 
	    //取得FileList取得的file集合  TODO 圈定当前标签id
	    for(var i = 0 ;i<$("#"+id+" #multifile")[0].files.length;i++){ 
	        file=$("#"+id+" #multifile")[0].files[i]; 
	        if(file.size>_fileSize){
	        	YYUI.promAlert("上传的文件不能大于"+changeFileSize(_fileSize));
	        	return;
	        }
	        
	        var fileName = file.name;
	        var extStart = fileName.lastIndexOf(".");
            var ext = fileName.substring((extStart+1), fileName.length).toUpperCase();
            if(_fileType){
            	var fileTypeArr=_fileType.split(",");
            	var isExitFileType='0';
            	for(var i=0;i<fileTypeArr.length;i++){
            		if(fileTypeArr[i].toUpperCase()==ext){
            			isExitFileType='1';
            			break;
            		}
            	}
            	if(isExitFileType=='0'){
            		YYUI.promAlert("上传文件限于"+_fileType+"格式");
    	        	return;
            	}
            }
            if(_vfileCount){
            	if($("#yy-upload-file-div").find("span.fileclass").length>(_vfileCount-1)){
            		YYUI.promAlert("最多上传"+_vfileCount+"个文件");
            		return;
            	}
            }
            
			//需要先判断 是否同名          再addRow            
            var fileSpanArr=$("#yy-upload-file-div").find("span.pic-file-span");
            if(fileSpanArr!=null&&fileSpanArr.length>0){
            	var fileSpanLen=fileSpanArr.length;
            	var t_fileLen=0;
            	 //判断上传文件是否同名
                fileSpanArr.each(function(){
                	if($(this).html()==file.name){
                		YYUI.promAlert(file.name+"已上传，不能再上传!");
                		return;
                	}
                	t_fileLen++;
                	if(fileSpanLen==t_fileLen){
                        addRow(file);
                	}
                });
            }else{
            	 addRow(file);
            }
	    }
	}
	//转换文件显示的大小
	function changeFileSize(vFileSize){
		var num;
		var v_num;
		 if (vFileSize > 1024 * 1024) {
			 num=vFileSize/(1024 * 1024);
			 v_num=num.toFixed(2)+"MB";
         } else {
             num=vFileSize/1024;
             v_num=num.toFixed(2)+"KB";
         }
		 return v_num;
	}
	
	function addRow(file){
		var tFileName=file.name;
		var fileName = tFileName;
		var fileSize = file.size;
		var uploadDate = "未上传";
		var operate = "<div class='btn-group yy-btn-actiongroup'>" 
			+ "<button id='yy-btn-removefile-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>" 
			+ "</div>";
		var newData = [{"uuid":"0",
                       //"fileType":fileType,
                       "fileName":fileName,
                       "fileSize":fileSize,
                       "uploadDate":uploadDate}
                       ];
		var addFileStr='<span style="padding-right: 10px;display:inline-block;" class="fileclass">'+renderViewCol(newData[0])+'&nbsp;<button id="yy-btn-removefile-row"  class="btn btn-xs btn-danger delete removefile" data-rel="tooltip" title="删除">'+
		'<i class="fa fa-trash-o"></i></button></span>';
		
		$("#yy-upload-file-div").append(addFileStr);
		setTrAction();//设置行点击事件
		//将要上传的文件保存
		_files.push(file);
	}
	
	
	function setFileRowAction(nRow){
		$("#yy-btn-downloadfile-row", nRow).click(function() {
			onDownloadRow(nRow);
		});
		/* $("#yy-btn-removefile-row", nRow).click(function() {
			removeFileRow(nRow);
		}); */
		$("#picOnly-file-span", nRow).click(function() {
			showFilePic(nRow);
		});
	}
	
	function onDownloadRow(nRow){
		var tempFileSpan=$(nRow).find(".pic-file-span");
		var url="${ctx}/frame/attachment/download";
		var tempForm = document.createElement("form");    
	    tempForm.id="tempForm1";    
	    tempForm.method="post";    
	    tempForm.action=url;    
	    tempForm.target="download window";  
	    var hideInput = document.createElement("input");   
		hideInput.type="hidden";    
	    hideInput.name= "pk"; 
	    hideInput.value= $(tempFileSpan).attr("fileuuid"); 
		tempForm.appendChild(hideInput); 
	    document.body.appendChild(tempForm); 
		tempForm.submit();  
		document.body.removeChild(tempForm);
	}
	
	function removeFileByName(files,fileName){
		for(var i = 0;i<files.length;i++){
			if(fileName==files[i].name){
				return files.del(i);
			}
		}
		return files;
	}
	
	//edit by liusheng
	function getFileByName(files,fileName){
		for(var i = 0;i<files.length;i++){
			if(fileName==files[i].name){
				return files[i];
			}
		}
		return null;
	}
	
	function getCheckedRows(){
		var arrChk = $("#"+id+" #yy-upload-file-div input[name='chkrow']:checked");
		var nRows = new Array();
		$.each(arrChk, function (i, checkbox) {
	       var nRow = $(checkbox).closest("tr")[0];
	       nRows.push(nRow);
	    });
		return nRows;
	}
	//批量删除文件
	function onRemoveFile(){
		var nRows = getCheckedRows();
		if(nRows==null||nRows.length==0){
			YYUI.promMsg("请选择需要删除的记录！");
			return;
		}
		layer.confirm("确定要删除吗？",function(){
			for(var i = 0;i<nRows.length;i++){
				removeFileRow(nRows[i]);
			}
		});
	}
	//单行删除文件
	function removeFileRow(nRow){
		var tempFileSpan=$(nRow).find(".pic-file-span");
		layer.confirm("你确实要删除吗？", function(index) {
			layer.close(index);
			//new removeFileApi(nRow);
			if(typeof(tempFileSpan)==null||$(tempFileSpan).attr("fileuuid")=='0'){
	        	//新增的直接删除
	        	$(nRow).remove();
	        	//$("#"+id+" #fileuploadForm")[0].reset();
	        	_files = removeFileByName(_files,$(tempFileSpan).html());
	        }else{
	       		_deleteFiles.push($(tempFileSpan).attr("fileuuid"));//记录需要删除的id，在保存时统一删除
	       		$(nRow).remove();
	        }
		});	
	}
	
	/* this.removeFileApi = function(nRow) {
		if(typeof(tempFileSpan)==null||$(tempFileSpan).attr("fileuuid")=='0'){
        	//新增的直接删除
        	$(nRow).remove();
        	$("#"+id+" #fileuploadForm")[0].reset();
        	_files = removeFileByName(_files,$(tempFileSpan).html());
        }else{
       		_deleteFiles.push($(tempFileSpan).attr("fileuuid"));//记录需要删除的id，在保存时统一删除
       		$(nRow).remove();
        }
	} */
	
	
	this.clearFiles = function (){
		_files=new Array();
		//清空原来的缓存
		/* try{
			$('#'+id+' #fileuploadForm')[0].reset();
			_fileTableList.clear();
	　　　　	_fileTableList.draw();
		}catch(e){
			
		} */	
	}
	//@param entityUuid 所属实体id
	//@param entityType 所属实体类型
	//@param fnCallback（data） 回调函数 可以为空
	this.saveFiles =function(entityUuid,fnCallback) {
		var posturl = "${ctx}/frame/attachment/addAndDelFiles";
		var formData = new FormData();
	    formData.append("entityUuid", entityUuid);
	    formData.append("entityType", entityType);
	    //附件
        $.each(_files, function(i, file) {
            formData.append("attachment[]", file,file.name);
        });
      //删除文件部分
        if(_deleteFiles!=null&&_deleteFiles.length>0){
        	formData.append("deleteFiles[]", _deleteFiles);
        }
        $.ajax( {
			url : posturl,
			data: formData,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',     
			success : function(data) {
				if(data.success){
					//YYUI.succMsg("操作成功");
			        if(fnCallback){
			        	_files=new Array();
			        	_deleteFiles=new Array();
			        	eval(fnCallback+"(data)"); 
			        }
				}
				else{
					YYUI.failMsg("保存出现错误：" + data.msg);
				}
			}
		});
	}
	
	//保存文件
	function onSavefileFile(){
		
		var entityUuid = '${entityUuid}';
		if( entityUuid == undefined || entityUuid==""){
			 YYUI.promAlert('不能单独保存附件!');
			return ;
		}
		_fileUploadTool.saveFiles(entityUuid);
		
	}
	
	this.init = function(operType,vFileSize,vfileType,vfileCount) {
		if(operType=="edit"){//编辑页面
			$("#btnSpan"+id).show();
		}else{
			$("#btnSpan"+id).hide();
		}
		
		//$("#yy-btn-selectfile").show();
		//按钮的id别改动 add by liusheng 
		$("#"+id+" #yy-btn-remove-file").bind('click', onRemoveFile);
		$("#"+id+" #yy-btn-selectfile"+id).bind('click', onSelectFile);
		$("#"+id+" #yy-btn-savefile").bind('click', onSavefileFile);
		$("#"+id+" #multifile").bind('change', onSelectedFiles);

		//行操作：删除子表 文件
		var fileTable = $("#"+id+" #yy-upload-file-div");
		fileTable.on('click', '.delete', function (e) {
	        e.preventDefault();
	        //var nRow = $(this).closest('tr')[0];
	        //removeFileRow(nRow);
	        removeFileRow($(this).parent());
	    });
		//设置文件上传的大小
		if(vFileSize){
			_fileSize=vFileSize;
		}
		//设置文件上传的类型
		if(vfileType){
			_fileType=vfileType;
		}
		//设置上传文件的个数
		if(vfileCount){
			_vfileCount=vfileCount;
		}
	}
	
	this.show = function(){
		if($("#"+id).hasClass("hide"))
			$("#"+id).removeClass("hide");
	}
	this.hide = function(){
		if($("#"+id).hasClass("hide")==false)
			$("#"+id).addClass("hide");
	}
	
	//设置table每行的点击事件
	function setTrAction(){
		$("#yy-upload-file-div").find("span").each(function (){
			setFileRowAction($(this));
		});
	}
	 
}
</script>