<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="ctx" value="${pageContext.request.contextPath}" />



<div class="page-content" id="yy-page-list">
	<span style="font-size: 48px;color: red;">
	1、注意加上  &lt;%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %/&gt;       作为引入上传插件的标签<br>
	才能显示 &lt;tags:OssUploadTable id="uploadFiles" /&gt;<br>
	2、在一些以layer打开的页面，要在返回其他页面之前保证上传已经上传完，即调用回调方法_fileUploadTool.saveFiles('xx','afterUploadMethod');
	把返回页面、刷新数据等的操作放在回调方法里afterUploadMethod执行
	</span>
	
	<pre>
	var saveWaitLoad;
		
		$(document).ready(function() {
			//第一个参数  uploadFiles     
			//第二个参数userEntity     表示附件的类型，查询附件时将根据 该值和实体id查询相应的附件，建议与对应的实体名一致，例如用户资料需要附件，则使用userEntity作为区分
			_fileUploadTool = new FileUploadTool("uploadFiles","userEntity");//第一个参数为 自定义上传标签的id，第二个参数为关联实体的标示
			//_fileUploadTool.init("edit");//编辑还是查看，edit为编辑模式，其他（建议填写view）为查看模式。查看模式则不显示上传按钮和删除按钮
			//第一个参数表示 查看的模式 edit：编辑       view：查看
			//第二个参数表示10485760  表示文件的大小，请自己算文件的大小不要乱写（不要写英文、中文、特殊字符等非数值，也不建议写小数、分数、负数）
			//第三个参数表示上传文件的类型 ：'doc,docx,xls,xlsx,pdf,txt,zip,rar,jpg,jpeg,png,gif'
			//第四个参数为 5  ：为上传文件的个数
			//注意如果不需要用到，建议写上null
			_fileUploadTool.init("edit",10485760,'doc,docx,xls,xlsx,pdf,txt,zip,rar,jpg,jpeg,png,gif',5);//edit为编辑状态，10485760上传文件大小10m,不需要的可以设置为null
			
			//第一个参数：25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be表示需要查询实体的id，例如用户的附件，在为用户表的uuid
			//第二个参数：edit表示当前为编辑模式（则显示删除和下载按钮），如果为view,则表示查看模式（只显示下载按钮）
			_fileUploadTool.loadFilsTableList('25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be','edit');//参数为实体的id
			//_fileUploadTool.setViewMode  设置为查看模式     _fileUploadTool.setEditMode  设置为编辑模式
			
		});
		
	//点击保存	
	function saveFile(){
		saveWaitLoad=layer.load(2);
		
		//上传附件，注意在保存相应的实体后才调用该方法，并保证在调用该方法之前仍然停留在该页面（例如在编辑页面，在上传之前，不要返回到列表页面）
		//25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be表示你保存实体的id，例如在用户需要上传附件，则保存用户表的uuid，再例如网点资料需要上传附件，则为网点资料表的uuid
		//afterUploadMethod表示上传附件成功后执行的回调方法
		_fileUploadTool.saveFiles('25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be','afterUploadMethod');//第一个参数为实体的id，第二参数为上传之后回调的方法，如果不需要则只需传第一个参数
	}
	
	//上传成功后回调的方法，
	function afterUploadMethod(data){
		layer.close(saveWaitLoad);
		alert("这是上传之后需要回调的方法!");
		 //window.location.reload();
	}
	</pre>
	
	
	<!-- 上传附件插件 -->
	<tags:OssUploadTable id="uploadFiles" />
			
			
	<br><br><br>
	<button id="yy-btn-save"  onclick="saveFile();">
			<i class="fa fa-save"></i>上传文件
	</button>
</div>

<%-- <script type="text/javascript" src="${ctx}/assets/oss/lib/plupload-2.1.2/js/plupload.full.min.js"></script>
<script type="text/javascript" src="${ctx}/assets/oss/upload.js?v=123"></script> --%>

<script type="text/javascript">
		var saveWaitLoad;
		
		$(document).ready(function() {
			//第一个参数  uploadFiles     
			//第二个参数userEntity     表示附件的类型，查询附件时将根据 该值和实体id查询相应的附件，建议与对应的实体名一致，例如用户资料需要附件，则使用userEntity作为区分
			_fileUploadTool = new FileUploadTool("uploadFiles","userEntity");//第一个参数为 自定义上传标签的id，第二个参数为关联实体的标示
			//_fileUploadTool.init("edit");//编辑还是查看，edit为编辑模式，其他（建议填写view）为查看模式。查看模式则不显示上传按钮和删除按钮
			//第一个参数表示 查看的模式 edit：编辑       view：查看
			//第二个参数表示10485760  表示文件的大小，请自己算文件的大小不要乱写（不要写英文、中文、特殊字符等非数值，也不建议写小数、分数、负数）
			//第三个参数表示上传文件的类型 ：'doc,docx,xls,xlsx,pdf,txt,zip,rar,jpg,jpeg,png,gif'
			//第四个参数为 5  ：为上传文件的个数
			//注意如果不需要用到，建议写上null
			_fileUploadTool.init("edit",10485760,'doc,docx,xls,xlsx,pdf,txt,zip,rar,jpg,jpeg,png,gif',5);//edit为编辑状态，10485760上传文件大小10m,不需要的可以设置为null
			
			var selArr=new Array();
			
			//用于设置可以选择类别和备注的上传插件
			/* selArr.push({val:'01',name:'购机人身份证正反面照片111'});
			selArr.push({val:'02',name:'报警回执照片222'});
			selArr.push({val:'03',name:'报警人身份证正反面照片333'});
			_fileUploadTool.setSelect(selArr); */
			
			//第一个参数：25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be表示需要查询实体的id，例如用户的附件，在为用户表的uuid
			//第二个参数：edit表示当前为编辑模式（则显示删除和下载按钮），如果为view,则表示查看模式（只显示下载按钮）
			_fileUploadTool.loadFilsTableList('25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be','edit');//参数为实体的id
			//_fileUploadTool.setViewMode  设置为查看模式     _fileUploadTool.setEditMode  设置为编辑模式
			
		});
		
	//点击保存	
	function saveFile(){
		saveWaitLoad=layer.load(2);
		
		//上传附件，注意在保存相应的实体后才调用该方法，并保证在调用该方法之前仍然停留在该页面（例如在编辑页面，在上传之前，不要返回到列表页面）
		//25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be表示你保存实体的id，例如在用户需要上传附件，则保存用户表的uuid，再例如网点资料需要上传附件，则为网点资料表的uuid
		//afterUploadMethod表示上传附件成功后执行的回调方法
		_fileUploadTool.saveFiles('25e1a3d5-4f0b-4f84-964c-d4fe8bfe64be','afterUploadMethod');//第一个参数为实体的id，第二参数为上传之后回调的方法，如果不需要则只需传第一个参数
	}
	
	
	//上传成功后回调的方法，
	function afterUploadMethod(data){
		layer.close(saveWaitLoad);
		alert("这是上传之后需要回调的方法!");
		 //window.location.reload();
	}
	
</script>