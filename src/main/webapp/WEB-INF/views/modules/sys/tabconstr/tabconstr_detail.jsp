<%@ page contentType="text/html;charset=UTF-8"%>
<div class="hide" id="yy-page-detail">
	<div class="row yy-toolbar">
		<button id="yy-btn-backtolist" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 返回
		</button>
	</div>
	<div>
		<form id="yy-form-detail" class="form-horizontal yy-form-detail">
			<!-- 主表_s -->
			<input name="uuid" type="hidden" />
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">数据库名</label>
						<div class="col-md-8">
							<input class="form-control" name="constraintSchema" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">表名</label>
						<div class="col-md-8">
							<input class="form-control" name="tableName" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">表描述</label>
						<div class="col-md-8">
							<input class="form-control" name="tableNameDes" type="text">
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">外键名</label>
						<div class="col-md-8">
							<input class="form-control" name="constraintName" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">外键字段</label>
						<div class="col-md-8">
							<input class="form-control" name="columnName" type="text">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4 required">外键字段描述</label>
						<div class="col-md-8">
							<input class="form-control" name="columnNameDes" type="text">
						</div>
					</div>
				</div>
			</div>
			<fieldset>
			    <legend>参考表信息</legend>
			   	<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">参考表</label>
							<div class="col-md-8">
								<input class="form-control" name="referencedTableName" type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">参考表描述</label>
							<div class="col-md-8">
								<input class="form-control" name="referencedTableDes" type="text">
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">参考字段</label>
							<div class="col-md-8">
								<input class="form-control" name="referencedColumnName" type="text">
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4 required">参考字段描述</label>
							<div class="col-md-8">
								<input class="form-control" name="referencedColumnDes" type="text">
							</div>
						</div>
					</div>
				</div>
		  </fieldset>

			<!-- 主表_e -->

			<!-- 系统信息_s -->
			<%@include file="/WEB-INF/views/common/sys/sys_info.jsp"%>
			<!-- 系统信息_e -->
		</form>
	</div>
</div>