<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/device"/>
<html>
<head>
<title>设备信息</title>
</head>
<body>
	<div id="yy-page-detail" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 返回
			</button>
		</div>
	<div>
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
			<input name="uuid" id="uuid" type="text" class="hide" value="${entity.uuid}">
			<%-- <div class="row">
				<div class="col-md-8"  id="imexlate-text-upload">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div class="imexlate-text-input">
								<input type="text" id="fileName" class="imexlate-fileName" 
									readonly="readonly" value="${entity.sketch}"/>
							</div>
							<div class="imexlate-text-input" style="margin-left:5px;"> 
							
								<button id="yy-btn-findfile" class="btn green btn-sm">
									<i class="fa fa-file-o"></i>&nbsp;浏览
								</button>
								<div class="hide">
										<input type="file" id="multifile" name="attachment" /> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> --%>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">名称</label>
						<div class="col-md-8">
							<input name="name" id="name" type="text" class="form-control" value="${entity.name}">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">设备类型</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="tid" 
								name="tid" data-enum-group="DeviceType"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">间隔</label>
						<div class="col-md-8">
							<div class="input-group">
								<input name="interval.uuid" id="intervalUuid" type="hidden" value="${entity.interval.uuid}"/>
								<input name="intervalName" id="intervalName" type="text" 
									class="form-control" readonly="readonly" value="${entity.interval.name}">
								<span class="input-group-btn">
									<button id="interval-select-btn" class="btn btn-default btn-ref" type="button">
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
						<label class="control-label col-md-4">生产厂商</label>
						<div class="col-md-8">
							<div class="input-group input-icon right">
									<input id="supplierUuid" name="supplier.uuid" type="hidden" value="${entity.supplier.uuid}"> 
									<i class="fa fa-remove" onclick="cleanDef('supplierUuid','supplierName');" title="清空"></i>
									<input id="supplierName" name="supplierName" type="text" class="form-control" readonly="readonly" 
										disabled="disabled" value="${entity.supplier.name}">
									<span class="input-group-btn">
										<button id="supplier-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
						</div>
					</div>
				</div>
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
							<input name="barcode" type="text" class="form-control" value="${entity.barcode}">
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
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">设备状态</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="deviceStatus" 
								name="deviceStatus" data-enum-group="DeviceStatus"></select>
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
		</form>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/detailscript.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			//按钮绑定事件
			bindDetailActions();
			//bindButtonAction();
			setValue();
			
			YYFormUtils.lockForm("yy-form-detail");
		});

		//设置默认值
		function setValue() {
			if ('${openstate}' == 'add') {
				//$("select[name='is_use']").val('1');
			} else if ('${openstate}' == 'detail') {
				$("select[name='tid']").val('${entity.tid}');
				$("select[name='deviceStatus']").val('${entity.deviceStatus}');
			}
		}

		
		function showSketchImg(){
			showImgByUrl(encodeURI(encodeURI($("#imgHeadPhoto").attr("src"))));
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
	</script>
</body>
</html>
