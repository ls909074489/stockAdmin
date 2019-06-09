<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="public.jsp"%>
<%@include file="dateutils.jsp"%>
<script type="text/javascript">
	//===================按钮事件===================
	//保存
	var isClose=true;
 	function onSave(isClose) {
		addSubListValid();
		if (!$('#yy-form-edit').valid()) return false;
		doBeforeSave();
		if (!validOther()) return false;
		var editview = layer.load(2);
		
		var posturl = "${serviceurl}/add";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != "undefined") {
			posturl = "${serviceurl}/update";
		}
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success) {
					layer.close(editview);
					if (isClose) {
						window.parent.YYUI.succMsg('保存成功!');
						window.parent.onRefresh(true);
						//window.parent.onDetailRow(pk);跳转到编辑页面
						closeEditView();
					} else {
						YYUI.succMsg('保存成功!');
					}
					doAfterSaveSuccess(data.records);
				} else {
					//window.parent.YYUI.failMsg("保存出现错误：" + data.msg);
					window.parent.YYUI.failMsg("保存失败：" + data.msg);
					layer.close(editview);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				window.parent.YYUI.promAlert("保存失败，HTTP错误。");
				layer.close(editview);
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	} 
	//保存提交
	function onSaveSubmit(isClose){
		addSubListValid();
		if (!$('#yy-form-edit').valid()){
			return false;
		}
		doBeforeSaveSubmit();
		if (!validOther()){
			return false;
		}
		layer.confirm("你确实要提交吗？", function(index) {
			var editview = layer.load(2);
			
			var posturl = "${serviceurl}/saveSubmit";
			var pk = $("input[name='uuid']").val();
			if (pk != "" && typeof (pk) != "undefined") {
				posturl = "${serviceurl}/updateSubmit";
			}
			var opt = {
					url : posturl,
					type : "post",
					success : function(data) {
						if (data.success) {
							layer.close(editview);
							if (isClose) {
								window.parent.YYUI.succMsg('提交成功!');
								window.parent.onRefresh(true);
								closeEditView();
							} else {
								window.parent.YYUI.succMsg('提交成功!');
								window.parent.onRefresh(true);
							}
							doAfterSaveSubmitSuccess(data);
						} else {
							window.parent.YYUI.failMsg("提交出现错误：" + data.msg)
							layer.close(editview);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						window.parent.YYUI.promAlert("提交失败，HTTP错误。");
						layer.close(editview);
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
		}, function(index) {
			return;
		});
	}
	
	function onConfirmCancel() {
		if('${openstate}' == 'detail') {
			onCancel();
			return;
		}
		layer.confirm("你确实要退出保存页面吗？", function(index) {
			if(window.parent._tableList) {
				window.parent.onRefresh();
			}
			onCancel();
		}, function(index) {
			return;
		});
	}
	
	//取消编辑，返回列表视图
	function onCancel() {
		$('#yy-form-edit div.control-group').removeClass('error');
		closeEditView();
		doAfterCancel();
	}

	//返回列表视图
	function onBackToList() {
		closeEditView();
		doAfterBackToList();
	}

	//取消编辑视图
	function closeEditView() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	}
	//===================按钮绑定方法===================
	//绑定编辑页面按钮
	function bindEditActions() {
		$("#yy-btn-cancel").bind('click', onConfirmCancel);
		$("#yy-btn-save").bind("click", function() {
			onSave(isClose);
		});
		$("#yy-btn-savestay").bind("click", function() {
			onSave(isClose);
		});
		$("#rap-btn-savenew").bind('click', function() {
			onSave(false);
		});
		$("#yy-btn-savesubmit").bind('click', function(){
			onSaveSubmit(true);
		});
		bindSysInfo();
	}
	//绑定查询页面按钮
	function bindDetailActions() {
		$('#yy-btn-backtolist').bind('click', onBackToList);
		bindSysInfo();
	}
	
	//===================方法===================
	//表体添加行
	function addRow(tableList,data,tableid){
		tableList.rows.add(data);
		tableList.draw();
		creRowNo(tableid);
		total();
	}
	//表体删除行
	function deleteRow(tableList,nRow,tableid){
		var aData = tableList.row(nRow).data();
		var row = tableList.row(nRow);
		if(aData.uuid == null || aData.uuid==''){
			row.remove().draw();
		}else{
			$(nRow).find("[name='status']").val('0')
			$(nRow).find("[reallyname='status']").val('0')
			$(nRow).hide();
			row.draw();
		}
		creRowNo(tableid);
		total();
	}
	//合计行
	function total(){
		
	}
	//生成行号
	function creRowNo(tableid){
		if (typeof(tableid)=='undefined' || tableid == null || tableid == '') {
			var index = 1;
			$("#yy-table tbody tr").each(function(i){
				//$(this).find("input[reallyname='rowno']").val(i+1);
				if($(this).css("display")!='none'){
					$(this).find("input[reallyname='rowno']").val(index);
					index = index+1;
				}
			});
		}else{
			var index = 1;
			$("#"+ tableid +" tbody tr").each(function(i){
				if($(this).css("display")!='none'){
					$(this).find("input[reallyname='rowno']").val(index);
					index = index+1;
				}
			});
		}
		
	}
	
	/**
	 * 请求方法
	 * requestUrl: 请求链接
	 * params： 请求参数，以json{a:aa,b:bb}形式或者参数形式a=aa&b=bb
	 * callMethodName: 回调方法名，方法名，不要加引号
	 */
	function RequestServer(){
	 	var editview;
		this.request = function(requestUrl, params, callMethodName, callParams) {
			$.ajax({
				//async : false,
				cache: false,
				type : "post",
				dataType : "json",
				url : requestUrl,
				data : params,
				beforeSend: function(){
					editview = layer.load(2);
			    },
			    complete: function(){
			    	layer.close(editview);
			    },
				success : function(data, textStatus) {
					if (data.success) {
						data.callParams = callParams;
						callMethodName(data);
					} else {
						YYUI.failMsg("查询出现错误：" + data.msg)
					}
				},
				error : function(e){
					YYUI.promAlert("查询失败，HTTP错误。");
				}
			});
		}
	}
	 
	//ui：表格前两列宽度，如果是yy-table-x的不控制
	tabWidthBy2Column();
	function tabWidthBy2Column() {
		var tab = $("#yy-table-list").attr("class") || "";
		if(tab==""){return;};
		tab = tab.indexOf("yy-table-x")!=-1?true:false;
		if(!tab) {
			$("#yy-table-list thead tr").find("th:eq(0)").css("width", "50px");
			$("#yy-table-list thead tr").find("th:eq(1)").css("width", "80px");
			$("#yy-table-sublist thead tr").find("th:eq(0)").css("width", "50px");
			$("#yy-table-sublist thead tr").find("th:eq(1)").css("width", "80px");
		}
	}
	
/* 	function rMoney(s) { 
		return parseFloat(s.replace(/[^\d\.-]/g, "")); 
	}  */
	
	//清除参照输入框的值
	function cleanDef(defId,defName){
		if(cleanDefBefore()){
			$("#"+defId).val("");
			$("#"+defName).val("");
		}
		cleanDefAfter();
	}
	
	function cleanDefBefore() {
		return true;
	}

	function cleanDefAfter() {
		return true;
	}
	
	//公共方法之前
	function doBefore() {
		return true;
	}
	//公共方法之后
	function doAfter() {
		return true;
	}
	//保存前
	function doBeforeSave() {
		doBefore();
		return true;
	}
	//保存提交前
	function doBeforeSaveSubmit() {
		doBefore();
		return true;
	}
	//返回后
	function doAfterBackToList() {
		return true;
	}
	//取消后
	function doAfterCancel() {
		return true;
	}
	//保存成功后
	function doAfterSaveSuccess(data) {
		doAfter(data);
		return true;
	}
	//保存提交后
	function doAfterSaveSubmitSuccess(data) {
		doAfter(data);
		return true;
	}
	//子表校验
	function addSubListValid() {
	}
	//校验其它
	function validOther() {
		return true;
	}
</script>