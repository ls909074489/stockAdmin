YYMsg = {};

var YY_ALERTMSG_MAP;
YYMsg.alertMsg = function(key, msgArr) {
	if (!YY_ALERTMSG_MAP) {
		var alertmsgstr = localStorage.getItem("yy-alertmsg-map");
		YY_ALERTMSG_MAP = JSON.parse(alertmsgstr);
	}
	var msgobject = YY_ALERTMSG_MAP[key];
	if (msgobject) {
		return formatMsg(msgobject.alertmsg, msgArr);
	} else {
		YYUI.promMsg("获取不到提示信息。");
	}
}

// 格式化消息
function formatMsg(msgstr, msgArr) {
	if (msgArr == null || msgArr.length == 0) {
		return msgstr;
	} else {
		for (var i = 0; i < msgArr.length; i++) {
			msgstr = msgstr.replace(new RegExp("\\{" + i + "\\}", "g"), msgArr[i]);
			//msgstr.replace('{' + i + '}', msgArr[i]);
		}
		return msgstr;
	}

}
