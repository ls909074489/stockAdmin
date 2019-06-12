<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/info/device" />
<html>
<head>
<title>设备信息</title>
</head>
<body>
	<div id="yy-page" class="container-fluid page-container">
		<div class="page-content" id="yy-page-list">
			<div class="row yy-toolbar">
				<button id="yy-btn-add" class="btn blue btn-sm">
					<i class="fa fa-plus"></i> 新增
				</button>
				<button id="yy-btn-remove" class="btn red btn-sm">
					<i class="fa fa-trash-o"></i> 删除
				</button>
				<button id="yy-btn-refresh" class="btn blue btn-sm">
					<i class="fa fa-refresh"></i> 刷新
				</button>
			</div>
			<div class="row yy-searchbar form-inline">
				<form id="yy-form-query">
					<label for="search_EQ_tid" class="control-label">设备类型</label>
					<select class="yy-input-enumdata form-control"
						id="search_EQ_tid" name="search_EQ_tid"
						data-enum-group="DeviceType"></select>

					<label for="search_LIKE_name" class="control-label">名称
					</label> <input type="text" autocomplete="on" name="search_LIKE_name"
						id="search_LIKE_name" class="form-control input-sm">

					<button id="yy-btn-search" type="button"
						class="btn btn-sm btn-info">
						<i class="fa fa-search"></i>查询
					</button>
					<button id="rap-searchbar-reset" type="reset" class="red">
						<i class="fa fa-undo"></i> 清空
					</button>
				</form>
			</div>
			<div class="row">
				<table id="yy-table-list" class="yy-table">
					<thead>
						<tr>
							<th style="width: 30px;">序号</th>
							<th class="table-checkbox">
								<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" />
							</th>
							<th>操作</th>
							<th>设备类型</th>
							<th>名称</th>
							<th>间隔</th>
							<th>生产厂商</th>
							<th>设备状态</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 公用脚本 -->
	<%@include file="/WEB-INF/views/common/listscript.jsp"%>
	<c:choose>
		<c:when test="${hasSelStation eq 0}">
			<script type="text/javascript">
				layer.open({
					title:"请选择",
				    type: 2,
				    area: ['500px', '250px'],
				    shadeClose : false,
					shade : 0.8,
					closeBtn : 0,
				    content: '${ctx}/sys/org/toChangeStation'
				});
			</script>
		</c:when>
	</c:choose>
	
	<script type="text/javascript">
		//回到选择当前的厂商纷纷
		function callSelectSessionStation(data){
			onRefresh();
		}
	
		_isNumber = true;
		var _tableCols = [ {
			data : null,
			orderable : false,
			className : "center",
			width : "50"
		}, {
			data : "uuid",
			orderable : false,
			className : "center",
			className : "center",
			/* visible : false, */
			width : "40",
			render : YYDataTableUtils.renderCheckCol
		}, {
			data : "uuid",
			className : "center",
			orderable : false,
			render : YYDataTableUtils.renderActionCol,
			width : "50"
		},{
			data : "tid",
			width : "10%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("DeviceType", data);
			}
		},{
			data : 'name',
			width : "25%",
			className : "left",
			orderable : true,
			render : function(data, type, full) {
			       if(data!=null){
			    	   if(full.station!=null){
			    		   return '<span title="'+full.station.name+'">'+data+'</span>';
			    	   }else{
			    		   return data;
			    	   }
			       }else{
			    	   return "";
			       }
			}
		},{
			data : "interval",
			width : "10%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				if(data!=null){
					return data.name;
				}else{
					return "";
				}
			}
		},{
			data : "supplier",
			width : "20%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
				if(data!=null){
					return data.name;
				}else{
					return "";
				}
			}
		},{
			data : "deviceStatus",
			width : "10%",
			className : "center",
			orderable : true,
			render : function(data, type, full) {
			       return YYDataUtils.getEnumName("DeviceStatus", data);
			}
		}];

		//var _setOrder = [[5,'desc']];

		$(document).ready(function() {
			_queryData = $("#yy-form-query").serializeArray();

			bindListActions();
			serverPage('${serviceurl}/querySationDevice');
		});

	</script>
</body>
</html>