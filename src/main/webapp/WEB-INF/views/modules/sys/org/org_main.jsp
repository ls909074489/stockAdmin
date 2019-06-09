<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/org" />
<html>
<head>
<title>业务单元</title>
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
			<button id="yy-btn-remove" class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 删除
			</button>
			<!-- <button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
			</button> -->
			<button id="yy-btn-createStock" class="btn blue btn-sm">
				<i class="fa"></i> 初始仓库
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
			<form id="yy-form-edit" class="form-horizontal">
				<input name="uuid" type="hidden" value=""> <input name="islast" type="hidden" value="">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">机构代码</label>
							<div class="col-md-8">
								<input name="org_code" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">机构名称</label>
							<div class="col-md-8">
								<input name="org_name" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">上级机构</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="selOrgId" name="parentid" type="hidden"> <input id="selOrgName" name="parentname"
										type="text" class="form-control" readonly="readonly"> <span class="input-group-btn">
										<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
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
						<fieldset disabled="disabled">
						<div class="form-group">
							<label class="control-label col-md-4">是否启用</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="active" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
						</fieldset>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否云分仓</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="isCloudStock" data-enum-group="BooleanType" onchange="checkClound(this);">
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否备件中心</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="isCenterStock" data-enum-group="BooleanType" onchange="checkCenter(this);">
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否检测中心</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="isCheckStock" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否高维工厂</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="isRepair" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否网点机构</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="isOutlets" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">创建人</label>
							<div class="col-md-8">
								<input name="creater" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">创建时间</label>
							<div class="col-md-8">
								<input name="createdDate" class="Wdate form-control" type="text" onclick="WdatePicker()">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">审核人</label>
							<div class="col-md-8">
								<input name="verifier" class="form-control"></input>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">审核时间</label>
							<div class="col-md-8">
								<input name="verifiedDate" class="Wdate form-control" type="text" onclick="WdatePicker()">
							</div>
						</div>
					</div>
				</div> -->
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">功能描述</label>
							<div class="col-md-10">
								<textarea name="description" class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
				
				<!-- <div class="row">
					<div class="col-md-1 hos"  style="cursor:pointer;width:100px;"><i class="fa fa-caret-right"></i>系统信息</div>
					<div class="col-md-11" style="margin-left:-30px;margin-top:-12px;"><hr/></div>
				</div>
				<div class="parent">
					 <div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">创建人</label>
								<div class="col-md-8">
									<input name="creater" type="text" class="form-control" disabled>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">创建时间</label>
								<div class="col-md-8">
									<input name="createdtime" type="text" class="form-control date-picker" disabled>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">修改人</label>
								<div class="col-md-8">
									<input name="modify" type="text" class="form-control" disabled>
								</div>
							</div>
						</div>
					</div> 
				 	<div class="row">						
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4">修改时间</label>
								<div class="col-md-8">
									<input name="modifytime" type="text" class="form-control date-picker" disabled>
								</div>
							</div>
						</div>			
					</div> 
				</div> -->
				<!-- 系统信息_s -->
				<%@include file="/WEB-INF/views/common/sys/sys_info.jsp"%>
				<!-- 系统信息_e -->
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