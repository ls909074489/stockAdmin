var Login = function() {

    var handleLogin = function() {
        $('.login-form').validate({
        	errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                validatecode: {
                    required: true
                },
                username: {
                    required: true
                },
                password: {
                    required: true
                }
            },
            
            messages: {
                password: {
                    required: "请输入验证码"
                },
            	username: {
                    required: "请输入教师编号或学号"
                },
                password: {
                    required: "请输入密码"
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit
            	$('.alert-danger', $('.login-form')).show();
            	var validatecode = $("#validatecode").val();
				var loginname = $("#username").val();
		        var password = $("#password").val();
		        if(validatecode.length == 0){
		        	$("#login-msg").html("请先完成滑动验证");
		        } else if(loginname.length == 0){
		        	$("#login-msg").html("请输入教师编号或学号");
		        } else if(password.length == 0){
		        	$("#login-msg").html("请输入密码");
		        }
            },

            highlight: function(element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                // error.insertAfter(element.closest('.input-icon'));
            },

            submitHandler: function(form) {
                form.submit(); // form validation success, call ajax form submit
            }
        });

        $('.login-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.login-form').validate().form()) {
                    $('.login-form').submit(); //form validation success, call ajax form submit
                }
                return false;
            }
        });
    }

    var handleForgetPassword = function() {
        $('.forget-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                email: {
                    required: true,
                    email: true
                }
            },

            messages: {
                email: {
                    required: "请输入账号对应的邮箱地址."
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   

            },

            highlight: function(element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                error.insertAfter(element.closest('.input-icon'));
            },

            submitHandler: function(form) {
                form.submit();
            }
        });

        $('.forget-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.forget-form').validate().form()) {
                    $('.forget-form').submit();
                }
                return false;
            }
        });

        jQuery('#forget-password').click(function() {
        	alert("暂时不支持找回密码，请联系体育部教务员或体育部相关管理员 重置密码。");
            // jQuery('.login-form').hide();
            // jQuery('.forget-form').show();
        });

        jQuery('#back-btn').click(function() {
            jQuery('.login-form').show();
            jQuery('.forget-form').hide();
        });

    }


    return {
        //main function to initiate the module
        init: function() {
            handleLogin();
            handleForgetPassword();
        }
    };
}();


// 加入收藏夹
var addFavorite = function() {
	var url = window.location;
	var title = document.title;
	var ua = navigator.userAgent.toLowerCase();
	if (ua.indexOf("360se") > -1) {
		alert("您的浏览器不支持，请按 Ctrl+D 手动收藏！");
	} else if (ua.indexOf("msie 8") > -1) {
		window.external.AddToFavoritesBar(url, title); //IE8
	} else if (document.all) {
		try {
			window.external.addFavorite(url, title);
		} catch (e) {
			alert('加入收藏失败，请按 Ctrl+D 手动收藏!');
		}
	} else if (window.sidebar) {
		window.sidebar.addPanel(title, url, "");
	} else {
		alert('加入收藏失败，请按 Ctrl+D 手动收藏!');
	}
};

// 检查浏览器版本
var checkBrowser = function() {
	/*
	//绑定鼠标光标
	$('#username').focus();
	// 不给另存为网页,屏蔽ctrl+s
	document.onkeydown = function(event){
		if ((event.ctrlKey)&&(event.keyCode==229 || event.keyCode==83)){
			return false;
		}
	}
	*/
	//alert(window.localStorage);
	//alert(window.applicationCache);
	//if(!window.localStorage){
	//	YYUI.promMsg("本平台不支持您的浏览器，请留意屏幕下方的相关说明2");
	//}
	if (!window.applicationCache) {
		
		alert("本系统可能不支持您的浏览器，请用支持Html5的浏览器访问系统3");
		return false;
	}
	return true;
};

// 滑动验证模块
$("#slider").slider({
	width: 340, // width
	height: 40, // height
	sliderBg: "rgb(134, 134, 131)", // 滑块背景颜色
	color: "#fff", // 文字颜色
	fontSize: 14, // 文字大小
	bgColor: "#33CC00", // 背景颜色
	textMsg: "请按住滑块，拖动到最右边", // 提示文字
	successMsg: "验证通过", // 验证成功提示文字
	successColor: "red", // 滑块验证成功提示文字颜色
	time: 500, // 返回时间
	callback: function(result) { // 回调函数，true(成功),false(失败)
		$('.alert-danger', $('.login-form')).hide(); // 隐藏错误提示框
		var url = projectPath +'/login/getValidateVode';
		if(result){
			$.ajax({
				//提交数据的类型 POST GET
				type : "POST",
				//提交的网址
				url : url,
				//提交的数据
				data : {},
				//返回数据的格式
				datatype : "json",//"xml", "html", "script", "json", "jsonp", "text".
				//成功返回之后调用的函数 
				success : function(data) {
					$("#validatecode").val(data);
				},
				//调用出错执行的函数
				error : function() {
					//请求出错处理
					$('.alert-danger', $('.login-form')).show();
		    		$("#login-msg").html("滑动验证失败");
		    		$("#slider").slider("restore");
				}
			});
		}
	}
});