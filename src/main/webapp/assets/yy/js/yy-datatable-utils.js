YYDataTableUtils = {};

/**
 * datatable 复选框
 */
YYDataTableUtils.renderCheckCol = function(data, type, full) {

	var chkValue = data == null ? full.uuid : data;
	// return "<label><input name='chkrow' type='checkbox' value='" + full.uuid
	// + "'/><span class='lbl'></span></label>";
	// return "<label><input type='checkbox' name='chkrow' class='checkboxes'
	// value='" + data + "'/><span class='lbl'></span></label>";
	return '<label><span><input type="checkbox" name="chkrow" class="checkboxes" value="'
			+ data + '" /></span></label>';
};

/**
 * datatable 复选框 选中
 */
YYDataTableUtils.renderCheckedCol = function(data, type, full) {
	var chkValue = data == null ? full.uuid : data;
	return '<label><span><input type="checkbox" name="chkrow" class="checkboxes" value="'
			+ data + '" checked="checked" /></span></label>';
};

//查看-编辑-删除
YYDataTableUtils.renderActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
};


//查看-编辑
YYDataTableUtils.renderViewEditActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			+ "</div>";
};
//查看
YYDataTableUtils.renderViewActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
			+ "</div>";
};
//编辑
YYDataTableUtils.renderEditActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			+ "</div>";
};
//添加-删除
YYDataTableUtils.renderAddRemoveActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-add-row' type='button' class='btn btn-xs btn-success plus' data-rel='tooltip' title='添加'><i class='fa fa-plus'></i></button>"
			+ "<button id='yy-btn-remove-row' type='button' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
};
//删除
YYDataTableUtils.renderRemoveActionCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>"
			+ "<button id='yy-btn-remove-row' type='button' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
};
//子表：编辑-删除
YYDataTableUtils.renderActionSubCol = function(data, type, full) {
	return "<div class='btn-group rap-btn-actiongroup'>"
			+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info edit' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
			+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
};
//子表：取消-删除
YYDataTableUtils.renderEditActionSubCol = function(data, type, full) {
	return "<div class='btn-group rap-btn-actiongroup'>"
			+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger cancel' data-rel='tooltip' title='取消'><i class='fa fa-undo'></i></button>"
			+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
			+ "</div>";
};
//选择
YYDataTableUtils.renderSelectActionSubCol = function(data, type, full) {
	return "<div class='yy-btn-actiongroup'>" 
				+'<button id="yy-btn-select-row" class="btn btn-xs btn-success select" data-rel="tooltip" title="选择">选择</button>'
			+ "</div>";
};


/**
 * 添加行操作事件
 */
YYDataTableUtils.setActions = function(nRow, aData, iDataIndex) {
	// nRow: {node}: "TR" element for the current row
	// aData: {array}: Raw data array for this row
	// iDataIndex: {int}: The index of this row in aoData
	$(nRow).dblclick(function() {
		//onViewDetailRow(aData, iDataIndex, nRow);
		//onEditRow(aData, iDataIndex, nRow);
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

	$('#yy-btn-download-row', nRow).click(function() {
		onDownloadRow(aData, iDataIndex, nRow);
	});
	
	$('#yy-btn-gen-row', nRow).click(function() {
		onYyBtnGenRow(aData, iDataIndex, nRow);
	});
};

/**
 * 如果存在多datatable的页面需要把tableId传进来。
 */
YYDataTableUtils.getSelectPks = function(otableId) {
	// 遍历得到每个checkbox的value值
	var arrChk = new Array();
	if (otableId == null)
		arrChk = $("input[name='chkrow']:checked");
	else
		arrChk = $("#" + otableId + " input[name='chkrow']:checked");
	var pks = new Array();
	for (var i = 0; i < arrChk.length; i++) {
		pks.push(arrChk[i].value);
	}
	return pks;
};
/**
 * @param data:要显示的内容
 * @param length:缩略后的长度
 * @param 弹出类型:view/edit
 * @param fnCallback:回调函数，参数value为修改后的值，此函数当popType=edit时有效
 */
YYDataTableUtils.renderPopover = function(data, length, popType, fnCallback) {
	try {
		if (data == null) {
			return "";
		}
		if (!length) {
			length = 12;
		}
		if ("edit" != popType) {
			popType = 'view';
		}
		var popContent = getPopContent(data, popType, length, fnCallback);
		if (popType == 'view') {
			popContent = transferString(popContent, popType);
		}
		var shortStr = getLengthString(data, length);
		return "<a class=\"rap-popover\" data-container='body' data-toggle='popover' onclick='popover(this);' data-content='"
				+ popContent + "'>" + shortStr.encodeHtml() + "</a>"
	} catch (e) {
		return "";
	}
};
function getPopContent(data, popType, length, fnCallback) {
	if ("edit" == popType) {
		return "<textarea class=\"rap-popover-textarea\">"
				+ data
				+ "</textarea><div class=\"rap-toolbar-small\"><button class=\"btn btn-xs btn-info\" onclick=\"popoverEditCallBack(this,"
				+ length
				+ ","
				+ fnCallback
				+ ");\"><i class=\"glyphicon glyphicon-ok\"></i> 确定</button></div>";
	} else {
		return data;
	}
}
// 替换所有的回车换行
function transferString(content) {
	var string = content;
	try {
		string = string.replace(/\r\n/g, "<BR>")
		string = string.replace(/\n/g, "<BR>");
	} catch (e) {
		alert(e.message);
	}
	return string;
}
YYDataTableUtils.createInputStr = function(field,value){
	if(value == null){
		value = '';
	}
	var str = '<input type="text" name="'+field+'" value="' + value + '" class="form-control">';
	return str;
}
YYDataTableUtils.createEditOperationStr = function(){
	var str='<div class="yy-btn-actiongroup"> ' +
				'<button id="yy-btn-remove-row" class="btn btn-xs btn-danger delete" data-rel="tooltip" title="删除"> ' +
					'<i class="fa fa-trash-o"></i> ' +
				'</button> ' +
			'</div> ';
	return str;
}
YYDataTableUtils.createRefStr = function(field,value,btncla){
	if(value == null){
		value = '';
	}
	var str = '<div class="input-group"> '+
				'<input name="'+field+'" id="'+field+'" type="text"  value="' + value + '" class="form-control">  '+
				'<span class="input-group-btn"> '+
					'<button name="'+field+'"   class="btn btn-default btn-ref  '+btncla+'" '+
						'type="button" data-select2-open="single-append-text"> '+
						'<span class="glyphicon glyphicon-search"></span> '+
					'</button> '+
				'</span>  '+
			'</div>';
	return str;
}
/**
 * 导出table输出到excel
 * 用法：var exportDataTable = new TableExporter(table);
 *     exportDataTable.export(url,target);
 */
function TableExporter(in_table){
	var data = new Array();
	
	this.init = function(){
		if(in_table.tHead!=null){
			var rows = in_table.tHead.rows;
			this.appendRows(rows,"head");
		}
		var bodies = in_table.tBodies;
		if(bodies!=null&&bodies.length>0){
			for(var i=0;i<bodies.length;i++){
				rows = bodies[i].rows;
				this.appendRows(rows,"normal");
			}
		}
		if(in_table.tFoot!=null){
			var rows = in_table.tFoot.rows;
			this.appendRows(rows,"foot");
		}
	};
	this.insertRow = function(row,cellStyle){
		var insertData = new Array();
		var rowData = this.rowToData(row,cellStyle);
		insertData.push(rowData);
		data = insertData.concat(data);
	};
	this.appendRow = function(row,cellStyle){
		if(row!=null){
			var rowData = this.rowToData(row,cellStyle);
			data.push(rowData);
		}
	};
	this.appendRows=function(rows,cellStyle){
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				this.appendRow(rows[i],cellStyle);
			}
		}
	};
	//说明：data格式：tdData/@/tdData/@/tdData
	// tdData:cellValue/#/colspan/#/rowspan/#/cellStyle
	this.rowToData = function(row,cellStyle){
		if(!cellStyle){
			cellStyle="normal";
		}
		var cells = row.cells;
		var rowStr = "";
		for (j=0; j < cells.length; j++) {
			var cellText =this.getCellText(cells[j]) ;
			var colSpan = cells[j].colSpan;
			var rowSpan = cells[j].rowSpan;
			var tdData = cellText+"/#/"+colSpan+"/#/"+rowSpan+"/#/"+cellStyle;
			if(j==0){
				rowStr = tdData;
			}else{
				rowStr = rowStr+"/@/"+tdData;
			}
		}
		return rowStr;
	};
	this.getCellText = function(cell){
		var text = $(cell).text();
		var html = cell.innerHTML;
		if(text!=null&&text.length>0){
			return text;
		}else{
			if(html!=null&&html.length>0){
				return cell.firstChild.innerHTML;
			}else{
				return "";
			}
		}
	}
	this.getData = function(){
		return data;
	};
	this.exportExcel = function(url,target){
		if(!target){
			target="exportFrame";
		}
		var tempForm = document.createElement("form");    
	    tempForm.id = "tempForm1";    
	    tempForm.method = "post";    
	    tempForm.action = url;    
	    tempForm.target = target;  
		if(data){
			for(var i = 0;i<data.length;i++){
				if(data[i]){
					var hideInput = document.createElement("input");   
					hideInput.type="hidden";    
				    hideInput.name= "data"; 
				    hideInput.value= data[i]; 
					tempForm.appendChild(hideInput); 
				}
			}
		}
		document.body.appendChild(tempForm); 
		tempForm.submit();  
		document.body.removeChild(tempForm); 
	};
	this.init();
}