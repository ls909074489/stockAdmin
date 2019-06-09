<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
_isServerPage='true'
var _tableCols = [{
    data : "uuid",
    orderable : false,
    className : "center",
    width : "10%",
    render : YYDataTableUtils.renderCheckCol
},{
    data : "uuid",
    className : "center",
    orderable : false,
    render : function(data, type, full) {
    	return "<div class='yy-btn-actiongroup'>"
    	+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
    	+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"       
    	+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
    	+ "</div>";
    },
    width : "10%"
},{
    data : 'createtime',
    width : "12%",
    className : "center",
    orderable : true
}, {
    data : 'interfaceurl',
    width : "25%",
    orderable : true
},{
    data : 'description',
    width : "15%",
    className : "center",
    orderable : true
},{
    data : 'result',
    width : "15%",
    className : "center",
    orderable : true,
    "render":function (data) {
		return data==1?"成功":"失败";
    }
},{
    data : 'cause',
    width : "15%",
    orderable : true
}];

//刷新
/* function onRefresh() {
	serverPage();
} */

//服务器分页，排序
function getOrderbyParam(d) {
	var orderby = d.order[0];
	if (orderby != null && null != _tableCols) {
		var dir = orderby.dir;
		var orderName = _tableCols[orderby.column].data;
		return orderName + "@" + dir;
	}
	return "createtime@desc";
}

/*初始化页面*/
$(document).ready(function() {
	serverPage(null);//服务器分页
	bindButtonActions();//按钮绑定事件
});


function showData(data) {
    $("input[name='uuid']").val(data.uuid);
    $("#uuid").val(data.uuid);
    $("input[name='createtime']").val(data.createtime);
    $("input[name='interfaceurl']").val(data.interfaceurl);
    $("input[name='description']").val(data.description);
   	$("select[name='result']").val(data.result);
    //$("input[name='cause']").val(data.cause);
    $("textarea[name='cause']").val(data.cause);
    if(data.result==0){
    	$("#causeRow").show();
    }else{
    	$("#causeRow").hide();
    }
    startTime = $.myTime.UnixToDate(data.starttime/1000,true);
    $("input[name='starttime']").val($.myTime.UnixToDate(data.starttime/1000,true));
    $("input[name='endtime']").val($.myTime.UnixToDate(data.endtime/1000,true));
    
    if(data.content!=null){
    	$("textarea[name='content']").val(data.content.replace('\\',''));
    }
}

/*重新执行*/
function processJobLog(url,type){
	var uuid = $('#uuid').val();
	if(type=="执行数据"){
		onSave(uuid);
	}
	processJob(url,type,uuid);
}


/* 保存 */
function onSave() {
	var uuid = $("#uuid").val();
	var content = $("#content").val();
	$.ajax({
		"dataType" : "json",
		"type" : "POST",
		"url" : '${serviceurl}/onlySaveData',
		async: false,
		"data" :{"uuid" :uuid,"content":content},
		"success" : function(data) {
			if (data.success) {
				YYUI.succMsg("保存成功", {
					icon : 1
				});
				if (typeof (fnCallback) != "undefined")
					fnCallback(data);
					console.info(data);
			} else {
				YYUI.failMsg("保存失败，原因：" + data.msg);
			}
		},
		"error" : function(XMLHttpRequest, textStatus, errorThrown) {
			YYUI.failMsg("保存失败，HTTP错误。");
		}
	});
	
	
}

/*重写列表按钮*/
YYDataTableUtils.setActions = function(nRow, aData, iDataIndex) {
	//双击
	$(nRow).dblclick(function() {
		onViewDetailRow(aData, iDataIndex, nRow);
	});

	$('#yy-btn-view-row', nRow).click(function() {
		onViewDetailRow(aData, iDataIndex, nRow);
	});

	$('#yy-btn-edit-row', nRow).click(function() {
		onEditRow(aData, iDataIndex, nRow);
	});

	$('#yy-btn-remove-row', nRow).click(function() {
		onRemoveRow(aData, iDataIndex, nRow);
	});

	/*
	$('#yy-btn-download-row', nRow).click(function() {
		onDownloadRow(aData, iDataIndex, nRow);
	});
	
	$('#yy-btn-gen-row', nRow).click(function() {
		onYyBtnGenRow(aData, iDataIndex, nRow);
	});
	
	重新执行
	$('#yy-btn-resume-row', nRow).click(function() {
		onResume(aData, iDataIndex, nRow);
	});*/
};

</script>



