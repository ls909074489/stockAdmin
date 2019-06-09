<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="dateutils.jsp"%>
<%@include file="public.jsp"%>
<script type="text/javascript">
	var _tableList, _queryData, _detailRecord, _detailRecordIdx, _validator, _assignPks, _row, _pageNumber, _isNumber, _columnNum, _isServerPage=true;
	var _editParam = '1=1';
	var _addParam = '1=1';
	var _detailParam = '1=1';
	//===================公共方法===================
	function loadList(url, isnumber) {
		doBeforeLoadList();
		var loadview = layer.load(2);
		if (url == null) {
			url = '${serviceurl}/query';
		}
		$.ajax({
			url : url,
			type:"post",
			data : _queryData,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					_tableList.clear();
					_tableList.rows.add(data.records);
					_tableList.draw();
					if (isnumber) {
						_tableList.on('order.dt search.dt', function() {
							_tableList.column(0, {
								search : 'applied',
								order : 'applied'
							}).nodes().each(function(cell, i) {
								cell.innerHTML = i + 1;
							});
						}).draw();
					}
				} else {
					layer.alert(data.msg);
				}
				layer.close(loadview);
			}
		});
	}
	//合计列
	var totalAry = [];
	var _setOrder = [];
	var freshLoad = null;
	//服务器分页
	function serverPage(url) {
		var serverPageWaitLoad=layer.load(2);//加载等待ceng edit by liusheng		
		doBeforeServerPage();
		if (url == null) {
			url = '${serviceurl}/query';
		}
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"order" : _setOrder,
			"scrollX" : true,
			"processing" : false,
			"searching" : false,
			"serverSide" : true,
			"showRowNumber" : true,
			"pagingType" : "bootstrap_full_number",
			//"pageLength" : 15,
			"paging" : true,
			//"fixedHeader": true,//表头
			"footerCallback" : setTotal,//合计
			"fnDrawCallback" : fnDrawCallback,//列对齐设置
			"ajax" : {
				"url" : url,
				"type" : 'POST',
				"sync":'false',
				"data" : function(d) {
					freshLoad = layer.load(2);
					d.orderby = getOrderbyParam(d);
					if (_queryData == null)
						return;
					$.each(_queryData, function(index) {

						if (this['value'] == null || this['value'] == "")
							return;

						d[this['name']] = this['value'];

					});
				},
				"dataSrc" : function(json) {
					if(freshLoad != null) {
						layer.close(freshLoad);
					}
					//layer.closeAll();
					_pageNumber = json.pageNumber;
					return json.records == null ? [] : json.records;
				}
			},
			"initComplete": function(settings, json) {
				if(freshLoad != null) {
					layer.close(freshLoad);
				}
				layer.close(serverPageWaitLoad);//关闭加载等待ceng edit by liusheng
				//layer.closeAll();
			}
		});
	}

	// Remove the formatting to get integer data for summation
	var intVal = function(i) {
		return typeof i === 'string' ? i.replace(/[\$,]/g, '') * 1
				: typeof i === 'number' ? i : 0;
	};

	/**
	 * 添加合计行
	 */
	setTotal = function(row, data, start, end, display) {
		if (totalAry.length == 0) {
			return;
		}

		for (var y = 0; y < totalAry.length; ++y) {
			var api = this.api(), data;

			// Total over all pages
			var total = api.column(totalAry[y]).data().reduce(function(a, b) {
				return intVal(a) + intVal(b);
				//return accAdd(intVal(a), intVal(b));
			}, 0);
			// Total over this page
			var pageTotal = api.column(totalAry[y], {
				page : 'current'
			}).data().reduce(function(a, b) {
				return intVal(a) + intVal(b);
				//return accAdd(intVal(a), intVal(b));
			}, 0);
			// Update footer pageTotal.toFixed(2)
			$(api.column(totalAry[y]).footer()).html('' + Math.round(pageTotal*100)/100);
		}
	};
	
	//分页页码
	$.fn.dataTable.defaults.aLengthMenu = [ [ 5, 10, 15, 25, 50, 100, 500 ],
			[ 5, 10, 15, 25, 50, 100, 500 ] ];

	//服务器分页，排序
	function getOrderbyParam(d) {
		var orderby = d.order[0];
		if (orderby != null && null != _tableCols) {
			var dir = orderby.dir;
			var orderName = _tableCols[orderby.column].data;
			return orderName + "@" + dir;
		}
		return "uuid@desc";
	}
	//===================按钮事件===================
	//增加
	function onAdd() {
		if (!onAddBefore()) {
			return false;
		}
		layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${serviceurl}/onAdd?'+ _addParam, //iframe的url
		});
		onAddAfter();
	}
	//编辑
	function onEditDetail() {
		onEditRow(_detailRecord);
	}
	//行修改   @data 行数据  @rowidx 行下标
	function onEditRow(aData, iDataIndex, nRow) {
		if (!onEditRowBefore(aData, iDataIndex, nRow)) {
			return;
		}
		if (aData.billstatus > 0 && aData.billstatus != '1'
				&& aData.billstatus != '4') {
			YYUI.promMsg(YYMsg.alertMsg('sys-edit-no'));//已经提交或者审核的数据不能修改。
			return;
		}
		layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${serviceurl}/onEdit?uuid=' + aData.uuid + '&' + _editParam, //iframe的url
		});
	}
	//行查看 @data 行数据 @rowidx 行下标
	function onViewDetailRow(data, rowidx, row) {
		layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${serviceurl}/onDetail?uuid=' + data.uuid + '&' + _detailParam, //iframe的url
		});
	}
	//删除
	function onRemove() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeRemove(pks)) {
			removeRecord('${serviceurl}/delete', pks, onRefresh);
		}
	}
	//提交
	function onSubmit() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeSubmit(pks)) {
			submitRecord('${serviceurl}/batchSubmit', pks, onRefresh);
		}
	}
	//撤销提交
	function onUnSubmit() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeUnSubmit(pks)) {
			unSubmitRecord('${serviceurl}/batchUnSubmit', pks, onRefresh);
		}
	}
	//审核-普通审核
	function onApprove(isRemark) {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeApprove(pks)) {
			approveRecord('${serviceurl}/batchApprove', pks, onRefresh);
		}
	}
	//审核-弹出提示
	function onApprovex() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeApprove(pks)) {
			approveRecordx(null, pks, onRefresh);
		}
	
	}
	//弃审
	function onUnApprove() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeUnApprove(pks)) {
			unApproveRecord('${serviceurl}/batchUnApprove', pks, onRefresh);
		}
	}
	//高级查询
	function senQuery(data){
		_queryData = [{"name":"search_IN_uuid","value":data}];
		onSendRefresh();
	}
	
	//刷新
	function onSendRefresh(_isServerPage) {
		//var freshLoad = layer.load(2);
		if(typeof(_isServerPage) == "undefined") {
			_isServerPage = this._isServerPage;
		}
		doBeforeRefresh();
		if (_isServerPage) {
			
			_tableList.draw(); //服务器分页
			
		} else {
			loadList(); //非服务器分页
		}
	}
	
	//快速查询
	function onQuery() {
		doBeforeQuery();
		//获取查询数据，在表格刷新的时候自动提交到后台
		_queryData = $("#yy-form-query").serializeArray();
		onRefresh();
	}
	
	//刷新
	function onRefresh(_isServerPage) {
		//var freshLoad = layer.load(2);
		if(typeof(_isServerPage) == "undefined") {
			_isServerPage = this._isServerPage;
		}
		doBeforeRefresh();
		_queryData = $("#yy-form-query").serializeArray();
		if (_isServerPage) {
			_tableList.draw(); //服务器分页
		} else {
			loadList(); //非服务器分页
		}
		//layer.close(freshLoad);
		
	}
	//取消编辑，返回列表视图
	function onCancel() {
		$('#yy-form-edit div.control-group').removeClass('error');
		//YYUI.setListMode();
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
		doAfterCancel();
	}
	//导出
	function onExport() {
		var url = "${serviceurl}/exportExcel";
		var pks = YYDataTableUtils.getSelectPks();
		exportExcelRecord(url, pks/*, onRefresh*/);
	}
	//行删除   @data 行数据 rowidx 行下标
	function onRemoveRow(data, rowidx, row) {
		if (doBeforeRemoveRow(data)) {
			removeRecord('${serviceurl}/delete', [ data.uuid ], function() {
				_tableList.row(row).remove().draw(false);
			});
		}
	}
	//清空
	function onReset() {
		YYFormUtils.clearQueryForm("yy-form-query");
		return false;
	}

	/**
	 * 删除记录 url 后台删除的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function removeRecord(url, pks, fnCallback, isConfirm, isSuccess) {
		if (checkDelete(pks)) {

			if (typeof (isConfirm) == "undefined") {
				isConfirm = true;
			}
			if (typeof (isSuccess) == "undefined") {
				isSuccess = false;
			}
			//'确实要删除吗？'
			layer.confirm(YYMsg.alertMsg('sys-delete-sure'), function() {
				var listview = layer.load(2);
				$.ajax({
							"dataType" : "json",
							"type" : "POST",
							"url" : url,
							"data" : {
								"pks" : pks.toString()
							},
							"success" : function(data) {
								if (data.success) {
									layer.close(listview);
									//if (isSuccess)
									//"删除成功"
									YYUI.succMsg(YYMsg.alertMsg('sys-delete-success'), {
										icon : 1
									});
									if (typeof (fnCallback) != "undefined")
										fnCallback(data);
								} else {
									layer.close(listview);
									YYUI.failMsg(YYMsg.alertMsg('sys-delete-fail') + data.msg);//删除失败，原因：
								}
							},
							"error" : function(XMLHttpRequest, textStatus,
									errorThrown) {
								layer.close(listview);
								YYUI.failMsg(YYMsg.alertMsg('sys-delete-http'));//"删除失败，HTTP错误。"
							}
						});
			});
		}
	};

	//删除前检查
	function checkDelete(pks) {
		if (pks.length < 1) {
			YYUI.promMsg(YYMsg.alertMsg('sys-delete-choose'));//"请选择需要删除的记录"
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus == undefined) {
				return true;
			}
			if (billstatus != 1 && billstatus != 4) {
				YYUI.failMsg(YYMsg.alertMsg('sys-delete-check'));//存在不能删除的记录！"
				return false;
			}
		}
		return true;
	}
	/**
	 * 提交记录 url 后台提交的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function submitRecord(url, pks, fnCallback) {
		if (checkSubmit(pks)) {
			layer.confirm(YYMsg.alertMsg('sys-submit-sure'), function() {//'确定要提交吗？
				var listview = layer.load(2);
				$.ajax({
							"dataType" : "json",
							"type" : "POST",
							"url" : url,
							"data" : {
								"pks" : pks.toString()
							},
							"success" : function(data) {
								if (data.success) {
									layer.close(listview);
									//"提交成功"
									YYUI.succMsg(YYMsg.alertMsg('sys-submit-success'), {
										icon : 1
									});
									if (typeof (fnCallback) != "undefined")
										fnCallback(data);
								} else {
									layer.close(listview);
									YYUI.failMsg(YYMsg.alertMsg('sys-submit-fail') + data.msg);//提交失败，原因：
								}
							},
							"error" : function(XMLHttpRequest, textStatus,
									errorThrown) {
								layer.close(listview);
								YYUI.failMsg(YYMsg.alertMsg('sys-submit-http'));//"提交失败，HTTP错误。"
							}
						});
			});
		}
	};
	//提交前检查
	function checkSubmit(pks) {
		if (pks.length < 1) {
			YYUI.promMsg(YYMsg.alertMsg('sys-submit-choose'));//"请选择需要提交的记录"
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus != 1 && billstatus != 4) {
				YYUI.failMsg(YYMsg.alertMsg('sys-submit-relevance'));//"存在不能提交的记录！"
				return false;
			}
		}
		return true;
	}
	/**
	 * 撤销提交记录 url 后台提交的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function unSubmitRecord(url, pks, fnCallback) {
		if (checkUnSubmit(pks)) {
			layer.confirm(YYMsg.alertMsg('sys-unsubmit-sure'), function() {//'确实要撤销提交吗？'
				$.ajax({
					"dataType" : "json",
					"type" : "POST",
					"url" : url,
					"data" : {
						"pks" : pks.toString()
					},
					"success" : function(data) {
						if (data.success) {
							//if (isSuccess)
							YYUI.succMsg(YYMsg.alertMsg('sys-unsubmit-success'), {//"撤销提交成功"
								icon : 1
							});
							if (typeof (fnCallback) != "undefined")
								fnCallback(data);
						} else {
							YYUI.failMsg(YYMsg.alertMsg('sys_unsubmit-fail') + data.msg);//"撤销提交失败，原因："
						}
					},
					"error" : function(XMLHttpRequest, textStatus,
							errorThrown) {
						YYUI.failMsg(YYMsg.alertMsg('sys-unsubmit-http'));//"撤销提交失败，HTTP错误。"
					}
				});
			});
		}
	};
	//撤销提交前检查
	function checkUnSubmit(pks) {
		if (pks.length < 1) {
			YYUI.promMsg(YYMsg.alertMsg('sys-unsubmit-choose'));//"请选择需要撤销提交的记录"
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus != 2) {
				YYUI.failMsg(YYMsg.alertMsg('sys-unsubmit-relevance'));//"存在不能撤销提交的记录！"
				return false;
			}
		}
		return true;
	}
	/**
	 * 审核记录 url 后台提交的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function approveRecord(url, pks, fnCallback) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要审核的记录");
			return;
		}
		layer.confirm('确实要审核吗？', function() {
			var listview = layer.load(2);
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"data" : {
					"pks" : pks.toString()
				},
				"success" : function(data) {
					if (data.success) {
						layer.close(listview);
						//if (isSuccess)
						YYUI.succMsg("审核成功", {
							icon : 1
						});
						if (typeof (fnCallback) != "undefined")
							fnCallback(data);
					} else {
						layer.close(listview);
						YYUI.failMsg("审核失败，原因：" + data.msg);
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					layer.close(listview);
					YYUI.failMsg("审核失败，HTTP错误。");
				}
			});
		});
	};
	/**
	 * 审核记录 url 后台提交的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function approveRecordx(url, pks, fnCallback) {
		if (checkApprove(pks)) {
			
			postApprove("审核意见", url, pks, true, fnCallback);
		}
	};
	var _approveParam = {};
	function postApprove(title, url, pks, isShowSuccess, fnCallback) {
		if (isShowSuccess == null) {
			isShowSuccess = true;
		}
		var modal = $("#approveRemark");
		modal.find('#content').val("");
		modal.find('.modal-title').text(title);
		modal.find('#approvepass').unbind("click");
		modal.find('#approvepass').bind(
				"click",
				function() {
					url = '${serviceurl}/batchApprove';
					modal.find('.error').text('');
					var content = modal.find('#content').val();
					if(content!=null && content.length>200){
						window.parent.YYUI.failMsg("审核意见不能超过200个字符！");
						return;
					}
				
					_approveParam["approveRemark"] = $("#approveRemark").find(
							"#content").val();
					_approveParam["pks"] = pks == null ? "" : pks.toString();
					var listview = layer.load(2);
					$.ajax({
								"dataType" : "json",
								"type" : "POST",
								"url" : url,
								"data" : _approveParam,
								"success" : function(data) {
									$('#approveRemark').modal('hide');
									if (data.success) {
										layer.close(listview);
										if (isShowSuccess) {
											if (data.msg != null
													&& data.msg.length > 0)
												YYUI.succMsg(data.msg);
											else
												YYUI.succMsg('审核成功!');
										}
										if (typeof (fnCallback) != "undefined")
											fnCallback(data);
									} else {
										layer.close(listview);
										YYUI.failMsg(data.msg);
									}
								},
								"error" : function(XMLHttpRequest, textStatus,
										errorThrown) {
									layer.close(listview);
									YYUI.promAlert('审核失败，HTTP错误。');
								}
							});
				});
		modal.find('#approvenopass').unbind("click");
		modal.find('#approvenopass').bind(
				"click",
				function() {
					url = '${serviceurl}/batchRevoke';
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
					//queryData
					_approveParam["approveRemark"] = $("#approveRemark").find(
							"#content").val();
					_approveParam["pks"] = pks == null ? "" : pks.toString();
					var listview = layer.load(2);
					$.ajax({
								"dataType" : "json",
								"type" : "POST",
								"url" : url,
								"data" : _approveParam,
								"success" : function(data) {
									$('#approveRemark').modal('hide');
									if (data.success) {
										layer.close(listview);
										if (isShowSuccess) {
											if (data.msg != null
													&& data.msg.length > 0)
												YYUI.succMsg('data.msg!');
											else
												YYUI.succMsg('退回成功!');
										}
										if (typeof (fnCallback) != "undefined")
											fnCallback(data);
									} else {
										layer.close(listview);
										YYUI.failMsg(data.msg);
									}
								},
								"error" : function(XMLHttpRequest, textStatus,
										errorThrown) {
									layer.close(listview);
									YYUI.promAlert('退回失败，HTTP错误。');
								}
							});
				});
		$('#approveRemark').modal({
			toggle : "modal"
		});
	}
	//审核前检查
	function checkApprove(pks) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要审核的记录");
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus != 2) {
				YYUI.failMsg("存在不能审核的记录！");
				return false;
			}
		}
		return true;
	}
	//取消审核
	function unApproveRecord(url, pks, fnCallback) {
		if (checkUnApprove(pks)) {
			layer.confirm('确实要取消审核吗？', function() {
				$
						.ajax({
							"dataType" : "json",
							"type" : "POST",
							"url" : url,
							"data" : {
								"pks" : pks.toString()
							},
							"success" : function(data) {
								if (data.success) {
									//if (isSuccess)
									YYUI.succMsg("取消审核成功", {
										icon : 1
									});
									if (typeof (fnCallback) != "undefined")
										fnCallback(data);
								} else {
									YYUI.failMsg("取消审核失败，原因：" + data.msg);
								}
							},
							"error" : function(XMLHttpRequest, textStatus,
									errorThrown) {
								YYUI.failMsg("取消审核失败，HTTP错误。");
							}
						});
			});
		}
	};
	//弃核前检查
	function checkUnApprove(pks) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要弃审的记录。");
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus != 5) {
				YYUI.failMsg("存在不能弃审的记录！");
				return false;
			}
		}
		return true;
	}
	//确认导出
	function exportExcelRecord(url, pks/*, fnCallback, isConfirm, isSuccess*/) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择要导出的数据");
			return;
		}
		/*
		if (typeof (isConfirm) == "undefined") {
			isConfirm = true;
		}
		if (typeof (isSuccess) == "undefined") {
			isSuccess = false;
		}*/
		//layer.confirm('确实要导出吗？', function() {
		var form = $("<form id='excelForm'>");// 定义一个form表单
		form.attr('style', 'display:none');// 在form表单中添加查询参数
		form.attr('target', '');
		form.attr('method', 'post');
		form.attr('action', url);
		for (var i = 0; i < pks.length; i++) {
			var input1 = $('<input name="pks">');
			input1.attr('type', 'hidden');
			input1.attr('value', 1);
			form.append(input1);
		}
		$('body').append(form); // 将表单放置在web中
		//alert($("#form").html());
		form.submit();
		//document.body.removeChild(form);
		//});
	}

	//详细视图的删除	
	function onRemoveDetail() {
		if (doBeforeRemoveRow(_detailRecord)) {
			RapDataUtils.removeRecord('${serviceurl}/delete',
					[ _detailRecord.uuid ], function() {
						YYUI.setListMode();
						_tableList.row(_detailRecordIdx).remove();
						_tableList.draw(false);
					});
		}
	}

	function checkRepeat(obj, isValid) {
		var value = $(obj).val();
		var name = $(obj).attr("name");

		if (value == null || value.length == 0) {
			return false;
		}
		var result = true;
		var queryData = {};
		queryData["search_EQ_" + name] = value;
		if (isValid) {
			queryData["search_EQ_status"] = 1;
		}
		var form = obj.closest("form");
		var uuid = $("input[name='uuid']", form).val();
		if (uuid != null && uuid.length > 0) {
			queryData["search_NE_uuid"] = uuid;
		}
		$.ajax({
			url : '${serviceurl}/query',
			data : queryData,
			dataType : 'json',
			success : function(data) {
				if (data.records != null && data.records.length > 0) {
					clearError(obj);
					showError(obj);
					result = false;
				} else {
					clearError(obj);
				}
			}
		});
		return result;
	}
	function clearError(obj) {
		$(obj).removeClass("error");
		$(obj).next("span.error").remove();
	}
	function showError(obj) {
		$(obj).addClass("error");
		var showName = $(obj).closest("td").prev("td").text();
		$(obj).after(
				'<span for="' + $(obj).name + '" class="error">' + showName
						+ '已存在，请重新输入</span>');
	}

	function onCopy() {
		var pks = RapDataTableUtils.getSelectPks();
		if (pks != null && pks.length == 1) {
			RapDataUtils.copyRecord("${serviceurl}/baseCopy", pks, function(
					data) {
				onRefresh();
			});
		} else {
			YYUI.promMsg("请选择一条记录");
		}
	}
	
	//关闭单据
	function onClose() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeClose(pks)) {
			closeRecord('${serviceurl}/closeBills', pks, onRefresh);
		}
	}
	/**
	 * 关闭记录 url 后台关闭的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function closeRecord(url, pks, fnCallback) {
		if (checkClose(pks)) {
			layer.confirm('确实要关闭吗？', function() {
				$
						.ajax({
							"dataType" : "json",
							"type" : "POST",
							"url" : url,
							"data" : {
								"pks" : pks.toString()
							},
							"success" : function(data) {
								if (data.success) {
									//if (isSuccess)
									YYUI.succMsg("关闭成功", {
										icon : 1
									});
									if (typeof (fnCallback) != "undefined")
										fnCallback(data);
								} else {
									YYUI.failMsg("关闭失败，原因：" + data.msg);
								}
							},
							"error" : function(XMLHttpRequest, textStatus,
									errorThrown) {
								YYUI.failMsg("关闭失败，HTTP错误。");
							}
						});
			});
		}
	};
	//关闭前检查
	function checkClose(pks) {
		if (pks.length < 1) {
			YYUI.promMsg("请选择需要关闭的记录");
			return;
		}
		for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus != 5) {
				YYUI.failMsg("存在不能关闭的记录！");
				return false;
			}
		}
		return true;
	}

	//===================按钮绑定方法===================
	//绑定按钮事件
	function bindListActions() {
		$("#yy-btn-add").bind('click', onAdd);//新增
		$("#yy-btn-edit").bind('click', onEditDetail);//编辑		
		$("#yy-btn-copy").bind('click', onCopy);//复制
		$("#yy-btn-remove").bind('click', onRemove);//删除
		$("#yy-btn-submit").on('click', onSubmit);//提交
		$("#yy-btn-approve").on('click', function() {
			onApprove();
		});//审核
		$("#yy-btn-approve-x").on('click', function() {
			onApprovex();
		});//审核-带审批意见
		$("#yy-btn-unapprove").on('click', onUnApprove);//弃审
		$("#yy-btn-unsubmit").on('click', onUnSubmit);//撤销提交
		$("#yy-btn-refresh").bind('click', onRefresh);//刷新
		$("#yy-btn-search").bind('click', onQuery);//快速查询
		//$("#yy-btn-export").bind('click', onExport);//导出
		$("#yy-searchbar-reset").bind('click', onReset);//清空
		$("#yy-btn-remove-detail").bind('click', onRemoveDetail);
		$("#yy-btn-save").bind("click", function() {
			onSave(true);
		});
		$("#yy-btn-close").on('click', onClose);//关闭

		$("#yy-btn-cancel").bind('click', onCancel);
		//$('.group-checkable').bind("click",chkAll);//全选

		//快速搜索，只针对客户端分页的情况
		$('input.global_filter').on('keyup click', function() {
			filterGlobal();
		});
		$('input.column_filter').on('keyup click', function() {
			filterColumn($(this).parents('div').attr('data-column'));
		});

		$('.parent').children(".row").addClass("hide");

		$('.hos').bind('click', function() {
			// 获取所谓的父行
			if ($('.hos').children(".fa").hasClass("fa-caret-right")) {
				$('.hos').children(".fa").removeClass("fa-caret-right");
				$('.hos').children(".fa").addClass("fa-caret-down");
				$('.parent').children(".row").removeClass("hide");
			} else {
				$('.hos').children(".fa").removeClass("fa-caret-down");
				$('.hos').children(".fa").addClass("fa-caret-right");
				$('.parent').children(".row").addClass("hide");
			}
		});
		
		//查询框自动清除空格
		$('#yy-form-query :input').on('keyup', function() {
			StringUtils.clearAroundSpace($(this));
		});
		$('.yy-searchbar :input').on('keyup', function() {
			StringUtils.clearAroundSpace($(this));
		});
		
		//按回车查询
		$('.queryform').on('keyup', function(event){
			if(event.keyCode == "13") {
				onQuery();
	        }
		});
	}

	//ui：表格前两列宽度，如果是yy-table-x的不控制
	tabWidthBy2Column();
	function tabWidthBy2Column() {
		var tab = $("#yy-table-list").attr("class") || "";
		if (tab == "") {
			return;
		}
		;
		tab = tab.indexOf("yy-table-x") != -1 ? true : false;
		if (!tab) {
			$("#yy-table-list thead tr").find("th:eq(0)").css("width", "50px");
			$("#yy-table-list thead tr").find("th:eq(1)").css("width", "80px");
			$("#yy-table-sublist thead tr").find("th:eq(0)").css("width",
					"50px");
			$("#yy-table-sublist thead tr").find("th:eq(1)").css("width",
					"80px");
		}
	}

	//表格绘画完回调方法
	function fnDrawCallback() {

		//序列号
		if (_isNumber) {
			var pageLength = $('select[name="yy-table-list_length"]').val() || 10;
			_columnNum = _columnNum || 0;
			_tableList.column(_columnNum).nodes().each(function(cell, i) {
				cell.innerHTML = i + 1 + (_pageNumber) * pageLength;
			});
		}
	}
	
	function onAddBefore() {
		return true;
	}

	function onAddAfter() {
		return true;
	}

	function onEditRowBefore(aData, iDataIndex, nRow) {
		return true;
	}

	function doBeforeEdit(data) {
		return true;
	}
	function doBeforeRemove(pks) {
		return true;
	}
	function doBeforeSubmit(pks) {
		return true;
	}
	function doBeforeUnSubmit(pks) {
		return true;
	}
	function doBeforeApprove(pks) {
		return true;
	}
	function doBeforeUnApprove(pks) {
		return true;
	}
	function doBeforeSave() {
		return true;
	}
	function doBeforeExport() {
		return true;
	}
	function doBeforeRemoveRow(data) {
		return true;
	}
	function doBeforeView(data) {
		return true;
	}
	function doBeforeLoadList() {
		return true;
	}
	function doBeforeQuery() {
		return true;
	}
	function doBeforeRefresh() {
		return true;
	}
	function doBeforeServerPage() {
		return true;
	}

	function doAfterRefresh() {
		return true;
	}
	function doAfterEdit(data) {
		return true;
	}
	function doAfterView(data) {
		return true;
	}
	function doAfterBackToList() {
		return true;
	}
	function doAfterCancel() {
		return true;
	}
	function doAfterSaveSuccess(data) {
		return true;
	}
	function doBeforeClose(pks) {
		return true;
	}
</script>