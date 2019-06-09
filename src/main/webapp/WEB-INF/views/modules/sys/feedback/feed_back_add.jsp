<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="serviceurl" value="${ctx}/sys/feedback" />
<html>
<head>
<title>意见反馈</title>
  <link href="${ctx}/assets/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="${ctx}/assets/umeditor/umeditor.min.js"></script>
  <script type="text/javascript" src="${ctx}/assets/umeditor/zh-cn.js"></script>
</head>
<body>
	<div class="page-content " id="yy-page-edit">
		<div class="row">
			<form id="yy-form-edit" class="form-horizontal yy-form-edit">
				<input name="uuid" type="hidden" />
				<div class="row">
				<table>
					<tr style="height: 40px;">
						<td style="text-align: right;width: 100px;">
							<div class="">反馈类型&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td>
							<select class="form-control" name="feedbackType">
								<option value="0">建议</option>
								<option value="1">异常</option>
								<option value="2">其他</option>
							</select>
						</td>
					</tr>
					<tr style="">
						<td style="text-align: right;">
						<div>反馈内容&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
							<td>
								<!-- <textarea name="feedbackContent" rows="" cols="" class="form-control" style="width: 300px;"></textarea> -->
								<!--style给定宽度可以影响编辑器的最终宽度-->
								
								<script type="text/plain" id="myEditor" style="width:900px;height:300px;" name="feedbackContent">
								</script>
							</td>
						</tr>
				</table>
				</div>
			</form>
			<div class="row form-actions yy-toolbar" style="margin-top: 10px;text-align: center;background-color: white;">
						<button id="yy-btn-save">
							<i class="fa fa-save"></i> 保存
						</button>
						<button id="yy-btn-cancel" class="btn blue btn-sm">
							<i class="fa fa-rotate-left"></i> 取消
						</button>
				</div>
		</div>
		<script type="text/javascript">
			//实例化编辑器
			//var um = UM.getEditor('myEditor');
	
			//实例化编辑器，设置显示的工具栏
			/* $opt={toolbar:[
			        'undo redo | bold italic underline strikethrough | forecolor backcolor |',
			        'insertorderedlist insertunorderedlist ' ,
			        '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize',
			        ' | fullscreen'
			]}; */
			
			//初始化html编辑器start
			$opt={toolbar:[
			        'undo redo | bold italic underline strikethrough | forecolor backcolor | image |',
			        'insertorderedlist insertunorderedlist ' ,
			        '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize'
			],initialFrameWidth: '100%'};//
			
			var um = UM.getEditor('myEditor',$opt);
			UM.getEditor('myEditor').setWidth('860px');
	
	
			function getContent() {
			     return UM.getEditor('myEditor').getContent();
			}
		
			$(document).ready(function() {
				$("#yy-btn-save").bind("click", function() {
					onSave(true);
				});

				$("#yy-btn-cancel").bind('click', onCancel);

				
				//验证 表单
				validateForms();
			});


			//保存，isClose 是否保存后关闭视图，否为继续增加状态
			function onSave(isClose) {
				if (!$('#yy-form-edit').valid())
					return false;
				
				var opt = {
					url : "${serviceurl}/add",
					type : "post",
					success : function(data) {
						if (data.success) {
							layer.msg("保存成功 ", {
								icon : 1
							});
							onCancel();
						} else {
							layer.alert("保存出现错误：" + data.msg)
						}
					}
				}
				$("#yy-form-edit").ajaxSubmit(opt);
			}

			//取消编辑，返回列表视图
			function onCancel() {
				var index = parent.layer.getFrameIndex(window.name);
				//先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}
			
			 //验证表单
			function validateForms(){
				$('#yy-form-edit').validate({
					rules : {
						feedbackContent : {required : true,maxlength:200,minlength:3}
					}
				}); 
			}
		</script>
	</div>
</body>
</html>