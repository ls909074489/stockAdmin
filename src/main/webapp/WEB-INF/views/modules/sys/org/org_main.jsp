<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/org" />
<html>
<head>
<title>组织机构信息</title>
<style type="text/css">
/* 设置树的5个按钮的间距 */
.btn-group-sm>.btn, .btn-sm {
	padding: 5px 7px;
}
</style>
</head>
<body>
	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
			<div class="row-fluid">
				<div class="btn-group btn-group-solid">
					<button id="yy-expandSon" type="button" class="btn btn-sm blue">展开</button>
					<button id="yy-collapseSon" type="button" class="btn btn-sm green ">折叠</button>
					<button id="yy-treeRefresh" type="button" class="btn btn-sm blue">刷新</button>
				</div>
			</div>
			<span class="span12"> <input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<!-- <div id="treeOrg" class="ztree"></div> -->
		<div id="ztree" class="ztree"></div>
	</div>

	<div id="maindiv" class="ui-layout-center">
		<div class="row yy-toolbar" id="yy-toolbar-list">
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
			<button id="yy-btn-edit" class="btn blue btn-sm">
				<i class="fa fa-edit"></i> 修改
			</button>
			<button id="yy-btn-remove" class="btn blue btn-sm">
				<i class="fa fa-trash-o"></i> 删除
			</button>
		</div>
		<div class="row yy-toolbar hide" id="yy-toolbar-edit">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left" class="btn blue btn-sm"></i> 取消
			</button>
		</div>
		<div>
			<form id="yy-form-org" class="form-horizontal">
				<input name="uuid" type="hidden" value=""> <input name="islast" type="hidden" value="">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">机构ID</label>
							<div class="col-md-8">
								<input name="org_index" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">机构代码</label>
							<div class="col-md-8">
								<input name="org_code" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">机构名称</label>
							<div class="col-md-8">
								<input name="org_name" type="text" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">上级机构</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="selOrgId" name="parentid" type="hidden"> 
									<fieldset disabled="disabled">
									<input id="selOrgName" name="parentname" type="text" class="form-control" readonly="readonly"> 
									</fieldset>
									<span class="input-group-btn">
										<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">用户组</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="usergroupId" name="usergroup.uuid" type="hidden"> 
									<fieldset disabled="disabled">
										<input id="usergroupName" name="usergroupName" type="text" class="form-control" readonly="readonly"> 
									</fieldset>
									<span class="input-group-btn">
										<button id="yy-usergroup-select-btn" class="btn btn-default btn-ref" type="button">
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
							<label class="control-label col-md-4">是否启用</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="active" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">机构类型</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="orgtype" data-enum-group="OrgType">
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">描述</label>
							<div class="col-md-10">
								<textarea name="description" class="form-control"></textarea>
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
							<span id="fileSpanId">
								<input type="file" id="multifile" name="attachment"  class="btn" style=""/>
							</span>
						</div>
					</div>
				</div>
			</div>	
			</form>
		</div>
	</div>
	<%@include file="org_script.jsp"%>
	
	<!-- 树功能脚本 -->
	<jsp:include page="/WEB-INF/views/common/ztreescript.jsp" flush="true">   
	 	 <jsp:param name="serviceurl" value="${serviceurl}"/>
	     <jsp:param name="dataTreeUrl" value="${ctx}/sys/data/dataOrgList"/>
	     <jsp:param name="onDblClickMethod" value="selfOnClick"/> 
	     <jsp:param name="onClickMethod" value="selfOnClick"/>
	     <jsp:param name="onAsyncSuccessMethod" value="selfOnAsyncSuccess"/>
	     <jsp:param name="treeSearchType" value="1"/>
	</jsp:include> 
</body>
</html>