<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
<div class="row yy-toolbar">
			
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-mail-reply"></i> 返回
			</button>
		</div>
		<div class="row">
			<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
			<input name="uuid" type="hidden"/>
							<div class="row">
							<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">单据类型</label>
							<div class="col-md-8"><input class="form-control " name="documentType"  type="text"></div>
						</div>
						</div>
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">单据</label>
							<div class="col-md-8"><input class="form-control " name="documentType"  type="text"></div>
						</div>
						</div>	
						<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">岗位</label>
							<div class="col-md-8"><input class="form-control " name="jobs"  type="text"></div>
						</div>
						</div> -->
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">前缀</label>
							<div class="col-md-8"><input class="form-control " name="prefix"  type="text"></div>
						</div>
						</div>	
				</div>
				<div class="row">
					
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">归零标志</label>
							<div class="col-md-8">
								<select id="zeroMark" class="yy-input-enumdata form-control" name="zeroMark">
										<option value="y">年</option>
										<option value="m">月</option>
										<option value="d">日</option>
									</select>
							
							<!-- <input class="form-control " id="zeroMark" name="zeroMark"  type="text"> -->
							</div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">流水号位数</label>
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
							<!-- <input class="form-control " id="serialNumber" name="serialNumber"  type="text"> -->
							
							</div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否加年 </label>
							<div class="col-md-8">
							
							
								<select id="isAadYears" class="yy-input-enumdata form-control" name="isAadYears">
										<option value="y">是</option>
										<option value="n">否</option>
									</select>
							<!-- <input class="form-control " id="isAadYears" name="isAadYears"  type="text">-->
							</div>
						</div>
						</div>
				</div>
				<div class="row">
							
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否加月</label>
							<div class="col-md-8">
							<select id="isAddMonth" class="yy-input-enumdata form-control"  name="isAddMonth">
										<option value="y">是</option>
										<option value="n">否</option>
									</select>
							<!-- <input class="form-control " id="isAddMonth" name="isAddMonth"  type="text"> -->
							</div>
						</div>
						</div>	
						<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否加日</label>
							<div class="col-md-8">
							<select id="isAddDay" class="yy-input-enumdata form-control" name="isAddDay">
										<option value="y">是</option>
										<option value="n">否</option>
									</select>
							<!-- <input class="form-control " id="isAddDay" name="isAddDay"  type="text"> -->
							</div>
						</div>
						</div>
							
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">最新流水号</label>
							<div class="col-md-8"><input class="form-control " name="newSerialNumber"  type="text"></div>
						</div>
						</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">流水号上次归零时间</label>
							<div class="col-md-8"><input class="form-control " name="creationTime"  type="text"></div>
						</div>
					</div>
				</div>
			</form>
		</div>
</div>