<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<div class="page-content" id="yy-page-list" style="" align="center">
		<h3>add by ls2008</h3>
		<hr>
		<input type="button" value="promMsg" onclick="YYUI.promMsg('hello world');"/>  YYUI.promMsg('hello world');
		<hr>
		<input type="button" value="promMsg" onclick="YYUI.promMsg('hello world',1000);"/>  YYUI.promMsg('hello world',1000);
		<hr>
		<input type="button" value="succMsg" onclick="YYUI.succMsg('操作成功!');"/>  YYUI.succMsg('操作成功!');
		<hr>
		<input type="button" value="failMsg" onclick="YYUI.failMsg('操作失败!');"/>  YYUI.failMsg('操作失败!');
		<hr>
		<input type="button" value="promAlert" onclick="YYUI.promAlert('操作失败!');"/>  YYUI.promAlert('操作失败!');
		<hr>
		
		YYFormUtils.lockForm('yy-form-edit');
		
		var listWaitLoad=layer.load(2);

		layer.close(listWaitLoad);
		
		
		
		layer.open({
					title:"选择接单组",
				    type: 2,
				    area: ['500px', '400px'],
				    shadeClose : false,
					shade : 0.8,
				    content: '${serviceurl}/listSendUser?complainWorkId=${entity.uuid}'
				});
				
				
		layer.confirm("xxxxxx？", function(index) {
				layer.close(index);
		});		
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			     //当切换tab时，强制重新计算列宽
			     $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
			} );
		
		////////////////////////////////////////////////////////////////////////////////////////////
		
		$.ajax({
			       url: '${serviceurl}/previewExamById',
			       type: 'post',
			       data:{'uuid':'${entity.uuid}'},
			       dataType: 'json',
			       error: function(){
			    	   layer.close(previewWaitLoad);
						YYUI.failMsg(YYMsg.alertMsg('sys-submit-http',null));
			       },
			       success: function(data){
			    	   layer.close(previewWaitLoad);
						if(data.success){
							$("#priviewFormDiv").show();
						}else{
							YYUI.failMsg("预览生成失败，请联系管理员.");
						}
			       }
			   });
</div>

	
