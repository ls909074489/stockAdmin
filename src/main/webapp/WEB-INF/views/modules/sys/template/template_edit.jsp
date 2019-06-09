<%@ page contentType="text/html;charset=UTF-8"%>
<div class="hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">模板名称</label>
						<div class="col-md-8">
							<input name="templateName" type="text" class="form-control">
						</div>
					</div>
				</div>
				
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">主表中文名</label>
						<div class="col-md-8">
							<div class="input-group">
								<input  name="tarelid" type="hidden">
								<input id="coding" name="coding" type="hidden">
								<!-- <input id="tableName" name="tableName" type="hidden">  -->
								<input id="chineseTable" name="chineseTable" type="text" class="form-control"  readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						
							<!-- <input name="tableName" type="text" class="form-control"> -->
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">主表表名</label>
						<div class="col-md-8">
							<input name="tableName" id="tableName" readonly="readonly" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<!-- <div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">查询结果提交地址</label>
						<div class="col-md-8">
							<input name="submitAddress" type="text" class="form-control">
						</div>
					</div>
				</div> -->
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">说明</label>
						<div class="col-md-8">
							<input name="instructions" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>