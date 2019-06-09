<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
//===================公共方法===================
//加载子表数据
function loadSubList(mainTableId) {
	$.ajax({
		url : '${subserviceurl}/query',
		data : {
			"search_EQ_otherin.uuid" : mainTableId,
			"search_EQ_status" : 1
		},
		dataType : 'json',
		type : 'post',
		async : false,
		success : function(data) {
			_subTableList.clear();
			_subTableList.rows.add(data.records);
			_subTableList.draw();
		}
	});
};
//系统信息显示/隐藏
function bindSysInfo(){
	$('.parent').children(".row").addClass("hide");

	$('.hos').bind('click', function() {
		// 获取所谓的父行
		if ($('.hos').children(".fa").hasClass("fa-caret-right")) {
			$('.hos').children(".fa").removeClass("fa-caret-right");
			$('.hos').children(".fa").addClass("fa-caret-down");
			$('.parent').children(".row").removeClass("hide");
			// alert("enter");
		} else {
			$('.hos').children(".fa").removeClass("fa-caret-down");
			$('.hos').children(".fa").addClass("fa-caret-right");
			$('.parent').children(".row").addClass("hide");
		}
	});
}
//创建文本框
function creInputStr(field,value,readonly,cla){
	if(value==null){
		value = '';
	}
	var str='';
	if(field == 'rowno'){
		if(readonly){
			str = '<input style="border:1px;text-align:center;background-color:transparent;" class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input style="border:1px;text-align:center;background-color:transparent;"  class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
		}
	}else{
		if(readonly){
			str = '<input class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
		}
	}
	
	//var str = '<input class="form-control" name="'+detail+'[' + row + '].'+field+'" value="'+ value + '">';
	return str;
}
//创建行号
function creRownoInputStr(field,value,readonly,cla){
	if(value==null){
		value = '';
	}
	var str='';
	if(readonly){
		str = '<input style="border:1px;text-align:center;background-color:transparent;" class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
	}else{
		str = '<input style="border:1px;text-align:center;background-color:transparent;"  class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
	}
	//var str = '<input class="form-control" name="'+detail+'[' + row + '].'+field+'" value="'+ value + '">';
	return str;
}
//创建数字field字段名称,value值,readonly是否只读,cla样式,isInt是否正整数
function creNumInputStr(field,value,readonly,cla,isInt){
	if(value==null){
		value = '';
	}
	var str='';
	if(isInt){
		if(readonly){
			str = '<input onkeyup="clearNoIntNum(this)" class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input onkeyup="clearNoIntNum(this)"  class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
		}
	}else{
		if(readonly){
			str = '<input onkeyup="clearNoNum(this)" class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input onkeyup="clearNoNum(this)"  class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
		}
	}
	
	//var str = '<input class="form-control" name="'+detail+'[' + row + '].'+field+'" value="'+ value + '">';
	return str;
}

//创建正负数field字段名称,value值,readonly是否只读,cla样式
function crePositiveNegative(field,value,readonly,cla){
	if(value==null){
		value = '';
	}
	var str='';
	if(readonly){
		str = '<input onkeyup="clearNotPN(this)" class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
	}else{
		str = '<input onkeyup="clearNotPNku(this)" onblur="clearNotPNblur(this)"  class="numinput form-control '+cla+'" value="'+ value + '" reallyname="'+field+'">';
	}
	return str;
}

//创建参照  field：字段名称 value：值,readonly：是否可编辑,cla：样式
function creRefStr(field,value,readonly,cla){
	if(value==null){
		value = '';
	}
	var str = '';
	 if(readonly){
		 var str ='<div class="input-group"> '+
		 //'<input class="form-control" name="'+detail+'[' + row + '].'+field+'" value="'+ value + '"> '+
		  '<input class="form-control"  value="'+ value + '" reallyname="'+field+'" readonly="true"> '+
		 '<span class="input-group-btn"> '+
		 '<button id="'+field+'" class="btn btn-default btn-ref  '+cla+'" type="button" data-select2-open="single-append-text"> '+
		 '<span class="glyphicon glyphicon-search"></span> '+
		 '</button> '+
		 '</span> '+
		 '</div> ';
	}else{
		var str ='<div class="input-group"> '+
		 //'<input class="form-control" name="'+detail+'[' + row + '].'+field+'" value="'+ value + '"> '+
		  '<input class="form-control"  value="'+ value + '" reallyname="'+field+'"> '+
		 '<span class="input-group-btn"> '+
		 '<button id="'+field+'" class="btn btn-default btn-ref '+cla+'" type="button" data-select2-open="single-append-text"> '+
		 '<span class="glyphicon glyphicon-search"></span> '+
		 '</button> '+
		 '</span> '+
		 '</div> ';
	}
	return str;
}
//创建下拉框(新)
function creSelectStr(fype, fieldname,value,disabled){
	var selectStr = '';
	if(disabled){
		selectStr = selectStr + '<fieldset disabled>';
	}
	selectStr = selectStr +'<select class="yy-input-enumdata form-control" id="'+fieldname+'" reallyname="'+fieldname+'" data-enum-group="'+fype+'">';
	var enumMap = YYDataUtils.getEnumMap();
	var enumdatas = enumMap[fype];
	if(enumdatas){
		/* if(value!=='' &&　value!=null){
			for (i = 0; i < enumdatas.length; i++) {
				if(enumdatas[i].enumdatakey == value){
					selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
				}
			}
		} else { */
			selectStr = selectStr + '<option value="">&nbsp;</option>';
		//}
		for (i = 0; i < enumdatas.length; i++) {
			if(enumdatas[i].enumdatakey == value){ 
				selectStr = selectStr + "<option selected='selected' value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			} else {
				selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			}
		}
	}
	selectStr = selectStr +'</select>';
	if(disabled){
		selectStr = selectStr + '</fieldset>';
	}
	//if(value!=='' &&　value!=null){
	//	$("select[name='"+fieldname+"']").val(value);
	//}
	return selectStr;
}
//创建下拉框(旧  建议使用creSelectStr)
function creRnum(fype, fieldname,value,disabled){
	var selectStr = '';
	if(disabled){
		selectStr = selectStr + '<fieldset disabled>';
	}
	selectStr = selectStr +'<select class="yy-input-enumdata form-control" id="'+fieldname+'" reallyname="'+fieldname+'" data-enum-group="'+fype+'">';
	var enumMap = YYDataUtils.getEnumMap();
	var enumdatas = enumMap[fype];
	if(enumdatas){
		/* if(value!=='' &&　value!=null){
			for (i = 0; i < enumdatas.length; i++) {
				if(enumdatas[i].enumdatakey == value){
					selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
				}
			}
		} else { */
			selectStr = selectStr + '<option value="">&nbsp;</option>';
		//}
		for (i = 0; i < enumdatas.length; i++) {
			if(enumdatas[i].enumdatakey == value){ 
				selectStr = selectStr + "<option selected='selected' value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			} else {
				selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			}
		}
	}
	selectStr = selectStr +'</select>';
	if(disabled){
		selectStr = selectStr + '</fieldset>';
	}
	//if(value!=='' &&　value!=null){
	//	$("select[name='"+fieldname+"']").val(value);
	//}
	return selectStr;
}

//创建下拉框不含有ID 
function creSelectNoId(fype, fieldname, value, disabled){
	var selectStr = '';
	if(disabled){
		selectStr = selectStr + '<fieldset disabled>';
	}
	selectStr = selectStr +'<select class="yy-input-enumdata form-control" reallyname="'+fieldname+'" data-enum-group="'+fype+'">';
	var enumMap = YYDataUtils.getEnumMap();
	var enumdatas = enumMap[fype];
	if(enumdatas){
		selectStr = selectStr + '<option value="">&nbsp;</option>';
		for (i = 0; i < enumdatas.length; i++) {
			if(enumdatas[i].enumdatakey == value){ 
				selectStr = selectStr + "<option selected='selected' value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			} else {
				selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
			}
		}
	}
	selectStr = selectStr +'</select>';
	if(disabled){
		selectStr = selectStr + '</fieldset>';
	}
	return selectStr;
}

/**
 * 超过width的宽度后，自动以...省略掉，并以鼠标title的形式可看到全文字
 * data： 展示的内容
 * width：宽度，直接传入数值，如果需要文字大于100px的宽度就显示省略号，就传100就行 
 *，不能大于td的宽度，最好小于td宽度20px
 */
function createDivOverFlow(data, width, id) {
	if(data!=null) {
		return '<div class="textoverflow" style="width:'+width+'px" title="'+data+'"  id="'+id+'">'+data+'</dov>';
	}
	return data;
}
function createBreakWord(data, width, id) {
	if(data==null) {
		data = '&nbsp;';
	}
	return '<div class="textbreakword" style="width:'+width+'px"  id="'+id+'">'+data+'</dov>';
}

//更新input select name
function updateInputName(tableid,detailname){
	if(typeof(detailname)=='undefined' || detailname == null ){
		detailname = "details";
	}
	if (  typeof(tableid)=='undefined' || tableid == null || tableid == '') {
		$('#yy-table tbody').find("tr").each(function(i){
			$(this).find("input").each(function(){
				
				$(this).attr("name",detailname+"["+i+"]."+ $(this).attr("reallyname"));
				
			});
		});
		$('#yy-table tbody').find("tr").each(function(i){
			$(this).find("select").each(function(){
				$(this).attr("name",detailname+"["+i+"]."+ $(this).attr("reallyname"));
			});
		});
	} else {
		$("#" + tableid+" tbody").find("tr").each(function(i){
			$(this).find("input").each(function(){
				if($(this).attr("reallyname")){
				$(this).attr("name",detailname+"["+i+"]."+ $(this).attr("reallyname"));
				}
			});
		});
		$("#" + tableid+" tbody").find("tr").each(function(i){
			$(this).find("select").each(function(){
				$(this).attr("name",detailname+"["+i+"]."+ $(this).attr("reallyname"));
			});
		});
	}
}
//表体合计行tableid 表id,reallyname 是否只读,isInt 是否整数
function colSum(tableid,reallyname,isInt){
	var total = 0;
	if (typeof(tableid)=='undefined' || tableid == null || tableid == '') {
		$("#yy-table tbody tr").each(function(i){
			//$(this).find("input[reallyname='rowno']").val(i+1);
			if($(this).css("display")!='none'){
				var num = $(this).find("input[reallyname='"+reallyname+"']").val();
				if(num == null || num=='' || typeof(num)=='undefined'){
					num = 0;
				}
				total = accAdd(total,num); 
			}
		});
	}else{
		$("#"+ tableid +" tbody tr").each(function(i){
			if($(this).css("display")!='none'){
				var num = $(this).find("input[reallyname='"+reallyname+"']").val();
				if(num == null || num=='' || typeof(num)=='undefined'){
					num = 0;
				}
				total = accAdd(total,num);
			}
		});
	}
	if(isInt){
		total=parseInt(total);
	}
	return total;
}
//验证表体是否为空   tableid：默认为yy-table  msg：提示信息，默认为表体不能为空!
function validateTableNull(tableid,msg){
	if(msg==null || msg==''){
		msg='表体不能为空!';
	}
	if (typeof(tableid)=='undefined' || tableid == null || tableid == '') {
		if($("#yy-table tbody > tr").length==1 && $("#yy-table tbody > tr >td").length==1){
			YYUI.failMsg(msg);
			return false;
		}else{
			var boo=false;
			$("#yy-table tbody tr").each(function(i){
				if($(this).css("display")!='none'){
					boo=true;
				}
			});
			if(!boo){
				YYUI.failMsg(msg);
				return false;
			}else{
				return true;
			}
			
		}
	}else{
		if($("#"+ tableid +" tbody > tr").length==1 && $("#"+ tableid +" tbody > tr >td").length==1){
			YYUI.failMsg(msg);
			return false;
		}else{
			var boo=false;
			$("#"+ tableid +" tbody tr").each(function(i){
				if($(this).css("display")!='none'){
					boo=true;
				}
			});
			if(!boo){
				YYUI.failMsg(msg);
				return false;
			}else{
				return true;
			}
			
		}
	}
	
}
//只能输出数字
function clearNoNum(obj)
{
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d.]/g,"");
    //必须保证第一个为数字而不是.
    obj.value = obj.value.replace(/^\./g,"");
    //保证只有出现一个.而没有多个.
    obj.value = obj.value.replace(/\.{2,}/g,".");
    //保证.只出现一次，而不能出现两次以上
    obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
//只能输出数字
function clearNoIntNum(obj)
{
    //先把非数字的都替换掉，除了数字和.
    obj.value = obj.value.replace(/[^\d]/g,"");
}
//创建日期选择
function creDateStr(field,value,readonly,cla){
	if(value==null){
		value = '';
	}
	var str='';
	if(field == 'rowno'){
		if(readonly){
			str = '<input style="border:1px;text-align:center;background-color:transparent;" class="Wdate form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input style="border:1px;text-align:center;background-color:transparent;"  class="Wdate form-control '+cla+'" value="'+ value + '" reallyname="'+field+'" onclick=" WdatePicker();">';
		}
	}else{
		if(readonly){
			str = '<input class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'"  readonly="true">';
		}else{
			str = '<input class="form-control '+cla+'" value="'+ value + '" reallyname="'+field+'" onclick=" WdatePicker();">';
		}
	}
	
	return str;
}
//如果为空保留0，返回保留两位小数
function accNull(arg1){
	if(arg1==null){
		return 0.0000.toFixed(4);
	}else{
		return arg1.toFixed(4);
	}
}
//js 加法计算  
//调用：accAdd(arg1,arg2)  
//返回值：arg1加arg2的精确结果   
function accAdd(arg1,arg2){   
	var r1,r2,m;   
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}   
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}   
	m=Math.pow(10,Math.max(r1,r2))   
	return ((arg1*m+arg2*m)/m).toFixed(4);   
}   
//js 减法计算  
//调用：Subtr(arg1,arg2)  
//返回值：arg1减arg2的精确结果   
function accSubtr(arg1,arg2){  
   var r1,r2,m,n;  
   try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}  
   try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}  
   m=Math.pow(10,Math.max(r1,r2));  
   //last modify by deeka  
   //动态控制精度长度  
   n=(r1>=r2)?r1:r2;  
   return ((arg1*m-arg2*m)/m).toFixed(4);  
}   
//js 除法函数  
//调用：accDiv(arg1,arg2)  
//返回值：arg1除以arg2的精确结果   
function accDiv(arg1,arg2){   
	var t1=0,t2=0,r1,r2;   
	try{t1=arg1.toString().split(".")[1].length}catch(e){}   
	try{t2=arg2.toString().split(".")[1].length}catch(e){}   
	with(Math){   
	  r1=Number(arg1.toString().replace(".",""))   
	  r2=Number(arg2.toString().replace(".",""))   
	  return (r1/r2)*pow(10,t2-t1);   
	}   
}   

//js 乘法函数  
//调用：accMul(arg1,arg2)   
//返回值：arg1乘以arg2的精确结果   
function accMul(arg1,arg2)   
{   
	var m=0,s1=arg1.toString(),s2=arg2.toString();   
	try{m+=s1.split(".")[1].length}catch(e){}   
	try{m+=s2.split(".")[1].length}catch(e){}   
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);  
}  

//清除不是正负数的
function clearNotPNku(obj){
	 //先把非数字的都替换掉，除了数字和.
     obj.value = obj.value.replace(/[^\d.-]/g,"");
	 //保证.只出现一次，而不能出现两次以上
	 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	 obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
}

function clearNotPNblur(obj){
	var val=obj.value;
	var reg = /^(-)?\d+(\.\d+)?$/;  //  /^\-\d+\.?\d*$/;
	if(!reg.test(val)){
		return obj.value="";
	}
}
//去掉前后空格
function yyTrim(str)
{ 
    return str.replace(/(^\s*)|(\s*$)/g, ""); 
}
//数组去掉重复项
function unique(arr) {
	var result = [], isRepeated;
	for (var i = 0; i < arr.length; i++) {
		isRepeated = false;
		for (var j = 0, len = result.length; j < len; j++) {
			if (arr[i] == result[j]) {
				isRepeated = true;
				break;
			}
		}
		if (!isRepeated) {
			result.push(arr[i]);
		}
	}
	return result;
}

//传入数字,格式化为0.0000
function formatMoney(s) {
	if(!s) {
		return '0.0000';
	}
	return formatNumber(s, 4);
}

//格式化为整数
function formatInteger(s) { 
	if(!s) {
		return '0';
	}
	return formatNumber(s, 0); 
}

//传入数字,格式化为0.00
function formatAmount(s) { 
	if(!s) {
		return '0.00';
	}
	return formatNumber(s, 2); 
} 

//s:传入的float数字 ，n:希望返回小数点几位
function formatNumber(s, n) { 
	n = n >= 0 && n <= 20 ? n : 2; 
	s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + ""; 
	var l = s.split(".")[0].split("").reverse(), 
	r = s.split(".")[1]; 
	t = ""; 
	for(i = 0; i < l.length; i ++ ) { 
		t += l[i]; 
		//+ ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : ""); 
	} 
	if(n == 0) {
		return t.split("").reverse().join("");
	}
	return t.split("").reverse().join("") + "." + r; 
} 

</script>