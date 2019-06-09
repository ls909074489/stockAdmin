<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _tableCols = [{
		data : "uuid",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderActionCol(data,type,row,meta);
         },
		width : "20"
	},{
		data : 'rolegroup.rolegroup_name',
		width : "40%",
		className : "center",
		orderable : false
	}, {
		data : 'name',
		width : "60%",
		className : "center",
		orderable : false
	} ];

	function onRefresh() {
		//非服务器分页
		loadList();
	}

	function filterGlobal() {
		$('#yy-table-list').DataTable().search($('#global_filter').val(),
				$('#global_regex').prop('checked'),
				$('#global_smart').prop('checked')).draw();
	}

	function filterColumn(i) {
		$('#yy-table-list').DataTable().column(i).search(
				$('#col' + i + '_filter').val(), false, true).draw();
	}

	 //显示自定义的行按钮
	  function renderActionCol(data, type, full) {
		 if(full.urUuid!=null&&full.urUuid!=''){
				return "<div class='yy-btn-actiongroup'>" 
				+'<button id="yy-btn-unSelRole-row" class="btn btn-xs btn-success" data-rel="tooltip" title="移除">移除</button>'
				+ "</div>";
		 }else{
				return "<div class='yy-btn-actiongroup'>" 
				+'<button id="yy-btn-selRole-row" class="btn btn-xs btn-success" data-rel="tooltip" title="选入">选入</button>'
				+ "</div>";
		 }
       }
	  //定义行点击事件
	   function renderRowAction(nRow, aData, iDataIndex) {
			$('#yy-btn-selRole-row', nRow).click(function() {
				onSelRole(aData, iDataIndex, nRow);
			});
			
			$('#yy-btn-unSelRole-row', nRow).click(function() {
				onUnSelRole(aData, iDataIndex, nRow);
			});
			
		};
		
		function onUnSelRole(aData, iDataIndex, nRow){
			var _method='${callBackMethod}';
			if(_method){
				//window.parent._method(aData);
	        	eval(_method+"(aData)"); 
			}else{
				window.parent.callBackUnRole(aData);
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
		 }	
		
		function updateUserRole(aData){
			var t_url='${ctx}/sys/userrole/selecRoleUser';
			if(aData.urUuid!=null&&aData.urUuid!=''){
				t_url='${ctx}/sys/userrole/delRoleUser';
			}
			$("#selUrRoleId").val(aData.uuid);
			//var waitLoad=layer.load(2);
			$.ajax({
			       url: t_url,
			       type: 'post',
			       //async: false,
			       data:{'roleId':aData.uuid,'userId':'${selUserId}'},
			       dataType: 'json',
			       error: function(json){
			    	   //layer.close(waitLoad);
			    	   YYUI.failMsg('操作失败!');
			       },
			       success: function(json){
			    	   if(json.success){
			    		   //layer.close(waitLoad);
			    		   YYUI.succMsg('操作成功!');
				    	   loadList();
			    	   }else{
			    		   //layer.close(waitLoad);
			    		   YYUI.failMsg(json.msg);
			    	   }
			       }
			   });
		}
		
		function onSelRole(aData, iDataIndex, nRow){
			var _method='${callBackMethod}';
			if(_method){
				//window.parent._method(aData);
	        	eval(_method+"(aData)"); 
			}else{
				window.parent.callBackSelectRole(aData);
				//注意该处关闭弹框不能放在外面
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭     
			}
		 }	
	
	
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : renderRowAction,
			"processing" : true,//加载时间长，显示加载中
			"order" : []
		});

		$('input.global_filter').on('keyup click', function() {
			filterGlobal();
		});

		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();

	});
	
	
	function loadList(){
		$.ajax({
			url : '${ctx}/sys/data/dataRoleList',
			data : {
				'selUserId' : '${selUserId}'
			},
			dataType : 'json',
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
			}
		});
	}
</script>
