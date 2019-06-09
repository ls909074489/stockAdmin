<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="dateutils.jsp"%>
<script type="text/javascript">
	var _tableList, _queryData, _detailRecord, _detailRecordIdx, _validator, _assignPks, _row, _pageNumber,_isNumber,_columnNum;
	// _tableList: 表格对象 :isnumber代表是否显示序号
	function loadList(url,isnumber) {
		doBeforeLoadList();
		var view=layer.load(2);
		if (url == null) {
			url = '${serviceurl}/query';
		}
		$.ajax({
			url : url,
			data : _queryData,
			type:'post',
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					layer.close(view);
					_tableList.clear();
					_tableList.rows.add(data.records);
					_tableList.draw();
					if(isnumber){
						_tableList.on('order.dt search.dt',
						        function() {
							        _tableList.column(0, {
								        search: 'applied',
								        order: 'applied'
							        }).nodes().each(function(cell, i) {
								        cell.innerHTML = i + 1;
							        });
						}).draw();
					}
				} else {
					layer.alert(data.msg);
				}
			} ,
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.failMsg("失败，HTTP错误。");
			}
		});
	}
	//************ 列表工具栏 ***************//
	function onAdd() {
		onAddBefore();
		YYFormUtils.clearForm('yy-form-edit');
		YYUI.setEditMode();
		//$("#rap-form-edit [name='status']").val("1");
		//YYUI.setEditMode();
		//var now = new Date();
		//var nowStr = now.Format("yyyy-MM-dd");
		//$("#rap-form-edit [defaultDate='true']").val(nowStr);
		onAddAfter();
	}

	//工具栏删除动作，可批量
	function onRemove() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeRemove(pks)) {
			removeRecord('${serviceurl}/delete', pks, onRefresh);
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
	function onRefresh() {
		doBeforeRefresh();
		if (_isServerPage)
			_tableList.draw(); //服务器分页
		else
			loadList(); //非服务器分页
	}

	var _setOrder = [];
	//服务器分页
	function serverPage(url) {
		doBeforeServerPage();
		if (url == null) {
			url = '${serviceurl}/query';
		}
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"order" : _setOrder,//[]  edit by liusheng
			"processing" : true,
			"searching" : false,
			"serverSide" : true,
			"showRowNumber" : true,
			"pagingType" : "bootstrap_full_number",
			"paging" : true,
			"fnDrawCallback" : fnDrawCallback,
			"ajax" : {
				"url" : url,
				"type" : 'POST',
				"data" : function(d) {
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
					_pageNumber = json.pageNumber;
					return json.records == null ? [] : json.records;
				}
			}
		});
	}

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

	//行操作：查看行明细  
	//@data 行数据
	//@rowidx 行下标
	function onViewDetailRow(data, rowidx, row) {
		YYFormUtils.clearForm('yy-form-detail');
		showData(data);
		YYUI.setDetailMode();
	}

	/* function onEditRow(data) {
		doBeforeEdit();
		YYFormUtils.clearForm('yy-form-edit');
		YYUI.setEditMode();
		//$("#rap-form-edit [name='status']").val("1");
		//YYUI.setEditMode();
		//var now = new Date();
		//var nowStr = now.Format("yyyy-MM-dd");
		//$("#rap-form-edit [defaultDate='true']").val(nowStr);
		doAfterEdit();
	} */
	//行操作：编辑   
	//@data 行数据
	//@rowidx 行下标
	function onEditRow(aData, iDataIndex, nRow) {
		YYFormUtils.clearForm('yy-form-detail');
		showData(aData);
		YYUI.setEditMode();
		onAfterEditRow();
	}

	//行操作：删除   
	//@data 行数据
	//@rowidx 行下标
	function onRemoveRow(data, rowidx, row) {
		if (doBeforeRemoveRow(data)) {
			removeRecord('${serviceurl}/delete', [ data.uuid ], function() {
				_tableList.row(row).remove().draw(false);
			});
		}
	}

	/**
	 * 删除记录 url 后台删除的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function removeRecord(url, pks, fnCallback, isConfirm, isSuccess) {
		if (pks.length < 1) {
			YYUI.promMsg(YYMsg.alertMsg('sys-delete-choose',null));
			return;
		}

		if (typeof (isConfirm) == "undefined") {
			isConfirm = true;
		}
		if (typeof (isSuccess) == "undefined") {
			isSuccess = false;
		}

		//确定要删除吗？
		layer.confirm(YYMsg.alertMsg('sys-delete-sure',null), function() {

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
						YYUI.succMsg(YYMsg.alertMsg('sys-delete-success',null), {
							icon : 1
						});
						if (typeof (fnCallback) != "undefined")
							fnCallback(data);
					} else {
						YYUI.failMsg(YYMsg.alertMsg('sys-delete-fail',null) + data.msg);//删除失败，原因：
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.failMsg(YYMsg.alertMsg('sys-delete-fail',null));//"删除失败，HTTP错误。"
				}
			});
		});
	};

	//************ 查看明细工具栏 ***************//

	function onEditDetail() {
		onEditRow(_detailRecord);
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

	//返回列表视图
	function onBackToList() {
		YYUI.setListMode();
		doAfterBackToList();
		YYFormValidate.cancelValidate();
	}

	//************ 编辑工具栏 ***************//

	//保存，isClose 是否保存后关闭视图，否为继续增加状态
	function onSave(isClose) {
		doBeforeSave();
		//_validator.form();

		if (!$('#yy-form-edit').valid())
			return false;
		//RapFormUtils.setCheckBoxNotCheckedValue('rap-form-edit');
		//$('#yy-form-edit').validate();
		
		var commonSaveWaitLoad=layer.load(2);
		var posturl = "${serviceurl}/add";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != "undefined")
			posturl = "${serviceurl}/update";
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				layer.close(commonSaveWaitLoad);
				if (data.success) {
					onRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
					YYUI.succMsg(YYMsg.alertMsg('sys-save-success'));//保存成功
					doAfterSaveSuccess(data);
				} else {
					//YYUI.failMsg("保存出现错误：" + data.msg)
					YYUI.promAlert(data.msg);
				}
			} ,
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				layer.close(commonSaveWaitLoad);
				YYUI.failMsg("失败，HTTP错误。");
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

	//取消编辑，返回列表视图
	function onCancel() {
		//_validator.resetForm();
		$('#yy-form-edit div.control-group').removeClass('error');
		YYUI.setListMode();
		doAfterCancel();
		YYFormValidate.cancelValidate();
		layer.closeAll();
		/*
		//你确实要退出保存页面吗？
		layer.confirm(YYMsg.alertMsg('sys-save-out'), function() {
			$('#yy-form-edit div.control-group').removeClass('error');
			YYUI.setListMode();
			doAfterCancel();
			YYFormValidate.cancelValidate();
			layer.closeAll();
		});
		*/
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
			} ,
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.failMsg("失败，HTTP错误。");
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
	function onReset() {
		YYFormUtils.clearForm("yy-form-query");
		return false;
	}
	
	//绑定按钮事件
	function bindButtonActions() {
		$("#yy-btn-add").bind('click', onAdd);//新增
		$("#yy-btn-edit").bind('click', onEditDetail);//编辑		
		$("#yy-btn-copy").bind('click', onCopy);//复制
		$("#yy-btn-remove").bind('click', onRemove);//删除
		$("#yy-btn-refresh").bind('click', onRefresh);//刷新
		$("#yy-btn-search").bind('click', onQuery);//快速查询

		$('#yy-btn-backtolist').bind('click', onBackToList);
		$("#yy-btn-remove-detail").bind('click', onRemoveDetail);
		$('#yy-btn-backtolist').bind('click', onBackToList);
		$("#yy-searchbar-reset").bind('click', onReset);//清空
		$("#yy-btn-save").bind("click", function() {
			onSave(true);
		});
		$("#rap-btn-savenew").bind('click', function() {
			onSave(false);
		});
		$("#yy-btn-cancel").bind('click', onCancel);
		//$('.group-checkable').bind("click",chkAll);//全选

		//快速搜索，只针对客户端分页的情况
		$('input.global_filter').on('keyup click', function() {
			filterGlobal();
		});
		$('input.column_filter').on('keyup click', function() {
			filterColumn($(this).parents('div').attr('data-column'));
		});
		//alert($("#parent").children(".row"));
		$('.parent').children(".row").addClass("hide");
		//$('.parent').find('input').attr("disabled",true);

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

	//请求方法， msg是可传参数，可以不传
	function upRecord(url, pks, msg) {
		if (pks.length < 1) {
			msg = msg || "请选择需要操作的记录";
			YYUI.promMsg(msg);
			return;
		}
		$.ajax({
			"dataType" : "json",
			"type" : "POST",
			"url" : url,
			"data" : {
				"pks" : pks.toString()
			},
			"success" : function(data) {
				YYUI.succMsg("成功", {
					icon : 1
				});
				onRefresh();
			},
			"error" : function(XMLHttpRequest, textStatus, errorThrown) {
				YYUI.failMsg("失败，HTTP错误。");
			}
		});
	};
	
	//ui：表格前两列宽度，如果是yy-table-x的不控制
	tabWidthBy2Column();
	function tabWidthBy2Column() {
		var tab = $("#yy-table-list").attr("class") || "";
		if(tab==""){return;};
		tab = tab.indexOf("yy-table-x")!=-1?true:false;
		if(!tab) {
			$("#yy-table-list thead tr").find("th:eq(0)").css("width", "50px");
			$("#yy-table-list thead tr").find("th:eq(1)").css("width", "50px");
			$("#yy-table-list thead tr").find("th:eq(2)").css("width", "80px");
			$("#yy-table-sublist thead tr").find("th:eq(0)").css("width", "50px");
			$("#yy-table-sublist thead tr").find("th:eq(1)").css("width", "50px");
			$("#yy-table-sublist thead tr").find("th:eq(2)").css("width", "80px");
		}
	}
	
	//表格绘画完回调方法
	function fnDrawCallback(){
		
		//序列号
		if (_isNumber) {
			var pageLength = $('select[name="yy-table-list_length"]').val() || 10;
			_columnNum = _columnNum || 0;
			_tableList.column(_columnNum).nodes().each(function(cell, i) {
				cell.innerHTML = i + 1+(_pageNumber)*pageLength;
			});
		}
	}
	
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
	
	function onAddBefore() {
		return true;
	}

	function onAddAfter() {
		return true;
	}

	function doBeforeEdit(data) {
		return true;
	}
	function doBeforeRemove(pks) {
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

	function onAfterEditRow() {
		return true;
	}
</script>

