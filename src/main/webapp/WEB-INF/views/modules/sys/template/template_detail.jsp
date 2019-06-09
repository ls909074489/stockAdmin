<%@ page contentType="text/html;charset=UTF-8"%>
<div class="hide" id="yy-page-detail">
	<div class="row yy-toolbar">
		<button id="yy-btn-backtolist" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 返回
		</button>
	</div>
	<div>
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">模板名称</label>
						<div class="col-md-8">
							<input name="templateName" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">主表中文名</label>
						<div class="col-md-8">
							<input name="chineseTable" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">主表表名</label>
						<div class="col-md-8">
							<input name="tableName" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">说明</label>
						<div class="col-md-8">
							<input name="instructions" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<!-- <div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">查询结果提交地址</label>
						<div class="col-md-10">
							<input name="submitAddress" type="text" class="form-control">
						</div>
					</div>
				</div>
				
			</div> -->
		</form>
	</div>
</div>