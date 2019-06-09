<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>
	<div class="row">
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden" />
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务名称</label>
						<div class="col-md-8">
							<input class="form-control" name="jobname" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务编码</label>
						<div class="col-md-8">
							<input class="form-control " name="jobcode" type="text">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务执行类名</label>
						<div class="col-md-8">
							<input class="form-control" name="jobclass" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务实例id</label>
						<div class="col-md-8">
							<input class="form-control" name="jobbeanId" type="text">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">执行规则</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="timedRule" readonly="readonly"
								name="timedRule" data-enum-group="timedRule"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">执行时间</label>
						<div class="col-md-8">
							<input class="Wdate form-control" name="createtime" type="text"
									onclick=" WdatePicker();" readonly="readonly"> 
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">自定义Cron表达式</label>
						<div class="col-md-8">
							<input class="form-control" name="cronExpression" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务分组</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="timedRule" readonly="readonly"
								name="timedRule" data-enum-group="timedGroup"></select>
						</div>		
					</div>
				</div>
			</div>
			
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">任务描述：</label>
						<div class="col-md-8">
							<input class="form-control" name="description" type="text">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>