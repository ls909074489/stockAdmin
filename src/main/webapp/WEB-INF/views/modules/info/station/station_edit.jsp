<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/station"/>
<html>
<head>
<title>厂站信息</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="text" class="hide" value="${entity.uuid}">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">名称</label>
						<div class="col-md-8">
							<input name="name" type="text" class="form-control" value="${entity.name}">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">厂站标识</label>
						<div class="col-md-8">
							<input name="mark" type="text" class="form-control" value="${entity.mark}">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">厂站类型</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="type" 
								name="type" data-enum-group="StationType"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">坐标</label>
						<div class="col-md-8">
							<input name="pos" type="text" class="form-control" value="${entity.pos}">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">描述</label>
						<div class="col-md-10">
							<textarea name="description" class="form-control">${entity.description}</textarea>
						</div>
					</div>
				</div>
			</div>
			<%-- <div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div  id="divPreview" style="width: 100px;height: 100px;border:1px solid #ecdddd;">
								<img alt=""  id="imgHeadPhoto" src="${ctx}/${entity.sketchUrl}" style="width: 100px;height: 100px;">
								<!--  点击显示大图片 -->
								<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
									<div id="innerdiv" style="position:absolute;">
										<div align="right">
											<img src="" style="width: 230px;height: 230px;">
										</div>
										<img id="bigimg" style="border:5px solid #fff;" src="" />
									</div>
								</div>
							</div>
							<span id="fileSpanId">
								<input type="file" id="multifile" name="attachment"  class="btn" style=""/>
							</span>
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div  id="divPreview" style="width: 200px;height: 200px;border:1px solid #ecdddd;">
								<img alt=""  id="imgHeadPhoto" src="${ctx}/${entity.sketchUrl}" style="width: 200px;height: 200px;"  onclick="showFilePic();">
								<!--  点击显示大图片 -->
								<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
									<div id="innerdiv" style="position:absolute;">
										<div align="right">
											<img src="" style="width: 230px;height: 230px;">
										</div>
										<img id="bigimg" style="border:5px solid #fff;" src=""/>
									</div>
								</div>
							</div>
							<span id="fileSpanId">
								<input type="file" id="multifile" name="attachment"  class="btn" style=""/>
							</span>
						</div>
					</div>
				</div>
			</div>	
		</form>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	
	<script src="${ctx}/assets/yy/js/preview_image.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();
	</script>
	
	<script type="text/javascript">
		var _files=new Array();
	
		$(document).ready(function() {
			//按钮绑定事件
			bindEditActions();
			bindButtonAction();
			validateForms();
			setValue();
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
			} else if ('${openstate}' == 'edit') {
				$("select[name='type']").val('${entity.type}');
			}
		}
		
		function bindButtonAction(){
			$("#yy-btn-findfile").bind('click', onfindfileFile);
			$("#multifile").bind('change', onQueryFile);
			
			$(".pimg").click(function(){
				var _this = $(this);//将当前的pimg元素作为_this传入函数
				imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
			});
		}

		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'name' : {required : true,maxlength : 100},
					'mark' : {maxlength : 100},
					'type' : {required : true,maxlength : 100},
					'pos' : {maxlength : 100},
					'description' : {maxlength : 200}
				}
			});
		}
		
		//选择文件后
		function onQueryFile(){
			var fileName = this.files[0].name;
			var prefix = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
			$("#fileName").val(this.files[0].name);
			_files=new Array();
			_files.push(this.files[0]);
			
			prefix= prefix.toUpperCase();
			if(prefix=='JPG'||prefix=='JPEG'||prefix=='PNG'||prefix=='BMP'){
				//$("#fileName").val(this.files[0].name);
				PreviewImage(this,'imgHeadPhoto','divPreview');
			}else{
				$("#fileSpanId").html('<input type="file" id="multifile" name="attachment"  class="btn" style=""/>');
				$("#multifile").bind('change', onQueryFile);
				YYUI.failMsg("请上传jpg、jpep、png、bmp文件格式的图片");
			}
		}
		
		//点击浏览
		function onfindfileFile(){
			$("#multifile").click();
		}
		
		function onSave(isClose) {
			addSubListValid();
			if (!$('#yy-form-edit').valid()) return false;
			doBeforeSave();
			if (!validOther()) return false;
			
			var posturl = "${serviceurl}/addStation";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined") {
				posturl = "${serviceurl}/updateStation";
			}
			
			var formData = new FormData($('#yy-form-edit')[0]);
			//附件
 	        $.each(_files, function(i, file) {
	            formData.append("attachment[]", file,file.name);
	        });
	        
	        var editview = layer.load(2);
			
	        $.ajax( {
	        	url : posturl,
				data: formData,
	            cache: false,
	            contentType: false,
	            processData: false,
	            type: 'POST',     
				success : function(data) {
					if (data.success) {
						layer.close(editview);
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
						doAfterSaveSuccess(data.records);
					} else {
						window.parent.YYUI.failMsg("保存失败：" + data.msg);
						layer.close(editview);
					}
				},
				error: function(data){
					window.parent.YYUI.promAlert("保存失败，HTTP错误。");
					layer.close(editview);
				}
			});
		} 
		
		function showFilePic(){
			var file=_files[0];
			if(file!=null&&typeof(file) != "undefined"){
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
						type : 2,//type : 1,
						title : '图片预览',
						shadeClose : false,
						shade : 0.8,
						area : [ '90%', '90%' ],
						//content : '<img width="100%" height="100%" src="'+url+'"  alt="'+data.fileName+'" />' //iframe的url
						content: '${ctx}/frame/attachment/toViewImg?imgurl='+url
					});
				}else{
					YYUI.promAlert("该浏览器不支持未上传图片预览功能");				
				}	
			}else{
				layer.open({
					type : 2,//type : 1,
					title : '图片预览',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					content: '${ctx}/frame/attachment/toViewImg?imgurl='+encodeURI(encodeURI($("#imgHeadPhoto").attr("src")))
				});
			}
		}
	</script>
</body>
</html>
