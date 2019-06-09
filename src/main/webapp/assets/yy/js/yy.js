$(document).ready(function() {
	if (!window.applicationCache) {
		YYUI.promMsg("本系统可能不支持您的浏览器，请用支持Html5的浏览器访问系统！");
	}
	YYUI.setUIDefault();
	// 设置超时提醒，跳转
	$.ajaxSetup({
		complete : function(XMLHttpRequest, textStatus) {
			if (textStatus == "parsererror") {
				layer.alert('由于您长时间没有操作，请重新登陆', function(index) {
					layer.close(index);
					url = projectPath + '/logout';
					window.parent.location = url;
				});
			}
		}
	});
});

// 处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
function banBackSpace(e) {
	var ev = e || window.event;// 获取event对象
	if (ev.keyCode == 8) {
		var obj = ev.target || ev.srcElement;// 获取事件源
		var t = obj.type || obj.getAttribute('type');// 获取事件源类型
		if (obj.id == 'myEditor') {
			return true;
		}
		// 获取作为判断条件的事件类型
		var vReadOnly = obj.getAttribute('readonly');
		var vEnabled = obj.getAttribute('enabled');
		// 处理null值情况
		vReadOnly = (vReadOnly == null) ? false : vReadOnly;
		vEnabled = (vEnabled == null) ? true : vEnabled;
		// 当敲Backspace键时，事件源类型为密码或单行、多行文本的，
		// 并且readonly属性为true或enabled属性为false的，则退格键失效
		var flag1 = ((t == "password" || t == "text" || t == "search" || t == "textarea") && (vReadOnly == true || vEnabled != true)) ? true
				: false;
		// 当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
		var flag2 = (t != "password" && t != "text" && t != "search" && t != "textarea") ? true
				: false;
		// 判断
		if (flag2) {
			layer.confirm('确定退出登录？', function() {
				url = projectPath + '/logout';
				window.parent.location = url;
			});
			return false;
		}
		if (flag1) {
			layer.confirm('确定退出登录？', function() {
				url = projectPath + '/logout';
				window.parent.location = url;
			});
			return false;
		}
	}
}

// 禁止后退键 作用于Firefox、Opera
document.onkeypress = banBackSpace;
// 禁止后退键 作用于IE、Chrome
document.onkeydown = banBackSpace;