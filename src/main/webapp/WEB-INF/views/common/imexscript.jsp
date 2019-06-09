<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
	//确定导入
	function confirmImport(){
		if($("#fileName").val()==null || $("#fileName").val()==""){
			YYUI.promAlert("请选择导入文件");
			return;
		}
		var importview = layer.load(2);
		var url = "${pageContext.request.contextPath}/sys/imexlate/conport";
		 $.ajaxFileUpload({
	            url: url, 
	            type: 'post',
	            fileElementId: 'file', // 上传文件的id、name属性名
	            success: function(data,status){
	            	var result = eval("("+data.activeElement.innerText+ ")");  
	            	if(result.success){
	            		layer.close(importview);
	            		/* var value = $("#imexsc").val();
	            		if(value!=null){
	            			determineimporToo(result.msg)
	            		}else{ */
	            			determineimport(result.msg);
	            		/* } */
					}else{
						layer.close(importview);
						$("#fileName").val("");
						YYUI.promAlert(result.msg);
					}
	            },
	        });
	}
	$(document).ready(function() {
		$("#yy-import-btn-confirm").bind('click', confirmImport);//确定导入
		$("#im-uploadfile-btu").bind('click', onimport);//导入
		$("#yy-btn-export").bind('click', exportFile);//选择导出
		$("#yy-btn-export-query").bind('click', exportQueryFile);//查询导出 ls208
		/* $("#yy-btn-next-step").bind('click', nextStep);//下一步
		$("#yy-btn-pre-step").bind('click', preStep);//上一步 */
		$("#yy-btn-findfile").bind('click', onfindfileFile);
		
	});
	
	//选择文件后
	function onQueryFile(){
		var fileName = this.files[0].name;
		var prefix = fileName.substring(fileName.lastIndexOf('.')+1,fileName.length);
		if(prefix == "xls" || prefix == "xlsx"){
			$("#fileName").val(this.files[0].name);
		}else{
			YYUI.failMsg("文件格式不正确,您可以下载导入模板");
		}
	}
	//点击浏览
	function onfindfileFile(){
		$("#file").click();
	}
	/* function  nextStep(){
		$("#imexlate-first-step").addClass("imexlate-step-hide");
		$("#imexlate-second-step-hide").removeClass("imexlate-step-hide");
		$("#imexclate-button-next").addClass("imexlate-step-hide");
		$("#imexclate-button-pre").removeClass("imexlate-step-hide");
	}
	function  preStep(){
		$("#imexlate-second-step-hide").addClass("imexlate-step-hide");
		$("#imexlate-first-step").removeClass("imexlate-step-hide");
		$("#imexclate-button-pre").addClass("imexlate-step-hide");
		$("#imexclate-button-next").removeClass("imexlate-step-hide");
	} */
	//进入导入页面
	function  onimport(){
		$("#file").bind('change', onQueryFile);
		$("#im-modal-content").css("left",($("#im-uploadfile").width()-$("#im-modal-content").width())/2);
		$("#im-modal-content").css("top",($("#im-uploadfile").height()-$("#im-modal-content").height())/2);
		
	}
	//导出
	function exportFile(){
		var pks = YYDataTableUtils.getSelectPks();
		if(pks==""){
			YYUI.failMsg("请选择导出数据");
			return;
		}
		doBeforeExport();
		var Data = {
				"pks" : pks,
				 "coding" : "${imexCoding}"
			};
		$.ajax({
			url : "${serviceurl}/export",
			data : Data, 
			type : "post",
			success : function(data) {
				exportUpload(data,null);
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				window.parent.YYUI.promAlert("导出失败，HTTP错误。");
			}
		});
	}
	
	//导出查询结果 ls2008
	function exportQueryFile(){
		 doBeforeExport();
		 var exportQueryFileWaitLoad=layer.load(2);
		 var searchformData=$("#"+$(this).attr("queryformId")).serialize();
		/* var Data = {
				"pks" : pks,
				 "coding" : "${imexCoding}" 
			}; */
		$.ajax({
			url : "${serviceurl}/exportQuery",
			data : searchformData, 
			type : "post",
			success : function(data) {
				layer.close(exportQueryFileWaitLoad);
				if(data.success){
					exportUpload(data.msg,null);
				}else{
					YYUI.promAlert(data.msg);
				}
				
			},
			error:function(data){
				layer.close(exportQueryFileWaitLoad);
			}
		});
	}
	
	/*下载模板*/
	function downloadtemplate(coding){
		var Data = {
				//"filePath" : path,
				 "coding" : "${imexCoding}" 
			}; 
		$.ajax({
			url : '${ctx}/sys/imexlate/uploadTem',
			data : Data, 
			async : false,
			success : function(data) {
				if(data.success){
					var exportFileName = data.records[0].exportFileName;
					var path = rewriteFile(data.msg,exportFileName);
					exportUpload(path,data.records.exportFileName);
				}else{
					YYUI.failMsg("下载模板错误：" + data.msg)
				}
			}, 
		});
	}
	/*用于重写*/
	function rewriteFile(path,exportFileName){
		return path;
	}
	function exportUpload(filePath,filename){
		var url = "${ctx}/sys/imexlate/fileUpload";
		var form = $("<form id='excelForm'>");// 定义一个form表单
		form.attr('style', 'display:none');// 在form表单中添加查询参数
		form.attr('target', '');
		form.attr('method', 'post');
		form.attr('action', url);
		var input1 = $('<input name="filePath">');
		input1.attr('type', 'hidden');
		input1.attr('value',filePath);
		form.append(input1);
		var input2 = $('<input name="security">');
		input2.attr('type', 'hidden');
		if(filename==null){
			input2.attr('value',"${security}");
		}else{
			input2.attr('value',filename);
		}
		form.append(input2);
		$('body').append(form); // 将表单放置在web中
		form.submit();
		
		//document.body.removeChild(form); //这句代码不知道有什么作用
	}

	 //导入
	 function determineimport(path){
		 var Data = {
					"filePath" : path,
					 "coding" : "${imexCoding}" 
				};
		  $.ajax({
				url : '${serviceurl}/import',
				data : Data, 
				async : false,
				type : 'POST',
				success : function(data) {
					if(data.success ){
						if(data.msg=="0"){
							YYUI.failMsg("导入失败：")
							$("#fileName").val("");
							$("#yy-import-btn-close").click();
							doBeforeRefresh();
						}else{
							YYUI.succMsg("导入成功! 共导入：" + data.msg + "条数据");
							$("#fileName").val("");
							$("#yy-import-btn-close").click();
							doBeforeRefresh();
						}
					}else {
						//YYUI.promAlert('导入失败!');
						YYUI.failMsg("导入出现错误：" + data.msg)
						$("#fileName").val("");
						$("#yy-import-btn-close").click();
						doBeforeRefresh();
					}
				}, 
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					$("#fileName").val("");
					window.parent.YYUI.promAlert("导入失败，HTTP错误。");
					layer.close(editview);
				}
			}); 
	 }
	 /*用于导入后重写*/
	function doBeforeRefresh(){
		
	}
</script>
