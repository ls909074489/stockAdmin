<%@ page contentType="text/html;charset=UTF-8"%>
<div class="yy-tab hide" id="yy-page-sublist">
	<div class="tabbable-line">
		<ul class="nav nav-tabs ">
			<li class="active"><a href="#tab_15_1" data-toggle="tab">枚举数据列表
			</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active">
				<div class="row yy-toolbar">
					<button id="addNewSub" class="btn blue btn-sm">
						<i class="fa fa-plus"></i> 添加条码规则
					</button>
				</div>
					<table id="yy-table-sublist" class="yy-table">
						<thead>
							<tr>
								<th class="table-checkbox"><input type="checkbox"
									class="group-checkable" data-set="#yy-table-sublist .checkboxes" /></th>
								<th>操作</th>	
								<th>条码前缀</th>
								<th>条码名称</th>
								<th>开始截取位置</th>
								<th>截取长度</th>
								<!-- <th>是否默认</th> -->
								<th>条码长度</th>
								<th>显示顺序</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
			</div>
		</div>
	</div>
</div>