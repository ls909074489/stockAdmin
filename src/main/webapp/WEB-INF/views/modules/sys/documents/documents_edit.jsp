<%@ page contentType="text/html;charset=UTF-8"%>


<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save-doc">
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
						<label class="control-label col-md-4 required">单据类型</label>
						<div class="col-md-8">
							<input class="form-control" name="documentType" id="documentType" type="text">
						</div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">前缀</label>
						<div class="col-md-8">
							<input class="form-control" required name="prefix" id="prefix" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">单据</label>
						<div class="col-md-8">
							<input class="form-control " name="documents" id="documents" type="text">
						</div>
					</div>
				</div>

			</div>
			<div class="row">

				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">年</label>
						<div class="col-md-8">
							<select id="isAadYears" class="yy-input-enumdata form-control" name="isAadYears">
								<option value="y">是</option>
								<option value="n">否</option>
							</select>
							<!-- <input type="checkbox"  class="form-check" id="isAadYears"  name="isAadYears"> -->
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">月</label>
						<div class="col-md-8">
							<select id="isAddMonth" class="yy-input-enumdata form-control" name="isAddMonth">
								<option value="y">是</option>
								<option value="n">否</option>
							</select>
							<!-- <input type="checkbox"  class="form-check" id="isAddMonth" name="isAddMonth"> -->
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">日</label>
						<div class="col-md-8">
							<select id="isAddDay" class="yy-input-enumdata form-control" name="isAddDay">
								<option value="y">是</option>
								<option value="n">否</option>
							</select>
							<!-- <input type="checkbox"  class="form-check" id="isAddDay" name="isAddDay"> -->
						</div>
					</div>
				</div>


			</div>
			<div class="row">

				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">流水号归零标志</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="zeroMark" name="zeroMark" data-enum-group="ZeroMark"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">流水号位数</label>
						<div class="col-md-8">
							<select id="serialNumber" class="yy-input-enumdata form-control" name="serialNumber">
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="row">
			<a href="javascript:genDocuments()">生成单据号测试</a><br>
			<a href="javascript:batchBillcodes()">批量生成单据号测试</a>
		</div>
	</div>
</div>
