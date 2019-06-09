<%@ page contentType="text/html;charset=UTF-8"%>
<div class="hide" id="yy-page-detail">
	<div class="row yy-toolbar">

		<button id="yy-btn-backtolist" class="btn blue btn-sm">
			<i class="fa fa-mail-reply"></i> 返回
		</button>
	</div>
	<div class="row">
		<!-- <form id="yy-form-detail"  class="form-horizontal yy-form-detail"> -->
		<input name="uuid" type="hidden" />
		<div class="row">
			<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-4">角色编码</label>
						<div class="col-md-8">
							<input class="form-control " name="code" type="text" readonly="readonly">
						</div>
					</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<div class="col-md-4">
						<label class="control-label">角色名称</label>
					</div>
					<div class="col-md-8">
						<input class="form-control" name="name" type="text" readonly="readonly">
					</div>
				</div>
			</div>
		</div>
		<div style="height: 10px;"></div>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<div class="col-md-4">
						<label class="control-label">角色描述</label>
					</div>
					<div class="col-md-8">
						<!-- <input class="form-control" name="description"  type="text"> -->
						<textarea id="roleDescId" rows="" cols="" class="form-control" name="description" style="width: 100%;" readonly="readonly"></textarea>
					</div>
				</div>
			</div>

		</div>
		<!-- </form> -->
	</div>


	<div class="row"  id="assDivIdView">
		<div class="tabbable">
			<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a href="#user-relationView" id="user-relationView-tab" data-toggle="tab"> <i
						class="blue icon-magnet bigger-110"></i> 关联用户
				</a></li>

				<li class=""><a href="#functionView" id="functionView-tab" data-toggle="tab"> <i
						class="blue icon-cogs bigger-110"></i> 分配功能
				</a></li>
			</ul>

			<div class="tab-content">
				<!-- 已关联用户 【开始】 -->
				<div class="tab-pane active" id="user-relationView">
					<div class="row-fluid">
						<table id="tableList-AssUserView" class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
								    <th>登录账号</th>
								    <th>工号</th>
									<th>用户名</th>
									<th>所属单元</th>
									<th>最后登录IP</th>
									<th>最后登录时间</th>
									<!-- <th>操作</th> -->
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 已关联用户 【结束】 -->

				<!-- 已分配功能【开始】 -->
				<div class="tab-pane" id="functionView">
					<div class="col-md-3">
					<div class="row-fluid">
							<div style="text-align: center;">
								<div class="btn-group btn-group-solid">
									<button id="yy-expandSonView" type="button" class="btn btn-sm blue">
										展开
									</button>
									<button id="yy-collapseSonView" type="button" class="btn btn-sm green ">
										折叠
									</button>
									<button id="yy-treeRefreshView" type="button" class="btn btn-sm blue">
										刷新
									</button>
								</div>
							</div>
							<span class="span12"> <input name="searchTreeNode"
								id="searchTreeNodeView" class="search-query form-control"
								type="text" autocomplete="off" placeholder="查找...">
							</span>
						</div>
						<div id="roleFuncTreeView" class="ztree border-right"></div>
					</div>
					<div class="col-md-9" id="funcActionView">
							 <table class="table table-hover">
                                   <thead>
                                       <tr>
                                           <th>是否选择</th>
                                           <th>按钮编码</th>
                                           <th>按钮名称</th>
                                       </tr>
                                   </thead>
                                   <tbody id="funcActionTbodyView">
                                   </tbody>
                               </table>
					</div>
				</div>
				<!-- 已分配功能【结束】 -->
			</div>
		</div>
	</div>




</div>