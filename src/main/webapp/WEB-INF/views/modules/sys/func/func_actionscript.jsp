<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _actionTableList;//子表
	var _addActionList = new Array();
	var _deleteActionPKs = new Array();//需要删除的PK数组
	var _actiontableCols = [ {
		data : "uuid",
		orderable : false,
		className : "center",
		width : "20",
	    render : YYDataTableUtils.renderCheckCol
	}, {
		data : "uuid",
		className : "center",
		orderable : false,
		render : function(){return null;},
		width : "60"
	}, {
		data : 'actioncode',
		width : "40%",
		orderable : true
	}, {
		data : 'actionname',
		width : "50%",
		orderable : true
	} ];
	
	
	function onActionRefresh(){
		loadActioList(_selectedId);
	}
	
	//保存按钮
	function onActionSave(){
		if (!validOther()) return false;
		
		/* if(!validate())
			return false;  */
		//所有需要保存的参数
		addActionDeleteToFormData();
		var formData = $('#yy-action-from').serialize();
		/* if(formData==null||formData==""){
			alert('没做任何修改');
			return;
		} */
		var posturl = "${actionserviceurl}/saveAll";
		$.ajax({
			url : posturl,
			type : "post",
			data :formData,
			success : function(data) {
				if(data.success){
					YYUI.succMsg('操作成功!');
					onActionRefresh();
					showActionListToolBar();
				}else{
					YYUI.promAlert(data.msg);
				}
			}
		}); 
	}
	
	//编辑按钮
	function onActionEdit(){
		var node = getSelectedNodes();
		if(typeof(node) == 'undefined'){
			YYUI.promMsg("请选择节点");
			return;
		}
		//if(_selectedId.nodeData.func_type != 'func'){
		if(node.nodeData.func_type != 'func'){
			YYUI.promMsg("请选择功能类型的节点");
			return;
		} 
		showActionEditToolBar();
		onActionEditAll();
	}
	
	function onActiondelete(){
		var rows = getSelectedTr("yy-action-table");
		if(rows==null||rows.length==0){
			YYUI.promMsg("请选择需要删除的行"); 
			return;
		}
		for(var i=0;i<rows.length;i++){
			onActionRowBatchDelete(rows[i]);
		}
	}
	
	//取消按钮
	function onActionCancel(){
		showActionListToolBar();
		onActionRefresh();
	}
	
	//添加行按钮
	function onActionRowAdd(){
		var newData = [ {
			uuid : '',
			actioncode : '',
			actionname : ''
		} ];
		var nRow = _actionTableList.rows.add(newData).draw().nodes()[0];//添加行，并且获得第一行
		actionAddRow(_actionTableList,nRow);
	}
	
	//行删除按钮
	function onActionRowDelete(){
		var nRow = $(this).closest('tr')[0];
		var row = _actionTableList.row(nRow);
		var data = row.data();
		if (typeof (data) == null || data.uuid == '') {
			//新增的直接删除
			row.remove().draw();
			_addActionList = removeObjFromArr(_addActionList, nRow);
		} else {
			_deleteActionPKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
			_addActionList = removeObjFromArr(_addActionList, nRow);
			row.remove().draw();
		}
	}
	
	//批量删除行
	function onActionRowBatchDelete(nRow){
		var row = _actionTableList.row(nRow);
        var data = row.data();
        if(typeof(data)==null||data.uuid==''){
        	row.remove().draw();
			_addActionList = removeObjFromArr(_addActionList, nRow);
        }else{
        	_deleteActionPKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
			_addActionList = removeObjFromArr(_addActionList, nRow);
			row.remove().draw();
        }
	}
	
	//行取消按鈕
	function onActionRowCancel(){
		var nRow = $(this).closest('tr')[0];
		cancelEditRow(_actionTableList, nRow);
	}
	
	function onActionEditAll(){
		var rows = $("#yy-action-table tbody tr")
		if(rows!=null&&rows.length>0){
			for(var i=0;i<rows.length;i++){
				actionEditRow(_actionTableList, rows[i]);
			}
		}
	}
	
	//显示编辑界面按钮组
	function showActionEditToolBar(){
		$('#yy-action-listtoolbar').addClass("hide");
		$('#yy-action-edittoolbar').removeClass("hide");
	}
	
	//显示查看界面按钮组
	function showActionListToolBar(){
		$('#yy-action-listtoolbar').removeClass("hide");
		$('#yy-action-edittoolbar').addClass("hide");
	}
	
	//绑定按钮事件
	function bindActionActions() {
		$('#yy-action-save').bind('click', onActionSave);//编辑
		$('#yy-action-edit').bind('click', onActionEdit);//编辑
		$('#yy-action-cancel').bind('click', onActionCancel);//取消
		$('#yy-action-delete').bind('click', onActiondelete);//编辑
		$('#yy-action-addRow').bind('click', onActionRowAdd);//新增操作
		$('#yy-action-table').on('click','.delete', onActionRowDelete);//删除行
		$('#yy-action-table').on('click','.cancel', onActionRowCancel);//删除行
		
		
	}
	
	$(document).ready(function() {
		_actionTableList = $('#yy-action-table').DataTable({
			"columns" : _actiontableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"processing": true,
			"paging" : false,
			"order" : [[2,"asc"]]
		});
		YYUI.setUIAction("yy-action-table");
		bindActionActions();
		
	});
	

	
	//表体校验
	function getRowValidator() {
		return [ {
					name : "actioncode",
					rules : {
						required : true
					},
					message : {
						required : "按钮编码必输"
					}
				},
				{
					name : "actionname",
					rules : {
						required : true
					},
					message : {
						required : "按钮名称必输"
					}
				}
				
		];
	}
	//校验
	function validOther(){
		if(validateRowsData($("#yy-action-table tbody tr:visible[role=row]"),getRowValidator())==false){
			return false;
		}
		else{
			return true;
		} 
		return true;
	}
	
	//加载按钮数据
	function loadActioList(mainTableId) {
		$.ajax({
			url : '${actionserviceurl}/query',
			data : {
				"search_EQ_func.uuid" : mainTableId.id,
				"orderby" : "showorder@asc"
			},
			dataType : 'json',
			async : false,
			success : function(data) {
				hasLoadSub = true;
				_actionTableList.clear();
				_actionTableList.rows.add(data.records);
				_actionTableList.draw();
				resetActionDelete();
			}
		});
	}
	//清空要删除的pk
	function resetActionDelete(){
		_deleteActionPKs=[];
		$("input[name='deletePks']").remove();
		
	}
	//给表单添加要删除的pk
	function addActionDeleteToFormData(){
		$("input[name='deletePKs']").remove();
		for(var i=0;i<_deleteActionPKs.length;i++){
			var hidden = "<input type='hidden' name='deletePKs' value='"+_deleteActionPKs[i]+"'>";
			 $('#yy-action-from').append(hidden);
		}
	}
	//添加行
	function actionAddRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = '<input name="chkrow" type="checkbox" class="checkboxes" value="' + aData.uuid + '">'
		 +'<input type="hidden"  name="uuid"  value="' + aData.uuid + '">'
		 +'<input type="hidden"  name="funcid"  value="' + _selectedId.id + '">';
		 jqTds[1].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";
		jqTds[2].innerHTML = '<input type="text" id="wegwae" name="actioncode" class="form-control {required:true}" value="' + aData.actioncode + '">';
		jqTds[3].innerHTML = '<input type="text" name="actionname" class="form-control"  value="' + aData.actionname + '">';
		_addActionList.push(nRow);
	}
	
	//编辑行
	function  actionEditRow(oTable, nRow) {
	    var aData = oTable.row(nRow).data();
	    if(typeof(aData) != "undefined"){//eidt by liusheng
		    var jqTds = $('>td', nRow);
		    jqTds[0].innerHTML = '<input name="chkrow" type="checkbox" class="checkboxes" value="' + aData.uuid + '">'
		    +'<input type="hidden"  name="uuid"  value="' + aData.uuid + '">'
		    +'<input type="hidden"  name="funcid"  value="' + aData.func.uuid + '">';
		    jqTds[1].innerHTML = "<div class='btn-group rap-btn-actiongroup'>"
				+ "<button id='yy-btn-cancel-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
				+ "</div>";
		    jqTds[2].innerHTML = '<input type="text"  name="actioncode" class="form-control {required:true}"  value="' + aData.actioncode + '">';
		    jqTds[3].innerHTML = '<input type="text"  name="actionname" class="form-control"  value="' + aData.actionname + '">';
	    }
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
	//取消编辑
	function cancelEditRow(oTable, nRow) {
		var aData  = oTable.row(nRow).data();
	  	oTable.row(nRow).data(aData).draw();
	  	//setRowStyle(nRow);
	  	_addActionList = removeObjFromArr(_addList,nRow);
	}
	function getSelectedTr(tableId) {
		if(tableId==null){
			return new Array();
		}
		return $("#"+tableId+" tr:has(input[name='chkrow']:checked)");
	};
	
</script>
