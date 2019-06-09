<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/userProfile" />
<html>
<head>
<title>个人设置</title>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
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
				<table>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">姓名</label></td>
					<td><input class="form-control " name="username" type="text" readonly disabled></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">登录账号</label"></td>
					<td><input class="form-control" name="loginname" type="text" readonly disabled></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">部门</label"></td>
					<td><input class="form-control" name="deptname" type="text" readonly disabled></td></tr>
					<!-- <tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">职位</label"></td>
					<td><input class="form-control" name="deptname" type="text" readonly disabled></td></tr> -->
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">角色</label"></td>
					<td><input class="form-control" name="rolenames" type="text" readonly disabled></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">手机</label"></td>
					<td><input class="form-control" name="mobilephone" type="text"></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">电话</label"></td>
					<td><input class="form-control" name="telephone" type="text"></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">出生日期</label"></td>
					<td><input class="Wdate form-control" name="birthdate" type="text" onClick="WdatePicker(WdatePicker({maxDate:'%y-%M-{%d}'}))"></td></tr>
					<tr style="height: 40px;"><td style="width: 40%;text-align: right;"><label class="control-label col-md-2">备注</label"></td>
					<td><input class="form-control" name="remark" type="text"></td></tr>
				</table>
				</div>
				<!-- <div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">姓名：</label>
							<div class="col-md-8">
								<input class="form-control " name="username" type="text" readonly disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">登录账号：</label>
							<div class="col-md-8">
								<input class="form-control" name="loginname" type="text" readonly disabled>
							</div>
						</div>
					</div>

				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">部门：</label>
							<div class="col-md-8">
								<input class="form-control" name="deptname" type="text" readonly disabled>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">职位：</label>
							<div class="col-md-8">
								<input class="form-control" name="deptname" type="text" readonly disabled>
							</div>

						</div>
					</div>
				</div>


				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">手机：</label>
							<div class="col-md-8">
								<input class="form-control" name="mobilephone" type="text">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">电话：</label>
							<div class="col-md-8">
								<input class="form-control" name="telephone" type="text">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">出生日期：</label>
							<div class="col-md-8">
								<input class="Wdate form-control" name="birthdate" type="text" onClick="WdatePicker()">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">地址：</label>
							<div class="col-md-8">
								<input class="form-control " name="address" type="text">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-2">备注：</label>
							<div class="col-md-8">
								<input class="form-control" name="remark" type="text">
							</div>
						</div>
					</div>

				</div> -->
			</form>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				loadList();
				$("#yy-btn-save").bind("click", function() {
					onSave(true);
				});

				$("#yy-btn-cancel").bind('click', onCancel);
				
				//验证 表单
				validateForms();

			});

			function showData(data) {
				$("input[name='uuid']").val(data.records[0].uuid);
				//$("select[name='status']").val(data.status);
				$("input[name='loginname']").val(data.records[0].loginname);
				$("input[name='username']").val(data.records[0].username);
				$("input[name='mobilephone']").val(data.records[0].mobilephone);
				$("input[name='telephone']").val(data.records[0].telephone);
				$("input[name='mailbox']").val(data.records[0].mailbox);
				$("input[name='address']").val(data.records[0].address);
				$("input[name='birthdate']").val(data.records[0].birthdate);
				$("input[name='remark']").val(data.records[0].remark);
				/* $("input[name='invaliddate']").val(data.invaliddate);		
				$("input[name='orgname']").val(data.orgname);	 */
				$("input[name='deptname']").val(data.records[0].deptname);
				$("input[name='rolenames']").val(data.records[0].userrole);

			}

			function loadList() {
				//doBeforeLoadList();
				var url = '${serviceurl}/current';
				$.ajax({
					url : url,
					type:'post',
					data : {},
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							showData(data);
						} else {
							layer.alert("获取用户信息失败！");
						}
					}
				});
			}

			//保存，isClose 是否保存后关闭视图，否为继续增加状态
			function onSave(isClose) {
				if (!$('#yy-form-edit').valid())
					return false;
				
				posturl = "${serviceurl}/update";
				var opt = {
					url : posturl,
					type : "post",
					success : function(data) {
						if (data.success) {
							/* layer.msg("保存成功 ", {
								icon : 1
							}); */
							//提示没有显示清楚就已经关闭了窗口，测试说看不到提示，因此调用父页面的保存成功提示
							window.parent.onSaveUserProfile();
							onCancel();
						} else {
							layer.alert("保存出现错误：" + data.msg)
						}
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			}

			//取消编辑，返回列表视图
			function onCancel() {
				var index = parent.layer.getFrameIndex(window.name);
				//先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			
			 //验证表单
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						mobilephone : {isMobile : true},
						telephone : {isPhone : true},
						remark : {maxlength:200}
					}
				}); 
			}
		</script>
	</div>
</body>
</html>