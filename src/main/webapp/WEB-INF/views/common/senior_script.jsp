<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _zTree;//树
	var _changeParent;//是否变更了父节点
	
	var _rowNum = 0;
	
	//页面形态
	var _isSelected = true;
	 // _zTree 点击触发的事件
	function treeClickMethod(event, treeId, treeNode,rootSelectable) {
		
		if(!treeNode.nodeData.islast){
			return;
		}
		if(YYMAP.get(treeNode.id)!=null){
			return;
		}
		YYMAP.put(treeNode.id,treeNode.name);
		console.info(event);
		console.info(treeId);
		console.info(treeNode);
		var senRow = '<div class="senior-row" id="sen-row-'+_rowNum+'"><div class="senior-row-div-btn">'
		+'<a href="javascript:deleteRow('+_rowNum+',\''+treeNode.id+'\')" class="btn btn-circle btn-xs  red senior-row-a"><i class="fa fa-times"></i></a>'
  		+'</div><div class="senior-row-one"><input class="form-control " id="treeName'+_rowNum+'"  style="width:170px;" readonly="readonly"  value="'+treeNode.name+'" type="text">'+
  		'<input  name="seniorQuery['+_rowNum+'].fieldName" value="'+treeNode.nodeData.fieldName+'" type="hidden"><input  name="seniorQuery['+_rowNum+'].tableName" value="'+treeNode.nodeData.subTableName+'" type="hidden"></div>'//字段
  		+'<input  name="seniorQuery['+_rowNum+'].reselffieldName" id="reselffieldName'+_rowNum+'" value="'+treeNode.nodeData.reselffieldName+'" type="hidden">'
  		+'<input  name="seniorQuery['+_rowNum+'].repantfieldName" id="repantfieldName'+_rowNum+'" value="'+treeNode.nodeData.repantfieldName+'" type="hidden">'
		+'<input  name="seniorQuery['+_rowNum+'].panttableName" id="panttableName'+_rowNum+'" value="'+treeNode.nodeData.panttableName+'" type="hidden">';
  		var deleteRowNum = _rowNum;
		if(treeNode.nodeData.isAssociatedField){  //关联表字段
				senRow+='<input  name="seniorQuery['+_rowNum+'].associatedTable" value="'+treeNode.nodeData.associatedTable+'" type="hidden"><input  name="seniorQuery['+_rowNum+'].associatedTableField" value="'+treeNode.nodeData.associatedTableField+'" type="hidden">'
					  +'<input  name="seniorQuery['+_rowNum+'].valuefieldtype" value="'+treeNode.nodeData.valuefieldtype+'" type="hidden">'
					  +'<input  name="seniorQuery['+_rowNum+'].assValueField" value="'+treeNode.nodeData.assValuefield+'" type="hidden">';
			if(treeNode.nodeData.valuefieldAddress !=null){   //下拉
				senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;"  name="seniorQuery['+_rowNum+'].operator" >'
					  +'<option value="equals">等于</option><option value="notEquals">不等于</option></select></div>'
				      +'<div class="senior-row-div"><div class="input-group">'
				      +'<div class="senior-row-time"><select  id="associaField'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:250px;"  name="seniorQuery['+_rowNum+'].fieldValue" >'
				      +'</div></div></div>'
				      findAssociaField(_rowNum,treeNode.nodeData.valuefieldAddress);
				}else if(treeNode.nodeData.assgroupcode){    //枚举
					senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
					  +'<option value="equals">等于</option></select></div><div class="senior-row-div"><div class="senior-row-time">'
				      +'<select  id="assgroupcode'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:230px;"  name="seniorQuery['+_rowNum+'].fieldValue" ></div></div>'
				      groupcodeField(_rowNum,treeNode.nodeData.assgroupcode);
				}else if(treeNode.nodeData.fieldType=="datetime" || treeNode.nodeData.fieldType=="date"){
					var timeNum = _rowNum;
					senRow+='<div class="senior-row-select"><select id="selectTime'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
						   +'</select></div>'
		 				   +'<div id="time'+_rowNum+'" class="senior-row-time"><input  name="seniorQuery['+_rowNum+'].timeOne" id="d4311'+_rowNum+'"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+_rowNum+'\\\')}\'})"/>至<input  id="d4312'+_rowNum+'" class="Wdate input-time" type="text" name="seniorQuery['+_rowNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+_rowNum+'\\\')}\'})"/></div>'
				}else{
					senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
		 			+'<option value="equals">等于</option><option value="notEquals">不等于</option><option value="contains">包含</option><option value="leftContains">左包含</option><option value="rightContains">右包含</option>'
					+'</select></div><div class="senior-row-time"><input class="form-control " name= "seniorQuery['+_rowNum+'].fieldValue" style="width:250px;" name="ChineseTable"  type="text"></div>';
				}
		}else if(treeNode.nodeData.groupcode!= null){//枚举字段
			senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
				  +'<option value="equals">等于</option><option value="notEquals">不等于</option></select></div><div class="senior-row-div"><div class="senior-row-time">'
			      +'<select  id="groupcode'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:250px;"  name="seniorQuery['+_rowNum+'].fieldValue" ></div></div>'
			      groupcodeField(_rowNum,treeNode.nodeData.groupcode);
			
		}else if(treeNode.nodeData.fieldType=="datetime" || treeNode.nodeData.fieldType=="date"){//时间字段
			var timeNum = _rowNum;
			senRow+='<div class="senior-row-select"><select id="selectTime'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
				   +'</select></div>'
 				   +'<div id="time'+_rowNum+'" class="senior-row-time"><input  name="seniorQuery['+_rowNum+'].timeOne" id="d4311'+_rowNum+'"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+_rowNum+'\\\')}\'})"/>至<input  id="d4312'+_rowNum+'" class="Wdate input-time" type="text" name="seniorQuery['+_rowNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+_rowNum+'\\\')}\'})"/></div>'
 		}else{//其他字段
 			senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
 			+'<option value="equals">等于</option><option value="notEquals">不等于</option><option value="contains">包含</option><option value="leftContains">左包含</option><option value="rightContains">右包含</option>'
			+'</select></div><div class="senior-row-time"><input class="form-control " name= "seniorQuery['+_rowNum+'].fieldValue" style="width:250px;" name="ChineseTable"  type="text"></div>';
		}
		senRow+="</div>";
		$("#yy-senior-div").append(senRow);
		if(treeNode.nodeData.fieldType=="datetime" || treeNode.nodeData.fieldType=="date"){
			$("#selectTime"+_rowNum).append('<option value="between" selected="selected">介于</option><option value="equals">等于</option><option value="greaterThan">大于</option><option value="GreaterThanOrEqual">大于等于</option><option value="LessThan">小于</option><option value="LessThanOrEqual">小于等于</option>');
		}
		$("#selectTime"+timeNum).change(function(){
			if($("#selectTime"+timeNum).val()!="between"){
				$("#time"+timeNum).html('<input class="Wdate" style="width:250px;" type="text"  name="seniorQuery['+timeNum+'].timeOne" readonly="readonly" onClick="WdatePicker()">');
			}else{
				$("#time"+timeNum).html('<input  id="d4311'+timeNum+'" name="seniorQuery['+timeNum+'].timeOne"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+timeNum+'\\\')}\'})"/>至<input id="d4312'+timeNum+'" class="Wdate input-time" type="text" name="seniorQuery['+timeNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+timeNum+'\\\')}\'})"/>');
			}
		})
		_zTree.selectNode(treeNode);
		_rowNum++;
	}
	 
	function defaultSenRow(nodeData){
		if(YYMAP.get(nodeData.uuid)!=null){
			return;
		}
		YYMAP.put(nodeData.uuid,nodeData.uuid);
		var senRow = '<div class="senior-row" id="sen-row-'+_rowNum+'"><div class="senior-row-div-btn">'
		+'<a href="javascript:deleteRow('+_rowNum+',\''+nodeData.uuid+'\')" class="btn btn-circle btn-xs  red senior-row-a"><i class="fa fa-times"></i></a>'
  		+'</div><div class="senior-row-one"><input class="form-control " id="treeName'+_rowNum+'"  style="width:170px;" readonly="readonly"  value="'+nodeData.chineseField+'" type="text">'+
  		'<input  name="seniorQuery['+_rowNum+'].fieldName" value="'+nodeData.fieldName+'" type="hidden"><input  name="seniorQuery['+_rowNum+'].tableName" value="'+nodeData.subTableName+'" type="hidden"></div>'//字段
  		+'<input  name="seniorQuery['+_rowNum+'].reselffieldName" id="reselffieldName'+_rowNum+'" value="'+nodeData.reselffieldName+'" type="hidden">'
  		+'<input  name="seniorQuery['+_rowNum+'].repantfieldName" id="repantfieldName'+_rowNum+'" value="'+nodeData.repantfieldName+'" type="hidden">'
		+'<input  name="seniorQuery['+_rowNum+'].panttableName" id="panttableName'+_rowNum+'" value="'+nodeData.panttableName+'" type="hidden">';
  		var deleteRowNum = _rowNum;
		if(nodeData.isAssociatedField){  //关联表字段
			senRow+='<input  name="seniorQuery['+_rowNum+'].associatedTable" value="'+treeNode.nodeData.associatedTable+'" type="hidden"><input  name="seniorQuery['+_rowNum+'].associatedTableField" value="'+treeNode.nodeData.associatedTableField+'" type="hidden">'
			  +'<input  name="seniorQuery['+_rowNum+'].valuefieldtype" value="'+treeNode.nodeData.valuefieldtype+'" type="hidden">'
			  +'<input  name="seniorQuery['+_rowNum+'].assValueField" value="'+nodeData.assValuefield+'" type="hidden">';
			if(nodeData.valuefieldAddress !=null){   //下拉
			senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;"  name="seniorQuery['+_rowNum+'].operator" >'
				  +'<option value="equals">等于</option><option value="notEquals">不等于</option></select></div>'
			      +'<div class="senior-row-div"><div class="input-group">'
			      +'<div class="senior-row-time"><select  id="associaField'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:250px;"  name="seniorQuery['+_rowNum+'].fieldValue" >'
			      +'</div></div></div>'
			      findAssociaField(_rowNum,nodeData.valuefieldAddress);
			}else if(nodeData.assgroupcode){    //枚举
				senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
				  +'<option value="equals">等于</option></select></div><div class="senior-row-div"><div class="senior-row-time">'
			      +'<select  id="assgroupcode'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:230px;"  name="seniorQuery['+_rowNum+'].fieldValue" ></div></div>'
			      groupcodeField(_rowNum,nodeData.assgroupcode);
			}else if(nodeData.fieldType=="datetime" || nodeData.fieldType=="date"){
				var timeNum = _rowNum;
				senRow+='<div class="senior-row-select"><select id="selectTime'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
					   +'</select></div>'
	 				   +'<div id="time'+_rowNum+'" class="senior-row-time"><input  name="seniorQuery['+_rowNum+'].timeOne" id="d4311'+_rowNum+'"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+_rowNum+'\\\')}\'})"/>至<input  id="d4312'+_rowNum+'" class="Wdate input-time" type="text" name="seniorQuery['+_rowNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+_rowNum+'\\\')}\'})"/></div>'
			}else{
				senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
	 			+'<option value="equals">等于</option><option value="contains">包含</option><option value="leftContains">左包含</option><option value="rightContains">右包含</option>'
				+'</select></div><div class="senior-row-time"><input class="form-control " name= "seniorQuery['+_rowNum+'].fieldValue" style="width:250px;" name="ChineseTable"  type="text"></div>';
			}
		}else if(nodeData.groupcode!= null){//枚举字段
			senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
				  +'<option value="equals">等于</option></select></div><div class="senior-row-div"><div class="senior-row-time">'
			      +'<select  id="groupcode'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:230px;"  name="seniorQuery['+_rowNum+'].fieldValue" ></div></div>'
			      groupcodeField(_rowNum,nodeData.groupcode);
			
		}else if(nodeData.fieldType=="datetime" || nodeData.fieldType=="date"){//时间字段
			var timeNum = _rowNum;
			senRow+='<div class="senior-row-select"><select id="selectTime'+_rowNum+'"  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
				   +'</select></div>'
 				   +'<div id="time'+_rowNum+'" class="senior-row-time"><input  name="seniorQuery['+_rowNum+'].timeOne" id="d4311'+_rowNum+'"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+_rowNum+'\\\')}\'})"/>至<input  id="d4312'+_rowNum+'" class="Wdate input-time" type="text" name="seniorQuery['+_rowNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+_rowNum+'\\\')}\'})"/></div>'
 		}else{//其他字段
 			senRow+='<div class="senior-row-select"><select  class="yy-input-enumdata form-control" style="width:90px;" name="seniorQuery['+_rowNum+'].operator" >'
 			+'<option value="equals">等于</option><option value="contains">包含</option><option value="leftContains">左包含</option><option value="rightContains">右包含</option>'
			+'</select></div><div class="senior-row-time"><input class="form-control " name= "seniorQuery['+_rowNum+'].fieldValue" style="width:250px;" name="ChineseTable"  type="text"></div>';
		}
		senRow+="</div>";
		$("#yy-senior-div").append(senRow);
		if(nodeData.fieldType=="datetime" || nodeData.fieldType=="date"){
			$("#selectTime"+_rowNum).append('<option value="between" selected="selected">介于</option><option value="equals">等于</option><option value="greaterThan">大于</option><option value="GreaterThanOrEqual">大于等于</option><option value="LessThan">小于</option><option value="LessThanOrEqual">小于等于</option>');
		}
		$("#selectTime"+timeNum).change(function(){
			if($("#selectTime"+timeNum).val()!="between"){
				$("#time"+timeNum).html('<input class="Wdate" style="width:250px;" type="text"  name="seniorQuery['+timeNum+'].timeOne" readonly="readonly" onClick="WdatePicker()">');
			}else{
				$("#time"+timeNum).html('<input  id="d4311'+timeNum+'" name="seniorQuery['+timeNum+'].timeOne"  class="Wdate input-time" type="text" readonly="readonly" onFocus="WdatePicker({maxDate:\'#F{$dp.$D(\\\'d4312'+timeNum+'\\\')}\'})"/>至<input id="d4312'+timeNum+'" class="Wdate input-time" type="text" name="seniorQuery['+timeNum+'].timeTwo" readonly="readonly" onFocus="WdatePicker({minDate:\'#F{$dp.$D(\\\'d4311'+timeNum+'\\\')}\'})"/>');
			}
		})
		_rowNum++;
	}
	var _treeSetting = {
			check : {
				enable : false
			},
			async: {
				enable: true,
				url:"${ctx}/sys/senior/query?coding=${coding}",
				//url:"../sys/data/dataAdmin",		
				autoParam:["id", "name=n", "level=lv"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			view: {
				dblClickExpand: false,
				//ddDiyDom: addDiyDom,
				fontCss: getFontCss   //搜索结果高亮
			},
			data: {
				key: {
					title:"title"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				onDblClick: zTreeOnAsyncSuccess,
				onClick : treeClickMethod
			}
		};
	//成功加载树后
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		var nodes = _zTree.getNodes();
		_zTree.expandNode(nodes[0], true);
	}
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			
		}
		return childNodes;
	}
	//查询树节点后高亮显示
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}



	// _zTree 返回数据进行预处理
	function ajaxDataFilter(treeId, parentNode, responseData) {
		var records = responseData.records;
		return records;
	}

	
	
	var eventNUm = 1;
	document.onkeydown = function(event) {   //获取按键
		switch(event.keyCode) {
	    	case 13:eventNUm= 3;return;
	     		 break; // enter 键
	    	default:eventNUm=2 ;
	  }
		
	}
	//删除查询条件
	function deleteRow(number,id){
		if(eventNUm!=3){ 
			YYMAP.remove(id);
			$("#sen-row-"+number).remove();//点击了鼠标 左键
		}else{
			eventNUm = 2;  //a==3 按下了回车键
		}
	}
   
	//关联字段查询
	function findAssociaField(number,valuefieldAddress) {
		var 	url = "${ctx}"+valuefieldAddress;
		$.ajax({
			url : url,
			type : "post",
			success : function(data) {
				for(var i=0;i<data.length;i++){
					$("#associaField"+number).append('<option value="'+data[i].uuid+'">'+data[i].name+'</option>');
				}
			}
			})
	}
	//枚举字段
	function groupcodeField(number,groupcode){
		var doc = {"groupcode":groupcode}
		$.ajax({
			url : "${ctx}/sys/senior/queryEnumData",
			type : "post",
			data :doc,
			success : function(data) {
				for(var i=0;i<data.length;i++){
				$("#groupcode"+number).append('<option value="'+data[i].enumdatakey+'">'+data[i].enumdataname+'</option>');
				}
			}
			})
	}
	
	function onSearchTree(){
		var searchValue = $('#searchTreeNode').val();
		YyZTreeUtils.searchNode(_zTree,searchValue);
	}
	//绑定按钮事件
 	function bindDefaultActions() {
		//zTree的搜索事件绑定
		$('#searchTreeNode').bind("propertychange", onSearchTree)
			.bind("input", onSearchTree); 
		$('#searchTreeNode').bind('keypress',function(event){
	        if(event.keyCode == "13") {
	        	onSearchTree();
	        }
	    });
	}


	function readyZtree(){
		//加载ztree
		_zTree = $.fn.zTree.init($("#treeFunc"), _treeSetting);
		YYFormUtils.lockForm('yy-form-func');
		
		$("#mainTable").val("${mainTable}");
		
		bindDefaultActions();    // 开启 搜索 事件 
		
		//折叠/展开
		$('#csc-senior-query').bind('click', function() {
			_zTree.expandAll(true);
		});
		defaultCondition();
	}
	//});
	//默认条件加载
	function defaultCondition(){
		var doc = {"coding":"${coding}"}
		$.ajax({
			url : "${ctx}/sys/senior/queryDefault",
			type : "post",
			data :doc,
			success : function(data) {
				 for(var i=0;i<data.length;i++){
					 defaultSenRow(data[i]);
				} 
			}
			})
	}
	
	
	//当前选择的节点
	function getSelectedNodes() {
		return YyZTreeUtils.getZtreeSelectedNodes(_zTree);
	}
	function seniorBtn(){
		$("#yy-senior-btn-confirm").bind('click',confirmSenior);  //高级查询确定
	}
	
	//高级查询确定查询
	function  confirmSenior(){
		var names=$("#yy-form-senior").serializeArray();
		findSeniorQuery(names);
	}
	//高级查询确定查询
	function findSeniorQuery(names){
 		//var editview = layer.load(2);
		$.ajax({
			url : '${ctx}/sys/senior/seniorQuery',
			data : names,
			//dataType : 'json',
			async : false,
			type : "post",
			success : function(data) {
				if(data==null || data==""){
					YYUI.promAlert('没有您要找的数据');
				}else{
					$("#yy-btn-cancel").click();
					senQuery(data);	
				}
			},
		})
		
	};

	$(document).ready(function() {
		seniorBtn();     //高级查询按钮 
		readyZtree();    //加载高级查询候选条件
	$("#senior-content").css("left",($("#senior").width()-$("#senior-content").width())/2);
	$("#senior-content").css("top",($("#senior").height()-$("#senior-content").height())/2);
	
	
	});
	
	
	
	
	YYMAP={};
	 
	YYMAP.elements = new Array();  
	  
	YYMAP.size = function() {  
	        return YYMAP.elements.length;  
	   }  
	  
	YYMAP.isEmpty = function() {  
	        return (YYMAP.elements.length < 1);  
	   }  
	  
	YYMAP.clear = function() {  
		YYMAP.elements.length = 0;  
	}  
	  
	YYMAP.put = function(_key, _value) {  
		YYMAP.elements.push( {  
	            key : _key,  
	            value : _value  
	        });  
	    }  
	  
	YYMAP.remove = function(_key) {  
	        try {  
	            for ( var i = 0; i < this.size(); i++) {  
	  
	                if (YYMAP.elements[i].key == _key)  
	                	YYMAP.elements.splice(i, 1);
	                	if(YYMAP.get(_key) != null){
	                		YYMAP.remove;
	                	}else{
	                		return true; 
	                	}
	            }  
	        } catch (e) {  
	            return false;  
	        }  
	        return false;  
	    }  
	  
	YYMAP.get = function(_key) {  
	          
	        try {  
	            for ( var i = 0; i < this.size(); i++) {  
	                if (YYMAP.elements[i].key == _key) {  
	                    var _value = YYMAP.elements[i].value;  
	                    return _value;  
	                }  
	            }  
	        } catch (e) {  
	            return null;  
	        }  
	        return null;  
	    }  
	      
	YYMAP.containsKey=function(_key){  
	        try {  
	            for ( var i = 0; i < this.size(); i++) {  
	                if (YYMAP.elements[i].key == _key) {  
	                    return true;  
	                }  
	            }  
	        } catch (e) {  
	            return false;  
	        }  
	        return false;  
	    }  
	  
	      
	YYMAP.getValues=function(){  
	        var values=new Array();  
	        try {  
	            for ( var i = 0; i < this.size(); i++) {  
	                values.push(YYMAP.elements[i].key);  
	            }  
	        } catch (e) {  
	            //alert("Can not get YYMAP Values ! {1}"+e.message);  
	            return null;  
	        }  
	        return values;  
	    }  
	      
	YYMAP.getKeys=function(){  
	        var keys=new Array();  
	        try {  
	            for ( var i = 0; i < this.size(); i++) {  
	                keys.push(YYMAP.elements[i].values);  
	            }  
	        } catch (e) {  
	            //alert("Can not get YYMAP Keys ! {1}"+e.message);  
	            return null;  
	        }  
	        return keys;  
	    }  
	      
	YYMAP.mapStr=function(){  
	        return YYMAP.elements.toString();  
	} 
</script>