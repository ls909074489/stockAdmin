<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/sample"/>
<html>
<head>
<title>样品信息</title>
</head>
<body>
	<div id="yy-page-edit" class="container-fluid page-container page-content" >
		<div class="row yy-toolbar">
			<button id="yy-btn-save" class="btn blue btn-sm">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>
	<div>
		<div class="row yy-toolbar" style="display: block;">
			<button id="addNewSub" class="btn green btn-sm btn-info">
				<i class="fa fa-plus"></i> 添加
			</button>
		</div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="text" class="hide" value="${uuid}">
			<table style="width: 98%;text-align: center;" id="formTableId">
				<tr style="height: 30px;">
					<td style="width: 30%;">
						
					</td>
					<td id="tipTd" style="float: left;">
						
					</td>
				</tr>	
				<tr class="objTrCls" style="height: 40px;" dayVal="${toDay}">
					<td style="width: 15%;">
						产出日期
					</td>
					<td>
						<input type="text"  name="produceDate" id="produceDate" 
							class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" value="${toDay}"> 
					</td>
					<td style="width: 15%;">
						计划生产数量
					</td>
					<td>
						<input name="planCount" type="text" class="form-control" value="">
					</td>
					<td style="width:85px;">
						<button onclick="delTr(this);" type="button" class="btn btn-xs btn-danger" data-rel="tooltip" title="删除"><i class="fa fa-trash-o"></i>删除</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 公用脚本 -->
	<script type="text/javascript">
		var isClose = true;
		$(document).ready(function() {
			//按钮绑定事件
			//bindEditActions();
			validateForms();
			
			var rowData=window.parent.getRowData('${uuid}');
			$("#tipTd").html("订单数量:"+rowData.planCount+",使用现有库存:"+rowData.useStorageCount+",需生产数量:"+(rowData.planCount-rowData.useStorageCount));
			
			setValue();
			
			$("#yy-btn-cancel").bind('click', closeDialog);
			$("#yy-btn-save").bind("click", function() {
				onSave(isClose);
			});
			
			$("#addNewSub").bind("click", function() {
				var tDay=$("#formTableId tr:last").attr('dayVal');
				var nextDay="${toDay}";
				if (typeof(tDay) != "undefined"){
					nextDay = tDay;
				}else{
					
				}
				nextDay=addOneDay(nextDay);
					
				var strHtml='<tr class="objTrCls"  style="height: 40px;" dayVal="'+nextDay+'">'+
								'<td style="width: 15%;">'+
									'产出日期'+
								'</td>'+
								'<td>'+
									'<input type="text"  name="produceDate" id="produceDate" '+
										'class="form-control input-sm Wdate" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\'});"  value="'+nextDay+'">'+ 
								'</td>'+
								'<td style="width: 15%;">'+
									'订单数量'+
								'</td>'+
								'<td>'+
									'<input name="planCount" type="text" class="form-control" value="">'+
								'</td>'+
								'<td style="width:85px;">'+
									'<button onclick="delTr(this);" type="button" class="btn btn-xs btn-danger" data-rel="tooltip" title="删除"><i class="fa fa-trash-o"></i>删除</button>'+
								'</td>'+
							'</tr>';
				$("#formTableId").append(strHtml);
			});
		});

		
		//取消编辑，返回列表视图
		function closeDialog() {
			$('#yy-form-edit div.control-group').removeClass('error');
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
		
		//设置默认值
		function setValue() {
		
		}
		

		//表单校验
		function validateForms(){
			validata = $('#yy-form-edit').validate({
				onsubmit : true,
				rules : {
					'produceDate' : {required : true,maxlength : 20},
					'planCount' : {required : true,number:true,digits:true,maxlength : 10}
				}
			});
		}
		
		//校验子表
		function validOther(){
			if(validateRowsData($(".objTrCls"),getRowValidator())==false){
				return false;
			}
			else{
				return true;
			} 
			return true;
		}
		
		//表体校验
		function getRowValidator() {
			return [ {
						name : "produceDate",
						rules : {
							required :true,
							maxlength:20
						},
						message : {
							required : "必输",
							maxlength : "最大长度为20"
						}
					},{
						name : "planCount",
						rules : {
							required :true,
							digits :true,
							maxlength:20
						},
						message : {
							required : "必输",
							digits : "只能输入整数",
							maxlength : "最大长度为20"
						}
					}
			];
		}
		
		function onSave(isClose) {
			if (!validOther()) return false;
			
			var result = new Array();
			$(".objTrCls").each(function(){
				var trObj={}
				$(this).find('input, select').not('input[type="checkbox"]').each(function(){
					//trObj.push();
					if(trObj[this['name']]){
						trObj[this['name']] = trObj[this['name']]+","+this['value']; 
					}else{ 
						trObj[this['name']] = this['value']; 
					} 
				});
				result.push(trObj);
			});

			var postData={"produceList": JSON.stringify(result),"uuid":$("input[name='uuid']").val()};
			var waitInfoLoading = layer.load(2);
			$.ajax({
				type : "POST",
				data :postData,
				url : "${apiurl}/order/makePlan",
				async : true,
				xhrFields: {withCredentials: true},
		        crossDomain: true,
				dataType : "json",
				success : function(data) {
					layer.close(waitInfoLoading);
					if (data.flag==0) {
						if (isClose) {
							window.parent.YYUI.succMsg(data.msg);
							window.parent.onRefresh(true);
							closeDialog();
						} else {
							YYUI.succMsg(data.msg);
						}
					}else if (data.flag==-10) {
						YYUI.promMsg('会话超时，请重新的登录!');
						window.location = '${ctx}/logout';
					} else {
						window.parent.YYUI.failMsg(data.msg);
					}
				},
				error : function(data) {
					layer.close(waitInfoLoading);
					YYUI.promAlert(YYMsg.alertMsg('sys-submit-http',null));
				}
			});
		}
		
		function addOneDay(startDate) {
	        startDate = new Date(startDate);
	        startDate = +startDate + 1000*60*60*24;
	        startDate = new Date(startDate);
	        var hourStr=(startDate.getMonth()+1)+"";
	        if(hourStr.length==1){
	        	hourStr="0"+hourStr;
	        }
	        var secondStr=startDate.getDate()+"";
	        if(secondStr.length==1){
	        	secondStr="0"+secondStr;
	        }
	        var nextStartDate = startDate.getFullYear()+"-"+hourStr+"-"+secondStr;
	        return nextStartDate;
	    }
		
		//删除行
		function delTr(t){
			$(t).closest(".objTrCls").remove();
		}
	</script>
</body>
</html>
