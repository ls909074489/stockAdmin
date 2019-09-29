<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<c:set var="servicemainurl" value="${ctx}/info/projectinfo"/>
<c:set var="receiveurl" value="${ctx}/info/receive"/>
<html>
<head>
<title>条码扫描</title>
<style type="text/css">
/* #yy-table-list{
	width: 100% !important;
}
//如果遇到设有横向滚动条时，就固定设置Table宽度

#yy-table-listxxxxx{
	width: ***px !important;
}
th,td{
     white-space:nowrap;
 }
.dataTables_scrollHead { 
        		height: 39px;
 } */
</style>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="navbar-fixed-top">
				<div class="row yy-searchbar form-inline">
					<form id="yy-form-query" class="queryform">
						<label class="control-label">项目</label>
						<div class="input-group">
							<select class="combox form-control projectSelectCls" id="search_LIKE_mainId" onchange="changeProjectSel();" name="search_EQ_main.uuid" style="float: left;width: 200px;">
								<option value=""></option>
							</select>
						</div>
						<label for="search_LIKE_boxNum" class="control-label">箱号</label>
						<select class="yy-input-enumdata form-control" id="search_LIKE_boxNum" name="search_LIKE_boxNum" style="width:120px;"></select>
						
						<button id="yy-senior-btn-confirm" class="btn blue btn-sm" type="button" onclick="onConfirm();">
							<i class="glyphicon glyphicon-ok"></i> 确定
						</button>
						<button type="button" id="yy-btn-cancel" class="btn blue btn-sm" onclick="closeDialog();">
							<i class="fa fa-rotate-left"></i>取消
						</button> 
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//改变当前项目
		function changeProjectSel(){
			//onQuery();
		}

		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();
			//按回车查询
			$('#sweepCode').on('keyup', function(event){
				if(event.keyCode == "13") {
					matchMaterial();
		        }
			});
			
			//选择角色
			$('#yy-project-select').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择项目',
					shadeClose : false,
					shade : 0.8,
					area : [ '90%', '90%' ],
					content : '${ctx}/sys/ref/refProjectInfo?callBackMethod=window.parent.callBackSelectProject'//iframe的url
				});
			});
			
			$(".projectSelectCls").select2({
		        theme: "bootstrap",
		        allowClear: true,
		        placeholder: "请选择",
		        ajax:{
		            url:"${ctx}/info/projectinfo/select2Query",
		            dataType:"json",
		            delay:250,
		            data:function(params){
		                return {codeOrName: params.term};
		            },
		            cache:true,
		            processResults: function (res, params) {
		            	console.info(res);
		            	console.info(params);
		                var options = [];
		                var records = res.records;
		                for(var i= 0, len=records.length;i<len;i++){
		                    var option = {"id":records[i].uuid, "text":records[i].name+"("+records[i].code+")"};
		                    options.push(option);
		                }
		                return {
		                    results: options
		                };
		            },
		            escapeMarkup: function (markup) { return markup; },
		            minimumInputLength: 1
		        }
		    });
			
			$("#search_LIKE_boxNum").select2({
		        theme: "bootstrap",
		        allowClear: true,
		        placeholder: "请选择",
		        ajax:{
		            url:"${ctx}/info/projectinfo/select2BoxNumQuery",
		            dataType:"json",
		            delay:250,
		            data:function(params){
		                return {projectId: $("#search_LIKE_mainId").val(),"boxNum":params.term};
		            },
		            cache:true,
		            processResults: function (res, params) {
		            	var t_projectId = $("#search_LIKE_mainId").val();
		    			if(t_projectId==null||t_projectId==''){
		    				return {
			                    results: []
			                };
		    			}else{
		    				console.info(res);
			            	console.info(params);
			                var options = [];
			                var records = res.records;
			                for(var i= 0, len=records.length;i<len;i++){
			                    var option = {"id":records[i].uuid, "text":records[i].name};
			                    options.push(option);
			                }
			                return {
			                    results: options
			                };
		    			}
		            },
		            escapeMarkup: function (markup) { return markup; },
		            minimumInputLength: 1
		        }
		    });
		});
		
		
		//清空
		function onReset() {
			YYFormUtils.clearQueryForm("yy-form-query");
			$(".projectSelectCls").select2("val", " "); 
			return false;
		}
		
		function doBeforeQuery() {
			_ismatchSearch=false;
			console.info($("#search_LIKE_mainId").val()+">>>>>>>>>>>.");
			$("#projectInfoId").val($("#search_LIKE_mainId").val());
			return true;
		}
		
		
		//回调选择项目
		function callBackSelectProject(selNode){
			$("#search_LIKE_mainId").val(selNode.uuid);
			$("#search_LIKE_mainName").val(selNode.name);
		}
		
		function closeDialog(){
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
		
		function onConfirm(){
			var t_projectId = $("#search_LIKE_mainId").val();
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			var t_boxNum = $("#search_LIKE_boxNum").val();
			if(t_boxNum==null||t_boxNum==''){
				YYUI.promMsg("请填写箱号");
				return false;
			}
			window.parent.callBackToScanBarcode(t_projectId,t_boxNum);
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭 
		}
	</script>
</body>
</html>	

