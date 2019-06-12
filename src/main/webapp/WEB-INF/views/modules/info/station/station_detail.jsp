<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/station"/>
<html>
<head>
<title>厂站信息</title>
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
			<input name="uuid" type="text" class="hide">
			<%-- <div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2"></label>
						<div class="col-md-8">
							<div style="width: 100px;height: 100px;border:1px solid #ecdddd;">
								<img alt="" src="${ctx}/${entity.sketchUrl}" style="width: 100px;height: 100px;">
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
						<label class="control-label col-md-4">厂站类型</label>
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
				$("select[name='type']").val('${entity.type}');
			}
		}

		function showFilePic(){
			layer.open({
				type : 2,//type : 1,
				title : '图片预览',
				shadeClose : false,
				shade : 0.8,
				area : [ '90%', '90%' ],
				content: '${ctx}/frame/attachment/toViewImg?imgurl='+encodeURI(encodeURI($("#imgHeadPhoto").attr("src")))
			});
		}
	</script>
</body>
</html>
