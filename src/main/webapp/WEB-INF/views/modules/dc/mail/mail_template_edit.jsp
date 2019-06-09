<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content hide" id="yy-page-edit">
		<div class="row yy-toolbar">
			<button id="yy-btn-savemail">
				<i class="fa fa-save"></i> 保存
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
		</div>

		<div class="row">
			<form id="yy-form-edit"  class="form-horizontal yy-form-edit">
				<input name="uuid" type="hidden"/>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">关联单据</label>
								<div class="col-md-10">
									<select name="relevant_bill" class="yy-input-enumdata form-control" data-enum-group="RelevantBill"></select>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">模版编码</label>
								<div class="col-md-4"><input class="form-control" name="code"  type="text" value=""></div>
								<label class="control-label col-md-2">模版名称</label>
								<div class="col-md-4"><input class="form-control" name="name"  type="text" value="" style=""></div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">标题</label>
								<div class="col-md-10">
									<input class="form-control" name="title"  type="text" value="" style="">
								</div>
							</div>
						</div>
				</div> 
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">收件人</label>
								<div class="col-md-10">
									<!-- <input class="form-control" name="receiver"  type="text" value="" style=""> -->
									<textarea id=""  class="form-control" name="receiver"  rows="1" cols=""></textarea>
								</div>
							</div>
						</div>
				</div> 
				
				<!-- <div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">发件岗位</label>
								<div class="col-md-9"><input class="form-control" id="sendStationId" onclick="selectStation('sendStationId');" name="key"  type="text" value="" style="" readonly="readonly"></div>
								<div class="col-md-1">
									<a href="javascript:;"  onclick="selectStation('sendStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">主送岗位</label>
								<div class="col-md-9">
									<input class="form-control" id="mainStationId" onclick="selectStation('mainStationId');" name="key"  type="text" value="" style="" readonly="readonly">
								</div>
								<div class="col-md-1">
									<a href="javascript:;" onclick="selectStation('mainStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">抄送岗位</label>
								<div class="col-md-9"><input id="copyStationId" onclick="selectStation('copyStationId');" class="form-control" name="key" type="text" value="" style="" readonly="readonly"></div>
								<div class="col-md-1">
									<a href="javascript:;" onclick="selectStation('copyStationId');" class="btn btn-default btn-sm"><i class="fa fa-plus"></i>选择</a>
								</div>
							</div>
						</div>
				</div> -->
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">模版内容</label>
								<div class="col-md-10">
									<!-- <textarea  class="form-control" name="template"  rows="" cols="">请登录魅族官网，点击右上角"忘记密码"</textarea> -->
									<!--style给定宽度可以影响编辑器的最终宽度-->
									<script type="text/plain" id="myEditor" style="height:180px;" name="content">
									</script>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="control-label col-md-2">备注</label>
								<div class="col-md-10">
									<textarea id="remarkId"  class="form-control" name="remark"  rows="" cols=""></textarea>
								</div>
							</div>
						</div>
				</div>
			</form>
		</div>
</div>

<script type="text/javascript">
//实例化编辑器

//实例化编辑器，设置显示的工具栏
    $opt={toolbar:[
            'source | undo redo | bold italic underline strikethrough | forecolor backcolor |',
            'insertorderedlist insertunorderedlist ' ,
            '| justifyleft justifycenter justifyright justifyjustify |paragraph fontfamily fontsize',
            ' | fullscreen'
    ],initialFrameWidth: '100%'};
var um = UM.getEditor('myEditor',$opt);
UM.getEditor('myEditor').setWidth('98%');

</script>