<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-relate-user" class="btn btn-sm btn-info">
			<i class="fa fa-user"></i> 关联用户
		</button>
		<button id="yy-btn-assign-func" class="btn btn-sm btn-info">
			<i class="icon-cogs"></i> 分配功能
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>

	<div class="row">
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden"> <input name="rolegroup.uuid" type="hidden">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-4 required">角色编码</label>
						<div class="col-md-8">
							<input class="form-control " name="code" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-4 required">角色名称</label>
						<div class="col-md-8">
							<input class="form-control " name="name" type="text">
						</div>
					</div>
				</div>
			</div>
			<div style="height: 10px;"></div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-4">角色描述</label>
						<div class="col-md-8">
							<!-- <input class="form-control" name="description"  type="text"> -->
							<textarea id="roleDescId" rows="" cols="" class="form-control" name="description" style="width: 100%;"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div class="row" id="assDivIdEdit">
		<div class="tabbable">
			<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a href="#user-relation" id="user-relation-tab" data-toggle="tab"> <i
						class="blue icon-magnet bigger-110"></i> 关联用户
				</a></li>

				<li class=""><a href="#function" id="function-tab" data-toggle="tab"> <i class="blue icon-cogs bigger-110"></i>
						分配功能
				</a></li>
			</ul>

			<div class="tab-content">
				<!-- 已关联用户 【开始】 -->
				<div class="tab-pane active" id="user-relation">
					<div class="row-fluid">
						<table id="tableList-AssUser" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th>操作</th>
									<th>登录账号</th>
									<th>工号</th>
									<th>用户名</th>
									<th>所属单元</th>
									<th>最后登录IP</th>
									<th>最后登录时间</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 已关联用户 【结束】 -->

				<!-- 已分配功能【开始】 -->
				<div class="tab-pane" id="function">
					
					<div class="col-md-3">
						<div class="row-fluid">
							<div style="text-align: center;">
								<div class="btn-group btn-group-solid">
									<button id="yy-expandSon2" type="button" class="btn btn-sm blue">
										展开
									</button>
									<button id="yy-collapseSon2" type="button" class="btn btn-sm green ">
										折叠
									</button>
									<button id="yy-treeRefresh2" type="button" class="btn btn-sm blue">
										刷新
									</button>
								</div>
							</div>
							<span class="span12"> <input name="searchTreeNode"
								id="searchTreeNodeEdit" class="search-query form-control"
								type="text" autocomplete="off" placeholder="查找...">
							</span>
						</div>
						<div id="roleFuncTree" class="ztree border-right"></div>
					</div>
						<div class="col-md-9" id="funcAction">
							<button id="yy-btn-save-funcaction" class="btn btn-sm btn-info">
								<i class="fa fa-save"></i> 保存按钮权限
							</button>
						<form id="roleFuncActionsForm">
							<input type="hidden" id="rfaRoleId" name="roleId" value="">
							<input type="hidden" id="rfaFuncId" name="funcId" value="">
							 <table class="table table-hover">
                                   <thead>
                                       <tr>
                                           <th><input type="checkbox" id="selAllFunActionChk"/></th>
                                           <th>按钮编码</th>
                                           <th>按钮名称</th>
                                       </tr>
                                   </thead>
                                   <tbody id="funcActionTbody">
                                   </tbody>
                               </table>
	                      </form>
						</div>
				</div>
				<!-- 已分配功能【结束】 -->
			</div>
		</div>
	</div>
</div>