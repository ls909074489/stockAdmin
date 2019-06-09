<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>

<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>

	<div class="row">
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden" />
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">文本</label>
						<div class="col-md-8">
							<div class="input-icon right">
								<i class="fa"></i> <input name="texts" type="text"
									class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">数字</label>
						<div class="col-md-8">
							<div class="input-icon left">
								<i class="fa"></i> <input class="form-control " name="numbers"
									type="text" style="text-align: right;">
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">整数</label>
						<div class="col-md-8">
							<input class="form-control" name="integers" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">文本</label>
						<div class="col-md-8">
							<div class="input-icon right">
								<i class="fa"></i> <input name="texts" type="text1"
									class="form-control">
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">数字</label>
						<div class="col-md-8">
							<!-- <div class="input-icon right">
								<i class="fa"></i> -->
							<input class="form-control " name="numbers1" type="text"
								style="text-align: right;">
							<!-- </div> -->
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">整数</label>
						<div class="col-md-8">
							<input class="form-control" name="integers1" type="text">
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">枚举</label>
						<div class="col-md-8">
							<select class="yy-input-enumdata form-control" id="enumerates"
								name="enumerates" data-enum-group="enumerates"></select>
						</div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">日期</label>
						<div class="col-md-8">
							<!-- <input class="form-control date-picker" name="dates" type="text"> -->
							<input class="Wdate form-control" name="dates" type="text"
								onclick=" WdatePicker();">
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">描述</label>
						<div class="col-md-10">
							<input class="form-control" name="longtexts" type="text">
						</div>
					</div>
				</div>
			</div>

		</form>
		<!-- 附件上传 -->
		<tags:OssUploadTable id="uploadFiles" />
	</div>
</div>


<script type="text/javascript">
	function saveFile() {
		//附件用
		_fileUploadTool.saveFiles('${param.indexGroupId }', "callbackUpload");
	}

	//上传之后需要回调的方法，也就是你上传之后需要执行的方法
	function fnCallback(data) {
		console.info(data);
		alert(11);
	}
</script>