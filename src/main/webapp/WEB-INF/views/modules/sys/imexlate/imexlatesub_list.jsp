<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<div class="yy-tab hide" id="yy-page-sublist">
	<div class="tabbable-line">
		<ul class="nav nav-tabs ">
			<li class="active"><a href="#tab_15_1" data-toggle="tab">列名明细
			</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active">
				<div class="row yy-toolbar">
					<button id="addNewSub" class="btn blue btn-sm">
						<i class="fa fa-plus"></i> 添加
					</button>
				</div>
				<div class="table-responsive" style="position: relative; overflow-x:auto; width: 100%;">
					<table id="yy-table-sublist" class="yy-table">
						<thead id = "yy-thead-sublist">
							<tr style="white-space:nowrap;">
								<th class="center" style="width:80px">操作</th>
								<th>导出列号</th>
								<th>字段名</th>
								<th>字段中文名</th>
								<th>是否主表字段</th>
								<th>是否不能为空</th>
								<th>枚举编码</th>
								<th>限定值</th>
								<th>数据类型</th>
							</tr>
						</thead>
						<tbody id="yy-body-sublist">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>