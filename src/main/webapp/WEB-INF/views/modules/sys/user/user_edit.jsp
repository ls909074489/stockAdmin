<%@ page contentType="text/html;charset=UTF-8"%>


<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save">
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
						<label class="control-label col-md-4 required">登录账号</label>
						<div class="col-md-8">
							<input class="form-control " name="loginname" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">用户名</label>
						<div class="col-md-8">
							<input class="form-control" name="username" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">工号</label>
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
						<label class="control-label col-md-4 required">性别</label>
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
						<label class="control-label col-md-4 required">用户类型</label>
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
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">所属单位</label>
						<div class="col-md-8">
							<!-- <div class="input-group">
								<input id="selOrgId" name="orgid" type="hidden"> 
								<input id="selOrgName" name="orgname" type="text" class="form-control">
								<span class="input-group-btn">
									<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div> -->
							
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
				</div>
			</div>
			<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">年级</label>
							<div class="col-md-8"><select name="grade" class="yy-input-enumdata form-control" data-enum-group="StudentGrade"></select></div>
						</div>
					</div>	
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">学院</label>
							<div class="col-md-8">
								<input class="form-control " id="college" name="college"  type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">班级</label>
							<div class="col-md-8"><input class="form-control " name="classes"  type="text"></div>
						</div>
					</div>	
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">关联人员</label>
						<!-- <div class="col-md-8">
							<div class="input-group">
								<input id="user_refid" name="user_refid" type="hidden"> 
								<input id="user_refname" name="user_refname" type="text" class="form-control" readonly="readonly"> 
								<span class="input-group-btn">
									<button id="yy-userref-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div> -->
						<div class="col-md-8">
							<div class="input-group input-icon right">
								<input id="user_refid" name="user_refid" type="hidden"> 
								<i class="fa fa-remove" onclick="cleanDef('user_refid','user_refname');" title="清除"></i>
								<input id="user_refname" name="user_refname" type="text" class="form-control" readonly="readonly"> 
								<span class="input-group-btn">
									<button id="yy-userref-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>	
					</div>
				</div>
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
