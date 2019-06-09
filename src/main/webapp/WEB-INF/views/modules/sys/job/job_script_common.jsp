<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">

//ajax调用接口
function processJob(url,operation,pks){
	if(pks==null||typeof(pks) == "undefined"){
		pks = YYDataTableUtils.getSelectPks();
	}
	layer.confirm('确定要'+operation+'吗？', function() {
		ajaxProcess(url,operation,pks);
	});
}

function ajaxProcess(url,operation,pks){
	$.ajax({
		"dataType" : "json",
		"type" : "POST",
		"url" : url,
		async: false,
		"data" : {
			"pks" : pks.toString()
		},
		"success" : function(data) {
			if (data.success) {
				YYUI.succMsg(operation + "成功", {
					icon : 1
				});
				if (typeof (fnCallback) != "undefined")
					fnCallback(data);
			} else {
				YYUI.failMsg(operation+"失败，原因：" + data.msg);
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown) {
			YYUI.failMsg(operation+"失败，HTTP错误。");
		}
	});
}

function ajaxProcessData(url,operation,data){
	$.ajax({
		"dataType" : "json",
		"type" : "POST",
		"url" : url,
		async: false,
		"data" :data,
		"success" : function(data) {
			if (data.success) {
				YYUI.succMsg(operation + "成功", {
					icon : 1
				});
				if (typeof (fnCallback) != "undefined")
					fnCallback(data);
					//console.info(data);
			} else {
				YYUI.failMsg(operation+"失败，原因：" + data.msg);
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown) {
			YYUI.failMsg(operation+"失败，HTTP错误。");
		}
	});
}


(function($) {
    $.extend({
        myTime: {
            /**
             * 当前时间戳
             * @return <int>        unix时间戳(秒)  
             */
            CurTime: function(){
                return Date.parse(new Date())/1000;
            },
            /**              
             * 日期 转换为 Unix时间戳
             * @param <string> 2014-01-01 20:20:20  日期格式              
             * @return <int>        unix时间戳(秒)              
             */
            DateToUnix: function(string) {
                var f = string.split(' ', 2);
                var d = (f[0] ? f[0] : '').split('-', 3);
                var t = (f[1] ? f[1] : '').split(':', 3);
                return (new Date(
                        parseInt(d[0], 10) || null,
                        (parseInt(d[1], 10) || 1) - 1,
                        parseInt(d[2], 10) || null,
                        parseInt(t[0], 10) || null,
                        parseInt(t[1], 10) || null,
                        parseInt(t[2], 10) || null
                        )).getTime() / 1000;
            },
            /**              
             * 时间戳转换日期              
             * @param <int> unixTime    待时间戳(秒)              
             * @param <bool> isFull    返回完整时间(Y-m-d 或者 Y-m-d H:i:s)              
             * @param <int>  timeZone   时区              
             */
            UnixToDate: function(unixTime, isFull, timeZone) {
                if (typeof (timeZone) == 'number')
                {
                    unixTime = parseInt(unixTime) + parseInt(timeZone) * 60 * 60;
                }
                var time = new Date(unixTime * 1000);
                var ymdhis = "";
                ymdhis += time.getUTCFullYear() + "-";
                ymdhis += (time.getUTCMonth()+1) + "-";
                ymdhis += time.getUTCDate();
                if (isFull === true)
                {
                    ymdhis += " " + time.getUTCHours() + ":";
                    ymdhis += time.getUTCMinutes() + ":";
                    ymdhis += time.getUTCSeconds();
                }
                return ymdhis;
            }
        }
    });
})(jQuery); 


 //运行
 function run(jobId,parameterJson){
	
	$.ajax({
		"dataType" : "json",
		"type" : "POST",
		"url" : '${serviceurl}/runNow',
		async: false,
		"data" : {
			"jobId" : jobId,
			"parameterJson":parameterJson
		},
		"success" : function(data) {
			if (data.success) {
				YYUI.succMsg("立即执行成功,详情请查阅日志", {
					icon : 1
				});
					//if (typeof (fnCallback) != "undefined")
					//fnCallback(data);
			} else {
				YYUI.failMsg("立即执行操作失败，原因：" + data.msg);
			}
			onProcessCancel();
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown) {
			YYUI.failMsg("操作失败，HTTP错误。");
		}
	  });
	}


	//取消
	function onProcessCancel(){
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	}
	
	//重置
	function reset(){
		$("#startTime").val('');
		$("#endTime").val('');
	}

</script>