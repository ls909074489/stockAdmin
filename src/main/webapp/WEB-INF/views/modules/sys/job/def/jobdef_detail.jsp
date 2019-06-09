<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
    <div class="row yy-toolbar">
        <button id="yy-btn-backtolist" class="btn blue btn-sm">
            <i class="fa fa-mail-reply"></i> 返回
        </button>
    </div>
    
    <div class="row">
        <form id="yy-form-detail"  class="form-horizontal yy-form-detail">
            <input name="uuid" type="hidden"/>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4"><label class="control-label">任务编码：</label></div>
                        <div class="col-md-8"><input class="form-control" name="jobcode"  type="text"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4"><label class="control-label">任务名称：</label></div>
                        <div class="col-md-8"><input class="form-control" name="jobname"  type="text"></div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4"><label class="control-label">任务执行类名：</label></div>
                        <div class="col-md-8"><input class="form-control" name="jobclass"  type="text"></div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4"><label class="control-label">任务实例id：</label></div>
                        <div class="col-md-8">
                        	<input type="text" class="form-control error" name="jobbeanId" aria-required="true" aria-invalid="true">           
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <div class="col-md-4"><label class="control-label">任务描述：</label></div>
                        <div class="col-md-8"><input class="form-control" name="description"  type="text"></div>
                    </div>
                </div>
            </div>
            
        </form>
    </div>
</div>