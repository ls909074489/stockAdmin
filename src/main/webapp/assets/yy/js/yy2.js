//RAP AJAX 默认设置
$.ajaxSetup({
	"type" : "POST",
	"error" : function(XMLHttpRequest, textStatus, errorThrown){
		alert("操作请求(AJAX)出现错误，错误信息：" + errorThrown + "\n\nHTTP状态码：" + XMLHttpRequest.status);
	},
	//complete的执行在success之后，如果登录超时了，在success中很可能出现js错误，所以该方法无法拦截到服务器返回的登录超时信息。
	"complete" : function(XMLHttpRequest, textStatus){
		//var txt = XMLHttpRequest.responseText;
		//通过XMLHttpRequest取得响应头，sessionstatus
		var sessionstatus= XMLHttpRequest.getResponseHeader("sessionstatus"); 
		if(sessionstatus=="timeout"){ 
    		//如果超时就处理 ，指定要跳转的页面
        	alert("会话超时，请重新登录！");
        	//window.top.location = RAP_APP_PATH + "/login";
        } 
	}
});
/**
 * 重写jquery的ajax方法，增强success和error的回调方法。
 */
(function($){

    //备份jquery的ajax方法
    var _ajax=$.ajax;

    //重写jquery的ajax方法
    $.ajax=function(opt){
        //备份opt中error和success方法
        var fn = {
            error:function(XMLHttpRequest, textStatus, errorThrown){},
            success:function(data, textStatus){}
        }
        if(opt.error){
            fn.error=opt.error;
        }
        if(opt.success){
            fn.success=opt.success;
        }
        //扩展增强处理
        var _opt = $.extend(opt,{
            error:function(XMLHttpRequest, textStatus, errorThrown){
                //错误方法增强处理
            	/*if("parsererror"==textStatus){
            		//如果超时就处理 ，指定要跳转的页面
                	alert("会话超时或服务器错误，请重新登录！");
                	return;
            	}*/
                fn.error(XMLHttpRequest, textStatus, errorThrown);
            },

            success:function(data, textStatus,xhr){
                //成功回调方法增强处理
            	var sessionstatus= xhr.getResponseHeader("sessionstatus"); 
        		if(sessionstatus=="timeout"){ 
            		//如果超时就处理 ，指定要跳转的页面
                	alert("会话超时，请重新登录！");
                	return;
                } 
                fn.success(data, textStatus);
            },
            statusCode: {//传入statusCode对象，定义对状态码操作的方法
	             900 : function() {//900为服务器返回的自定义状态码，说明当前操作没有权限
	                 alert("您没有权限进行此项操作，请联系管理员！");
	                   return;
	
	             }
            }
        });
        _ajax(_opt);

    };

})(jQuery);

jQuery.extend(jQuery.colorbox.settings, {
	current : "当前图像 {current} 总共 {total}",
	previous : "前一页",
	next : "后一页",
	close : "&times;",
	xhrError : "此内容无法加载",
	imgError : "此图片无法加载",
	slideshowStart : "开始播放幻灯片",
	slideshowStop : "停止播放幻灯片",
	opacity : "0.5",
	iframe : true,
	overlayClose:false,  //单击遮罩层就可以把ColorBox关闭
	//speed : 200, //弹出速度 100ms
	close : '×'
	
});


//RapDataUtils.loadEnumData();

var _rapui;
var _hasShowPop ;
$(document).ready(function() {
	if (!window.applicationCache) {
		alert("本平台不支持您的浏览器，请留意屏幕下方的相关说明");
	}
	_rapui = new RapUIManager();
	//_rapui.configColorBox();
	_rapui.setUIStyle();
	_rapui.setListMode();
	RapValidator.setJqValidator();
	
	//popover
	$(document).on("click",function(){
		  if(_hasShowPop){
			  $(".popover").popover("hide");
			  _hasShowPop=false;
		  }
	  });
});

