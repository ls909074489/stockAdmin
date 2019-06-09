<%@ page contentType="text/html;charset=UTF-8"%>

<!-- 系统信息_s -->
<fieldset disabled>
	<div class="row">
		<div class="hos hosleft">
			<i class="fa fa-caret-right"></i>系统信息
		</div>
		<div class="hosright"></div>
	</div>
	<div class="parent">
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">单据状态</label>
					<div class="col-md-8">
						<select class="yy-input-enumdata form-control" id="billstatus"
							name="billstatus" data-enum-group="billstatus"></select>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">创建人</label>
					<div class="col-md-8">
						<input name="creatorname" type="text" class="form-control">
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">创建时间</label>
					<div class="col-md-8">
						<input name="createtime" type="text" class="form-control">
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">修改人</label>
					<div class="col-md-8">
						<input name="modifiername" type="text" class="form-control">
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">修改时间</label>
					<div class="col-md-8">
						<input name="modifytime" type="text" class="form-control">
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">审核人</label>
					<div class="col-md-8">
						<input name="approvername" type="text" class="form-control">
					</div>
				</div>
			</div>

		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">审核时间</label>
					<div class="col-md-8">
						<input name="approvetime" type="text"
							class="form-control date-picker">
					</div>
				</div>
			</div>
			
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">申请人</label>
					<div class="col-md-8">
						<input name="creatorname" type="text" class="form-control">
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">申请时间</label>
					<div class="col-md-8">
						<input name="createtime" type="text" class="form-control">
					</div>
				</div>
			</div>
		</div>
		
	</div>
</fieldset>
<!-- 系统信息_e -->
