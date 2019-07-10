<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
<title>项目</title>
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
		</div>
		<div>
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" id="uuid" type="hidden"/>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >项目号</label>
							<div class="col-md-8" >
								<input name="code" id="code" type="text" value="${entity.code}" class="form-control">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required" >项目名称</label>
							<div class="col-md-8" >
								<input name="name" id="name" type="text" value="${entity.name}" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-2" >备注</label>
							<div class="col-md-10" >
								<input name="memo" id="memo" type="text" value="${entity.memo}" class="form-control">
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<div class="tabbable-line">
			<ul class="nav nav-tabs ">
				<li class="active"><a href="#tab_15_1" data-toggle="tab">列表
				</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active">
					<div class="row yy-toolbar">
						<button id="addNewSub" class="btn blue btn-sm" type="button">
							<i class="fa fa-plus"></i> 添加
						</button>
					</div>
					<table id="yy-table-sublist" class="yy-table">
						<thead>
							<tr>
								<th>序号</th>	
								<th>操作</th>	
								<th>箱号</th>	
								<th>物料</th>	
								<th>限制数量</th>	
								<th>计划数量</th>	
								<th>备注</th>	
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
		var enumMap = YYDataUtils.getEnumMap();
		var enumdatas = enumMap['BoxNum'];
		
		var _subTableList;//子表
		var _columnNum;
		
		/* 子表操作 */
		var _subTableCols = [{
			data : null,
			orderable : false,
			className : "center",
			width : "20"
		},{
			data : "uuid",
			className : "center",
			orderable : false,
			render : YYDataTableUtils.renderRemoveActionCol,
			width : "20"
		}, {
			data : 'boxNum',
			width : "20",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				//return creSelectStr('BoxNum','boxNum',data,false);
				var selectStr = '';
				selectStr = selectStr +'<select class="yy-input-enumdata form-control" id="boxNum" reallyname="boxNum" name="boxNum" data-enum-group="BoxNum" onchange="changeBox(this);">';
				if(enumdatas){
					selectStr = selectStr + '<option value="">&nbsp;</option>';
					for (i = 0; i < enumdatas.length; i++) {
						if(enumdatas[i].enumdatakey == data){ 
							selectStr = selectStr + "<option selected='selected' value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
						} else {
							selectStr = selectStr + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
						}
					}
				}
				selectStr = selectStr +'</select>';
				return selectStr;
			}
		}, {
			data : 'material',
			width : "80",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				var str ='<div class="input-group materialRefDiv"> '+
				 '<input class="form-control materialCodeInputCls"  value="'+ data.code + '" reallyname="code" name="code" readonly="readonly"> '+
				 '<input class="form-control"  value="'+ data.uuid + '" type="hidden" reallyname="materialId" name="materialId"> '+
				 '<span class="input-group-btn"> '+
				 '<button id="" class="btn btn-default btn-ref materialcode" type="button" data-select2-open="single-append-text"> '+
				 '<span class="glyphicon glyphicon-search"></span> '+
				 '</button> '+
				 '</span> '+
				 '</div> ';
				return str;
			}
		}, {
			data : 'material.limitCount',
			width : "80",
			className : "center",
			visible : false,
			orderable : true
		}, {
			data : 'planAmount',
			width : "80",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="planAmount">';
			}
		}, {
			data : 'memo',
			width : "160",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				if(data==null){
					data="";
				}
				return '<input class="form-control" value="'+ data + '" name="memo">';
			}
		}];

		 
		$(document).ready(function() {
			bindEditActions();//綁定平台按鈕
			
			validateForms();
			
			_subTableList = $('#yy-table-sublist').DataTable({
				"columns" : _subTableCols,
				"paging" : false//,"order" : [[5,"asc"]]
			});
			
			//添加按钮事件
			$('#addNewSub').click(function(e) {
				layer.open({
					title:"物料",
				    type: 2,
				    area: ['1000px', '95%'],
				    shadeClose : false,
					shade : 0.8,
				    content: "${ctx}/sys/ref/refMaterial?callBackMethod=window.parent.callBackAddMaterial"
				});
			});
			
			//行操作：删除子表
			$('#yy-table-sublist').on('click', '.delete', function(e) {
				e.preventDefault();
				var delThis=$(this);
				layer.confirm('确实要删除吗？', function(index) {
					layer.close(index);
					//此处的this表示layer.confirm,所以delThis变量
					var nRow = delThis.closest('tr')[0];//$(this).closest('tr')[0];
					var row = _subTableList.row(nRow);
					row.remove().draw();
				});
			});
			
			$('#yy-table-sublist').on('click','.materialcode',updateMaterialRef);//
		});
		var t_refMaterialEle;
		function updateMaterialRef(){
			t_refMaterialEle = $(this);
			layer.open({
				title:"物料",
			    type: 2,
			    area: ['1000px', '95%'],
			    shadeClose : false,
				shade : 0.8,
			    content: "${ctx}/sys/ref/refMaterial?callBackMethod=window.parent.callBackSelectMaterial"
			});
		}
		
		//换箱
		function changeBox(t){
			console.info("select>>>>>>>>>>>>>>>"+$(t).val());
			var row =$(t).closest("tr");
			var materialData = _subTableList.row(row).data().material;
			var tr_limitCount = materialData.limitCount;
			if(tr_limitCount==1){
				var trCode = materialData.code;
				console.info("code ========="+trCode);
				var sameCodeCount = 0;
				$(".materialCodeInputCls").each(function(){
					if(trCode==$(this).val()){
						sameCodeCount++;
					}
					if(sameCodeCount>1){
						YYUI.promMsg("物料 "+trCode+" 限制数量为1,请确认物料或选择其他箱号");
						$(t).val("");
						return false;
					}
				});
			}
		}
		
		function checkCanAdd(selNode){
			var canAdd=true;
			var sameCodeCount = 0;
			$(".materialCodeInputCls").each(function(){
				var trBoxNum = $(this).closest("tr").find("select[name='boxNum']").val();
				console.info("trBoxNum>>>>>"+trBoxNum);
				
				if(selNode.code==$(this).val()){
					console.info(selNode);
					if(selNode.limitCount==1){
						sameCodeCount++;
						if(sameCodeCount>1){
							YYUI.promMsg("物料 "+selNode.code+" 限制数量为1,请确认物料或选择其他箱号");
							canAdd = false;
							return false;
						}
					}
				}
			});
			return canAdd;
		}
		
		//回调修改物料
		function callBackSelectMaterial(selNode){
			var canAdd=checkCanAdd(selNode);
			if(canAdd){
				$(t_refMaterialEle).closest(".materialRefDiv").find("input[name='code']").val(selNode.code);
				$(t_refMaterialEle).closest(".materialRefDiv").find("input[name='materialId']").val(selNode.uuid);
			}
		}
		 
		//回调添加物料
		function callBackAddMaterial(selNode){
			var canAdd=checkCanAdd(selNode);//判断是否能添加
			if(canAdd){
				var subNewData = [ {
					'uuid' : '',
					'material' : {"uuid":selNode.uuid,"code":selNode.code,"name":selNode.name,"limitCount":selNode.limitCount},
					'planAmount':'',
					'memo':''
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
			}
		}
		
		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'code' : {required : true,maxlength : 100},
					'name' : {required : true,maxlength : 100},
					'memo' : {maxlength : 100}
				}
			});
		}


		//主子表保存
		function onSave(isClose) {
			var subValidate=validOther();
			var mainValidate=$('#yy-form-edit').valid();
			if(!subValidate||!mainValidate){
				return false;
			}
			//保存新增的子表记录 
	        var _subTable = $("#yy-table-sublist").dataTable();
	        var subList = new Array();
	        var rows = _subTable.fnGetNodes();
	        for(var i = 0; i < rows.length; i++){
	            subList.push(getRowData(rows[i]));
	        }
	        if(subList.length==0){
	        	YYUI.promAlert("请添加明细");
	        	return false;
	        }
			var saveWaitLoad=layer.load(2);
			var opt = {
				url : "${serviceurl}/addwithsub",
				type : "post",
				data : {"subList" : subList},
				success : function(data) {
					layer.close(saveWaitLoad);
					if (data.success == true) {
						if (isClose) {
							window.parent.YYUI.succMsg('保存成功!');
							window.parent.onRefresh(true);
							closeEditView();
						} else {
							YYUI.succMsg('保存成功!');
						}
					} else {
						YYUI.promAlert("保存失败：" + data.msg);
					}
				}
			}
			$("#yy-form-edit").ajaxSubmit(opt);
		}
		
		//校验子表
		function validOther(){
			if(validateRowsData($("#yy-table-sublist tbody tr:visible[role=row]"),getRowValidator())==false){
				return false;
			}else{
				return true;
			} 
		}
		
		//表体校验
		//表体校验
		function getRowValidator() {
			return [ {
						name : "planAmount",
						rules : {
							required : true,
							//number :true,
							digits :true,
							maxlength:8
						},
						message : {
							required : "必输",
							//number :"请输入合法的数字",
							digits :"只能输入整数",
							maxlength : "最大长度为8"
						}
					},{
						name : "boxNum",
						rules : {
							required : true,
							maxlength:3
						},
						message : {
							required : "请选择",
							maxlength : "最大长度为3"
						}
					}
			];
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
	</script>
</body>
</html>
