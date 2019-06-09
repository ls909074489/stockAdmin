YYDataUtils = {};

/* 枚举 */
/**
 * 获取存储与本地缓存中的枚举Map
 */
var YY_ENUM_MAP;
YYDataUtils.getEnumMap = function() {
	if (!YY_ENUM_MAP) {
		var mapstr = localStorage.getItem("yy-enum-map");
		YY_ENUM_MAP = JSON.parse(mapstr);
	}
	return YY_ENUM_MAP;
}

/**
 * 获取指定分组的枚举数据列表
 */
YYDataUtils.getEnumList = function(groupCode) {
	var map = YYDataUtils.getEnumMap();
	return map[groupCode];
}


/**
 * 获取指定组的枚举并以枚举值为Key返回一个Map
 */
var YY_ENUMGROUP_KEY_MAP = {};
YYDataUtils.getEnumGroupKeyMap = function(groupCode) {
	if (!YY_ENUMGROUP_KEY_MAP[groupCode]) {
		var list = YYDataUtils.getEnumList(groupCode);
		if (list) {
			var keymap = {};
			for ( var i = 0; i < list.length; i++) {
				var k = list[i].enumdatakey;
				keymap[k] = list[i];
			}
			YY_ENUMGROUP_KEY_MAP[groupCode] = keymap;
		}
	}
	return YY_ENUMGROUP_KEY_MAP[groupCode];
}

/**
 * 获取指定分组与key的枚举数据
 */
YYDataUtils.getEnumData = function(groupCode, key) {
	var map = YYDataUtils.getEnumGroupKeyMap(groupCode);
	return map[key];
}

/**
 * 获取指定分组与key的枚举数据名称
 */
YYDataUtils.getEnumName = function(groupCode, key) {
	var map = YYDataUtils.getEnumGroupKeyMap(groupCode);
	var val;
	try {
		val = map[key].enumdataname;
	} catch (e) {
		val = key;
	}
	if(groupCode=="billstatus"){
		if(key=='1'){
			return "<span style='background-color:#E1E5EC;padding:2px;'><font >"+val+"</font></span> ";
		}else if(key=='2'){
			return "<span style='background-color:#32C5D2;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}else if(key=='3'){
			return "<span style='background-color:#BF55EC;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";		
		}else if(key=='4'){
			return "<span style='background-color:#22313F;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}else if(key=='5'){
			return "<span style='background-color:#3598DC;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}
		return "";
	}else if(groupCode=="Pg_SendPostStatus"){
		if(key=='01'){
			return "<span style='background-color:#26c281;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}else if(key=='02'){
			return "<span style='background-color:#e08283;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}else if(key=='03'){
			return "<span style='background-color:#3598dc;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";		
		}
	}else if(groupCode=="Rg_SendPostStatus"){
		 if(key=='01'){
			return "<span style='background-color:#e08283;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";
		}else if(key=='02'){
			return "<span style='background-color:#3598dc;padding:2px;'><font color='#FFFFFF'>"+val+"</font></span> ";		
		}
	}else{
		return val;
	}
	
}


/**
 * 获取指定分组的下拉框并赋值
 */
YYDataUtils.getEnumSelect = function(groupCode, key, selectName) {
	var list = YYDataUtils.getEnumList(groupCode);
	var htmlVal = '<select name="' + selectName + '" class="form-control">';
	if (list) {
		
		for ( var i = 0; i < list.length; i++) {
			var datakey = list[i].enumdatakey;
			var dataName = list[i].enumdataname;
			if(key && key == datakey) {
				htmlVal = htmlVal + '<option value="' + datakey + '" selected="selected">' + dataName + '</option>'
			} else {
				htmlVal = htmlVal + '<option value="' + datakey + '" >' + dataName + '</option>'
			}
		}
	}
	htmlVal = htmlVal + '</select>';
	return htmlVal;
}

/**
 * 删除记录 url 后台删除的url pks 主键数组 fnCallback 成功后回调函数
 */
YYDataUtils.removeRecord = function(url, pks, fnCallback, isConfirm, isSuccess) {
	if (pks.length < 1) {
		YYUI.promMsg("请选择需要删除的记录");
		return;
	}

	if (typeof (isConfirm) == "undefined") {
		isConfirm = true;
	}
	if (typeof (isSuccess) == "undefined") {
		isSuccess = false;
	}
	/*if (isConfirm && !window.confirm("确实要删除吗？")) {
		return;
	}*/
	layer.confirm("确实要删除吗？",function(){
	$.ajax({
		"dataType" : "json",
		"type" : "POST",
		"url" : url,
		"data" : {
			"pks" : pks.toString()
		},
		"success" : function(data) {
			if (data.success) {
				if (isSuccess)
					YYUI.succMsg("删除成功");
				if (typeof (fnCallback) != "undefined")
					fnCallback(data);
			} else {
				YYUI.failMsg("删除失败，原因：" + data.msg);
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown) {
			YYUI.failMsg("删除失败，HTTP错误。");
		}
	});
	});
}
/**
 * 删除数组元素
 * n表示第几项，从0开始算起。 //prototype为对象原型，注意这里为对象增加自定义方法的方法。
 */
Array.prototype.del=function(n) {
	if(n<0) 
		//如果n<0，则不进行任何操作。
		return this; 
	else return this.slice(0,n).concat(this.slice(n+1,this.length)); 
	/* concat方法：返回一个新数组，这个新数组是由两个或更多数组组合而成的。 　
	　　这里就是返回this.slice(0,n)/this.slice(n+1,this.length) 　　　
	     　组成的新数组，这中间，刚好少了第n项。 slice方法： 返回一个数组的一段，两个参数，分别指定开始和结束的位置。 */
}