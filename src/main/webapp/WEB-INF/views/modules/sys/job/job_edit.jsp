<%@ page contentType="text/html;charset=UTF-8"%>

<div class="page-content hide" id="yy-page-edit">
	<div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm" >
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div>
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">任务名称</label>
						<div class="col-md-9">
							<!-- 隐藏域,表明是新增或更新,更新时候改动 -->
							<input id="addOrUpdate" name="addOrUpdate" type="hidden"/>
							<input name="jobName" type="text" placeholder="使用英文名" class="form-control" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">任务分组</label>
						<div class="col-md-9">
							 <select class="yy-input-enumdata form-control" id="jobGroup"                    
                             name="jobGroup" data-enum-group="jobGroup" ></select> 
						</div>
					</div>
				</div>
			</div>
			
			<div id= "selectCronTypeRow" class="row">
				<div class="col-md-6">
			        <div class="form-group">
			            <label class="control-label col-md-3 required">执行方式</label>
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
							<input name="jobBeanId" type="text" placeholder="Spring 注入的 Bean Id" class="form-control"/>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 自定义Cron表达式 -->
			<div id="cronExpressionRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">Cron表达式</label>
						<div class="col-md-9">
							<input id="cronExpression" name="cronExpression" placeholder="Cron表达式" type="text" class="form-control">
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
							<input class="Wdate form-control" id="dayCronDate"  onclick="WdatePicker({dateFmt:'H:mm:ss'}) ">        
						</div>
					</div>
				</div>
			</div>
			
			<!-- 日期控件  执行一次 -->
			<div id="onceDateRow" class="row" style="display:none">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">参照时间</label>
						<div class="col-md-9">
							<input class="Wdate form-control" id="onceCronDate"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">        
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
							<select class="yy-input-enumdata form-control" id="week" name="week" data-enum-group="week"></select>
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
							<input class="Wdate form-control" id="yearCronDate" onclick="WdatePicker({dateFmt:'MM-dd HH:mm:ss'})">        
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
							<input class="Wdate form-control" id="monthCronDate"  onclick="WdatePicker({dateFmt:'每月 dd 号 HH:mm:ss'})">        
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
							<input class="Wdate form-control" id="hourCronDate"  onclick="WdatePicker({dateFmt:'mm:ss'})">        
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
							 <select class="yy-input-enumdata form-control" id="minutecronDate">
                             	<option value="1">每隔1分钟</option>
                            	<option value="5">每隔5分钟</option>
                             	<option value="10">每隔10分钟</option>
                             	<option value="30">每隔30分钟</option>
                             </select>
						</div>
					</div>
				</div>
			</div>
			
			<div id="dateConstraintsRow" class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3 required">立即执行时间约束</label>
						<div class="col-md-9">
							<select class="yy-input-enumdata form-control" id="isDateConstraints"                    
                             name="isDateConstraints" data-enum-group="BooleanType" ></select>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label class="control-label col-md-3">任务描述</label>
						<div class="col-md-9">
						    <textarea name="desc" class="limited form-control"></textarea>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>





