<%@ page contentType="text/html;charset=UTF-8"%>
 <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%> 
<div id="yy-page-edit" class="page-content">
	<!-- <div class="row yy-toolbar">
		<button id="yy-btn-save" class="btn blue btn-sm">
			<i class="fa fa-save"></i> 保存
		</button>
		<button id="yy-btn-cancel" class="btn blue btn-sm">
			<i class="fa fa-rotate-left"></i> 取消
		</button>
	</div> -->
	<div>
		<form id="yy-form-edit" class="form-horizontal yy-form-edit">
			<input name="uuid" type="hidden">
			
				<!-- <div class="row">
				
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">单据号</label>
						<div class="col-md-8">
							<input name="billcode" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">业务日期</label>
						<div class="col-md-8">
							<input name="billdate" type="text" class="form-control date-picker">
						</div>
					</div>
				</div>
			
			
				
			
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">快递单号</label>
						<div class="col-md-8">
							<input name="expressnumber" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">快递公司</label>
						<div class="col-md-8">
							<input name="expresscorp" type="text" class="form-control">
						</div>
					</div>
				</div>
				
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">收件人</label>
						<div class="col-md-8">
							<input name="receiver" type="text" class="form-control">
						</div>
					</div>
				</div>
			</div> -->
			
			<div class="row" style="margin-left:-38px;">
			<div class="col-md-10">
					<div class="form-group">
						<label class="control-label col-md-2">收货地址</label>
						<div class="col-md-10 ">
						
							<select class="yy-input-enumdata form-control"  id="country" style="width:70px;float:left;"
									name="country"  data-enum-group="" >
									<option selected="selected" value="">国家</option></select>
									<select class="yy-input-enumdata form-control"  id="province" style="width:70px;float:left;"
									name="province" data-enum-group="">
									<option selected="selected" value="">省份</option></select>
									<select class="yy-input-enumdata form-control"  id="usertype"
									name="city" data-enum-group="" style="width:70px;float:left;">
									<option selected="selected" value="">城市</option></select>
									<select class="yy-input-enumdata form-control"  id="usertype"
									name="area" data-enum-group="" style="width:70px;float:left;">
									<option selected="selected" value="">区域</option></select>
									
								<input name="address" type="text"  placeholder="详细地址" style="float:left;" class="form-control input-large">
								
						</div>
					</div>
				</div>
				
			</div> 
			<!-- <div class="row">
			
				
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">收件人电话</label>
						<div class="col-md-8">
							<input name="receiverphone" type="text" class="form-control">
						</div>
					</div>
				</div>
				
			
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">寄件人</label>
						<div class="col-md-8">
							<input name="sender" type="text" class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">寄件人电话</label>
						<div class="col-md-8">
							<input name="senderphone" type="text" class="form-control">
						</div>
					</div>
				</div>
				
			
			</div>
			<div class="row">
			<div class="col-md-8">
					<div class="form-group">
						<label class="control-label col-md-2">备注</label>
						<div class="col-md-10">
							<textarea name="memo" class="form-control"></textarea>
						</div>
					</div>
				</div>
			</div> -->
			
			<div class="row">
			<div class="col-md-1 hos"  style="cursor:pointer;"><i class="fa fa-caret-right"></i>系统信息</div>
			<div class="col-md-11" style="margin-left:-30px;margin-top:-12px;"><hr/></div>
			</div>
			<div class="parent">
			 <div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">创建人</label>
						<div class="col-md-8">
							<input name="creater" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">制单部门</label>
						<div class="col-md-8">
							<input name="vmakedept" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">创建时间</label>
						<div class="col-md-8">
							<input name="createdtime" type="text" class="form-control date-picker" disabled>
						</div>
					</div>
				</div>
			</div> 
			 <div class="row">
				
				
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">修改人</label>
						<div class="col-md-8">
							<input name="modify" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
			
			
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">修改时间</label>
						<div class="col-md-8">
							<input name="modifytime" type="text" class="form-control date-picker" disabled>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-4">单据状态</label>
						<div class="col-md-8">
							<input name="billstatus" type="text" class="form-control" disabled>
						</div>
					</div>
				</div>
				</div> 
				</div>
				
		</form>
	<!-- 公用脚本 -->
		<%@include file="/WEB-INF/views/common/commonscript.jsp"%>
	</div>
	<script type="text/javascript">
	
	//这些js代码不需要加上，已写在功能脚本中
	
	$(document).ready(function() {
		//loadList();
	bindButtonActions();	
		
	
	
	 });
	</script>
</div>