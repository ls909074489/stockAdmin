<%@ page contentType="text/html;charset=UTF-8"%>
<div class="yy-tab"  id="yy-page-tab">
	<div class="tabbable-line">
	    <ul class="nav nav-tabs ">
	        <li class="active">
	            <a href="#yy-tab-action" data-toggle="tab">按钮权限 </a>
	        </li>
	        <li>
	            <a href="#yy-tab-param" data-toggle="tab">系统参数 </a>
	        </li>
	    </ul>
	    <div class="tab-content">
	        <div class="tab-pane active" id="yy-tab-action">
	           <div id="yy-action-listtoolbar" class="row yy-toolbar" >
	           		<button id="yy-action-edit" class="btn blue btn-sm">
						<i class="fa fa-edit"></i> 编辑
					</button>
				</div>
				<div id="yy-action-edittoolbar" class="row yy-toolbar hide" >
					<button id="yy-ction-save" class="btn blue btn-sm">
						<i class="fa fa-save"></i> 保存
					</button>
					<button id="yy-action-addRow" class="btn blue btn-sm">
						<i class="fa fa-plus"></i> 新增
					</button>
					<button id="yy-ction-delete" class="btn red btn-sm">
						<i class="fa fa-trash-o"></i> 删除
					</button>
					<button id="yy-action-cancel" class="btn blue btn-sm">
						<i class="fa fa-rotate-left"></i> 取消
					</button>
				</div>
				<form id="yy-action-from">
					<table id="yy-action-table" class="yy-table">
						<thead>
							<tr>
								<th class="table-checkbox"><input type="checkbox" class="group-checkable" data-set="#yy-action-table .checkboxes"/></th>
								<th>操作</th>
								<th>按钮编码</th>
								<th>按钮名称</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</form>
	        </div>
	        <div class="tab-pane" id="yy-tab-param">
				
	        </div>
	    </div>
	</div>
</div>