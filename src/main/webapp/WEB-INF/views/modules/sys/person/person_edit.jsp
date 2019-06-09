<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="hide" id="yy-page-edit">
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
			<input name="uuid" type="hidden"> 
			<input name="department.uuid" type="hidden">
			<input id="orgId" name="corp.uuid" type="hidden" value="">
			<input id="relation_user" name="relation_user.uuid" type="hidden" value="">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">姓名</label>
						<div class="col-md-8">
							<input class="form-control " name="name" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">员工号</label>
						<div class="col-md-8">
							<input class="form-control " name="job_number" type="text">
						</div>
					</div>
				</div>
				<!-- <div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">系统账号</label>
						<div class="col-md-8">
							<div class="input-group">
									<input id="relation_user_id" name="relation_user.uuid" type="hidden">
									<input id="relation_user_loginname" name="relation_user_loginname" type="text" class="form-control">
									<span class="input-group-btn">
										<button id="yy-relation-user" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
							</div>
						</div>
					</div>
				</div> -->
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">在职状态</label>
							<div class="col-md-8">
								<select class="yy-input-enumdata form-control" id="job_status" name="job_status" data-enum-group="PostStatus"></select>
							</div>
						</div>
				 </div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">性别</label>
						<div class="col-md-8">
							<!-- <select name="" class="form-control">
							</select> -->
							<select class="yy-input-enumdata form-control" id="sex" name="sex" data-enum-group="sys_sex"></select>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">出生日期</label>
						<div class="col-md-8">
							<input class="Wdate form-control " name="birth_date" type="text" onclick="WdatePicker();">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">学历</label>
						<div class="col-md-8">
						<select name="education" id="education" class="yy-input-enumdata form-control" data-enum-group="Education"></select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">入职日期</label>
						<div class="col-md-8">
							<input class="Wdate form-control " name="entry_date" type="text" onclick="WdatePicker();">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">离职日期</label>
						<div class="col-md-8">
							<input class="Wdate form-control " name="departure_date" type="text" onclick="WdatePicker();">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">岗位</label>
						<div class="col-md-8">
							<select class="form-control"  id="post_id" name="post.uuid" >
								<option value=""></option>
								<c:forEach var="list" items="${postList}">
									<option value="${list.uuid}">${list.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">微信号</label>
							<div class="col-md-8">
								<input class="form-control " name="wechat" type="text">
							</div>
						</div>
				</div>
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">移动电话</label>
							<div class="col-md-8">
								<input class="form-control " name="mobile_phone" type="text">
							</div>
						</div>
				</div>
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">邮箱</label>
							<div class="col-md-8">
								<input class="form-control " name="email" type="text">
							</div>
						</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">工作年限</label>
							<div class="col-md-8">
								<input class="form-control " name="work_years" type="text">
							</div>
						</div>
				 </div>
				 <div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">总部培训</label>
						<div class="col-md-8">
							<select name="is_train" id="is_train" class="yy-input-enumdata form-control" data-enum-group="BooleanType"></select>
						</div>
					</div>
				  </div>
				  <div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">是否督导</label>
							<div class="col-md-8">
								<select name="is_supervise" id="is_supervise" class="yy-input-enumdata form-control" data-enum-group="BooleanType"></select>
							</div>
						</div>
				 	</div>
			</div>
			<!-- <div class="row">
				<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">在职状态</label>
							<div class="col-md-8">
								<select name="job_status" class="form-control">
									<option vlaue="01">在职</option>
									<option vlaue="02">离职</option>
								</select>
							</div>
						</div>
				 </div>
			</div> -->
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">K3代码</label>
						<div class="col-md-8">
							<input class="form-control " name="k3code" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">K3名称</label>
						<div class="col-md-8">
							<input class="form-control " name="k3name" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">行业经验</label>
						<div class="col-md-10">
							<input class="form-control " name="experience" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2">备注</label>
							<div class="col-md-10">
								<textarea rows="" cols="" name="memo"  class="form-control"></textarea>
							</div>
						</div>
					</div>
			</div>
		</form>
	</div>
</div>