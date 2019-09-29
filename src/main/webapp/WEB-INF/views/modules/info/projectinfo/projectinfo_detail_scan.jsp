<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/projectinfoSub"/>
<c:set var="servicemainurl" value="${ctx}/info/projectinfo"/>
<html>
<head>
</head>
<body>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
	<div class="container-fluid page-container page-content">
		<div class="row" style="text-align: center;margin-top: 20px;">
			<label for="sweepCode" class="control-label">扫描条码</label>
			<input type="text" autocomplete="on" name="sweepCode"
				id="sweepCode" class="input-sm" style="width: 380px;">
			<button id="yy-btn-match" type="button" class="btn btn-sm btn-info">
				<i class="fa fa-search"></i> 匹配
			</button>
		</div>
		<div class="row">
			<div class="col-md-6" style="padding-left: 0px;">
				<div class="row yy-searchbar">
					<form id="yy-form-query" class="queryform">
						<input name="search_EQ_main.uuid" id="search_LIKE_mainId" type="hidden" value="${projectId}" class="yy-input"> 
						<input name="search_EQ_boxNum" id="search_EQ_boxNum" type="hidden" value="${boxNum}" class="yy-input">
					</form>
				</div>
				<div class="row">
					<table id="yy-table-list" class="yy-table">
						<thead>
							<tr>
								<th>剩余未扫物料</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="col-md-6" style="padding-left: 0px;">
				<div class="row yy-searchbar">
				</div>
				<div class="row">
					<table id="yy-table-listSelect" class="yy-table">
						<thead>
							<tr>
								<th>已扫条码</th>
							</tr>
						</thead>
						<tbody id="barcodeBodyId">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	var jsonResp = jQuery.parseJSON('${subList}');
	var _tableCols = [{
		data : 'material',
			width : "15%",
			className : "center",
			orderable : true,
			render : function (data, type, full) {
				if(full.limitCount==1){//唯一条吗
					return data.hwcode+"("+YYDataUtils.getEnumName("MaterialLimitCount", full.limitCount)+") "+full.unScanCount+data.unit;
				}else {
					return data.hwcode+"("+YYDataUtils.getEnumName("MaterialLimitCount", full.limitCount)+") ";
				}
            }
		}
	];
	
	var _tableColsSelect = [ {
	           		data : 'barcode',
	           		width : "15%",
	           		className : "center",
	           		orderable : true
	           	}
	   ];

	function onRefresh() {
		//非服务器分页
		loadList();
	}
	
	function onRefreshSelect() {
		//非服务器分页
		loadListSelect();
	}

	 //显示自定义的行按钮
	  function renderRelateUser(data, type, full) {
		 if(full.userrole=='undefined' ||full.userrole==undefined || full.userrole=="" || full.userrole==null){
			return "<div class='yy-btn-actiongroup'>" 
		        + "<button id='yy-btn-selObj-row' class='btn btn-xs btn-success' data-rel='tooltip' title='选入'>选入</button>"
				+ "</div>";
		 }else{
			 return "<div class='yy-btn-actiongroup' style='color: red;'>" 
		        + "已选"
				+ "</div>";
		 }
	  }
	  
	  //显示自定义的行按钮
	    function renderselObj(data, type, full) {
			return "<div class='yy-btn-actiongroup'>" 
			        + "<button id='yy-btn-delObj-row' class='btn btn-xs btn-success' data-rel='tooltip' title='移除'>移除</button>"
					+ "</div>";
		}
	  
	  
		function filterColumn(i) {
			$('#yy-table-list').DataTable().column(i).search(
					$('#col' + i + '_filter').val(), false, true).draw();
		}
		
		function filterColumnSel(i) {
			$('#yy-table-listSelect').DataTable().column(i).search(
					$('#col' + i + '_filter2').val(), false, true).draw();
		}
		
		
		$(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : selRowAction,
				"processing" : true,//加载时间长，显示加载中
				"paging" :false,
				"order" : []
			});
			
			_tableListSelect = $('#yy-table-listSelect').DataTable({
				"columns" : _tableColsSelect,
				"createdRow" : unSelRowAction,
				"processing" : true,//加载时间长，显示加载中
				"paging" :false,
				"order" : []
			});
			
			//$("#yy-btn-selObj-row").bind('click', selObj);//
			$("#yy-btn-search").bind('click', onRefresh);//快速查询
			$("#yy-btn-searchSelect").bind('click', onRefreshSelect);//快速查询
			
			$('input.column_filter').on('keyup click', function() {
				filterColumn($(this).parents('div').attr('data-column'));
			});
			$('input.column_filter2').on('keyup click', function() {
				filterColumnSel($(this).parents('div').attr('data-column'));
			});
			$("#yy-btn-match").bind('click', matchMaterial);//
			
			//加载数据
			loadList();
			//已选入的用户
			//loadListSelect();
		});
		
		
		//匹配物料
		function matchMaterial(){
			var t_projectId = $("#search_LIKE_mainId").val();
			if(t_projectId==null||t_projectId==''){
				YYUI.promMsg("请选择项目");
				return false;
			}
			var t_boxNum = $("#search_EQ_boxNum").val();
			if(t_boxNum==null||t_boxNum==''){
				YYUI.promMsg("请填写箱号");
				return false;
			}
			
			_ismatchSearch=true;//设置为扫描条形码查询
			
			var searchCode = "";
			var t_sweepCode = $("#sweepCode").val();
			if(t_sweepCode!=null&&t_sweepCode!=''){
				var hasMatch=false;
				if(jsonResp!=null&&jsonResp.length>0){
					for (i = 0; i < jsonResp.length; i++) {
						var t_pre = jsonResp[i].enumdatakey;
						var materialLength = parseInt(jsonResp[i].keyLength);
						console.info(t_pre+"======"+t_sweepCode.indexOf(t_pre)+">>>"+(t_pre.length+materialLength));
						if(t_sweepCode.indexOf(t_pre)==0){//以19,39...开头的
							searchCode = t_sweepCode.substring(t_pre.length,t_pre.length+materialLength);//截取位数
							console.info("searchCode>>>>>>>>>"+searchCode);
							$("#search_LIKE_materialHwCode").val(searchCode);
							hasMatch=true;
							break;
						}
					}
				}
				if(hasMatch){
					$("#search_LIKE_materialHwCode").val(t_sweepCode);
					//获取查询数据，在表格刷新的时候自动提交到后台
					//_queryData = $("#yy-form-query").serializeArray();
					//onRefresh();
					var str ='<tr role="row" class="even"><td class="center">'+t_sweepCode+'</td></tr>';
					$("#barcodeBodyId").append(str);
				}else{
					YYUI.promAlert("没有对应的物料"+searchCode);
				}
			}else{
				YYUI.promMsg("请填写条码");
			}
		}
		
		
		 //用户列表定义行点击事件
		function selRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-selObj-row', nRow).click(function() {
				selObj(aData, iDataIndex, nRow);
			});
		};
		
		//角色下的用户列表行点击事件
		function unSelRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-delObj-row', nRow).click(function() {
				delObj(aData, iDataIndex, nRow);
			});
		}
		
		function loadList(){
			var listWaitLoad=layer.load(2);
			$.ajax({
				url : '${serviceurl}/dataUnOut',
				data : $("#yy-form-query").serializeArray(),
				dataType : 'json',
				type : 'post',
				success : function(data) {
					layer.close(listWaitLoad);
					_tableList.clear();
					_tableList.rows.add(data.records);
					_tableList.draw();
				}
			});
		}
		
		function loadListSelect(){
			var listWaitLoad2=layer.load(2);
			$.ajax({
				url : '${ctx}/sys/role/dataSelRoles?selUserId=${selUserId}',
				data : $("#yy-form-querySelect").serializeArray(),
				dataType : 'json',
			    type: 'post',
				success : function(data) {
					layer.close(listWaitLoad2);
					_tableListSelect.clear();
					_tableListSelect.rows.add(data.records);
					_tableListSelect.draw();
				}
			});
		}
		//选入用户
		function selObj(aData, iDataIndex, nRow){
			$.ajax({
			       url: '${ctx}/sys/userrole/selecRoleUser',
			       type: 'post',
			       data:{'roleId':aData.uuid,'userId':'${selUserId}'},
			       dataType: 'json',
			       error: function(){
			       },
			       success: function(json){
				        if(json.success){
				        	//$(nRow).find("div.yy-btn-actiongroup").html("<span style='color: red;'>已选</span>");
				        	loadList();
				        	loadListSelect();
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }else{
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }
			       }
			});
		}
		//移除用户
		function delObj(aData, iDataIndex, nRow){
			$.ajax({
			       url: '${ctx}/sys/userrole/delRoleUser',
			       type: 'post',
			       data:{'roleId':aData.uuid,'userId':'${selUserId}'},
			       dataType: 'json',
			       error: function(){
			       },
			       success: function(json){
				        if(json.success){
				        	loadList();
				        	loadListSelect();
				        	 layer.msg(json.msg, {
				        	        time: 1000
				        	    });
				        }else{
				        	layer.msg(json.msg, {
			        	        time: 1000
			        	    });
				        }
			       }
			});
		}
		
		
	</script>
</body>
</html>
