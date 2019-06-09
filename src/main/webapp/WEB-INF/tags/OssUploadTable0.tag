<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- BEGIN PAGE CONTENT-->
<div id="${id}" class="page-area">
	<div class="">
		<!-- <form name=theform>
		<input type="radio" name="myradio" value="local_name" checked=true/> 上传文件名字保持本地文件名字
		<input type="radio" name="myradio" value="random_name" /> 上传文件名字是随机文件名, 后缀保留
		</form> -->
		
		<div id="container">
			<!-- <a id="selectfiles" href="javascript:void(0);" class='btn'>选择文件</a>
			<a id="postfiles" href="javascript:void(0);" class='btn'>开始上传</a> -->
			
			<span id="btnSpan${id}">
				<button id="selectfiles${id}" class="btn green btn-sm btn-info" type="button">
					<i class="fa fa-file-o"></i> 选择文件
				</button>
			</span>
			<div id="ossfile" style="display: inline-block;height: 15px;"></div>
		</div>
		
		<span id="console" style="display: none;"></span>
		
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
	<script type="text/javascript" src="${ctx}/assets/oss/lib/plupload-2.1.2/js/plupload.full.min.js"></script>
	<%-- <script type="text/javascript" src="${ctx}/assets/oss/upload.js?v=223"></script> --%>
	
</div>
<!-- END PAGE CONTENT-->
<script type="text/javascript">
function FileUploadTool(id,entityType){
	
	var t_entityUuid='';
	var t_entityType=entityType;
	var t_fnCallback='';
	var waitUploadLoad;
	
	accessid = ''
	accesskey = ''
	host = ''
	policyBase64 = ''
	signature = ''
	callbackbody = ''
	filename = ''
	key = ''
	expire = 0
	g_object_name = ''
	g_object_name_type = 'random_name'//local_name
	now = timestamp = Date.parse(new Date()) / 1000; 

	
	function send_request()
	{
	    var xmlhttp = null;
	    if (window.XMLHttpRequest)
	    	
	    {
	        xmlhttp=new XMLHttpRequest();
	    }
	    else if (window.ActiveXObject)
	    {
	        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	  
	    if (xmlhttp!=null)
	    {
	    	//serverUrl = 'http://localhost:8080/csc/assets/oss/php/get.php'
	    	serverUrl = projectPath+'/sys/data/getOSSConfigure?entityType='+entityType;
	        xmlhttp.open( "GET", serverUrl, false );
	        xmlhttp.send( null );
	        return xmlhttp.responseText
	    }
	    else
	    {
	        alert("Your browser does not support XMLHTTP.");
	    }
	};

	/*function check_object_radio() {
	    var tt = document.getElementsByName('myradio');
	    for (var i = 0; i < tt.length ; i++ )
	    {
	        if(tt[i].checked)
	        {
	            g_object_name_type = tt[i].value;
	            break;
	        }
	    }
	}*/

	function get_signature()
	{
	    //可以判断当前expire是否超过了当前时间,如果超过了当前时间,就重新取一下.3s 做为缓冲
	    now = timestamp = Date.parse(new Date()) / 1000; 
	    if (expire < now + 3)
	    {
	        body = send_request()
	        var obj = eval ("(" + body + ")");
	        host = obj['host']
	        policyBase64 = obj['policy']
	        accessid = obj['accessid']
	        signature = obj['signature']
	        expire = parseInt(obj['expire'])
	        callbackbody = obj['callback'] 
	        key = obj['dir']
	        return true;
	    }
	    return false;
	};

	function random_string(len) {
	　　len = len || 32;
	　　var chars = 'abcdefghijklmnopqrstuvwxyz123456789';   
	　　var maxPos = chars.length;
	　　var pwd = '';
	　　for (i = 0; i < len; i++) {
	    　　pwd += chars.charAt(Math.floor(Math.random() * maxPos));
	    }
	    return pwd;
	}

	function get_suffix(filename) {
	    pos = filename.lastIndexOf('.')
	    suffix = ''
	    if (pos != -1) {
	        suffix = filename.substring(pos)
	    }
	    return suffix;
	}

	function calculate_object_name(file)
	{
	    if (g_object_name_type == 'local_name')
	    {
	        g_object_name += "${filename}"
	    }
	    else if (g_object_name_type == 'random_name')
	    {
	        suffix = get_suffix(file.name)
	        g_object_name = key+file.id+suffix;//key + random_string(16) + suffix
	    }
	    return ''
	}

	function get_uploaded_object_name(file)
	{
	    /* if (g_object_name_type == 'local_name')
	    {
	        tmp_name = g_object_name
	        tmp_name = tmp_name.replace("${filename}", filename);
	        return tmp_name
	    }
	    else if(g_object_name_type == 'random_name')
	    {
	        return g_object_name
	    } */
	    suffix = get_suffix(file.name)
        g_object_name = key+file.id+suffix;//key + random_string(16) + suffix
        return g_object_name;
	}

	function set_upload_param(up, file, ret)//function set_upload_param(up, filename, ret)
	{
	    if (ret == false)
	    {
	        ret = get_signature()
	    }
	    g_object_name = key;
	   /*  if (filename != '') { suffix = get_suffix(filename)
	        calculate_object_name(filename)
	    } */
	    if (file != '') { 
	    	suffix = get_suffix(file.name)
	        calculate_object_name(file)
	    }
	    new_multipart_params = {
	        'key' : g_object_name,
	        'policy': policyBase64,
	        'OSSAccessKeyId': accessid, 
	        'success_action_status' : '200', //让服务端返回200,不然，默认会返回204
	        'callback' : callbackbody,
	        'signature': signature,
	    };

	    up.setOption({
	        'url': host,
	        'multipart_params': new_multipart_params
	    });

	    up.start();
	}

	//删除
	function removeOssUpFile(fileRemoveBtn,isAdd){
		layer.confirm("你确实要删除吗？", function(index) {
			layer.close(index);
			uploader.removeFile($(fileRemoveBtn).parent().attr("id"));
			$(fileRemoveBtn).parent().remove();
		});	
	}



	var uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight,html4',
		browse_button : 'selectfiles'+id, 
	    //multi_selection: false,
		container: document.getElementById('container'),
		flash_swf_url : 'lib/plupload-2.1.2/js/Moxie.swf',
		silverlight_xap_url : 'lib/plupload-2.1.2/js/Moxie.xap',
	    url : 'http://oss.aliyuncs.com',

	    filters: {
	        mime_types : [ //只允许上传图片和zip文件
	        { title : "Image files", extensions : "jpg,gif,png,bmp,gif" }, 
	        { title : "Zip files", extensions : "zip,rar,7z" },
	        { title : "office files", extensions : "doc,docx,xls,xlsx,ppt,pptx,cvs,pdf,txt" }
	        ],
	        max_file_size : '4mb', //最大只能上传10mb的文件
	        prevent_duplicates : true //不允许选取重复文件
	    },

		init: {
			PostInit: function() {
				//document.getElementById('ossfile').innerHTML = '';
				/* document.getElementById('postfiles').onclick = function() {
	            set_upload_param(uploader, '', false);
	            return false;
				}; */
			},

			FilesAdded: function(up, files) {
				plupload.each(files, function(file) {
					if(file.size>_fileSize){//10485760
						up.removeFile(file.id);
						YYUI.promAlert("上传的文件不能大于4M");
					}else{
						var fileName = file.name;
				        var extStart = fileName.lastIndexOf(".");
			            var ext = fileName.substring((extStart+1), fileName.length).toUpperCase();
			            var isExitFileType='1';
			            if(_fileType){
			            	isExitFileType='0';
			            	var fileTypeArr=_fileType.split(",");
			            	for(var i=0;i<fileTypeArr.length;i++){
			            		if(fileTypeArr[i].toUpperCase()==ext){
			            			isExitFileType='1';
			            			break;
			            		}
			            	}
			            }	
						
			            if(isExitFileType=='1'){
			            	var uploadFileCount=$("#ossfile").find("div").length;
			            	if(uploadFileCount!=null&&uploadFileCount>(_vfileCount-1)){//判断上传文件的个数
			            		up.removeFile(file.id);
				            	YYUI.promAlert("最多上传"+_vfileCount+"个文件");
			            	}else{
			            		//返回文件名start
								/* var newData = [{"uuid":"0",
				                    "fileName":file.name,
				                    "fileSize":file.size
				                    }
				                    ];
									var data=newData[0];
									var t_fileName=data.fileName;
									var extStart = t_fileName.lastIndexOf(".");
									var bext=t_fileName.substring((extStart+1), t_fileName.length);
								    var ext = bext.toUpperCase();
									if(t_fileName.length>10){
										t_fileName=t_fileName.substring(0,10)+"..."+bext;
									}
							        if(ext=='JPG'||ext=='JPEG'||ext=='PNG'||ext=='BMP'){
							        	t_fileName= '<a title="'+data.fileName+'"  style="text-decoration:none;"><span id="pic-file-span" class="pic-file-span" fileuuid="'+data.uuid+'">'+t_fileName+'</span></a>';
							        }else{
							        	t_fileName='<a title="'+data.fileName+'" style="text-decoration:none;">'+t_fileName+'</a>';
							        } */
							      //返回文件名end
								
								/* document.getElementById('ossfile').innerHTML += '<div id="' + file.id + '" isadd="1" style="display: inline-block;float:left;padding-right:10px;">' + t_fileName + ' (' + plupload.formatSize(file.size) + ')<b></b>'
								+'<button id="yy-btn-removefile-row" style="float:right;" class="btn btn-xs btn-danger delete" data-rel="tooltip" title="删除" onclick="removeOssUpFile(this,1);"><i class="fa fa-trash-o"></i></button>'
								//+'<br><div class="progress"><div class="progress-bar" style="width: 0%"></div></div>'
								+'</div>'; */
								
								 addRow(file);
								setTrAction();//设置行点击事件
			            	}
			            	
			            }else{
			            	up.removeFile(file.id);
			            	YYUI.promAlert("上传文件限于"+_fileType+"格式");
			            }
					}
				});
			},

			BeforeUpload: function(up, file) {
	            //check_object_radio();
	            set_upload_param(up, file, true);//set_upload_param(up, file.name, true);
	            
	            waitUploadLoad=layer.load(2);
	        },

			UploadProgress: function(up, file) {
				//上传滚动条
				var d = document.getElementById(file.id);
				//d.getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
				$("#"+file.id).find("b").html('<span>' + file.percent + "%</span>");
				/*var prog = d.getElementsByTagName('div')[0];
	            var progBar = prog.getElementsByTagName('div')[0]
				progBar.style.width= 2*file.percent+'px';
				progBar.setAttribute('aria-valuenow', file.percent);*/
			},

			FileUploaded: function(up, file, info) {
	            if (info.status == 200){
	               // document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = 'upload to oss success, object name:' + get_uploaded_object_name(file.name) + ' 回调服务器返回的内容是:' + info.response;
	            	
	            	/* var posturl = "${ctx}/frame/attachment/addAndDelOssFiles";
	        		var formData = new FormData();
	        	    formData.append("entityUuid", getEntityUUid());
	        	    formData.append("entityType", getEntityType());
	        	    
	        	    formData.append("addFileName",file.name );
	        	    formData.append("addFileSize",file.size);
	        	    formData.append("addFilePath", get_uploaded_object_name(file.name));

	        	    
	                $.ajax( {
	        			url : posturl,
	        			data: formData,
	                    cache: false,
	                    contentType: false,
	                    processData: false,
	                    type: 'POST',     
	        			success : function(data) {
	        				if(data.success){
	        					YYUI.succMsg("操作成功");
	        			        if(fnCallback){
	        			        	eval(fnCallback+"(data)"); 
	        			        }
	        				}
	        				else{
	        					YYUI.failMsg("保存出现错误：" + data.msg);
	        				}
	        			}
	        		}); */
	            }else if (info.status == 203){
	                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '上传到OSS成功，但是oss访问用户设置的上传回调服务器失败，失败原因是:' + info.response;
	            }else{
	                document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = info.response;
	            } 
			},
			UploadComplete:function(up,files){
				
				var formData = new FormData();
        	    formData.append("entityUuid", getEntityUUid());
        	    formData.append("entityType", getEntityType());
        	    
				if(files!=null&&files.length>0){
					/* var addFileNames=new Array();
					var addFileSizes=new Array();
					var addFilePaths=new Array(); */
					for(var i=0;i<files.length;i++){
						/* addFileNames.push(files[i].name);
						addFileSizes.push(files[i].size);
						addFilePaths.push(get_uploaded_object_name(files[i])); */
						
						formData.append("addFileName",files[i].name);
		        	    formData.append("addFileSize",files[i].size);
		        	    formData.append("addFilePath",get_uploaded_object_name(files[i]));
					}
	        	    /* formData.append("addFileName[]",addFileNames);
	        	    formData.append("addFileSize[]",addFileSizes);
	        	    formData.append("addFilePath[]",addFilePaths); */
				}
				//删除文件部分
		        if(_deleteFiles!=null&&_deleteFiles.length>0){
		        	formData.append("deleteFiles[]", _deleteFiles);
		        }
			   $.ajax( {
        			url : "${ctx}/frame/attachment/addAndDelOssFiles",
        			data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',     
        			success : function(data) {
        				if(data.success){
        					plupload.each(files,function(f) { 
        						if(f!=null&&typeof(f.id)!='undefined'){
        							uploader.removeFile(f.id); 
        						}
        	                }); 
        					
        					if(files!=null&&files.length>0){//上传成功后移除曾经上传过的附件
        						for(var i=0;i<files.length;i++){
        							up.removeFile(files[i].id);
        						}
        					}	
        					up.refresh();
        					uploader.refresh();
        					//uploader.init();
        					
        					
        					layer.close(waitUploadLoad);
        					//YYUI.succMsg("操作成功");
        					var fnCB=getFnCallback();
        			        if(fnCB){
        			        	eval(fnCB+"(data)"); 
        			        }
        				}
        				else{
        					YYUI.failMsg("保存出现错误：" + data.msg);
        				}
        			}
        		});
        	
			},
			Error: function(up, err) {
				up.removeFile(err.file.id);//删除失败的文件
				
	            if (err.code == -600) {
	                //document.getElementById('console').appendChild(document.createTextNode("\n选择的文件太大了,可以根据应用情况，在upload.js 设置一下上传的最大大小"));
	            	YYUI.promAlert("上传的文件不能大于4M");
	            }
	            else if (err.code == -601) {
	                document.getElementById('console').appendChild(document.createTextNode("\n选择的文件后缀不对,可以根据应用情况，在upload.js进行设置可允许的上传文件类型"));
	            }
	            else if (err.code == -602) {
	                document.getElementById('console').appendChild(document.createTextNode("\n这个文件已经上传过一遍了"));
	            }
	            else 
	            {
	                document.getElementById('console').appendChild(document.createTextNode("\nError xml:" + err.response));
	            }
			}
		}
	});


	uploader.init();
	
	
	//获取保存数据库的对应实体信息start
	function getEntityType(){
		return t_entityType;
	}
	function getEntityUUid(){
		return t_entityUuid;
	}
	function getFnCallback(){
		return t_fnCallback;
	}
	//获取保存数据库的对应实体信息end
	
	//设置table每行的点击事件
	function setTrAction(){
		/* $("#yy-upload-file-div").find("span").each(function (){
			setFileRowAction($(this));
		}); */
		$("#ossfile").find("div").each(function (){
			if(_showMode=='edit'){
				$(this).find("#yy-btn-removefile-row").show();
				//$("#"+id+" #yy-upload-file-div .delete").show();
			}else{
				$(this).find("#yy-btn-removefile-row").hide();
				//$("#"+id+" #yy-upload-file-div .delete").hide();
			}
			setFileRowAction($(this));
		});
	}
	
	
	var _deleteFiles=new Array(),_files=new Array();
	var _fileSize=4194304;//10485760;//上传文件的大小默认10m
	var _fileType;//上传文件的类型
	var _vfileCount=4;//上传文件的个数
	var _showMode;//编辑或者查看模式
	
	
	var _fileTableCols = 	[
	{
		data : "uuid",
		className : "center",
		sortable : false,
		render : renderRowAction,
		width : "50"
	},
	{
		data : 'fileName',
		width : "60%",
		sortable : true,
		"render": function (data,type,row,meta ) {
			return renderViewCol(data,type,row,meta);
         }
	},
	{
		data : 'fileSize',
		width : "10%",
		sortable : true
	},
	{
		data : 'uploadDate',
		width : "20%",
		sortable : true
	}];
	
	function renderRowAction(data,type,row){
		var actionStr="<div class='btn-group yy-btn-actiongroup'>"; 
		if(row.uploadDate!='未上传'){
			actionStr+="<button id='yy-btn-downloadfile-row' class='btn btn-xs btn-info' data-rel='tooltip' title='下载' type='button'><i class='fa fa-download'></i></button>";
		}
		actionStr+="<button id='yy-btn-removefile-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除' type='button'><i class='fa fa-trash-o'></i></button></div>" ;
		return actionStr;
	}
	
	function renderViewCol(data, type, full) {
	    var extStart = data.lastIndexOf(".");
	    var ext = data.substring((extStart+1), data.length).toUpperCase();
	    if(data.indexOf("span")>0){
	    	 ext = data.substring((extStart+1), (data.length-7)).toUpperCase();
	    }
        if(ext=='JPG'||ext=='JPEG'||ext=='PNG'||ext=='BMP'){
        	return '<a><span id="pic-file-span">'+data+'</span></a>';
        }
		return data;
	}
	
	function showFilePic(data, iDataIndex, nRow){
		var spanObj=$(nRow).find(".pic-file-span");
		var file=uploader.getFile(data.uuid);  
		if(data.uploadDate=='未上传'){
			//建立一個可存取到該file的url
				var url = null ; 
				try{
					/* if (window.createObjectURL!=undefined) { // basic
						url = window.createObjectURL(file) ;
					} else if (window.URL!=undefined) { // mozilla(firefox)
						url = window.URL.createObjectURL(file) ;
					} else if (window.webkitURL!=undefined) { // webkit or chrome
						url = window.webkitURL.createObjectURL(file) ;
					} */
					
					if (file.type == 'image/gif') {//gif使用FileReader进行预览,因为mOxie.Image只支持jpg和png
	                    var fr = new mOxie.FileReader();
	                    fr.onload = function () {
	                       // callback(fr.result);
	                        fr.destroy();
	                        fr = null;
	                    }
	                    fr.readAsDataURL(file.getSource());
	                } else {
	                    var preloader = new mOxie.Image();
	                    preloader.onload = function () {
	                        //preloader.downsize(550, 400);//先压缩一下要预览的图片,宽300，高300
	                        var imgsrc = preloader.type == 'image/jpeg' ? preloader.getAsDataURL('image/jpeg', 80) : preloader.getAsDataURL(); //得到图片src,实质为一个base64编码的数据
	                        //callback && callback(imgsrc); //callback传入的参数为预览图片的url
	                        url=imgsrc;
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
	                        preloader.destroy();
	                        preloader = null;
	                    };
	                    preloader.load(file.getSource());
	                }
					
				} catch(err) {
					url=null;
		        　	}
		}else{
			layer.open({
				type : 1,
				title : '图片预览',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content : '<img width="100%" height="100%" src="${ctx}/frame/attachment/downloadOssFile?pk='+data.uuid+'"  alt="'+data.fileName+'" />'
			});
		}
	}
	
	//@param entityUuid 所属实体id
	//@param entityType 所属实体类型
	//@param editType 查看类型 编辑或查看 edit/view
	this.loadFilsTableList=function(entityUuid,editType){
		
		if(entityUuid==null||entityUuid==""){
			_fileTableList.clear();
			try {
　　　　			_fileTableList.draw();
		        　} catch(err) {
		        //YYUI.failMsg("加载数据错误");
		        　}
			if(editType=="view"){
				$("#btnSpan"+id).hide();
				$("#"+id+" .yy-toolbar").hide();
				$("#"+id+" #yy-table-list-file tr td .delete").hide();
			}else{
				$("#btnSpan"+id).show();
				$("#"+id+" .yy-toolbar").show();
				$("#"+id+" #yy-table-list-file tr td .delete").show();
			}
			return false;
		}
	
		//加载文件列表 
		var queryData={
				"search_EQ_entityType":entityType,
				"search_EQ_entityUuid":entityUuid,
				"orderby":"uploadDate@desc"};
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
					$("#btnSpan"+id).hide();
					$("#"+id+" .yy-toolbar").hide();
					$("#"+id+" #yy-table-list-file tr td .delete").hide();
				}else{
					$("#btnSpan"+id).show();
					$("#"+id+" .yy-toolbar").show();
					$("#"+id+" #yy-table-list-file tr td .delete").show();
				}
			}
		});
	}
	
	
	
	
	function addRow(file){
		//addFileToTable
		var newData = [{"uuid":file.id,
                       //"fileType":fileType,
                       "fileName":file.name,
                       "fileSize":changeFileSize(file.size),
                       "uploadDate":"未上传"}
                       ];
        var nRow;
        try {
        	nRow = _fileTableList.rows.add(newData).draw().nodes()[0];
	        　}  catch(err) {
	        　}
        var aData = _fileTableList.row(nRow).data();
        var jqTds = $('>td', nRow);
        //jqTds[0].innerHTML = operate;
        //setRowStyle(nRow);
	}
	
	//转换文件显示的大小
	function changeFileSize(vFileSize){
		var num;
		var v_num;
		try{
			 if (vFileSize > 1024 * 1024) {
				 num=vFileSize/(1024 * 1024);
				 v_num=num.toFixed(2)+"MB";
	         } else if(vFileSize > 1024){
	             num=vFileSize/1024;
	             v_num=num.toFixed(2)+"KB";
	         }else{
	        	 num=vFileSize;
	             v_num=num.toFixed(2)+"B";
	         }
		}catch(e){
			v_num="";
		}
		 return v_num;
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
		//var tempFileSpan=$(nRow).find(".pic-file-span");
		var url="${ctx}/frame/attachment/downloadOssFile";
		var tempForm = document.createElement("form");    
	    tempForm.id="tempForm1";    
	    tempForm.method="post";    
	    tempForm.action=url;    
	    tempForm.target="download window";  
	    var hideInput = document.createElement("input");   
		hideInput.type="hidden";    
	    hideInput.name= "pk"; 
	    //hideInput.value= $(tempFileSpan).attr("fileuuid"); 
	    hideInput.value= data.uuid; 
		tempForm.appendChild(hideInput); 
	    document.body.appendChild(tempForm); 
		tempForm.submit();  
		document.body.removeChild(tempForm);
	}
	
	//单行删除文件
	function removeFileRow(nRow){
		layer.confirm("你确实要删除吗？", function(index) {
			layer.close(index);
			var row = _fileTableList.row(nRow);
	        var data = row.data();
	        try{
	        	if(typeof(data)==null||data.uuid==''||data.uploadDate=='未上传'){
	        		uploader.removeFile(data.uuid);
	            	//新增的直接删除
	            	row.remove().draw();
	            }else{
	           		_deleteFiles.push(data.uuid);//记录需要删除的id，在保存时统一删除
	                row.remove().draw();
	            }
	        }catch(e){
	        	//console.info(e);
	        }
		});	
	}
	
	
	this.clearFiles = function (){
		_files=new Array();
		//清空原来的缓存
		try{
			_fileTableList.clear();
	　　　　	_fileTableList.draw();
		}catch(e){
			
		}	
	}
	//@param entityUuid 所属实体id
	//@param entityType 所属实体类型
	//@param fnCallback（data） 回调函数 可以为空
	this.saveFiles =function(entityUuid,fnCallback) {
		t_entityUuid=entityUuid;
		t_fnCallback=fnCallback;
		set_upload_param(uploader, '', false);
	}
	
	
	this.init = function(operType,vFileSize,vfileType,vfileCount) {
		if(operType=="edit"){//编辑页面
			$("#btnSpan"+id).show();
		}else{
			$("#btnSpan"+id).hide();
		}
		
		//按钮的id别改动 add by liusheng 

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
	
	//设置为编辑模式
	this.setEditMode=function (){
		$("#btnSpan"+id).show();
		$("#"+id+" .yy-toolbar").show();
		$("#"+id+" #yy-table-list-file tr td .delete").show();
	}
	//设置为查看模式模式
	this.setViewMode=function (){
		$("#btnSpan"+id).show();
		$("#"+id+" .yy-toolbar").hide();
		$("#"+id+" #yy-table-list-file tr td .delete").hide();
	}
}
//上传之后需要回调的方法，也就是你上传之后需要执行的方法
/* function fnCallback(data){
	YYUI.promMsg("上传后回调");
} */
</script>