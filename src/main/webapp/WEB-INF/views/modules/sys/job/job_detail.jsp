<%@ page contentType="text/html;charset=UTF-8"%>
<div class="page-content hide" id="yy-page-detail">
	<div class="row yy-toolbar">
		<button id="yy-btn-backtolist" class="btn blue btn-sm">
			<i class="fa fa-mail-reply"></i> 返回
		</button>
		<button id="yy-btn-joblog" class="btn blue btn-sm">
			<i class="fa fa-search-plus"></i> 执行情况日志
		</button>
		<button id="yy-btn-joblog-delete" class="btn red btn-sm btn-info">
			<i class="fa fa-trash-o"></i> 清空日志
		</button>
	</div>
	<div>
		<form id="yy-form-detail" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3">任务名称</label>
						<div class="col-md-9">
							<input name="jobName" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">任务分组</label>
						<div class="col-md-9">
							<select class="yy-input-enumdata form-control" id="jobGroup"                    
                             name="jobGroup" data-enum-group="jobGroup"></select>
						</div>
					</div>
				</div>
			</div>
			
			<div id= "selectCronTypeRow" class="row">
				<div class="col-md-6">
			        <div class="form-group">
			            <label class="control-label col-md-3">执行方式</label>
			            <div class="col-md-9">
							<select class="yy-input-enumdata form-control" id="cronType"                    
                             name="cronType" data-enum-group="cronExpression" onchange="selectCron(this.value);"></select>
			            </div>
			        </div>
			    </div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">任务实例ID</label>
						<div class="col-md-9">
							<input name="jobBeanId" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			
			<!-- 自定义Cron表达式 -->
			<div id="cronExpressionRow" class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">Cron表达式</label>
						<div class="col-md-9">
							<input id="cronExpression" name="cronExpression" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			
			<!-- 描述cron的日期控件 -->
			<div id="dayRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'H:mm:ss'}) ">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 日期控件 执行一次 -->
			<div id="dateRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 选择星期几 -->
			<div id="weekRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">星  期</label>
						<div class="col-md-9">
							<select class="yy-input-enumdata form-control" id="week"                    
                             name="week" data-enum-group="week"></select>
                        </div>
					</div>
				</div>
			</div>
			
			<!-- 按照年执行 -->
			<div id="yearRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">年参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'MM-dd HH:mm:ss'})">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 按照月执行 -->
			<div id="monthRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'每月 dd 号 HH:mm:ss'})">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 按照小时执行 -->
			<div id="hourRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'mm:ss'})">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 按照分钟执行 -->
			<div id="minuteRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">分钟间隔</label>
						<div class="col-md-9">
							<!-- <input class="Wdate form-control" id="cronDate" name="cronDate" onclick="WdatePicker({dateFmt:'mm'})">  --> 
							<select class="yy-input-enumdata form-control" id="cronDate"                    
                             name="cronDate">
                             <option value="1">每隔1分钟</option>
                             <option value="2">每隔5分钟</option>
                             <option value="10">每隔10分钟</option>
                             </select>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3">任务描述</label>
						<div class="col-md-9">
						    <textarea name="desc" class="limited form-control" ></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>