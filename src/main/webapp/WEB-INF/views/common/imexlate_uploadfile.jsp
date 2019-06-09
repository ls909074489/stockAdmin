<%@ page contentType="text/html;charset=UTF-8"%>
<div class="modal fade" id="im-uploadfile" tabindex="-1" >
	<!-- <div class="modal-dialog"> -->
	<div class="modal-content" id="im-modal-content">
		<div class="imexlate-header">
			<button type="button" class="close" style="margin-top:5px;" data-dismiss="modal" aria-hidden="true">qwqwqw</button>
			<h4 class="senior-modal-title"><i class="fa fa-chevron-down"></i>导入</h4>
		</div>
		<div class="modal-body" id="imexlate-modal-body">
			<div id="imexlate-step-div">
				<div class="imexlate-step-title">导入${security}<br/><br/></div>
				<div id="imexlate-first-step">
					<div class="imexlate-text">
						1.下载模版 &nbsp;&nbsp;>&nbsp;&nbsp; 2.导入Excel&nbsp;&nbsp;>&nbsp;&nbsp; 3.导入完毕<br/><br/>
							温馨提示：<br/><br/>
							导入模板的格式不能修改，录入方法请参考演示模板。<br/><br/>
						<!-- <a href="javascript:downloadtemplate();">下载导入模板</a><br/> -->
						<div id="imexlate-text-upload">
							<div class="imexlate-text-input" id="imexlate-text-input-span"><span id="imexlate-text-input-text">请选择要导入文件：</span></div>
							<div class="imexlate-text-input"><input type="text" id="fileName" class="imexlate-fileName" readonly="readonly"/></div>
							<div class="imexlate-text-input" style="margin-left:5px;"> 
							
								<button id="yy-btn-findfile" class="btn green btn-sm">
									<i class="fa fa-file-o"></i>&nbsp;浏览
								</button>
							</div>
						</div>
						<div class="hide">
							<form id="yy-import-file" >
								<input type="file" id="file" name="file" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="is-modal-footer" >
			<div id="imexclate-button-pre">
				<a href="javascript:downloadtemplate();">下载导入模板</a>
				<button id="yy-import-btn-confirm" class="btn yellow btn-sm btn-info is-modal-btn" >
					 导&nbsp;&nbsp;&nbsp;&nbsp;入
				</button>
			</div>
			<div class="hide">
				<button type="button" id="yy-import-btn-close" data-dismiss="modal" ></button>
			</div>
		</div>
	</div>
</div>