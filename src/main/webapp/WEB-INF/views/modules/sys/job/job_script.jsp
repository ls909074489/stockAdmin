<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	var _isServerPage = false;
	var _isNumber = true;
	var _tableCols = [
			{
				data : null,
				orderable : false,
				className : "center",
				width : "20"
			},
			{
				data : 'uuid',
				orderable : false,
				className : "center",
				width : "20",
				render : YYDataTableUtils.renderCheckCol
			},{
				data : "uuid",
				className : "center",
				orderable : false,
				render : function(data, type, full) {
					var e = "<div class='btn-group yy-btn-actiongroup'>"
							+ "<button id='yy-btn-view-row' class='btn btn-xs btn-success' data-rel='tooltip' title='查看'><i class='fa fa-search-plus'></i></button>"
							+ "<button id='yy-btn-edit-row' class='btn btn-xs btn-info' data-rel='tooltip' title='编辑'><i class='fa fa-edit'></i></button>"
							+ "<button id='yy-btn-remove-row' class='btn btn-xs btn-danger' data-rel='tooltip' title='删除'><i class='fa fa-trash-o'></i></button>"
							+ "<button id='yy-btn-run-row' class='btn btn-xs btn-info' data-rel='tooltip' title='立即执行'><i class='fa fa-bolt'></i></button>";
					//如果为正常
					if (full.jobStatus == "NORMAL") {
						e += "<button id='yy-btn-pause-resume-row' class='btn btn-xs btn-info' data-rel='tooltip' title='暂停/恢复'><i class='fa fa-pause'></i></button>"
								+ "</div>";
					} else {
						e += "<button id='yy-btn-pause-resume-row' class='btn btn-xs btn-info' data-rel='tooltip' title='暂停/恢复'><i class='fa fa-play'></i></button>"
								+ "</div>";
					}
					return e;
				},
				width : "70"
			},{
				data : 'jobName',
				width : "60",
				className : "center",
				orderable : true
			}, {
				data : 'jobGroup',
				className : "center",
				width : "50",
				orderable : true,
				render : function(data, type, full) {
					return YYDataUtils.getEnumName("jobGroup", data);
				}
			},{
				data : 'cronType',
				className : "center",
				width : "50",
				orderable : true,
				render : function(data, type, full) {
				       return YYDataUtils.getEnumName("cronExpression", data);
				}
			}, {
				data : 'cronExpression',
				width : "80",
				orderable : true
			}, {
				data : 'jobBeanId',
				className : "center",
				width : "60",
				orderable : true
			}, {
				data : 'jobStatus',
				className : "center",
				width : "40",
				orderable : true
			}, {
				data : 'desc',
				width : "100",
				render : function(data, type, full) {
					if (data != null && data != '') {
						//如果显示不全就用 ... 
						if (data.length > 30) {
							return data.substring(0, 20) + " ...";
						} else {
							return data;
						}
					} else {
						return '';
					}
				}
			} ];

	// 表单验证 validate
	function validateForms() {
		$('#yy-form-edit').validate({
			rules : {
				jobName : {
					required : true,
					maxlength : 50
				},
				jobGroup : {
					required : true
				},
				jobBeanId : {
					required : true,
					maxlength : 50
				},
				cronType : {
					required : true
				},
				cronDate : {
					required : true
				}
			}
		});
	}

	//列表工具栏  重写 新增
	function onAdd() {
		onAddBefore();
		YYFormUtils.clearForm('yy-form-edit');
		YYUI.setEditMode();
		$("#cronExpressionRow").hide();
		$("#selectCronTypeRow").show();
		$("#addOrUpdate").val(1);//新增为1
		onAddAfter();
	}

	//暂停/恢复
	function onPauseOrResumeRow(aData, iDataIndex, nRow) {
		//var btn = $(nRow).find('#yy-btn-pause-resume-row');
		if (aData.jobStatus == "NORMAL") {
			//processJob('${serviceurl}/pauseJob','暂停',aData.uuid);
			//<!-- btn.html("<i class='fa fa-play'></i>"); -->
			layer.confirm('确实要暂停吗？', function() {
				ajaxProcess('${serviceurl}/pauseJob', '暂停', aData.uuid);
				loadList(null, _isNumber);
				bindButtonActions();//按钮绑定事件
			});
		} else {
			//processJob('${serviceurl}/resumeJob','恢复',aData.uuid);
			//<!-- btn.html("<i class='fa fa-pause'></i>"); -->
			layer.confirm('确实要恢复吗？', function() {
				ajaxProcess('${serviceurl}/resumeJob', '恢复', aData.uuid);
				loadList(null, _isNumber);
				bindButtonActions();//按钮绑定事件
			});
		}
	}

	// 立即执行
	function onRunNowRow(aData, iDataIndex, nRow) {

		//先判断是否有时间约束
		if (aData.isDateConstraints == 0) {
			run(aData.uuid);

		} else {
			//弹出对话框
			url = '${serviceurl}/setRunParam?jobId=' + aData.uuid; //+'&callBackMethod=window.parent.callBack'
			layer.open({
				title : '立即执行(' + aData.jobName + ')',
				type : 2,
				area : [ '28%', '35%' ],
				fix : false, //不固定
				content : url
			});
		}
	}

	//编辑
	function onEditRow(aData, iDataIndex, nRow) {
		YYFormUtils.clearForm('yy-table-list');
		showData(aData);
		YYUI.setEditMode();
		$("select[name='jobGroup']").attr("readonly", "readonly")
		$("input[name='jobName']").attr("readonly", "readonly");
		$("input[name='jobBeanId']").attr("readonly", "readonly");
		$("#addOrUpdate").val(0);//修改为0
	}

	//查看
	function onViewDetailRow(aData, iDataIndex, nRow) {
		YYFormUtils.clearForm('yy-form-detail');
		showData(aData);
		$("#cronExpressionRow").show();
		$("#selectCronTypeRow").show();
		YYUI.setDetailMode();
	}

	// 重写 showDate方法
	function showData(data) {
		$("input[name='uuid']").val(data.uuid);
		$("input[name='jobName']").val(data.jobName);
		$("select[name='jobGroup']").val(data.jobGroup);
		$("input[name='cronExpression']").val(data.cronExpression);
		$("input[name='jobBeanId']").val(data.jobBeanId);
		$("textarea[name='desc']").val(data.desc);
		$("select[name='isDateConstraints']").val(data.isDateConstraints);
		var cronType = data.cronType;//按照那种时间执行
		$("select[name='cronType']").val(cronType);
		selectCron(cronType);//隐藏对应的文本框,赋值 cronDate
		$("input[name='cronDate']").val(data.cronDate);//赋值进去cronDate 日期

		if (data.cronType == 'minute') {
			$("#minutecronDate").val(data.cronDate);
		}
	}

	// 重写列表按钮
	YYDataTableUtils.setActions = function(nRow, aData, iDataIndex) {
		$(nRow).dblclick(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-view-row', nRow).click(function() {
			onViewDetailRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-edit-row', nRow).click(function() {
			onEditRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-remove-row', nRow).click(function() {
			onRemoveRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-download-row', nRow).click(function() {
			onDownloadRow(aData, iDataIndex, nRow);
		});

		$('#yy-btn-gen-row', nRow).click(function() {
			onYyBtnGenRow(aData, iDataIndex, nRow);
		});

		//暂停/恢复
		$('#yy-btn-pause-resume-row', nRow).click(function() {
			onPauseOrResumeRow(aData, iDataIndex, nRow);
		});

		//立即执行
		$('#yy-btn-run-row', nRow).click(function() {
			onRunNowRow(aData, iDataIndex, nRow);
		});
	};

	//选择cron表达式
	function selectCron(val) {
		$("#onceDateRow").hide();
		$("#weekRow").hide();
		$("#yearRow").hide();
		$("#dayRow").hide();
		$("#cronExpressionRow").hide();
		$("#minuteRow").hide();
		$("#hourRow").hide();
		$("#monthRow").hide();

		$("#yearCronDate").removeAttr("name");
		$("#dayCronDate").removeAttr("name");
		$("#monthCronDate").removeAttr("name");
		$("#yearCronDate").removeAttr("name");
		$("#onceCronDate").removeAttr("name");
		$("#hourCronDate").removeAttr("name");
		$("#minutecronDate").removeAttr("name");

		//自定义
		if (val == "custom") {
			$("#cronExpressionRow").show();
		} else if (val == "day") { // 天    
			$("#dayRow").show();
			$("#dayCronDate").attr("name", "cronDate");
		} else if (val == "week") { // 星期
			$("#weekRow").show();
			$("#dayRow").show();
			$("#dayCronDate").attr("name", "cronDate");
		} else if (val == "month") { // 月
			$("#monthRow").show();
			$("#monthCronDate").attr("name", "cronDate");
		} else if (val == "year") { // 年
			$("#yearRow").show();
			$("#yearCronDate").attr("name", "cronDate");
		} else if (val == "once") {
			$("#onceDateRow").show();
			$("#onceCronDate").attr("name", "cronDate");
		} else if (val == "hour") {
			$("#hourRow").show();
			$("#hourCronDate").attr("name", "cronDate");
		} else if (val == "minute") {
			$("#minuteRow").show();
			$("#minutecronDate").attr("name", "cronDate");
		}
	}

	
	/**
	 * 删除记录 url 后台删除的url pks 主键数组 fnCallback 成功后回调函数
	 */
	function deleteJobLog() {
		var jobname = $("input[name='jobName']").val();
		var url = '${ctx}/job/log/deleteJobLog';
		
		//确定要删除吗？
		layer.confirm('确定要清空该任务的日志吗？', function() {
			$.ajax({
				"dataType" : "json",
				"type" : "POST",
				"url" : url,
				"data" : {
					"jobname" : jobname
				},
				"success" : function(data) {
					if (data.success) {
						YYUI.succMsg('清空成功');
					} else {
						YYUI.failMsg('清空失败' + data.msg);//删除失败，原因：
					}
				},
				"error" : function(XMLHttpRequest, textStatus, errorThrown) {
					YYUI.failMsg('清空失败');//"删除失败，HTTP错误。"
				}
			});
		});
	};
	
	function showJobLog() {
		var jobname = $("input[name='jobName']").val();
		layer.open({
			type : 2,
			title : '单据',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/job/log/showJobLog?jobname=' + jobname //iframe的url
		});
	}
	
	//页面加载函数
	$(document).ready(function() {
		table = $('#yy-table-list');
		_tableList = $('#yy-table-list').DataTable({
			"columns" : _tableCols,
			"createdRow" : YYDataTableUtils.setActions,
			"processing" : true,//加载时间长，显示加载中
			"order" : []
		});
		loadList(null, _isNumber);
		bindButtonActions();//按钮绑定事件
		
		$('#yy-btn-joblog').click(function() {
			showJobLog();
		});
		
		$('#yy-btn-joblog-delete').click(function() {
			deleteJobLog();
		});
		
		validateForms();
	});
</script>






