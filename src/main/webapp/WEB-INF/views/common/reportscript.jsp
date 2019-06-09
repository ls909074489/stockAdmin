<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="public.jsp"%>
<script type="text/javascript">
    //初始化报表：宽  高  锁定行  锁定列
    function initReport(width,height,headerRows,fixedCols){
    	/* if(width==null||width==''){
    		width="1000px";
    	}
    	if(height==null||height==''){
    		height="500px";
    	}
    	if(headerRows==null||headerRows==''){
    		headerRows=2;
    	}
    	if(fixedCols==null||fixedCols==''){
    		fixedCols=0;
    	} */
		//设定SuperTable
       $("#GridView1").toSuperTable({ width: width,height: height, headerRows: headerRows,fixedCols: fixedCols, onFinish:
            function() { }
        }) 
	}
	function onExport(){
		
		var _queryData = $("#yy-form-query").serializeArray();
		var url = '${serviceurl}/exportData';
		var tempForm = document.createElement("form");
		tempForm.id = "tempForm1";
		tempForm.method = "post";
		tempForm.action = url;
		tempForm.target = "download window";
		for (var i = 0; i < _queryData.length; i++) {
			var hideInput = document.createElement("input");
			hideInput.type = "hidden";
			hideInput.name = _queryData[i].name;
			hideInput.value = _queryData[i].value;
			tempForm.appendChild(hideInput);
		}
		document.body.appendChild(tempForm);
		tempForm.submit();
		document.body.removeChild(tempForm);
	}
	function reset(){
		YYFormUtils.clearQueryForm("yy-form-query");
		return false;
	}
	function bindReportActions(){
		$("#yy-btn-export").bind("click",onExport);
		$("#yy-btn-search").bind('click', loadList);//
		$("#yy-searchbar-reset").bind('click', reset);//
	}
	//清除不是正负数的
	function clearNotPNku(obj){
		 //先把非数字的都替换掉，除了数字和.
	     obj.value = obj.value.replace(/[^\d.-]/g,"");
		 //保证.只出现一次，而不能出现两次以上
		 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		 obj.value = obj.value.replace("-","$#$").replace(/\-/g,"").replace("$#$","-");
	}
	// 日期，在原有日期基础上，增加days天数，默认增加1天
	function addDate(date, days) {
		if (days == 0) {
	        return date;
	    }
	    if (days == undefined || days == '') {
	        days = 1;
	    }
	    
	    var date = new Date(date);
	    date.setDate(date.getDate() + days);
	    var month = date.getMonth() + 1;
	    var day = date.getDate();
	    return date.getFullYear() + '-' + getFormatDate(month) + '-' + getFormatDate(day);
	}
	
	// 日期月份/天的显示，如果是1位数，则在前面加上'0'
	function getFormatDate(arg) {
	    if (arg == undefined || arg == '') {
	        return '';
	    }
	
	    var re = arg + '';
	    if (re.length < 2) {
	        re = '0' + re;
	    }
	
	    return re;
	}
	// 日期 计算两个日期差
	function diffDate(date1,date2){
		 var d1 = new Date(date1);
		 var d2 = new Date(date2);
		 var time = d2.getTime() - d1.getTime();
		 return Math.floor(time/(24*60*60*1000));
	}
	function change(data){
		if(data==null){
			return "";
		}else{
			return formatThousands(data);
		}
	}
	//返回千分位的数字
	function formatThousands(data) {
		if(data==null){
			return "";
		}
	    return (parseFloat(num).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');

	}
	//转换字符串
	function changeStr(data){
		if(data==null || data=='null'){
			return '';
		}else{
			return data;
		}
	}
	//转换数字 
	function changeNum(data,iszero){
		if(data==null || data=='null'){
			if(iszero){
				return 0;
			}else{
				return '';
			}
		}else{
			return data;
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
</script>