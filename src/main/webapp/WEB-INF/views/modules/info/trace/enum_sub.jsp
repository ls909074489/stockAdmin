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
								<th>追溯物料范围</th>
								<th>所属物料大类</th>
								<th>追溯基线粒度</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
			</div>
		</div>
	</div>
</div>