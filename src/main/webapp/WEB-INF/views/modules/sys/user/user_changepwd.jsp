<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/user" />
<html>
<head>
<title>个人密码修改</title>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
		<div class="row">
			<form class="form-horizontal" name="yy-form-changepwd" id="yy-form-changepwd">
				<table>
					<tr style="height: 10px;"><td></td><td></td></tr>
					<tr style="height: 40px;">
						<td style="width: 30%;"><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;原密码：</label></td>
						<td style="width: 60%;"><input class="form-control" type="password" name="oldpassword" id="oldpassword" class="span4" style="width: 280px;"/></td>
					</tr>
					
					<tr style="height: 40px;">
						<td><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;新密码：</label></td>
						<td><input class="form-control" type="password" name="newpassword" id="newpassword" class="span4"  style="width: 280px;"/></td>
					</tr>
					
					<tr style="height: 40px;">
						<td><label class="control-label col-md-4">&nbsp;&nbsp;&nbsp;&nbsp;确认新密码：</label></td>
						<td><input class="form-control" type="password" name="newpassword2" id="newpassword2" class="span4"  style="width: 280px;"/></td>
					</tr>
				</table>
				<!-- <div class="control-group">
					<label class="control-label" for="oldpassword">原密码：</label>
					<div class="controls">
						<div>
							<input class="form-control" type="password" name="oldpassword" id="oldpassword" class="span4" />
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="newpassword">新密码：</label>
					<div class="controls">
						<div>
							<input class="form-control" type="password" name="newpassword" id="newpassword" class="span4" />
						</div>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="newpassword2">确认新密码：</label>
					<div class="controls">
						<div>
							<input class="form-control" type="password" name="newpassword2" id="newpassword2" class="span4" />
						</div>
					</div>
				</div> -->

				<div class="row form-actions yy-toolbar" style="margin-top: 10px;text-align: center;background-color: white;">
					<button id="btn-post" type="button">
						<i class="fa fa-save"></i> 提交
					</button>
					<button id="yy-btn-cancel" type="reset" class="btn blue btn-sm">
						<i class="fa fa-rotate-left"></i> 清除
					</button>
					<button id="yy-btn-tologin" type="button" class="btn blue btn-sm">
						<i class="fa icon-key"></i> 退出
					</button>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		function changePwd() {
			if (!$('#yy-form-changepwd').valid())
				return false;
			var postData = $("#yy-form-changepwd").serializeArray();

			$.ajax({
				url : '${serviceurl}/changepwd',
				type : 'POST',
				dataType : "json",
				ContentType : "application/json; charset=utf-8",
				data : postData,
				success : function(data) {
					if (data.success) {
						YYUI.promAlert('密码修改成功!');
						$('#yy-form-changepwd')[0].reset();
						
						window.parent.checkToSeleStation();
						
						//修改密码成功后关闭框  edit by liusheng
						var index = parent.layer.getFrameIndex(window.name);
						//先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭 
					} else {
						//YYUI.failMsg("密码修改失败，原因：" + data.msg); 
						YYUI.failMsg(data.msg); 
					}
				}
			});
		}

		$(document).ready(function() {
			$('#btn-post').bind('click', changePwd);
			
			$('#yy-btn-tologin').bind('click', function(){
				url = '${ctx}/logout';
				window.location=url;
			});
			//验证 表单
			validateForms();
			
			/* $('#yy-form-changepwd').validate({
				rules : {
					oldpassword : {
						required : true
					},
					newpassword : {
						required : true,
						minlength : 1,
						maxlength: 16,
					},
					newpassword2 : {
						required : true,
						equalTo : "#newpassword"
					}
				},
				messages : {
					oldpassword : {
						required : "请输入当前用户原始密码"
					},
					newpassword : {
						required : "请输入新密码",
						minlength : "密码不符合安全要求，至少8个字符",
						maxlength: "密码不符合安全要求，最长16个字符",
						strongPsw: true,//密码强度
					},
					newpassword2 : {
						required : "请重复输入新密码",
					}
				}
			}); */
		});
		
        jQuery.validator.addMethod("same", function(value, element) {
        	return this.optional(element) || same(value);
        }, "新密码不能与旧密码重复"); 
        
        function same(pwd) {
        	var oldPwd = $("#oldpassword").val();
        	if (oldPwd == pwd)
        		return false; 
        	else 
        		return true;
        }
        
		$.validator.addMethod("strongPsw", function(value, element) {
			//alert(value);
		    if(passwordLevel(value) == 1){
		    	return false;
		    }
		    return true
		}, "密码过于简单");
		
		function passwordLevel(password) {
		    var Modes = 0;
		    for (i = 0; i < password.length; i++) {
		        Modes |= CharMode(password.charCodeAt(i));
		    }
		    return bitTotal(Modes);
		 
		    //CharMode函数
		    function CharMode(iN) {
		        if (iN >= 48 && iN <= 57)//数字
		            return 1;
		        if (iN >= 65 && iN <= 90) //大写字母
		            return 2;
		        if ((iN >= 97 && iN <= 122) || (iN >= 65 && iN <= 90)) //大小写
		            return 4;
		        else
		            return 8; //特殊字符
		    }
		 
		    //bitTotal函数
		    function bitTotal(num) {
		        modes = 0;
		        for (i = 0; i < 4; i++) {
		            if (num & 1) modes++;
		            num >>>= 1;
		        }
		        return modes;
		    }
		}
		
		 //验证表单
		function validateForms(){
			$('#yy-form-changepwd').validate({
				rules : {
					oldpassword : {
						required : true
					},
					newpassword : {
						required : true,
						minlength : 6,
						maxlength: 16/* ,
						strongPsw: true *///密码强度
					},
					newpassword2 : {
						required : true,
						minlength : 6,
						maxlength: 16,
						equalTo : "#newpassword"/* ,
						strongPsw: true *///密码强度
					}
				},
				messages : {
					oldpassword : {
						required : "请输入当前用户旧密码"
					},
					newpassword : {
						required : "请输入新密码",
						minlength : "密码不符合安全要求，至少6个字符",
						maxlength: "密码不符合安全要求，最长16个字符"
					},
					newpassword2 : {
						required : "请重复输入新密码",
						minlength : "密码不符合安全要求，至少6个字符",
						maxlength: "密码不符合安全要求，最长16个字符",
						equalTo:"请再次输入新密码"
					}
				}
			}); 
		}
	</script>
</body>
</html>