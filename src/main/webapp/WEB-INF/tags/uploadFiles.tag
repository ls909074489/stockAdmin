<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!-- BEGIN PAGE CONTENT-->
<div id="${id}" class="page-area">
	<div class="yy-toolbar">
		<span id="btnSpan${id}">
		<!-- 按钮的id别改动 add by liusheng -->
			<button id="yy-btn-selectfile" class="btn green btn-sm btn-info">
				<i class="fa fa-file-o"></i> 选择文件
			</button>
			<button id="yy-btn-savefile" class="btn btn-sm btn-info">
				<i class="fa fa fa-save"></i> 保存文件
			</button>
		</span>
		<div class="hide">
			<form action="#" id="fileuploadForm" enctype="multipart/form-data">
				<input type="file" id="multifile" multiple size="80" />
			</form>
		</div>
	</div>
	
	<div class="">
		<table id="yy-table-list-file" class="yy-table">
			<thead>
				<tr>
					<!-- <th class="table-checkbox"><input type="checkbox"
						class="group-checkable" data-set="#yy-table-list-file .checkboxes" /></th> -->
					<th>操作</th>
					<!-- <th>文件类型</th> -->
					<th>文件名称</th>
					<th>文件大小</th>
					<th>上传时间</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>

</div>
<!-- END PAGE CONTENT-->
<script type="text/javascript">
function FileUploadTool(id,entityType){
	var _fileTableList,_deleteFiles=new Array(),_files=new Array();
	var _fileSize=10485760;//上传文件的大小默认10m
	var _fileType;//上传文件的类型
	
	var _fileTableCols = 	[/* {
		data : null,
		sortable : false,
		className : "center",
		width : "30",
		render : RapDataTableUtils.renderCheckCol
	}, */
	{
		data : "uuid",
		className : "center",
		sortable : false,
		render : renderRowAction,
		width : "50"
	},
	/* {
		data : 'fileType',
		width : "15%",
		//render : function(data, type, full){},
		sortable : true
	}, */
	{
		data : 'fileName',
		width : "60%",
		//render : function(data, type, full){},
		sortable : true,
		"render": function (data,type,row,meta ) {
			return renderViewCol(data,type,row,meta);
         }
	},
	{
		data : 'fileSize',
		width : "10%",
		//render : function(data, type, full){},
		sortable : true
	},
	{
		data : 'uploadDate',
		width : "20%",
		//render : function(data, type, full){},
		sortable : true
	}];
	
	function renderRowAction(){
		return "<div class='btn-group yy-btn-actiongroup'>" 
		+ "<button id='yy-btn-downloadfile-row' class='btn btn-xs btn-info' data-rel='tooltip' title='下载'><i class='fa fa-download'></i></button>" 
		+ "<button id='yy-btn-removefile-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>" 
		+ "</div>";
	}
	
	function renderViewCol(data, type, full) {
	    var extStart = data.lastIndexOf(".");
        var ext = data.substring((extStart+1), data.length).toUpperCase();
        if(ext=='JPG'||ext=='JPEG'||ext=='PNG'||ext=='BMP'){
        	//return '<a onclick="showPic(\''+full.url+'\');">'+data+'</a>';
        	return '<a><span id="pic-file-span">'+data+'</span></a>';
        }
		return data;
	}
	
	function showFilePic(data, iDataIndex, nRow){
		var file=getFileByName(_files,data.fileName);
		if(data.uploadDate=='未上传'){
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
					content : '<img width="100%" height="100%" src="'+url+'"  alt="'+data.fileName+'" />' //iframe的url
				});
			}else{
				YYUI.promAlert("该浏览器不支持未上传图片预览功能");				
			}	
		}else{
			layer.open({
				type : 1,
				title : '图片预览',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '<img width="100%" height="100%" src="'+projectPath+"/"+data.url+'"  alt="'+data.fileName+'" />' //iframe的url
			});
		}
	}
	
	//@param entityUuid 所属实体id
	//@param entityType 所属实体类型
	//@param editType 查看类型 编辑或查看 edit/view
	this.loadFilsTableList=function(entityUuid,editType){
		//清空原来的缓存
		_files=new Array();
		$('#'+id+' #fileuploadForm')[0].reset();
		
		if(entityUuid==null||entityUuid==""){
			_fileTableList.clear();
			try {
　　　　			_fileTableList.draw();
		        　} catch(err) {
		        //YYUI.failMsg("加载数据错误");
		        　}
			if(editType=="view"){
				$("#"+id+" .yy-toolbar").hide();
				$("#"+id+" #yy-table-list-file tr td .delete").hide();
			}else{
				$("#"+id+" .yy-toolbar").show();
				$("#"+id+" #yy-table-list-file tr td .delete").show();
			}
			return false;
		}
	
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
				_fileTableList.clear();
				_fileTableList.rows.add(data.records);
				try {
	        　　　　			_fileTableList.draw();
			        　} catch(err) {
			        //YYUI.failMsg("加载数据错误");
			        　}
				if(editType=="view"){
					$("#"+id+" .yy-toolbar").hide();
					$("#"+id+" #yy-table-list-file tr td .delete").hide();
				}else{
					$("#"+id+" .yy-toolbar").show();
					$("#"+id+" #yy-table-list-file tr td .delete").show();
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
	        	YYUI.promAlert("上传文件大于"+changeFileSize(_fileSize));
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
            addRow(file);
	    }
	}
	//转换文件显示的大小
	function changeFileSize(vFileSize){
		var num;
		var v_num;
		 if (vFileSize > 1024 * 1024) {
			 num=vFileSize/(1024 * 1024);
			 v_num=num+"MB";
         } else {
             num=vFileSize/1024;
             v_num=num+"KB";
         }
		 return v_num;
	}
	function addRow(file){
		var tFileName=file.name;
		//var fileType = tFileName.substring((tFileName.lastIndexOf(".")+1), tFileName.length).toUpperCase();//file.type;
		var fileName = tFileName;
		var fileSize = file.size;
		var uploadDate = "未上传";
		var operate = "<div class='btn-group yy-btn-actiongroup'>" 
			+ "<button id='yy-btn-removefile-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>" 
			+ "</div>";
		//addFileToTable
		var newData = [{"uuid":"",
                       //"fileType":fileType,
                       "fileName":fileName,
                       "fileSize":fileSize,
                       "uploadDate":uploadDate}
                       ];
        var nRow;
        try {
        	nRow = _fileTableList.rows.add(newData).draw().nodes()[0];
	        　}  catch(err) {
	        　}
        var aData = _fileTableList.row(nRow).data();
        var jqTds = $('>td', nRow);
        //jqTds[4].innerHTML = operate;
        //setRowStyle(nRow);
		//将要上传的文件保存
		_files.push(file);
	}
	
	
	function setFileRowAction(nRow, aData, iDataIndex){
		$("#yy-btn-downloadfile-row", nRow).click(function() {
			onDownloadRow(aData, iDataIndex, nRow);
		});
		$("#pic-file-span", nRow).click(function() {
			showFilePic(aData, iDataIndex, nRow);
		});
	}
	
	function onDownloadRow(data, iDataIndex, nRow){
		var url="${ctx}/frame/attachment/download";
		var tempForm = document.createElement("form");    
	    tempForm.id="tempForm1";    
	    tempForm.method="post";    
	    tempForm.action=url;    
	    tempForm.target="download window";  
	    var hideInput = document.createElement("input");   
		hideInput.type="hidden";    
	    hideInput.name= "pk"; 
	    hideInput.value= data.uuid; 
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
		var arrChk = $("#"+id+" #yy-table-list-file input[name='chkrow']:checked");
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
		var row = _fileTableList.row(nRow);
        var data = row.data();
        if(typeof(data)==null||data.uuid==''){
        	//新增的直接删除
        	row.remove().draw();
        	$("#"+id+" #fileuploadForm")[0].reset();
        	_files = removeFileByName(_files,data.fileName);
        }else{
       		_deleteFiles.push(data.uuid);//记录需要删除的id，在保存时统一删除
               row.remove().draw();
        }
	}
	
	
	this.clearFiles = function (){
		_files=new Array();
		//清空原来的缓存
		try{
			$('#'+id+' #fileuploadForm')[0].reset();
			_fileTableList.clear();
	　　　　	_fileTableList.draw();
		}catch(e){
			
		}	
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
					YYUI.succMsg("保存成功");
			        if(fnCallback){ 
			        	//fnCallback(data);
			        	 /* var  func=eval(fnCallback);
			        	 console.info(func);
						 new func(); */
			        	eval(fnCallback+"(data)"); 
			        }
			        setTimeout(function(){
				        window.location.reload();
			        }, 1500);
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
	
	this.init = function(operType,vFileSize,vfileType) {
		if(operType=="edit"){//编辑页面
			$("#btnSpan"+id).show();
		}else{
			$("#btnSpan"+id).hide();
		}
		
		//$("#yy-btn-selectfile").show();
		//按钮的id别改动 add by liusheng 
		$("#"+id+" #yy-btn-remove-file").bind('click', onRemoveFile);
		$("#"+id+" #yy-btn-selectfile").bind('click', onSelectFile);
		$("#"+id+" #yy-btn-savefile").bind('click', onSavefileFile);
		$("#"+id+" #multifile").bind('change', onSelectedFiles);
		_fileTableList = $("#"+id+" #yy-table-list-file").DataTable({
			"columns" : _fileTableCols,
			"createdRow" : setFileRowAction,
			"paging" : false,
			"info" : false,
			"sort": false,
			"searching": false,
			"order": [] 
		});
		//行操作：删除子表 文件
		var fileTable = $("#"+id+" #yy-table-list-file");
		fileTable.on('click', '.delete', function (e) {
	        e.preventDefault();
	        var nRow = $(this).closest('tr')[0];
	        removeFileRow(nRow);
	    });
		//设置文件上传的大小
		if(vFileSize){
			_fileSize=vFileSize;
		}
		//设置文件上传的类型
		if(vfileType){
			_fileType=vfileType;
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
	
}
//上传之后需要回调的方法，也就是你上传之后需要执行的方法
/* function fnCallback(data){
	YYUI.promMsg("上传后回调");
} */
</script>