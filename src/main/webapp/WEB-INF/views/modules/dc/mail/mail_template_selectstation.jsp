<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="roleId" value="${param.roleId}" />
<style>
<!--
select[multiple], select[size]{
	height: 300px;
}
-->
</style>
<script type="text/javascript" src="${ctx}/assets/yy/js/rap-selector.js?v=412412313123"></script>

<div class="container-fluid page-container page-content" style="height: 400px;">
	<div class="yy-toolbar">
		<button id="yy-btn-station-sure" class="btn blue btn-sm">
			<i class="glyphicon glyphicon-ok"></i> 确定
		</button>
	</div>
	<div class="page-area" id="yy-page-area-list">
		<div  id="dbselector_user"></div>
	</div>
</div>

<script type="text/javascript">
		var roleId = "${roleId}";
		var url1 = "${ctx}/dc/mail_template/findStation?roleId="+roleId;
		var url2 = "";
		
		$(document).ready(function() {
			var selector = new  RapSelector("dbselector_user",url1,url2,"未关联岗位","已关联岗位");
			selector.init("uuid","userName");
			//确定
		/* 	$("#ok").bind('click', function(){
				var users = selector.getSelectedValue();
				$.ajax({
					url : "${ctx}/modules/sys/userrole/assUser",
					type : "POST",
					data : {
						"roleId" : roleId, 
						"userIds" : users.toString()
					},
					dataType : "json",
					success : function(data) {
						alert("用户分配成功");
						window.parent.$.colorbox.close();
						window.parent.loadListAssUser();
						window.parent.$("#user-relation-tab").click();
					},
					error : function(msg) {
						alert("用户分配失败,失败原因： " + msg);
					}
				});
			});
			
			$("#close").bind('click',function(){
				if(window.parent.$.colorbox)
					window.parent.$.colorbox.close();
				else
					window.close();
			}); */
			
			$("#yy-btn-station-sure").bind("click", function() {
				var selIds = selector.getSelectedValue();
			    var selITexts = selector.getSelectedText();
				 window.parent.setPosition(selITexts);
				 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				 parent.layer.close(index); //再执行关闭 
			});
		});
</script>
