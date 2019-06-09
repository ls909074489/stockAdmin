<%@ page contentType="text/html;charset=UTF-8"%>


<div class="hide" id="yy-page-edit">
		<div class="row yy-toolbar">
			<button id="yy-btn-save">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>

		<div class="row">
			<form id="yy-form-edit"  class="form-horizontal yy-form-edit">			
				<input name="uuid" type="hidden"/>
							<div class="row">
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4 required">模板名称</label>
								<div class="col-md-8"><input class="form-control " name="templateName"  type="text"></div>
							</div>
						</div>	
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4 required">模板编码</label>
								<div class="col-md-8"><input class="form-control " name="coding"  type="text"></div>
							</div>
						</div>	
						<div class="col-md-4">
							<div class="form-group">
								<label class="control-label col-md-4 required">导出文件名</label>
								<div class="col-md-8"><input class="form-control " name="exportFileName"  type="text"></div>
							</div>
						</div>	
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否创建模板</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" id="iscreate" name="iscreate" data-enum-group="BooleanType"></select>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
</div>
