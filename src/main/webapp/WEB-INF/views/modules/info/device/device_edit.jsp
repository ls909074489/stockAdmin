<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/device"/>
<html>
<head>
<title>设备信息</title>
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
		<form id="yy-form-edit" class="form-horizontal yy-form-edit" enctype="multipart/form-data">
			<input name="uuid" id="uuid" type="text" class="hide" value="${entity.uuid}">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">厂站</label>
						<div class="col-md-8">
							<div class="input-group input-icon right">
									<input id="stationUuid" name="station.uuid" type="hidden" value="${entity.station.uuid}"> 
									<i class="fa fa-remove" onclick="cleanDef('stationUuid','stationName');" title="清空"></i>
									<input id="stationName" name="stationName" type="text" class="form-control" readonly="readonly" 
										value="${entity.station.name}">
									<span class="input-group-btn">
										<button id="station-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">名称</label>
						<div class="col-md-8">
							<input name="name" id="name" type="text" class="form-control" value="${entity.name}">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">物料分类</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="tid" 
								name="tid" data-enum-group="MaterialClass"></select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">出厂时间</label>
						<div class="col-md-8">
							<input class="Wdate form-control" name="factoryDate" type="text" onclick="WdatePicker()" value="${entity.factoryDate}">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">设备条码</label>
						<div class="col-md-8">
							<input name="barcode" id="barcode" type="text" class="form-control" value="${entity.barcode}" onchange="changeBarcode();">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">应用类型</label>
						<div class="col-md-8">
							<input name="applicate" type="text" class="form-control" value="${entity.applicate}">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">安装时间</label>
						<div class="col-md-8">
							<input class="Wdate form-control" name="setupDate" type="text" onclick="WdatePicker()" value="${entity.setupDate}">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">工序</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="deviceStatus" 
								name="deviceStatus" data-enum-group="WorkingProcedure"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">通道参数</label>
						<div class="col-md-8">
							<input name="argument" type="text" class="form-control" value="${entity.argument}">
						</div>
					</div>
				</div>
			</div>	
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">备注</label>
						<div class="col-md-10">
							<textarea name="context" class="form-control">${entity.context}</textarea>
						</div>
					</div>
				</div>
			</div>	
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div  id="divPreview" style="width: 200px;height: 200px;border:1px solid #ecdddd;">
								<img alt=""  id="imgHeadPhoto" src="${ctx}/${entity.sketchUrl}" style="width: 200px;height: 200px;" onclick="showSketchImg();">
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
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div  id="divPreview" style="width: 200px;height: 200px;border:1px solid #ecdddd;">
								<img alt=""  id="barcodeImgId" src="${ctx}/${entity.barcodeUrl}" style="width: 200px;height: 200px;"  onclick="showBarcodeImg();">
							</div>
						</div>
					</div>
				</div>
			</div>	
			<div class="row" style="font-size: 18px;font-weight: bold;">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							设备图片
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							设备条码
						</div>
					</div>
				</div>
			</div>		
			<%-- <div class="row">
				<div class="col-md-8"  id="imexlate-text-upload">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div class="imexlate-text-input" style="display: none;">
								<input type="text" id="fileName" class="imexlate-fileName" 
									readonly="readonly" value="${entity.sketch}"/>
							</div>
							<div class="imexlate-text-input" style="margin-left:5px;"> 
							
								<button id="yy-btn-findfile" class="btn green btn-sm">
									<i class="fa fa-file-o"></i>&nbsp;浏览
								</button>
								<input type="file" id="multifile" name="attachment"  class="btn" style=""/> 
							</div>
						</div>
					</div>
				</div>
			</div> --%>
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
		
		
		function bindButtonAction(){
			
			$('#station-select-btn').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择厂站',
					shadeClose : false,
					shade : 0.8,
					area : [ '1000px', '90%' ],
					content : '${ctx}/sys/ref/refStationSel?callBackMethod=window.parent.callBackStation'
				});
			});
			
			$('#supplier-select-btn').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择厂商',
					shadeClose : false,
					shade : 0.8,
					area : [ '1000px', '90%' ],
					content : '${ctx}/sys/ref/refSupperlierSel?callBackMethod=window.parent.callBackSelSupplier'
				});
			});
			
			$('#interval-select-btn').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择间隔',
					shadeClose : false,
					shade : 0.8,
					area : [ '1000px', '90%' ],
					content : '${ctx}/sys/ref/refIntervallierSel?callBackMethod=window.parent.callBackInterval'
				});
			});
			
			$("#yy-btn-findfile").bind('click', onfindfileFile);
			$("#multifile").bind('change', onQueryFile);
			
			$(".pimg").click(function(){
				var _this = $(this);//将当前的pimg元素作为_this传入函数
				imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
			});
			
		}

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
				$("#stationUuid").val('${currentStation.uuid}');
				$("#stationName").val('${currentStation.name}');
			} else if ('${openstate}' == 'edit') {
				$("select[name='tid']").val('${entity.tid}');
				$("select[name='deviceStatus']").val('${entity.deviceStatus}');
			}
		}

		//选择文件后
		function onQueryFile(){
			var fileName = this.files[0].name;
			var prefix = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
			$("#fileName").val(this.files[0].name);
			_files=new Array();
			prefix= prefix.toUpperCase();
			if(prefix=='JPG'||prefix=='JPEG'||prefix=='PNG'||prefix=='BMP'){
				//$("#fileName").val(this.files[0].name);
				PreviewImage(this,'imgHeadPhoto','divPreview');
				_files.push(this.files[0]);
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
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'stationName' : {required : true},
					'name' : {required : true,maxlength : 100},
					'tid' : {required : true},
					'deviceStatus' : {required : true},
					'barcode' : {maxlength : 50},
					'applicate' : {maxlength : 50},
					'argument' : {maxlength : 100},
					'context' : {maxlength : 200}
				}
			});
		}
		
		function onSave(isClose) {
			addSubListValid();
			if (!$('#yy-form-edit').valid()) return false;
			doBeforeSave();
			if (!validOther()) return false;
			
			var posturl = "${serviceurl}/addDevice";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined") {
				posturl = "${serviceurl}/updateDevice";
			}
			
			//var formData = new FormData();
			var formData = new FormData($('#yy-form-edit')[0]);
			//_files.push($("#multifile").files[0]);
			//附件
 	        $.each(_files, function(i, file) {
	            formData.append("attachment[]", file,file.name);
	        });
	        //formData.append("uuid", $("#uuid").val());
	        
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
		
		
		//回调选择
		function callBackStation(data){
			$("#stationUuid").val(data.uuid);
			$("#stationName").val(data.name);
		}
		
		
		function showSketchImg(){
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
				showImgByUrl(encodeURI(encodeURI($("#imgHeadPhoto").attr("src"))));
			}
		}
		
		function showBarcodeImg(){
			showImgByUrl(encodeURI(encodeURI($("#barcodeImgId").attr("src"))));
		}
		
		function showImgByUrl(urlPath){
			layer.open({
				type : 2,//type : 1,
				title : '图片预览',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content: '${ctx}/frame/attachment/toViewImg?imgurl='+urlPath
			});
		}
		
		//设备条码
		function changeBarcode(){
			var barcodeLoading = layer.load(2);
				$.ajax({
					type : "POST",
					data :{"qrtext": $("#barcode").val()},
					url : "${serviceurl}/genQrcode",
					async : true,
					dataType : "json",
					success : function(data) {
						console.info(data);
						$("#barcodeImgId").attr("src","${ctx}/"+data.msg);
						layer.close(barcodeLoading);
						if (data.success) {
							YYUI.succMsg(YYMsg.alertMsg('sys-success-todo',['生成设备条码']));
						}else {
							YYUI.promAlert(YYMsg.alertMsg('sys-fail-todo',['生成设备条码'])+data.msg);
						}
					},
					error : function(data) {
						layer.close(barcodeLoading);
						YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
					}
				});
		}
	</script>
</body>
</html>
