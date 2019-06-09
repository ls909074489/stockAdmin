<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
//日期格式  date.format("yyyy-MM-dd HH:mm:ss")
Date.prototype.format = function(format) {
	var o = {
		"M+" : this.getMonth() + 1, //month 
		"d+" : this.getDate(), //day 
		"H+" : this.getHours(), //hour 
		"m+" : this.getMinutes(), //minute 
		"s+" : this.getSeconds(), //second 
		"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter 
		"S" : this.getMilliseconds()
	//millisecond 
	}
	
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}

	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1,
					RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
							.substr(("" + o[k]).length));
		}
	}
	return format;
};

var DateUtils = {};
DateUtils.formatDate = function(strDate, pattern) {
	strDate = strDate || '';
	if(strDate!='') {
		if (/\.0/.test(strDate)) {
			strDate = strDate.replace(/\.0/, '');
		}
		strDate = strDate.replace(/-/g, '/');
		if(pattern==undefined) {
			pattern = 'yyyy-MM-dd HH:mm:ss';
		}
		strDate = (new Date(strDate)).format(pattern);
	}
	return strDate;
};

/**
 * 清除全部空格
 */
var StringUtils = {};
//清除全部空格
StringUtils.clearAllSpace = function(obj){
	var val = $(obj).val();
	if(/\s+/g.test(val)) {
		val = val.replace(/\s+/g, "");;
		$(obj).val(val);
	}
}
//清除前后空格
StringUtils.clearAroundSpace = function(obj){
	var val = $(obj).val();
	if(/^\s+|\s+$/.test(val)) {
		val = val.replace(/^\s+|\s+$/, "");;
		$(obj).val(val);
	}
}


</script>