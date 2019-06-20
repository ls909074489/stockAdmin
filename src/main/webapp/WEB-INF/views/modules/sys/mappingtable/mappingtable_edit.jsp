<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/mappingTable"/>
<c:set var="servicesuburl" value="${ctx}/info/mappingTableSub"/>
<html>
<head>
<title>标准映射表</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content">
	
		<div class="row yy-toolbar">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
			<button id="yy-btn-gen" class="btn blue btn-sm">
				<i class="fa fa-building"></i> 生成代码
			</button>
		</div>
		<div class="hide">
		</div>
		<div>
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" id="uuid" type="hidden" value="${entity.uuid}"/>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">模板名称</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="templateName" id="templateName" type="text" class="form-control" value="${entity.templateName}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">模板类型</label>
							<div class="col-md-8">
								<select name="templateType"  class="form-control">
									<option value="1">普通列表（前端分页）</option>
									<option value="2">普通列表（服务器分页）</option>
									<option value="3">树状结构</option>
									<option value="4">左树右列表</option>
									<option value="5">主子表（服务器分页）</option>
									<option value="6">主子表（前端分页）</option>
									<option value="11">列表单选</option>
									<option value="12">树单选</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">java文件路径</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="javaWorkspace" id="packageNamePath" type="text" class="form-control" value="${entity.javaWorkspace}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">java上级包名</label>
							<div class="col-md-8">
								<input name="packageName" id="packageName" type="text" class="form-control" value="${entity.packageName}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
						<input type="button" value="选择路径" id="javaPathBtn"/>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">页面文件路径</label>
							<div class="col-md-8" id="" style="float: left;">
								<input name="jspWorkspace" id="jspWorkspace" type="text" class="form-control" value="${entity.jspWorkspace}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">@RequestMapping(value = "/xx/xx")</label>
							<div class="col-md-8">
								<input name="controllerPath" type="text" class="form-control" value="${entity.controllerPath}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">页面路径(return "xx/xx";)</label>
							<div class="col-md-8">
								<input id="jspPath" name="jspPath" type="text" class="form-control" value="${entity.jspPath}">
							</div>
						</div>
					</div>
					<div class="col-md-1">
						<input type="button" value="选择路径" id="jspPathBtn"/>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">实体的用途名</label>
							<div class="col-md-8">
								<input name="entityChinese" type="text" class="form-control" value="${entity.entityChinese}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">生成表的名字</label>
							<div class="col-md-8">
								<input name="tableName" type="text" class="form-control" value="${entity.tableName}">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">实体的名字</label>
							<div class="col-md-8">
								<input name="entityName" type="text" class="form-control" value="${entity.entityName}">
							</div>
						</div>
					</div>
					<div class="col-md-2" style="padding-left: 0px;">
						extends
						<select name="extendsEntity">
							<option value="BaseEntity">BaseEntity</option>
							<option value="SuperEntity">SuperEntity</option>
							<option value="TreeEntity">TreeEntity</option>
						</select>
					</div>
				</div>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">映射关系
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<div class="row yy-toolbar">
						<button id="addNewSub" class="btn blue btn-sm">
							<i class="fa fa-plus"></i> 添加
						</button>
						<!-- <div role="form" class="form-inline" style="display: inline-block;">
							<form id="yy-form-subquery">	
								<input type="hidden" name="search_EQ_main.uuid" id="mainId" value="">	
								&nbsp;&nbsp;	
								<label for="search_LIKE_name" class="control-label">名称 </label>
								<input type="text" autocomplete="on" name="search_LIKE_name" id="search_LIKE_name" class="form-control input-sm">
								
								<label for="search_EQ_isexclude" class="control-label">状态 </label>
								<select class="yy-input-enumdata form-control" id="search_EQ_isexclude" name="search_EQ_isexclude" data-enum-group="SportResultStatus"></select>
								
								<button id="yy-btn-searchSub" type="button" class="btn btn-sm btn-info">
									<i class="fa fa-search"></i>查询
								</button>
								<button id="rap-searchbar-resetSub" type="reset" class="red">
									<i class="fa fa-undo"></i> 清空
								</button>	
							</form>
						</div> -->
					</div>
						<table id="yy-table-sublist" class="yy-table-x">
							<thead>
								<tr>
									<!-- <th class="table-checkbox"><input type="checkbox"
										class="group-checkable" data-set="#yy-table-sublist .checkboxes" /></th> -->
									<th>序号</th>	
									<th>操作</th>	
									<th>实体字段</th>
									<th>数据库字段</th>
									<th>备注</th>
									<th>列表是否显示</th>
									<th>是否主表</th>
									<th>页面显示方式</th>
									<th>字段类型</th>
									<th>字段长度</th>
								</tr>
							</thead>
							<tbody>
	
							</tbody>
						</table>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/editscript.jsp"%>
	
	<script type="text/javascript">
	var _subTableList;//子表
	var _addList = new Array(); //新增的行/修改的行
	var _deletePKs = new Array();//需要删除的PK数组
	var _columnNum;
	
	/* 子表操作 */
	var _subTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "30"
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			width : "50",
			render :YYDataTableUtils.renderRemoveActionCol
		}, {
			data : "colName",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				var tUuid=full.uuid;
				if (typeof(tUuid) == "undefined"){
					tUuid="";
				}
				if(data==null){
					data="";
				}
				return '<input type="hidden" name="uuid" value="'+tUuid+'"><input class="form-control inputChange" value="'+ data + '" name="colName">';
			}
		}, {
			data : "colNameDb",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colNameDb">';
			}
		}, {
			data : "colDesc",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colDesc">';
			}
		}, {
			data : "listVisiable",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('BooleanType','listVisiable',data,false);
			}
		}, {
			data : "mainTable",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('BooleanType','mainTable',data,false);
			}
		}, {
			data : "eleType",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('eleTypeEnum','eleType',data,false);
			}
		}, {
			data : "colType",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				return creSelectStr('colTypeEnum','colType',data,false);
			}
		}, {
			data : "colLength",
			orderable : false,
			className : "center",
			width : "80",
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="colLength">';
			}
		}
	];
	

	$(document).ready(function() {
		bindEditActions();//綁定平台按鈕
		$("#yy-btn-gen").bind('click', onGenCode);
		
		_subTableList = $('#yy-table-sublist').DataTable({
			"columns" : _subTableCols,
			//"dom" : '<"top">rt<"bottom"iflp><"clear">',
			"paging" : false/* ,
			"order" : [[5,"asc"]] */
		});
		
		setValue();
		
		$("#yy-btn-searchSub").bind('click', onRefreshSub);//快速查询
		$("#yy-searchbar-resetSub").bind('click', onResetSub);//清空
		
		validateForms();
		
		//添加按钮事件
		$('#addNewSub').click(function(e) {
			e.preventDefault();
			
			var subNewData = [ {
				'uuid' : '',
				'colName' : '',
				'colNameDb' :'',
				'colDesc' :'',
				'listVisiable' :1,
				'isMain' :1,
				'eleType' : '',
				'colType' : '',
				'colLength' : ''
			} ];
			var nRow = _subTableList.rows.add(subNewData).draw().nodes()[0];//添加行，并且获得第一行
			_subTableList.on('order.dt search.dt',
			        function() {
				_subTableList.column(0, {
					        search: 'applied',
					        order: 'applied'
				        }).nodes().each(function(cell, i) {
					        cell.innerHTML = i + 1;
				        });
			}).draw(); 
			inputChangeKeyup();
		});
		
		//行操作：删除子表
		$('#yy-table-sublist').on('click', '.delete', function(e) {
			e.preventDefault();
			var delThis=$(this);
			layer.confirm('确实要删除吗？', function(index) {
				layer.close(index);
				
				//此处的this表示layer.confirm,所以delThis变量
				var nRow = delThis.closest('tr')[0];
				
				var row = _subTableList.row(nRow);
				var data = row.data();
				if (typeof (data) == null || data.uuid == '') {
					//新增的直接删除
					row.remove().draw();
					//_addList = removeObjFromArr(_addList, nRow);
				} else {
					_deletePKs.push(data.uuid);//记录需要删除的id，在保存时统一删除
					//_addList = removeObjFromArr(_addList, nRow);
					row.remove().draw();
				}
			});
		});
	});
	
	//设置默认值
	function setValue(){
		if('${openstate}'=='add'){
			//$("input[name='billdate']").val('${billdate}');
		}else if('${openstate}'=='edit'){
			$("select[name='extendsEntity']").val('${entity.extendsEntity}');
			$("select[name='templateType']").val('${entity.templateType}');
			loadSubList('${entity.uuid}');
		}
	}
	
	
	//主子表保存
	function onSave(isClose) {
		var subValidate=validOther();
		var mainValidate=$('#yy-form-edit').valid();
		if(!subValidate||!mainValidate){
			return false;
		}
		
		//保存新增的子表记录 
		var subList = new Array();
		
         _table = $("#yy-table-sublist").dataTable();
         var rows = _table.fnGetNodes();
         for(var i = 0; i < rows.length; i++){
             subList.push(getRowData(rows[i]));
         }
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
			
		var saveWaitLoad=layer.load(2);
		var opt = {
			url : posturl,
			type : "post",
			data : subData,
			success : function(data) {
				layer.close(saveWaitLoad);
				if (data.success == true) {
					_deletePKs = new Array();
					_addList = new Array();
					hasLoadSub = false;
					YYUI.succMsg('保存成功!');
					window.parent.onRefresh(true);
					closeEditView();
					window.location.reload();
				} else {
					YYUI.promAlert("保存失败：" + data.msg);
				}
			}
		}
		$("#yy-form-edit").ajaxSubmit(opt);
	}
	
	//表头校验
	function validateForms(){
		$('#yy-form-edit').validate({
			rules : {
				'templateName' : {required : true,maxlength:50},
           		'javaWorkspace' : {required : true,maxlength:50},
           		'packageName' : {required : true,maxlength:50},
           		'jspWorkspace' : {required : true,maxlength:50},
           		'controllerPath' : {required : true,maxlength:50},
           		'jspPath' : {required : true,maxlength:50},
           		'entityChinese' : {required : true,maxlength:50},
           		'tableName' : {required : true,maxlength:50},
           		'entityName' : {required : true,maxlength:50}
			}	
		}); 
	}
	//校验子表
	function validOther(){
		if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row]"),getRowValidator())==false){
			return false;
		}
		else{
			return true;
		} 
		return true;
	}
	
	//表体校验
	function getRowValidator() {
		return [{
					name : "colName",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "colNameDb",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "colDesc",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "eleType",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "colType",
					rules : {
						required :true,
						maxlength:50
					},
					message : {
						required : "必输",
						maxlength : "最大长度为100"
					}
				},{
					name : "colLength",
					rules : {
						digits:true,
						required :true,
						maxlength:3
					},
					message : {
						digits:"请输入大于0的整数",
						required : "必输",
						maxlength : "最大长度为3"
					}
				}
		];
	}
	
	
	//刷新子表
	function onRefreshSub() {
		_subTableList.draw(); //服务器分页
	}
	//重置子表查询条件
	function onResetSub() {
		YYFormUtils.clearForm("yy-form-subquery");
		return false;
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
	
	//加载从表数据 mainTableId主表Id
	function loadSubList(mainTableId) {
		var loadSubWaitLoad=layer.load(2);
		$.ajax({
			url : '${servicesuburl}/query',
			data : {
				"search_EQ_main.uuid" : mainTableId,
				"orderby.uuid" : mainTableId
			},
			dataType : 'json',
			type : 'post',
			async : false,
			success : function(data) {
				layer.close(loadSubWaitLoad);
				
				_subTableList.clear();
				_subTableList.rows.add(data.records);
				_subTableList.on('order.dt search.dt',
				        function() {
					_subTableList.column(0, {
						        search: 'applied',
						        order: 'applied'
					        }).nodes().each(function(cell, i) {
						        cell.innerHTML = i + 1;
					        });
				}).draw();
				inputChangeKeyup();
			}
		});
	}
	
	//样式inputChange绑定，大写转换为下横线加小写的
	function inputChangeKeyup(){
		$(".inputChange").bind('keyup',function(){
			var tVal=$(this).val();
			var newVal="";
			for(var i=0;i<tVal.length;i++){
				var c=tVal.charAt(i);
				if(c<'A' || c>'Z'){
					newVal+=c;
				}else{
					newVal+="_"+c.toLocaleLowerCase();
				}
			}
			//$(this).next().val(newVal);
			$(this).closest("tr").find("input[name='colNameDb']").val(newVal);
		});
	}
	
	//生成代码
	function onGenCode(){
		$.ajax({
			type : "POST",
			data :{"uuid":$("#uuid").val()},
			url : "${serviceurl}/genCode",
			//async : true,
			dataType : "json",
			success : function(data) {
				YYUI.succMsg(data.msg);
			},
			error : function(data) {
				YYUI.failMsg("操作失败，请联系管理员");
			}
		});
	}
</script>
</body>
</html>