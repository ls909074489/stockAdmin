<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _zTree;//树
	//页面形态
	var _isSelected = true;

	var _selectedId;//选中节点
	
	var treeWaitLoad;//树刷新等待层

	function getTreeDataUrl() {
		var treeUrl = '';
		treeUrl = '${param.dataTreeUrl}';
		if (!treeUrl) {
			treeUrl = "${param.serviceurl}/dataTreeList";
		}
		return treeUrl;
	}

	var _treeSetting = {
		check : {
			enable : false
		},
		async : {
			enable : true,
			url : getTreeDataUrl(),
			autoParam : [ "id", "name=n", "level=lv" ],
			otherParam : {
				"otherParam" : "zTreeAsyncTest"
			},
			dataFilter : filter
		},
		view : {
			dblClickExpand : false,
			showTitle : false,
			fontCss : YyZTreeUtils.getFontCss
		},
		data : {
			key : {
				title : "title"
			},
			simpleData : {
				enable : true
			}
		},
		callback : {
			onDblClick : zTreeOnDblClick,
			onClick : zTreeOnClick,
			onAsyncSuccess : zTreeOnAsyncSuccess
		}
	};

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}

	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}

	function onSearchTree() {
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree, searchValue);
	}

	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}

	// _zTree 点击触发的事件
	function zTreeOnClick(event, treeId, treeNode) {
		var _method = '${param.onClickMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode)");
		} else {
			if (!_isSelected) {
				YYUI.promMsg("编辑状态，不能操作节点。");
				_zTree.selectNode(_selectedId);
				return false;
			}
			_selectedId = treeNode;
			_zTree.selectNode(treeNode);
			showData(treeNode);
		}
	}

	//_zTree 双击触发的事件
	function zTreeOnDblClick(event, treeId, treeNode) {
		var _method = '${param.onDblClickMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode)");
		} else {
			if (!_isSelected) {
				YYUI.promMsg("编辑状态，不能操作节点。");
				_zTree.selectNode(_selectedId);
				return false;
			}
			_selectedId = treeNode;
			_zTree.selectNode(treeNode);
			showData(treeNode);
		}
	}

	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		layer.close(treeWaitLoad);//关闭树刷新等待层
		var _method = '${param.onAsyncSuccessMethod}';
		if (_method) {
			eval(_method + "(event, treeId, treeNode, msg)");
		} else {
			var nodes = _zTree.getNodes();
			_zTree.expandNode(nodes[0], true);
			if (_selectedId) {
				var node = _zTree.getNodeByParam("id", _selectedId);
				// 选中当前操作（新增/修改）后的节点
				if(node!=null){
					var pNode = _zTree.getNodeByParam("id", node.pid);
					_zTree.expandNode(pNode, true);
				}
				_zTree.selectNode(node);
				if(node!=null){
					showData(node);
				}
				_selectedId = null;
			}
		}
	}

	//刷新
	function treeRefresh() {
		treeWaitLoad=layer.load(2);
		_zTree.reAsyncChildNodes(null, 'refresh', false);
		YYFormUtils.clearForm('yy-form-edit');
	}

	var _tableList, _queryData, _detailRecord, _detailRecordIdx, _validator, _assignPks, _row, _pageNumber, _isNumber, _columnNum, _isServerPage=true;
	var _editParam = '1=1';
	var _addParam = '1=1';
	var _detailParam = '1=1';
	
	$(document).ready(function() {
				
		treeWaitLoad=layer.load(2);
		//加载ztree
		_zTree = $.fn.zTree.init($("#ztree"), _treeSetting);

		treeDefaultActions();
		bindDefaultActions();

	});
	
	//绑定树按钮事件
	function treeDefaultActions(){
		$("#yy-btn-org-sure").bind("click", function() {
			zTreeOnDblClick(null, null, getSelectedNodes());
		});

		//折叠/展开
		$('#yy-expandAll').bind('click', function() {
			_zTree.expandAll(true);
		});
		$('#yy-collapseAll').bind('click', function() {
			_zTree.expandAll(false);
		});
		$('#yy-expandSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(true);
			} else {
				_zTree.expandNode(nodes, true, true, true);
			}
		});

		$('#yy-collapseSon').bind('click', function() {
			var nodes = getSelectedNodes();
			if (typeof (nodes) == 'undefined') {
				_zTree.expandAll(false);
			} else {
				_zTree.expandNode(nodes, false, true, true);
			}
		});

		$('#yy-treeRefresh').bind('click', treeRefresh);

		var t_treeSearchType='${param.treeSearchType}';
		if(t_treeSearchType!=null&&t_treeSearchType=='1'){
			//不绑定输入框改变事件
		}else{
			//zTree的搜索事件绑定
			$('#searchTreeNode').bind("propertychange", onSearchTree).bind(
					"input", onSearchTree);
		}
		$('#searchTreeNode').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				onSearchTree();
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
			url = '${param.serviceurl}/query';
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
					_pageNumber = json.pageNumber;
					return json.records == null ? [] : json.records;
				}
			},
			"initComplete": function(settings, json) {
				if(freshLoad != null) {
					layer.close(freshLoad);
				}
				layer.close(serverPageWaitLoad);//关闭加载等待ceng edit by liusheng
			}
		});
	}
	
	//添加合计行
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
	
	function doBeforeQuery() {
		return true;
	}
	function onAddBefore() {
		return true;
	}
	function onAddAfter() {
		return true;
	}
	function doBeforeServerPage() {
		return true;
	}
	function doBeforeRemoveRow(data) {
		return true;
	}
	function doBeforeRemove(pks) {
		return true;
	}
	function onEditRowBefore(aData, iDataIndex, nRow) {
		return true;
	}
	
	//删除前检查
	function checkDelete(pks) {
		if (pks.length < 1) {
			YYUI.promMsg(YYMsg.alertMsg('sys-delete-choose'));//"请选择需要删除的记录"
			return;
		}
		/* for (var i = 0; i < pks.length; i++) {
			var row = $("input[value='" + pks[i] + "']").closest("tr");
			var billstatus = _tableList.row(row).data().billstatus;
			if (billstatus == undefined) {
				return true;
			}
			if (billstatus != 1 && billstatus != 4) {
				YYUI.failMsg(YYMsg.alertMsg('sys-delete-check'));//存在不能删除的记录！"
				return false;
			}
		} */
		return true;
	}
	
	//绑定默认按钮事件
	function bindDefaultActions(){
		$('#yy-btn-add').bind('click', onAdd);
		$('#yy-btn-remove').bind('click', onRemove);
		$("#yy-btn-search").bind('click', onQuery);//快速查询
		$('#yy-btn-refresh').bind('click', onRefresh);
		$('#yy-btn-save').bind('click', onSave);
	}
	
	// 树点击事件
	function selfOnClick(event, treeId, treeNode){
		if (!_isSelected) {
			YYUI.promMsg("编辑状态，不能操作节点。");
			_zTree.selectNode(_selectedId);
			return false;
		}
		_selectedId = treeNode;
		_zTree.selectNode(treeNode);
		showData(treeNode);
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
		_queryData = $("#yy-form-query").serializeArray();
		_tableList.draw(); //服务器分页
	}
	
	//删除
	function onRemove() {
		var pks = YYDataTableUtils.getSelectPks();
		if (doBeforeRemove(pks)) {
			removeRecord('${param.serviceurl}/delete', pks, onRefresh);
		}
	}
	//行删除   @data 行数据 rowidx 行下标
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
								YYUI.succMsg(YYMsg.alertMsg('sys-delete-success'), {icon : 1});
								if (typeof (fnCallback) != "undefined"){
									fnCallback(data);
								}
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

	//新增
	function onAdd() {
		if (!onAddBefore()) {
			return false;
		}
		var node = getSelectedNodes();
		if (typeof (node) == 'undefined') {
			YYUI.promMsg("请先选择节点");
			return;
		}
		layer.open({
			type : 2,
			title : false,//标题
			shadeClose : false,//是否点击遮罩关闭
			shade : 0.8,//透明度
			closeBtn : 0,//关闭按钮
			area : [ '100%', '100%' ],
			content : '${param.serviceurl}/onAdd?'+ _addParam, //iframe的url
		});
		onAddAfter();
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
			content : '${param.serviceurl}/onEdit?uuid=' + aData.uuid + '&' + _editParam, //iframe的url
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
			content : '${param.serviceurl}/onDetail?uuid=' + data.uuid + '&' + _detailParam, //iframe的url
		});
	}
	
	//保存
	function onSave() {
		var posturl = "${param.serviceurl}/add";
		var isAdd = true;
		pk = $("#yy-form-edit input[name='uuid']").val();
		if (pk != "") {
			posturl = "${param.serviceurl}/update";
			isAdd = false;
		}
		if (!$("#yy-form-edit").valid())
			return false;
		var opt = {
			url : posturl,
			type : "post",
			success : function(data) {
				if (data.success == true) {
				 	onRefresh();
					_selectedId = data.records[0].uuid;
				} else {
					YYUI.promAlert("操作失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}

</script>