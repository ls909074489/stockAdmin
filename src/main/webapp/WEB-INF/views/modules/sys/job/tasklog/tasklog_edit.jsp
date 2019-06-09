<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="../job_script_common.jsp"%>
<div class="hide" id="yy-page-edit">
    <div class="row yy-toolbar">
        <button id="yy-btn-save" class="btn blue btn-sm">
            <i class="fa fa-save"></i> 保存
        </button>
        
        <!--  重新执行 -->
		<div class='btn-group' role='group'>
		    <button type='button' class='btn btn-default dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>
		                 重新执行
		        <span class='caret'></span>
		    </button>
		    <ul class='dropdown-menu'>
		        <li><a href='#' onclick="processJobLog('${serviceurl}/resumeData','执行数据')">只执行数据</a></li>
		        <li><a href='#' onclick="processJobLog('${serviceurl}/resumeRequest','执行数据')">重新调用接口</a></li>
		    </ul>
		</div> 
        <button id="yy-btn-cancel" class="btn blue btn-sm">
            <i class="fa fa-rotate-left"></i> 取消
        </button>
    </div>

    <div class="row">
        <form id="yy-form-edit" class="form-horizontal yy-form-edit">
            <input id="uuid" name="uuid" type="hidden"/>

            <!-- 第一行 -->
            <div class="row">
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">接口地址</label>
                            <div class="col-md-9">
                                <input name="interfaceurl" type="text" readonly="readonly" class="limited form-control">
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">接口描述</label>
                            <div class="col-md-9">
                                <input name="description" type="text" readonly="readonly" class="limited form-control">
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>

            <!-- 第二行 -->
            <div class="row">
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">执行时间</label>
                            <div class="col-md-9">
                                <input class="Wdate form-control" name="createtime" type="text"
                                       onclick=" WdatePicker();" readonly="readonly">
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">是否成功</label>
                            <div class="col-md-9">
                                <select class="yy-input-enumdata form-control" id="result" readonly="readonly"
                                        name="result" data-enum-group="timedResult"></select>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
            
		    <!-- 第二行 -->
            <div class="row">
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">同步开始时间</label>
                            <div class="col-md-9">
                                <input class="form-control" name="starttime" type="text" readonly="readonly">
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-md-6">
                    <fieldset disabled="disabled">
                        <div class="form-group">
                            <label class="control-label col-md-3">同步结束时间</label>
                            <div class="col-md-9">
                               <input class="form-control" name="endtime" type="text" readonly="readonly">
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
            
            <!-- 第 行 --style="display:none"-->
		    <div id="causeRow" class="row">
		        <div class="col-md-6">
		            <fieldset disabled="disabled">
		                <div class="form-group">
		                    <label class="control-label col-md-3">失败原因</label>
		                    <div class="col-md-9">
		                        <!-- <input name="cause" type="text" readonly="readonly" class="limited form-control">  -->
		                    	<textarea name="cause" class="limited form-control" readonly="readonly" style="width:551px;height:82px;"></textarea>
		                    </div>
		                </div>
		            </fieldset>
		        </div>
		    </div>
		  

            <!-- 第 行 -->
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="control-label col-md-3">返回内容</label>
                        <div class="col-md-9">
                            <textarea id="content" name="content" class="limited form-control" style="margin: 0px; height: 650px; width: 750px;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            
        </form>
    </div>
</div>













