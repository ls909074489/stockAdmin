<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/func" />
<c:set var="subserviceurl" value="${ctx}/sys/funcAction" />
<html>
<head>
<title>功能注册</title>
</head>
<body>

	<div id="leftdiv" class="ui-layout-west">
		<div class="row-fluid">
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
		<div id="ztree" class="ztree"></div>
	</div>

	<div id="maindiv" class="ui-layout-center">
		<div class="row yy-toolbar" id="yy-toolbar-list">
			<!-- <button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
			</button> -->
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
			<button id="yy-btn-edit" class="btn blue btn-sm">
				<i class="fa fa-edit"></i> 修改
			</button>
			<button id="yy-btn-remove" class="btn red btn-sm btn-info">
				<i class="fa fa-trash-o"></i> 删除
			</button>
			<button id="yy-btn-enable" class="btn yellow btn-sm btn-info">
				<i class="fa fa-unlock-alt"></i> 启用
			</button>
			<button id="yy-btn-disenable" class="btn yellow btn-sm btn-info">
				<i class="fa fa-ban"></i> 禁用
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
				<input name="uuid" type="hidden" value=""> 
				<input name="parentid" type="hidden" value="">
				<input name="islast" type="hidden" value="">
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">功能编码</label>
							<div class="col-md-8">
								<input name="func_code" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">功能名称</label>
							<div class="col-md-8">
								<input name="func_name" type="text" class="form-control">
							</div>
						</div>
					</div>
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">上级节点</label>
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
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required-tip">功能类型</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" id="func_type" name="func_type" data-enum-group="functype"></select>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2 required-tip">链接URL</label>
							<div class="col-md-10">
								<input name="func_url" type="text" class="form-control" placeholder="@ctx@/" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否启用</label>
							<div class="col-md-8">
								<fieldset disabled="disabled">
									<select class="yy-input-enumdata form-control" id="usestatus" name="usestatus" data-enum-group="Usestatus"></select>
								</fieldset>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">显示顺序</label>
							<div class="col-md-8">
								<input name="showorder" type="text" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">图标样式</label>
							<div class="col-md-8">
								<div class="input-group">
									<input name="iconcls" id="iconcls" type="text" class="form-control"> <span class="input-group-btn">
										<button id="yy-def-iconcls" class="btn btn-default btn-ref" type="button"
											data-select2-open="single-append-text">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
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
			</form>
			
			<div class="yy-tab" id="yy-page-sublist">
				<div class="tabbable-line">
					<ul class="nav nav-tabs ">
						<li class="active">
							<a href="#tab_15_1" data-toggle="tab">权限按钮	</a>
						</li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active">
							<div class="row yy-toolbar" style="display: none;">
								<button id="addNewSub" class="btn blue btn-sm">
									<i class="fa fa-plus"></i> 添加
								</button>
							</div>
								<table id="yy-table-sublist" class="yy-table">
									<thead>
										<tr>
											<th class="table-checkbox"><input type="checkbox"
												class="group-checkable" data-set="#yy-table-sublist .checkboxes" /></th>
											<th>操作</th>
											<th>按钮编码</th>
											<th>按钮名称</th>
										</tr>
									</thead>
									<tbody id="yy-table-body-sublist">
									</tbody>
								</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 公共脚本 -->
	<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/subcommonscript.jsp"%>
	
	
	<%@include file="func_script.jsp"%>
	
	<!-- 树功能脚本 -->
	<jsp:include page="/WEB-INF/views/common/ztreescript.jsp" flush="true">   
	 	 <jsp:param name="serviceurl" value="${serviceurl}"/>
	     <jsp:param name="dataTreeUrl" value="${ctx}/sys/func/dataFuncList"/>
	     <jsp:param name="onDblClickMethod" value="selfOnClick"/> 
	     <jsp:param name="onClickMethod" value="selfOnClick"/>
	</jsp:include> 
</body>
</html>