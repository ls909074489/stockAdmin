<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
var _tableCols = [
              	{
              		data : "uuid",
              		orderable : false,
              		className : "center",
              		/* visible : false, */
              		width : "5%",
              		render : YYDataTableUtils.renderCheckCol
              	}, {
              		data : "uuid",
              		className : "center",
              		orderable : false,
              		render : YYDataTableUtils.renderViewEditActionCol,
              		width : "15%"
              	}
              			, {
              			data : 'templateName',
              			width : "15%",
              			className : "center",
              			orderable : true
              		}, {
              			data : 'chineseTable',
              			width : "15%",
              			className : "center",
              			orderable : true
              		}, {
              			data : 'tableName',
              			width : "15%",
              			className : "center",
              			orderable : true
              		}
              		, {
              			data : 'instructions',
              			width : "15%",
              			className : "center",
              			orderable : true
              		}
              		
              		,  {
              			data : 'coding',
              			width : "15%",
              			className : "center",
              			orderable : true
              		}
              		
              	];

	$(document).ready(function() {
		 _tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"order" : [[1,"asc"]]
		});
		
		//按钮绑定事件
		bindButtonActions();
		
		//高级查询候选条件加载
		//readyZtree();
		//seniorBtn();
		validateForms();
	});
	
	//校验
	function validateForms(){
		validata = $('#yy-form-edit').validate({
			onsubmit : true,
			rules : {
				'templateName' : {required : true},
				'chineseTable' : {required : true},
				'tableName' : {required : true}
			}			
		});
	}
	
	function subValidateForms(){
		validata = $('#yy-form-edit').validate({
			onsubmit : true,
			rules : {
				'templateName' : {required : true},
				'chineseTable' : {required : true},
				'tableName' : {required : true}
			}			
		});
	}
	//选择表名
	$('#yy-org-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择主表表名',
			shadeClose : false,
			shade : 0.8,
			area : [ '300px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/template/selectTable?rootSelectable=true&callBackMethod=window.parent.callBackSelectMainTable', //iframe的url
		});
	});
	function callBackSelectMainTable(node){
		$("input[name='tarelid']").val(node.nodeData.uuid);
		$("#coding").val(node.nodeData.coding);
		$("input[name='chineseTable']").val(node.name)
		$("input[name='tableName']").val(node.nodeData.tableName);
		
	}
	
	 
	/* 子表操作 */
	
	
	var _subTableCols = [
{
	data : "uuid",
	orderable : false,
	className : "center",
	/* visible : false, */
	width : "70",
	render : YYDataTableUtils.renderActionSubCol
}
,	{
			data : 'subChineseTable',
			width : "100",
			className : "center",
			orderable : true
		}
		,{
		data : 'fieldName',
		width : "100",
		className : "center",
		orderable : true
	}
	,{
		data : 'groupcode',
		width : "100",
		className : "center",
		orderable : true
	}
	,{
		data : 'chineseField',
		width : "100",
		className : "center",
		orderable : true
	},{
		data : 'iscondition',
		width : "50",
		className : "center",
		orderable : true
	},{
		data : 'isDefaultCond',
		width : "50",
		className : "center",
		orderable : true
	}, {
		data : 'isAssociatedField',
		width : "50",
		className : "center",
		orderable : true
	}
	, {
		data : 'associatedTable',
		width : "50",
		className : "center",
		orderable : true
	}
	, {
		data : 'associatedTableField',
		width : "50",
		className : "center",
		orderable : true
	}
	, {
		data : 'assValuefield',
		width : "50",
		className : "center",
		orderable : true
	}, {
		data : 'assgroupcode',
		width : "50",
		className : "center",
		orderable : true
	}
	,{
		data : 'valuefieldAddress',
		width : "100",
		className : "center",
		orderable : true
	}
	
	];
	var rowNum = 1;
	//加载页面时初始化子表
	$(document).ready(function() {
		table = $('#yy-table-sublist');
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false,
			
			"order" : []
		});
		loadList();
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();

			var newData = [ {
				 /* uuid : '', */
				 subChineseTable : '',
				 fieldName : '',
				 groupcode : '',
				 chineseField : '',
				 iscondition : '',
				 isDefaultCond : '',
				 isAssociatedField : '',
				 associatedTable : '',
				 associatedTableField : '',
				 assValuefield : '',
				 assgroupcode:'',
				 valuefieldAddress : ''
			} ];
			var nRow = _subTableList.rows.add(newData).draw().nodes()[0];//获得第一个tr节点
			addRow(_subTableList, nRow,rowNum);
			rowNum++;
			
		});
		//行操作：删除子表
		table.on('click', '.delete', function(e) {
			e.preventDefault();
			var nRow = $(this).closest('tr')[0];
			var row = _subTableList.row(nRow);
			var data = row.data();
			if (typeof (data) == null || data.uuid == '') {
				//新增的直接删除
				row.remove().draw();
				_addList = removeObjFromArr(_addList, nRow);
			} else {
				_deletePKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
				_addList = removeObjFromArr(_addList, nRow);
				row.remove().draw();
			}
		});
		//行操作：取消编辑
		table.on('click', '.cancel', function(e) {
			e.preventDefault();
			var nRow = $(this).closest('tr')[0];
			cancelEditRow(_subTableList, nRow);
		});
		//行操作：编辑	
		table.on('click', '.edit', function(e) {
			e.preventDefault();
			/* 获取点击事件所在的行 */
			var nRow = $(this).closest('tr')[0];
			editRow(_subTableList, nRow);

		});
	});
		//添加行
	function addRow(oTable, nRow,number) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";

		jqTds[1].innerHTML = '<div style="width:150px;" class="input-group"><input  id="subChineseTable'+number+'" name="subChineseTable" type="text" class="form-control" readonly="readonly">'+
		'<span class="input-group-btn"><button  class="btn btn-default btn-ref" type="button" onclick="conditionsTable('+number+')"><span class="glyphicon glyphicon-search"></span></button></span></div>'
		+ '<input type="hidden"   id="subTableName'+number+'" name="subTableName"  value="' + aData.subTableName + '">'
		+'<input type="hidden"   id="reselffieldName'+number+'" name="reselffieldName"  value="' + aData.reselffieldName + '">'
		+'<input type="hidden"   id="repantfieldName'+number+'" name="repantfieldName"  value="' + aData.repantfieldName + '">'
		+'<input type="hidden"   id="panttableName'+number+'" name="panttableName"  value="' + aData.panttableName + '">';
		jqTds[2].innerHTML = '<div class="col-md-3"><select id="fieldName'+number+'" style="width:150px;" name="fieldName" class="form-control"></select></div>'
		+'<fieldset disabled><div class="col-md-3 hide"><select id="fielpe'+number+'"   style="width:150px;"  class="form-control"></select></div></fieldset><input type="hidden" id="fieldType'+number+'" name="fieldType">'; 
		jqTds[3].innerHTML = '<input type="text" style="width:100px;" name="groupcode"  value="' + aData.groupcode + '">';
		jqTds[4].innerHTML = '<input type="text" style="width:100px;" name="chineseField"  value="' + aData.chineseField + '">';
		jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes" id="iscondition'+number+'" name="iscondition" value="' + aData.iscondition + '">';
		jqTds[6].innerHTML = '<input type="checkbox" class="checkboxes" id="isDefaultCond'+number+'" name="isDefaultCond" value="' + aData.isDefaultCond + '">';
		jqTds[7].innerHTML = '<input type="checkbox" class="checkboxes" id="isAssociatedField'+number+'"  name="isAssociatedField" value="' + aData.isAssociatedField + '">';
		
		jqTds[8].innerHTML = '<input type="text" style="width:100px;" name="associatedTable" id="associatedTable'+number+'"  value="' + aData.associatedTable + '">';
		jqTds[9].innerHTML = '<div class="col-md-3"><select id="associatedTableField'+number+'" style="width:150px;" name="associatedTableField" class="form-control"></select></div>';
		jqTds[10].innerHTML = '<div class="col-md-3"><select id="assValuefield'+number+'" style="width:150px;" name="assValuefield" class="form-control"></select></div>'
		+'<div class="col-md-3 hide"><select id="valuefieldtype'+number+'" name="valuefieldtype"  style="width:150px;"  class="form-control"></select></div>'
		$("#associatedTable"+number).change( function() {
			assFindFiled(number,null,null,null);
		});
		
		jqTds[11].innerHTML = '<input type="text" style="width:100px;" name="assgroupcode" id="assgroupcode'+number+'"  value="' + aData.assgroupcode + '">';

		jqTds[12].innerHTML = '<input type="text" name="valuefieldAddress" id="valuefieldAddress'+number+'"  value="' + aData.valuefieldAddress + '">';
		_addList.push(nRow);
	}
/* 	function initRow(data,nRow){
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = '<div style="width:150px;" class="input-group"><input   value="'+data.subChineseTable+'" name="subChineseTable" type="text" class="form-control" readonly="readonly">'+
		'<span class="input-group-btn"><button  class="btn btn-default btn-ref" type="button" ><span class="glyphicon glyphicon-search"></span></button></span></div>'
		+'<input type="hidden" style="width:150px;" readonly="readonly"   value="' + data.subTableName + '">';
		jqTds[1].innerHTML = '<input type="text" style="width:150px;" readonly="readonly"    value="' + data.fieldName + '">'
		+'<input type="hidden" style="width:150px;" readonly="readonly"    value="' + data.fieldType + '">';
		if(data.groupcode==null){
			jqTds[2].innerHTML = '<input type="text" style="width:100px;" name="groupcode"  value="" readonly="readonly">';
		}else{
			jqTds[2].innerHTML = '<input type="text" style="width:100px;" name="groupcode" readonly="readonly"  value="' + data.groupcode + '">';
		}
		jqTds[3].innerHTML = '<input type="text" style="width:100px;" name="chineseField" readonly="readonly" value="' + data.chineseField + '">';
		alert(data.iscondition);
		jqTds[4].innerHTML = '<input type="text" style="width:50px;" readonly="readonly"   value="' + data.iscondition + '">';
		jqTds[5].innerHTML = '<input type="text" style="width:50px;" readonly="readonly"   value="' + data.isDefaultCond + '">';
		jqTds[6].innerHTML = '<input type="text" style="width:50px;" readonly="readonly"   value="' + data.isAssociatedField + '">';
		if(data.isAssociatedField){
			jqTds[7].innerHTML = '<input type="text" name="valuefieldAddress"   value="' + data.valuefieldAddress + '">';
		}else{
			jqTds[7].innerHTML = '<input type="text" name="valuefieldAddress"  value="">';
		}
		jqTds[8].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-cancel-row' class='btn btn-xs btn-danger cancel' data-rel='tooltip' title='取消'><i class='fa fa-undo'></i></button><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";
		_addList.push(nRow);
	} */
	//修改行  (oTable-->datatable，nRow-->tr对象，而不是datatable的row)
	function editRow(oTable, nRow) {
		var aData = oTable.row(nRow).data();
		var jqTds = $('>td', nRow);
		jqTds[0].innerHTML = "<div class='yy-btn-actiongroup'><button id='yy-btn-cancel-row' class='btn btn-xs btn-danger cancel' data-rel='tooltip' title='取消'><i class='fa fa-undo'></i></button><button id='yy-btn-remove-row' class='btn btn-xs btn-danger delete' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button></div>";

		 /* '<input style="width:110px;" id="subChineseTable'+rowNum+'" value="'+aData.subChineseTable+'" name="subChineseTable" type="text" class="form-control" readonly="readonly">'+
		'<span class="input-group-btn"><button  class="btn btn-default btn-ref" type="button" onclick="conditionsTable('+rowNum+')"><span class="glyphicon glyphicon-search"></span></button></span></div>'
		 */jqTds[1].innerHTML ='<div style="width:150px;" class="input-group"><input type="hidden"  name="uuid"  value="'+aData.uuid+'"<div style="width:200px;" class="input-group"><input  id="subChineseTable'+rowNum+'" name="subChineseTable" value="'+aData.subChineseTable+'" type="text" class="form-control" readonly="readonly">'+
		'<span class="input-group-btn"><button  class="btn btn-default btn-ref" type="button" onclick="conditionsTable('+rowNum+')"><span class="glyphicon glyphicon-search"></span></button></span></div>'
		+'<input type="hidden" style="width:150px;" readonly="readonly" id="subTableName'+rowNum+'" name="subTableName"  value="' + aData.subTableName + '">'
		+'<input type="hidden"   id="reselffieldName'+rowNum+'" name="reselffieldName"  value="' + aData.reselffieldName + '">'
		+'<input type="hidden"   id="repantfieldName'+rowNum+'" name="repantfieldName"  value="' + aData.repantfieldName + '">'
		+'<input type="hidden"   id="panttableName'+rowNum+'" name="panttableName"  value="' + aData.panttableName + '">';
		jqTds[2].innerHTML = '<div class="col-md-3"><select id="fieldName'+rowNum+'" style="width:150px;" name="fieldName" class="form-control"></select></div>'
		+'<fieldset disabled><div class="col-md-3 hide"><select id="fielpe'+rowNum+'" name="fieldType"  style="width:150px;"  class="form-control"></select></div></fieldset><input type="hidden" id="fieldType'+rowNum+'" value="'+aData.fieldType+'" name="fieldType">'; 
		findField(rowNum,aData.fieldName,aData.fieldType); //初始化下拉框
		if(aData.groupcode==null){
			jqTds[3].innerHTML = '<input type="text" style="width:100px;" name="groupcode"  value="">';
		}else{
			jqTds[3].innerHTML = '<input type="text" style="width:100px;" name="groupcode"  value="' + aData.groupcode + '">';
		}
		if(aData.chineseField == null){
			jqTds[4].innerHTML = '<input type="text" style="width:100px;" name="chineseField"  value="">';
		}else{
			jqTds[4].innerHTML = '<input type="text" style="width:100px;" name="chineseField"  value="' + aData.chineseField + '">';
		}
			if(aData.iscondition=="是"){
			jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes" id="iscondition'+rowNum+'" name="iscondition" checked="checked">';
		}else{
			jqTds[5].innerHTML = '<input type="checkbox" class="checkboxes" id="iscondition'+rowNum+'" name="iscondition">';
		}
		if(aData.isDefaultCond=="是"){
			jqTds[6].innerHTML = '<input type="checkbox" class="checkboxes" id="isDefaultCond'+rowNum+'" name="isDefaultCond" checked="checked">';
		}else{
			jqTds[6].innerHTML = '<input type="checkbox" class="checkboxes" id="isDefaultCond'+rowNum+'" name="isDefaultCond">';
		}
		if(aData.isAssociatedField=="是"){
			jqTds[7].innerHTML = '<input type="checkbox" class="checkboxes" id="isAssociatedField'+rowNum+'"  name="isAssociatedField" checked="checked">';
		}else{
			jqTds[7].innerHTML = '<input type="checkbox" class="checkboxes" id="isAssociatedField'+rowNum+'"  name="isAssociatedField">';
		}
		if(aData.associatedTable==null){
			jqTds[8].innerHTML = '<input type="text" style="width:100px;" name="associatedTable" id="associatedTable'+rowNum+'" value="">';
			jqTds[9].innerHTML = '<div class="col-md-3"><select id="associatedTableField'+rowNum+'" style="width:150px;" name="associatedTableField" class="form-control"></select></div>';
			jqTds[10].innerHTML = '<div class="col-md-3"><select id="assValuefield'+rowNum+'" style="width:150px;" name="assValuefield" class="form-control"></select></div>';
		}else{
			jqTds[8].innerHTML = '<input type="text" style="width:100px;" name="associatedTable" id="associatedTable'+rowNum+'"  value="' + aData.associatedTable + '">';
			jqTds[9].innerHTML = '<div class="col-md-3"><select id="associatedTableField'+rowNum+'" style="width:150px;" name="associatedTableField" class="form-control"></select></div>';
			jqTds[10].innerHTML = '<div class="col-md-3"><select id="assValuefield'+rowNum+'" style="width:150px;" name="assValuefield" class="form-control"></select></div>';
			assFindFiled(rowNum,aData.associatedTableField,aData.assValuefield,aData.assFindFiled);

		}
		if(aData.assgroupcode == null){
			jqTds[11].innerHTML = '<input type="text" style="width:100px;" name="assgroupcode" id="assgroupcode'+rowNum+'"  value="">';
		}else{
			jqTds[11].innerHTML = '<input type="text" style="width:100px;" name="assgroupcode" id="assgroupcode'+rowNum+'"  value="' + aData.assgroupcode + '">';
		}
		
		
		
		
		
		if(aData.valuefieldAddress!=null){
			jqTds[12].innerHTML = '<input type="text" name="valuefieldAddress" id="valuefieldAddress'+rowNum+'"  value="' + aData.valuefieldAddress + '">';
		}else{
			jqTds[12].innerHTML = '<input type="text" name="valuefieldAddress" id="valuefieldAddress'+rowNum+'" value="">';
		}
		/* if(aData.associatedTable != null){
			findAssField(rowNum,null,null,null);
		} */
		_addList.push(nRow);
		rowNum++;
	}
	//显示表头数据
	function showData(data) {
		$("input[name='tarelid']").val(data.tarel.uuid);	
		$("input[name='uuid']").val(data.uuid);		
		$("input[name='templateName']").val(data.templateName);
		$("input[name='instructions']").val(data.instructions);
		$("input[name='tableName']").val(data.tableName);
		$("input[name='creatorname']").val(data.creatorname);
		$("input[name='createtime']").val(data.createtime);
		$("input[name='modifiername']").val(data.modifiername);
		$("input[name='modifytime']").val(data.modifytime);
		$("input[name='coding']").val(data.coding);
		$("input[name='chineseTable']").val(data.chineseTable);
	 }	
	
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		$.ajax({
			url : '${subserviceurl}/query',
			data : {
				"search_EQ_template.uuid" : mainTableId,
				"orderby" : "subChineseTable@asc",
				"search_EQ_status" : 1
			},
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(data) {
				hasLoadSub = true;
				for(var i=0;i<data.records.length;i++){
					if(data.records[i].isDefaultCond==true){
						data.records[i].isDefaultCond="是";
					}else{
						data.records[i].isDefaultCond="否";
					}
					if(data.records[i].isAssociatedField==true){
						data.records[i].isAssociatedField="是";
					}else{
						data.records[i].isAssociatedField="否";
					}
					if(data.records[i].iscondition==true){
						data.records[i].iscondition="是";
					}else{
						data.records[i].iscondition="否";
					}
				}
				_subTableList.clear();
				_subTableList.rows.add(data.records);
				_subTableList.draw();
			}
		});
	}
	//刷新
	function onRefresh() {
		loadList(); //非服务器分页
	}
	
	function conditionsTable(num){
		if($("#coding").val() == ""){
			YYUI.promMsg('请先选择主表',3000);
		}else{
		layer.open({
		type : 2,
		title : '请选择所属表',
		shadeClose : false,
		shade : 0.8,
		area : [ '300px', '90%' ],
		content : '${pageContext.request.contextPath}/sys/template/selectCon?rootSelectable=true&callBackMethod=window.parent.callBackSelectMainTable&rowNum='+num+'&coding='+$("#coding").val(), //iframe的url
	}); 
	}
	}
	//确定选择
	function callBackSelectTable(node,num){
		 $("#subChineseTable"+num).val(node.name);
		$("#subTableName"+num).val(node.nodeData.tableName);
		findField(num,null,null);
		if(node.nodeData.tableName==$("#tableName").val()){
			$("#reselffieldName"+num).val(null);
			$("#repantfieldName"+num).val(null);
			$("#panttableName"+num).val(null);
			return;
		} 
		settables(node.nodeData,num,true)
	}
	var tablenumber = 1;
	function settables(nodeData,num,_isTrue){
		if(nodeData.tableName==$("#tableName").val()){
			return;
		}
		//关联父表本表字段
		var reselffieldName = nodeData.fieldName;
		//关联父表父表字段
		var repantfieldName = nodeData.parefieldName;
		//父表名
		var panttableName = nodeData.parent.tableName;
		if(_isTrue){
			$("#reselffieldName"+num).val(reselffieldName+tablenumber);
			$("#repantfieldName"+num).val(repantfieldName+tablenumber);
			$("#panttableName"+num).val(panttableName+tablenumber);
		}else{
			$("#reselffieldName"+num).val($("#reselffieldName"+num).val()+","+reselffieldName+tablenumber);
			$("#repantfieldName"+num).val($("#repantfieldName"+num).val()+","+repantfieldName+tablenumber);
			$("#panttableName"+num).val($("#panttableName"+num).val()+","+panttableName+tablenumber);
		}
		tablenumber++;
		settables(nodeData.parent,num,false);
	}
	function assFindFiled(num,fieldName,assfieldName,valuefieldtype){
		var doc = {"tableName":$("#associatedTable"+num).val()};
		 $.ajax({
			url : '${ctx}/sys/relation/queryField',
			data :doc,
			dataType : 'json',
			//async : true,
			success : function(data) {
				 $("#associatedTableField"+num).empty();
				$("#assValuefield"+num).empty(); 
				for(var i=0;i<data.length;i++){
					if(data[i].columnName == "status"){
						
					}else{
						$("#associatedTableField"+num).append("<option value='"+data[i].columnName+"'  >"+data[i].columnName+"</option>");
						$("#assValuefield"+num).append("<option value='"+data[i].columnName+"'  >"+data[i].columnName+"</option>");
						$("#valuefieldtype"+num).append("<option value='"+data[i].columnName+"'  >"+data[i].columnName+"</option>");

					}
				}
				 if(fieldName !=null){
					$("#associatedTableField"+num).val(fieldName);
					$("#assValuefield"+num).val(assfieldName);
					$("#valuefieldtype"+num).val(valuefieldtype);
				}else{
					
				}  
			}
		});
		 $("#assValuefield"+num).change(function(){
			 $('#assValuefield'+num).val($('#assValuefield'+num).val());
			 $('#valuefieldtype'+num).val($('#valuefieldtype'+num).val());
		 })
	}
	function findField(num,fieldName,fieldType){
		var doc = {"tableName":$("#subTableName"+num).val()};
		 $.ajax({
			url : '${ctx}/sys/relation/queryField',
			data :doc,
			dataType : 'json',
			//async : true,
			success : function(data) {
				 $("#fieldName"+num).empty();
				$("#fieldType"+num).empty(); 
				/* $("#fieldRowName"+num).html(""); */
				for(var i=0;i<data.length;i++){
					if(data[i].columnName == "status"){
						
					}else{
						$("#fieldName"+num).append("<option value='"+data[i].columnName+"'  >"+data[i].columnName+"</option>");
						$("#fielpe"+num).append("<option value='"+data[i].fieldType+"'  >"+data[i].fieldType+"</option>");
					}
				}
				 if(fieldType !=null){
					$("#fielpe"+num).val(fieldType);
					$("#fieldName"+num).val(fieldName);
				}else{
					
				}  
			}
		});
		 $("#fieldName"+num).change(function(){
			 $('#fielpe'+num).get(0).selectedIndex=$('option:selected', '#fieldName'+num).index();
			 $('#fieldType'+num).val($('#fielpe'+num).val());
		 })
	}
	
	
	function onSave(isClose) {
		var validateResult = true;
		 if (!$('#yy-form-edit').valid()){
			 return false;
		 }
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
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			success : function(data) {
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
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
</script>
