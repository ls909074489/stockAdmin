<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/department" />
<html>
<head>
<title>业务部门</title>
</head>
<body>

	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
			<div class="input-group" style="padding-bottom: 5px;">
				<input name="currentOrgId" type="hidden"> 
				<input name="currentOrgName" type="text" class="form-control"  readonly="readonly" placeholder="选择所属单元">
				<span class="input-group-btn">
					<button id="yy-def-parentname" class="btn btn-default btn-ref" type="button">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</span>
			</div>
			<div class="row-fluid" style="padding-bottom: 5px;">
				<div class="btn-group btn-group-solid">
					<button id="yy-expandSon" type="button" class="btn btn-sm blue">
						展开
					</button>
					<button id="yy-collapseSon" type="button" class="btn btn-sm green ">
						折叠
					</button>
					<button id="yy-treeRefresh" type="button" class="btn btn-sm blue">
						刷新
					</button>
				</div>
			</div>
			<span class="span12">
				<input name="searchTreeNode" id="searchTreeNode" class="search-query form-control"
				type="text" autocomplete="off" placeholder="查找...">
			</span>
		</div>
		<div id="treeDepartment" class="ztree"></div>
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
			<button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
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
			<form id="yy-form-department" class="form-horizontal">
				<input name="uuid" type="hidden" value=""> 
				<input id="orgId" name="corp.uuid" type="hidden" value="${orgId}"> 
				<input name="isDirect" type="hidden" value="">
				<input name="parentid" type="hidden" value="">
				<input name="islast" type="hidden" value="">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">部门代码</label>
							<div class="col-md-8">
								<input name="code" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">部门名称</label>
							<div class="col-md-8">
								<input name="name" type="text" class="form-control">
							</div>
						</div>
					</div>
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">上级部门</label>
							<div class="col-md-8">
								<div class="input-group">
									<input name="parentid" type="hidden"> <input name="parentname" type="text" class="form-control">
									<span class="input-group-btn">
										<button id="yy-def-parentname" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div> -->
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否启用</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" name="active" data-enum-group="BooleanType">
								</select>
							</div>
						</div>
					</div> -->
				</div>
				<div class="row">
					<!-- <div class="col-md-4">
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
								<input name="createdDate" class="form-control date-picker"></input>
							</div>
						</div>
					</div> -->
					<!-- <div class="col-md-4">
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
								<input class="Wdate form-control" name="verifiedDate"
								type="text" onclick="WdatePicker()">
							</div>
						</div>
					</div> -->
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">备注</label>
							<div class="col-md-10">
								<textarea rows="" cols="" name="memo"  class="form-control"></textarea>
							</div>
						</div>
					</div>
				</div>
				<!-- 系统信息_s -->
				<%@include file="/WEB-INF/views/common/sys/sys_info.jsp"%>
				<!-- 系统信息_e -->
			</form>
		</div>
	</div>
	<%@include file="department_script.jsp"%>
</body>
</html>