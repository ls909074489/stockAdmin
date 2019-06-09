<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _subTableList;//子表
	var _addList = new Array(); //新增的行/修改的行
	var _deletePKs = new Array();//需要删除的PK数组
	/*按钮事件*/
	//主子表保存
	function onSave(isClose) {
		var validateResult = true;
		if (!$('#yy-form-edit').valid())
			validateResult = false;
		if (!validOther()) return false;
		//子表一数据校验
		/* if(validateRowsData(_addList)==false)
			validateResult = false; */
		if(!validateResult)
			return false;
		//保存新增的子表记录 
		YYFormUtils.setCheckBoxNotCheckedValue('yy-form-edit');
		YYFormUtils.setCheckBoxNotCheckedValue('secondform');
		var subList = getToSaveList();
		var subData = null;

		//所有需要保存的参数
		subData = {
			"subList" : subList,
			"deletePKs" : _deletePKs
		};

		var posturl = "${serviceurl}/addwithsub";
		var pk = $("input[name='uuid']").val();
		if (pk != "" && typeof (pk) != null)
			posturl = "${serviceurl}/updatewithsub";
			
		var subCommonSaveWaitLoad=layer.load(2);
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			success : function(data) {
				layer.close(subCommonSaveWaitLoad);
				if (data.success == true) {
					_deletePKs = new Array();
					_addList = new Array();
					hasLoadSub = false;
					onRefresh();
					if (isClose) {
						YYUI.setListMode();
					} else {
						onAdd();
					}
				} else {
					//YYUI.failMsg("操作失败：" + data.msg);
					YYUI.promAlert("操作失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	//新增
	function onAdd() {
		onAddBefore();
		YYFormUtils.clearForm('yy-form-edit');
		YYUI.setEditMode();
		showSub("add",'');
		onAddAfter();
	}

	//行操作：查看行明细  同时要隐藏子表
	//@data 行数据
	//@rowidx 行下标操作事件
	function onViewDetailRow(data,iDataIndex, nRow) {
		showData(data);
		showSub("view",data.uuid);
		YYUI.setDetailMode();
	}
	//行操作：修改数据  同时显示子表
	function onEditRow(data,iDataIndex, nRow) {
		showData(data);
		showSub("edit",data.uuid);
		YYUI.setEditMode();
	}
	//取消编辑
	function cancelEditRow(oTable, nRow) {
		var aData  = oTable.row(nRow).data();
	  	oTable.row(nRow).data(aData).draw();
	  	//setRowStyle(nRow);
	  	_addList = removeObjFromArr(_addList,nRow);
	}
	/*表体行操作*/
	//校验多行数据 返回boolean类型
	function validateRowsData(rowList){
		var result = true;
		for(var i=0;i<rowList.length;i++){
			if(!validateRowData(rowList[i])){
				result=false;
			}
		}
		return result;
	}
	
	//校验多行数据 返回boolean类型  edit by liusheng  引入subcommonscript.jsp 导致yy-utils-validate.js的方法被覆盖   
	function validateRowsData(rowList,validator) {
		var result = true;
		for (var i = 0; i < rowList.length; i++) {
			if (!validateRowData(rowList[i],validator)) {
				result = false;
			}
		}
		return result;
	}
	
	//获取所有新增的行
	function getToSaveList(){
		var postList = new Array();
		for(var i=0;i<_addList.length;i++){
			var nRow = _addList[i];
			if(nRow!=null){
				var addData = getRowData(nRow);
				postList.push(addData);
			}
		}
		return postList;
	}
	//提交数据时需要特殊处理checkbox的值
	function getRowData(nRow){
		var data = $('input, select', nRow).not('input[type="checkbox"]').serialize();
		//处理checkbox的值
		$('input[type="checkbox"]',nRow).each(function(){
			var checkboxName = $(this).attr("name");
			var checkboxValue = "false";
			if(this.checked){
				checkboxValue = "true";
			}
			data = data+"&"+checkboxName+"="+checkboxValue;
		});
		return data;
	}
	/**
	* 显示子表信息
	* @param showMod 视图类型，edit或者view
	* @param mainTableId 主表id
	*/
	function showSub(showMod,mainTableId){
		_addList = new Array();
		if(mainTableId==null||mainTableId==''){
			_mainId = '';
			_subTableList.clear().draw();
		}else{
			_mainId=mainTableId;
			loadSubList(mainTableId)
		}
		//$('#yy-page-subdiv').html("");
		//$('#yy-page-sublist').show();
		if("view"==showMod){
			$("#yy-page-sublist").find("div.yy-toolbar").hide();
			$("#yy-page-sublist").find("#yy-btn-edit-row,#yy-btn-remove-row").hide();
			$("#yy-page-sublist").find(".editFormBtn").hide();//子表下 样式为 class为editFormBtn也隐藏 edit by liusheng 
		}else{
			$("#yy-page-sublist").find("div.yy-toolbar").show();
			$("#yy-page-sublist").find("#yy-btn-edit-row,#yy-btn-remove-row").show();
			$("#yy-page-sublist").find(".editFormBtn").show();//子表下 样式为 class为editFormBtn也显示 edit by liusheng 
		}
	}
	//初始化新增或修改行的样式
	function setRowStyle(nRow){
		YYUI.setUIStyle();
		$('input[type=checkbox].make-switch',nRow).bootstrapSwitch();
	}
	//删除操作行
	function removeObjFromArr(array,obj){
		for(var i=0;i<array.length;i++){
			if(array[i]==obj){
				return array.del(i);
			}
		}
		return array;
	}
	//校验其它
	function validOther() {
		return true;
	}
</script>