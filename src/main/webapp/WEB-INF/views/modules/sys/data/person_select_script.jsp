<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _raplayout,_queryData;
	var _tableListAssUser,_tableListAssUserView;//角色下的用户列表
	var _tableCols = [{
		data : "uuid",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderActionCol(data,type,row,meta);
         },
		width : "10%"
	}, {
		data : 'name',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'job_number',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'post',
		width : "10%",
		className : "center",
		orderable : false,
		"render": function (data,type,row,meta ) {
			return renderPostCol(data,type,row,meta);
        }
	}, {
		data : 'mobile_phone',
		width : "15%",
		className : "center",
		orderable : false
	}, {
		data : 'email',
		width : "15%",
		className : "center",
		orderable : false
	}];

	function onRefresh() {
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
	
	 $(document).ready(function() {
			_tableList = $('#yy-table-list').DataTable({
				"columns" : _tableCols,
				"createdRow" : renderRowAction,
				//"dom" : '<"top">rt<"bottom"iflp><"clear">',
				"order": [] 
			});
			
			$('input.global_filter').on('keyup click', function() {
				filterGlobal();
			});
			$('input.column_filter').on('keyup click', function() {
				filterColumn($(this).parents('div').attr('data-column'));
			});

			//设置布局
			_raplayout=setBodyLayout();
			
			//加载数据
			
			$("#yy-btn-add").bind('click', onAdd);//新增
			
			//$('#yy-btn-remove').bind('click', onRemove);//删除
			//$("#yy-btn-edit").bind('click', onEditDetail);//编辑
			
			$("#yy-btn-save").bind("click", function() {//点击保存角色按钮
				onSave(true);
			});
			$("#yy-btn-search").bind('click', onQuery);//查询
			$('#yy-btn-cancel').bind('click', onCancel);//编辑页面返回
			
			$('#yy-btn-backtolist').bind('click', onCancel);//查看页面返回
			
			
			
			$('#yy-relation-user').on('click', function() {
				layer.open({
					type : 2,
					title : '请选择系统账号',
					shadeClose : false,
					shade : 0.8,
					area : [ '800px', '90%' ],
					content : '${ctx}${serviceurl}/selectUser', //iframe的url
				});
			});
			
		});
	 
	 //选择用户后
	 function callBackSelectUser(data){
		 $("#relation_user_id").val(data.uuid);
		 $("#relation_user_loginname").val(data.loginname);
	 }
	 
	 //定义行点击事件
	function renderRowAction(nRow, aData, iDataIndex) {
		$('#yy-btn-selPerson-row', nRow).click(function() {
			onSelPerson(aData, iDataIndex, nRow);
		});
	
	};
	 
	 //显示自定义的行按钮
	  function renderActionCol(data, type, full) {
			return "<div class='yy-btn-actiongroup'>" 
					+'<button id="yy-btn-selPerson-row" class="btn btn-xs btn-success" data-rel="tooltip" title="选入">选入</button>'
					+ "</div>";
		}
		
	//岗位
	function renderPostCol(data, type, full) {
			 if(data!=null&&data.name!=null){
				 return data.name;
			 }
			return "";
	}
	
	 function onSelPerson(aData, iDataIndex, nRow){
		window.parent.callBackSelectPerson(aData);
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭 
	 }
	 
	// zTree 当前选择的节点
	function getSelectedTreeId() {
		var treeId;
		var nodes = _zTree.getSelectedNodes();
		if (nodes.length > 0) {
			treeId = nodes[0].id;
		}
		return treeId;
	}
	
	// _tableList: 表格对象， roleGroupId: 当前用户组ID
	function loadList() {
		_queryData= $("#yy-form-query").serializeArray();
		$.ajax({
			type : 'post',
			url : '${ctx}${serviceurl}/dataPersonByDeptId',
			dataType : 'json',
			data : _queryData,
			success : function(data) {
				_tableList.clear();
				_tableList.rows.add(data.records);
				_tableList.draw();
			}
		});
	}
	
	
	 
	 function onQuery(){
		 var deptId = $("#search_departmentId").val();
			if(deptId==null||deptId.length==0){
				layer.alert("请选择部门");
				return false;
			}
			//获取查询数据，在表格刷新的时候自动提交到后台
			_queryData = $("#yy-form-query").serializeArray();
			loadList();
	 }
	 
	 
</script>
