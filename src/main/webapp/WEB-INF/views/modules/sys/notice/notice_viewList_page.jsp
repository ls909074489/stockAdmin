<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<div class="page-content" id="yy-page-list">
	<div class="row">
		<table id="yy-table-list" class="yy-table">
			<thead>
				<tr>
					<!-- <th>
						<input type="checkbox" class="group-checkable" data-set="#yy-table-list .checkboxes" /></th> -->
					<th>操作</th>
					<th>所属系统</th>
					<th>标题</th>
					<!-- <th>内容</th> -->
					<th>通知分类</th>
					<th>通知状态</th>
					<th>发布人</th>
					<th>发布时间</th>
				</tr>
			</thead>
			<tbody>
				
			</tbody>
		</table>
	</div>
</div>


<script type="text/javascript">
	var _fileUploadToolView;//上传变量
	var _tableCols = [
		/* data : "uuid",
		orderable : false,
		className : "center",
		width : "5%",
		render : YYDataTableUtils.renderCheckCol
	}, { */
	{
		data : "uuid",
		className : "center",
		orderable : false,
		render: function (data,type,row,meta ) {
			return renderNoticeActionCol(data,type,row,meta);
         },
		width : "10%"
	} ,{
		data : 'system_name',
		width : "12%",
		className : "center",
		orderable : true
	}, {
		data : 'notice_title',
		width : "30%",
		orderable : true
	}/* , {
		data : 'notice_content',
		width : "20%",
		orderable : true
	} */, {
		data : 'notice_category',
		width : "8%",
		orderable : true,
		"render": function (data,type,row,meta ) {
			if(data==1){
				return "常规通知";
			}else if(data==2){
				return "重要公告";
			}else if(data==3){
				return "紧急通知";
			}
         }
	}, {
		data : 'notice_status',
		width : "8%",
		orderable : true
	}, {
		data : 'publisher',
		width : "10%",
		orderable : true
	}, {
		data : 'issue_date',
		width : "13%",
		orderable : true
	}];

	
	function renderNoticeActionCol(data, type, full) {
		return "<div class='yy-btn-actiongroup'>" 
				+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
				+ "</div>";
	}
	
	 //定义行点击事件
	function noticeRowAction(nRow, aData, iDataIndex) {
		$('#yy-btn-view-row', nRow).click(function() {
			_fileUploadToolView.loadFilsTableList(aData.uuid, "view");
			onViewDetailRow(aData, iDataIndex, nRow);
		});
	};
	
	$(document).ready(function() {
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : noticeRowAction,//YYDataTableUtils.setActions,
			"processing": true,//加载时间长，显示加载中
			//"dom" : '<"top">rt<"bottom"p><"clear">',
			"order" : []
		});

		$('input.global_filter').on( 'keyup click', function () {
	        filterGlobal();
	    } );

		//按钮绑定事件
		bindButtonActions();
		//加载数据
		loadList();
		//附件用
		_fileUploadToolView = new FileUploadTool("viewfiles","noticeEntity");
		
		_fileUploadToolView.init();
		
	});
	 function showData(data) {
		$("input[name='uuid']").val(data.uuid);	
		$("input[name='system_name']").val(data.system_name);			
		$("input[name='notice_title']").val(data.notice_title);
		$("select[name='notice_category']").val(data.notice_category);
		$("input[name='notice_status']").val(data.notice_status);			
		$("input[name='publisher']").val(data.publisher);
		$("input[name='issue_date']").val(data.issue_date);
		$("#viewContentId").html(data.notice_content);
	}
	
</script>
