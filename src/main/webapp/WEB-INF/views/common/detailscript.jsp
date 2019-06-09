<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="public.jsp"%>
<%@include file="dateutils.jsp"%>
<script type="text/javascript">
	var isClose = false;
	//===================按钮事件===================
	//返回列表视图
	function onBackToList() {
		closeDetailView();
		doAfterBackToList();
	}
	//返回
	function closeDetailView() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	}
	//提交
	function onSubmit(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus>0 && billstatus!='1' && billstatus!='4'){
			YYUI.failMsg("非自由态或退回态的单据不能提交！")
			return false;
		}
		doBeforeSubmit();
		var detailview = layer.load(2);		
		var opt = {
				url : "${serviceurl}/submit",
				type : "post",
				success : function(data) {
					if (data.success) {
						layer.close(detailview);
						if (isClose) {
							window.parent.YYUI.succMsg('提交成功!');
							window.parent.onRefresh(true);
							closeDetailView();
						} else {
							window.parent.YYUI.succMsg('提交成功!');
							window.parent.onRefresh(true);
						}
						doAfterSubmitSuccess(data.records);
					} else {
						window.parent.YYUI.failMsg("提交出现错误：" + data.msg)
						layer.close(detailview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("提交失败，HTTP错误。");
					layer.close(editview);
				}
			}
			$("#yy-form-detail").ajaxSubmit(opt);
	}
	//退回
	function onRevoke(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus>0 && (billstatus!='2' && billstatus!='3')){
			YYUI.failMsg("非提交态或审批态的单据不能退回！")
			return false;
		}
		doBeforeRevoke();
		layer.confirm('确实要退回吗？', function() {
			var detailview = layer.load(2);	
			var opt = {
				url : "${serviceurl}/revoke",
				type : "post",
				success : function(data) {
					if (data.success) {
						layer.close(detailview);
						if (isClose) {
							window.parent.YYUI.succMsg('退回成功!');
							window.parent.onRefresh(true);
							closeDetailView();
						} else {
							window.parent.YYUI.succMsg('退回成功!');
							window.parent.onRefresh(true);
						}
						doAfterRevokeSuccess(data.records);
					} else {
						window.parent.YYUI.failMsg("退回出现错误：" + data.msg)
						layer.close(detailview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("退回失败，HTTP错误。");
					layer.close(detailview);
				}
			}
			layer.closeAll();
			$("#yy-form-detail").ajaxSubmit(opt);
			
		});
	}
	//审核
	function onApprove(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus > 0 && billstatus!='2' && billstatus!='3'){
			YYUI.failMsg("非提交态和审批态的单据不能审核！")
			return false;
		}
		doBeforeApprove();
		var detailview = layer.load(2);		
		var opt = {
				url : "${serviceurl}/approve",
				type : "post",
				success : function(data) {
					if (data.success) {
						layer.close(detailview);
						if (isClose) {
							window.parent.YYUI.succMsg('审核成功!');
							window.parent.onRefresh(true);
							closeDetailView();
						} else {
							window.parent.YYUI.succMsg('审核成功!');
							window.parent.onRefresh(true);
						}
						doAfterApproveSuccess(data.records);
					} else {
						window.parent.YYUI.failMsg("审核出现错误：" + data.msg)
						layer.close(detailview);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("审核失败，HTTP错误。");
					layer.close(detailview);
				}
			}
			$("#yy-form-detail").ajaxSubmit(opt);
	}
	var _approveParam = {};
	//审核
	function onApprovex(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus > 0 && billstatus!='2' && billstatus!='3'){
			YYUI.failMsg("非提交态和审批态的单据不能审核！")
			return false;
		}
		doBeforeApprove();
		
		var modal = $("#approveRemark");
		modal.find('#content').val("");
		modal.find('.modal-title').text("审核意见");
		modal.find('#approvepass').unbind("click");
		modal.find('#approvepass').bind("click",
				function() {
					modal.find('.error').text('');
					var content = modal.find('#content').val();
					if(content!=null && content.length>200){
						window.parent.YYUI.failMsg("审核意见不能超过200个字符！");
						return;
					}
					_approveParam["approveRemark"] = content;
					var detailview = layer.load(2);		
					var opt = {
							url : "${serviceurl}/approve",
							type : "post",
							"data" : _approveParam,
							success : function(data) {
								$('#approveRemark').modal('hide');
								if (data.success) {
									//layer.close(detailview);
									layer.closeAll();
									if (isClose) {
										window.parent.YYUI.succMsg('审核成功!');
										window.parent.onRefresh(true);
										//closeDetailView();
										layer.closeAll();
									} else {
										window.parent.YYUI.succMsg('审核成功!');
										window.parent.onRefresh(true);
									}
									doAfterApproveSuccess(data.records);
								} else {
									window.parent.YYUI.failMsg("审核出现错误：" + data.msg)
									//layer.close(detailview);
									layer.closeAll();
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								window.parent.YYUI.promAlert("审核失败，HTTP错误。");
								//layer.close(detailview);
								layer.closeAll();
							}
						}
						$("#yy-form-detail").ajaxSubmit(opt);
				});
		modal.find('#approvenopass').unbind("click");
		modal.find('#approvenopass').bind("click",
				function() {
					modal.find('.error').text('');
					var content = modal.find('#content').val();
					if(content==null||content.length==0){
						window.parent.YYUI.failMsg("退回意见不能为空！");
						return;
					}
					if(content!=null && content.length>200){
						window.parent.YYUI.failMsg("退回意见不能超过200个字符！");
						return;
					}
					_approveParam["approveRemark"] = content;
					var detailview = layer.load(2);		
					var opt = {
							url : "${serviceurl}/revoke",
							type : "post",
							"data" : _approveParam,
							success : function(data) {
								$('#approveRemark').modal('hide');
								if (data.success) {
									//layer.close(detailview);
									if (isClose) {
										window.parent.YYUI.succMsg('退回成功!');
										window.parent.onRefresh(true);
										closeDetailView();
									} else {
										window.parent.YYUI.succMsg('退回成功!');
										window.parent.onRefresh(true);
									}
									doAfterApproveSuccess(data.records);
									layer.closeAll();
								} else {
									window.parent.YYUI.failMsg("退回出现错误：" + data.msg)
									//layer.close(detailview);
									layer.closeAll();
								}
							},
							error : function(XMLHttpRequest, textStatus, errorThrown) {
								window.parent.YYUI.promAlert("退回失败，HTTP错误。");
								//layer.close(detailview);
								layer.closeAll();
							}
						}
						$("#yy-form-detail").ajaxSubmit(opt);
				});
		$('#approveRemark').modal({
			toggle : "modal"
		});
	}
	//取消审核
	function onUnApprove(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus > 0 && billstatus!='5'){
			YYUI.failMsg("非通过态的单据不能取消审核！")
			return false;
		}
		doBeforeUnApprove();
		layer.confirm('确实要取消审核吗？', function() {	
			var detailview = layer.load(2);
			var opt = {
				url : "${serviceurl}/unApprove",
				type : "post",
				success : function(data) {
					if (data.success) {
						//layer.close(detailview);
						if (isClose) {
							window.parent.YYUI.succMsg('取消审核成功!');
							window.parent.onRefresh(true);
							closeDetailView();
						} else {
							window.parent.YYUI.succMsg('取消审核成功!');
							window.parent.onRefresh(true);
						}
						doAfterUnApproveSuccess(data.records);
						layer.closeAll();
					} else {
						window.parent.YYUI.failMsg("取消审核出现错误：" + data.msg)
						//layer.close(detailview);
						layer.closeAll();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("取消审核失败，HTTP错误。");
					//layer.close(detailview);
					layer.closeAll();
				}
			}
			$("#yy-form-detail").ajaxSubmit(opt);
			//layer.closeAll();
		});
	}
	//撤销提交
	function onUnSubmit(isClose){
		var billstatus=$("select[name='billstatus']").val();
		if(billstatus > 2){
			YYUI.failMsg("非提交态的单据不能撤销提交！")
			return false;
		}
		doBeforeUnSubmit();
		layer.confirm('确实要撤销提交吗？', function() {	
			var detailview = layer.load(2);
			var opt = {
				url : "${serviceurl}/unSubmit",
				type : "post",
				success : function(data) {
					if (data.success) {
						//layer.close(detailview);
						if (isClose) {
							window.parent.YYUI.succMsg('撤销提交成功!');
							window.parent.onRefresh(true);
							closeDetailView();
						} else {
							window.parent.YYUI.succMsg('撤销提交成功!');
							window.parent.onRefresh(true);
						}
						doAfterSubmitSuccess(data.records);
						layer.closeAll();
					} else {
						window.parent.YYUI.failMsg("撤销提交出现错误：" + data.msg)
						//layer.close(detailview);
						layer.closeAll();
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					window.parent.YYUI.promAlert("撤销失败，HTTP错误。");
					//layer.close(detailview);
					layer.closeAll();
				}
			}
			
			$("#yy-form-detail").ajaxSubmit(opt);
			
		});
	}
	//行编辑   @data 行数据  @rowidx 行下标
	function onEditRow(aData, iDataIndex, nRow) {
		if(!onEditRowBefore(aData, iDataIndex, nRow)) {
			return;
		}
		layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${serviceurl}/onEdit?uuid=' + aData.uuid, //iframe的url
		});
	}
	
	//跳转到编辑页面
	function toEdit(){
		/* layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${serviceurl}/onEdit?uuid=' + $("input[name='uuid']").val() //iframe的url
		}); */
		window.location.href='${serviceurl}/onEdit?uuid=' + $("input[name='uuid']").val();
	}
	
	//===================按钮绑定方法===================
	//绑定查询页面按钮
	function bindDetailActions() {
		$('#yy-btn-backtolist').bind('click', onBackToList);//返回
		$('#yy-btn-submit').bind('click', function(){
			onSubmit(false);
		});//提交
		$('#yy-btn-revoke').bind('click', function(){
			onRevoke(isClose);
		});//退回
		$('#yy-btn-unsubmit').bind('click', function(){
			onUnSubmit(false);
		});//撤销提交
		$('#yy-btn-approve').bind('click', function(){
			onApprove(false);
		});//审核
		$('#yy-btn-approve-x').bind('click', function(){
			onApprovex(false);
		});//审核
		$('#yy-btn-unapprove').bind('click', function(){
			onUnApprove(false);
		});//弃审
		
		$('#yy-btn-approve-look').bind('click', function(){
			onLookApprove();
		});//查看审批意见
		
		
		$("#yy-btn-toedit").bind('click', toEdit);//编辑页面
		
		bindSysInfo();
	}
	//===================方法===================
	
	//查看审批意见
	function onLookApprove(){
		var billtype = "";
		var billid = "";
		onApproveLook(billtype,billid);
	}
	
	function onApproveLook(billtype,billid){
		var link = '${ctx}' + '/sys/message/msgShow?billtype='+billtype+"&billid="+billid;
		layer.open({
			type : 2,
			title : '审批意见',
			shadeClose : true,
			shade : 0.8,
			area : [ '90%', '80%' ],
			content : link
		//iframe的url
		});
	}
	
	//公共方法之前
	function doBefore() {
		return true;
	}	
	//公共方法之后
	function doAfter() {
		return true;
	}
	function doAfterBackToList() {
		return true;
	}
	//提交前
	function doBeforeSubmit() {
		doBefore();
		return true;
	}
	//提交成功后
	function doAfterSubmitSuccess(data) {
		doAfter(data);
		return true;
	}
	//撤销提交
	function doBeforeRevoke() {
		doBefore();
		return true;
	}
	//撤销提交成功后
	function doAfterRevokeSuccess(data) {
		doAfter(data);
		return true;
	}
	//审核前
	function doBeforeApprove() {
		doBefore();
		return true;
	}
	//审核成功后
	function doAfterApproveSuccess(data) {
		doAfter(data);
		return true;
	}
	//弃审前
	function doBeforeUnApprove() {
		doBefore();
		return true;
	}
	//弃审成功后
	function doAfterUnApproveSuccess(data) {
		doAfter(data);
		return true;
	}
	//弃审前
	function doBeforeUnSubmit() {
		doBefore();
		return true;
	}
	//弃审成功后
	function doAfterUnSubmitSuccess(data) {
		doAfter(data);
		return true;
	}
</script>