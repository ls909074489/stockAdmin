<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
<div class="row yy-toolbar">
			
			<button id="yy-btn-backtolist" class="btn blue btn-sm">
				<i class="fa fa-mail-reply"></i> 返回
			</button>
		</div>
		<div class="row">
			<form id="yy-form-detail"  class="form-horizontal yy-form-detail">
				<input name="uuid" type="hidden" />
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">登录账号</label>
							<div class="col-md-8">
								<input class="form-control " name="loginname" type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">用户名</label>
							<div class="col-md-8">
								<input class="form-control" name="username" type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">工号</label>
							<div class="col-md-8">
								<input class="form-control" name="jobnumber" type="text">
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">所属单位</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="selOrgId" name="orgid" type="hidden"> 
									<input id="selOrgName" name="orgname" type="text" class="form-control">
									<span class="input-group-btn">
										<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">所属部门</label>
							<div class="col-md-8">
								<div class="">
									<input id="selDeptd" name="deptid" type="hidden"> 
									<input id="selDeptName" name="deptname" type="text" class="form-control">
									<span class="input-group-btn">
										<button id="yy-dept-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">关联人员</label>
							<div class="col-md-8">
								<input class="form-control" name="personname" type="text">
								<div class="input-group">
									<input id="selPersonId" name="personid" type="hidden"> 
									<input id="selPersonName" name="personname" type="text" class="form-control" readonly="readonly">
									<span class="input-group-btn">
										<button id="person-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div> -->
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">性别</label>
							<div class="col-md-8">
								<select name="sex" class="yy-input-enumdata form-control" data-enum-group="sys_sex"></select>
							</div>
						</div>
					</div>	
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">手机号码</label>
							<div class="col-md-8">
								<input class="form-control" name="mobilephone" type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">用户类型</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" id="usertype" name="usertype" data-enum-group="UserType"></select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">生效日期</label>
							<div class="col-md-8">
								<input id="d4311" class="Wdate form-control" name="validdate" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')}'})">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">失效日期</label>
							<div class="col-md-8">
								<input id="d4312" class="Wdate form-control" name="invaliddate" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}'})">
							</div>
						</div>
					</div>
					<!-- <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">所属单位</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="selOrgId" name="orgid" type="hidden"> 
									<input id="selOrgName" name="orgname" type="text" class="form-control" readonly="readonly"> 
									<span class="input-group-btn">
										<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div> -->
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">描述</label>
							<div class="col-md-10">
								<textarea rows="" cols="" class="form-control" name="description" style="width: 100%;"></textarea>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
</div>