<%@ page contentType="text/html;charset=UTF-8"%>

<div id="senior" class="modal fade" tabindex="-1"
	style="text-align: center;">
	<div class="modal-content" id="senior-content">
		<div class="senior-header">
			<button type="button" style="margin-top: 5px;" class="close"
				data-dismiss="modal" aria-hidden="true"></button>
			<h4 class="senior-modal-title">
				<i class="fa fa-search-plus"></i>高级查询
			</h4>
		</div>
		<div id="yy-senior-center">
			<div id="yy-senior-leftdiv" class="ui-layout-west" style="overflow:auto">
				<div class="row-fluid"></div>
				<div id="treeFunc" class="ztree"></div>
			</div>

			<div id="yy-senior-maindiv" style="margin-top: 5px;">
				<div>
					<form id="yy-form-senior" class="form-horizontal"
						onsubmit="return false">
						<input type="hidden" id="mainTable" name="mainTable" value="" />
						<div id="yy-senior-div" class="row-fluid"
							style="width: 612px; height: 300px; overflow-y: auto"></div>
					</form>
				</div>
			</div>
		</div>
		<div class="is-modal-footer is-modal-btn">
			<button id="yy-senior-btn-confirm" class="btn blue btn-sm">
				<i class="glyphicon glyphicon-ok"></i> 确定
			</button>
			<button type="button" data-dismiss="modal" id="yy-btn-cancel"
				class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i>取消
			</button>

		</div>
	</div>
</div>