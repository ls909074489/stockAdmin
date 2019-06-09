<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style type="text/css" id="yangshi"></style>


<div class="page-content" id="yy-page-list" style="" align="center">
		<div class="row yy-toolbar">
			<button id="yy-btn-add" class="btn blue btn-sm">
				<i class="fa fa-plus"></i> 新增
			</button>
			<button id="yy-btn-remove" class="btn blue btn-sm">
				<i class="fa fa-trash-o"></i> 删除
			</button>
			<button id="yy-btn-refresh" class="btn blue btn-sm">
				<i class="fa fa-refresh"></i> 刷新
			</button>
			<button id="yy-btn-export" class="btn btn-sm btn-info">
				<i class="fa fa-file-excel-o"></i> 导出
			</button>
			<button id="yy-btn-cancel" class="btn blue btn-sm btn-info">
				<i class="fa fa-rotate-left"></i> 取消
			</button>
			<button id="yy-btn-save" class="btn blue btn-sm btn-info">
				<i class="fa fa-save"></i> 保存
			</button>
		</div>
		<hr>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<div class="col-md-12">
						日期插件：<input class="Wdate" type="text" onClick="WdatePicker()">   onClick="WdatePicker()"
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<div class="col-md-12">
						带时间：<input type="text" id="d241" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
						class="Wdate" style="width:150px"/> 
						 WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<div class="col-md-12">
						时间范围：<input class="Wdate" type="text" onClick="WdatePicker({minDate:'%y-%M-%d',maxDate:'%y-%M-{%d+7}'})">
						WdatePicker({minDate:'%y-%M-%d',maxDate:'%y-%M-{%d+7}'})
					</div>
				</div>
			</div>
		</div>		
		<hr>	
		格式	说明
		%y	当前年
		%M	当前月
		%d	当前日
		%ld	本月最后一天
		%H	当前时
		%m	当前分
		%s	当前秒
		{}	运算表达式,如:{%d+1}:表示明天
		#F{}	{}之间是函数可写自定义JS代码
		<hr>
		面的日期不能大于后面的日期且两个日期都不能大于 2020-10-01
		<input id="d4311" class="Wdate" type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4312\')||\'2020-10-01\'}'})"/> 
		<input id="d4312" class="Wdate" type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'d4311\')}',maxDate:'2020-10-01'})"/>
		<hr>
		
		<hr>
		datatables参数：<br>
		不排序："ordering": false
		<hr>
		textarea表单赋值:$("textarea[name='description']").val(data.description);
		<br>
		下拉选择框复制：$("select[name='job_status']").val(data.job_status);	
		<hr>
		
		<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-3">选择业务单元</label>
						<div class="col-md-8">
							<div class="input-group input-icon right">								<i class="fa fa-remove" onclick="cleanDef('selOrgId','selOrgName');" title="清空输入"></i>
								<i class="fa fa-remove" onclick="cleanDef('selOrgId','selOrgName');" title="清空输入"></i>
								<input id="selOrgId" name="parentid" type="hidden"> 
								<input id="selOrgName" name="parentname" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-org-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-3">选择业务部门</label>
						<div class="col-md-8">
							<div class="input-group input-icon right">
								<input id="selDeptid" name="parentid" type="hidden">
								<i class="fa fa-remove" onclick="cleanDef('selOrgId','selOrgName');" title="清空输入"></i>
								<input id="selDeptName" name="parentname" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-dept-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-3">选择业务人员(树方式)</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="selPersonId" name="parentid" type="hidden"> 
								<input id="selPersonName" name="parentname" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-person-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
		</div>
		<div class="row">
			<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-3">选择业务人员(列表方式)</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="selPersonId2" name="parentid2" type="hidden"> 
								<input id="selPersonName2" name="parentname2" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="person-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label class="control-label col-md-3">督导</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="superviseId" name="superviseId" type="hidden"> 
								<input id="superviseName" name="superviseName" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="supervise-select-btn" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
			</div>
				
		</div>
		<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">角色</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="roleId" name="roleId" type="hidden"> 
								<input id="roleName" name="roleName" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-role-select" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">发货机构</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="send_corp_id" name="send_corp_id" type="hidden"> 
								<input id="send_corp_name" name="send_corp_name" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-sendcorp-select" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">检测机构</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="check_corp_id" name="check_corp_id" type="hidden"> 
								<input id="check_corp_name" name="check_corp_name" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-checkcorp-select" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">维修网点</label>
						<div class="col-md-8">
							<div class="input-group">
								<input id="repair_outlet_id" name="repair_outlet_id" type="hidden"> 
								<input id="repair_outlet_name" name="repair_outlet_name" type="text" class="form-control" readonly="readonly">
								<span class="input-group-btn">
									<button id="yy-repairoutlet-select" class="btn btn-default btn-ref" type="button">
										<span class="glyphicon glyphicon-search"></span>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">供应商</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="supplierId" name="supplierId" type="hidden"> 
							<input id="supplierName" name="supplierName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-supplier-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">仓库</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="stockId" name="stockId" type="hidden"> 
							<input id="stockName" name="stockName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-stock-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">岗位</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="postId" name="postId" type="hidden"> 
							<input id="postName" name="postName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-post-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">银行账号</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="bankaccId" name="bankaccId" type="hidden"> 
							<input id="bankaccName" name="bankaccName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-bankacc-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">故障原因</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="failurecauseId" name="failurecauseId" type="hidden"> 
							<input id="failurecauseName" name="failurecauseName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-failurecause-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-3">故障分类</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="failureclassId" name="failureclassId" type="hidden"> 
							<input id="failureclassName" name="failureclassName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-failureclass-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-2">
				<div class="form-group">
					<label class="control-label col-md-3">枚举单选</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="enumdataId" name="enumdataId" type="hidden"> 
							<input id="enumdataName" name="enumdataName" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-enumdata-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<label class="control-label col-md-3">枚举多选</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="enumdataId" name="enumdataIds" type="hidden"> 
							<input id="enumdataName" name="enumdataNames" type="text" class="form-control" readonly="readonly">
							<span class="input-group-btn">
								<button id="yy-enumdatas-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">网点列表（包括yy_org和yy_org_outlets的uuid）</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="approvalOutletsId" name="approvalOutletsId" type="hidden"> 
									<input id="approvalOutletsName" name="approvalOutletsName" type="text" class="form-control" readonly="readonly" disabled="disabled">
									<span class="input-group-btn">
										<button id="yy-approvalOutlets-select" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
			</div>
			
			<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">流程组</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="processId" name="processId" type="hidden"> 
									<input id="processName" name="processName" type="text" class="form-control" readonly="readonly" disabled="disabled">
									<span class="input-group-btn">
										<button id="yy-process-select" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
			</div>						
		</div>
		<br>
		<div class="row">
			<div class="col-md-8">
						<div class="form-group">
							<label class="control-label col-md-4">异常类型</label>
							<div class="col-md-8">
								<div class="input-group">
									<select name="firstAbnormityType" id="firstAbnormityType" style="width: 100px;">
									</select>
									<select name="secondAbnormityType" id="secondAbnormityType" style="width: 100px;">
									</select>
									<input id="secondAbnormitySpec" type="text" value="" style="width: 200px;"/>
									<span id="abnormityTypeSpecification" style="display: none;"></span>
								</div>
							</div>
						</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
						<div class="form-group">
							<label class="control-label col-md-4">用户</label>
							<div class="col-md-8">
								<div class="input-group">
									<input id="userId" name="userId" type="hidden"> 
									<input id="userName" name="userName" type="text" class="form-control" readonly="readonly" disabled="disabled">
									<span class="input-group-btn">
										<button id="yy-user-select" class="btn btn-default btn-ref" type="button">
											<span class="glyphicon glyphicon-search"></span>
										</button>
									</span>
								</div>
							</div>
						</div>
			</div>	
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">总部人员（魅族科技下的人员）</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="sales" name="sales" type="hidden"> 
							<input id="salesname" name="salesname" type="text"
							 class="form-control" readonly="readonly" disabled="disabled">
							<span class="input-group-btn">
								<button id="yy-sales-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">产品系列</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="productSeriesId" name="productSeriesId" type="hidden"> 
							<input id="productSeriesName" name="productSeriesName" type="text"
							 class="form-control" readonly="readonly" disabled="disabled">
							<span class="input-group-btn">
								<button id="yy-productseries-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>					
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">专卖店</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="zmdId" name="zmdId" type="hidden"> 
							<input id="zmdName" name="zmdName" type="text"
							 class="form-control" readonly="readonly" disabled="disabled">
							<span class="input-group-btn">
								<button id="yy-zmd-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>	
			<div class="col-md-4">
				<div class="form-group">
					<label class="control-label col-md-4">获取一级网点</label>
					<div class="col-md-8">
						<div class="input-group">
							<input id="firstOutletId" name="firstOutletId" type="hidden"> 
							<input id="firstOutletName" name="firstOutletName" type="text"
							 class="form-control" readonly="readonly" disabled="disabled">
							<span class="input-group-btn">
								<button id="yy-firstOutlet-select" class="btn btn-default btn-ref" type="button">
									<span class="glyphicon glyphicon-search"></span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>	
		</div>
		<br>
		<br>
		<hr>
		<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label class="control-label col-md-4">选择<input type="button" onclick="aa();"value="aa"/></label>
						<div class="col-md-8">
								<select id="yy-country-select" class="form-control"></select>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<div class="col-md-12">
								<select id="yy-province-select" class="form-control"></select>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<div class="col-md-12">
								<select id="yy-city-select" class="form-control"></select>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-group">
						<div class="col-md-12">
								<select id="yy-district-select" class="form-control"></select>
						</div>
					</div>
				</div>
		</div>
		<div>
			获取地址值：YYAddressUtils.getAddress(new Array('a037aaef-ca55-11e5-b7f9-5cb9018f5fb4','a03a416b-ca55-11e5-b7f9-5cb9018f5fb4','a03a4bb9-ca55-11e5-b7f9-5cb9018f5fb4','a03a4c35-ca55-11e5-b7f9-5cb9018f5fb4'));
		</div>
		<br>
		<hr>
		<form id="yy-form-edit" class="form-horizontal">
			<span style="color: red;">
				参考：<a href="http://www.runoob.com/jquery/jquery-plugin-validate.html" target="_blank">
				http://www.runoob.com/jquery/jquery-plugin-validate.html
				</a>
				<br>
				需要添加自定义的验证方法可参照：/yy-web/src/main/webapp/assets/metronic/v4.5/global/plugins/jquery-validation/js/validate-methods.js
		    	<br>)
		    	<br>
				<br>
				<pre>
					1、添加初始化
					$(document).ready(function(){
						//验证 表单
						validateForms();
					});	
					2、
					function validateForms(){
						$('#yy-form-edit').validate({
							rules : {
								      org_code : {required : true,maxlength:10,minlength:2},
								//....
							}
						}); 
					}
				</pre>
			
		    </span>
		    <br>
			<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1">必填、输入长度</label>
							<div class="col-md-2">
								<input type="text" class="form-control" name="org_code" value=""/>
							</div>
							<div class="col-md-9" style="text-align: left;">
								required:true	必须输入的字段。
								maxlength:5	输入长度最多是 5 的字符串（汉字算一个字符）。
								minlength:10	输入长度最小是 10 的字符串（汉字算一个字符）
							</div>
						</div>
					</div>
			</div>
			<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<label class="control-label col-md-1">整数</label>
							<div class="col-md-2">
								<input type="text" class="form-control" name="work_years" value=""/>
							</div>
							<div class="col-md-9" style="text-align: left;">
								digits:true
							</div>
						</div>
					</div>
			</div>
			
			<div class="row">	
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label col-md-1">邮箱</label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="email" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							email: true
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">	
					<div class="form-group">
						<label class="control-label col-md-1">信用卡号</label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="creditcard" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							creditcard: true
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">	
					<div class="form-group">
						<label class="control-label col-md-1">手机号码</label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="mobile" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isMobile:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">	
					<div class="form-group">
						<label class="control-label col-md-1">电话号码验证    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="phone" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isPhone:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">	
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label col-md-1"> 联系电话(手机/电话皆可)验证    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="tel" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isTel:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">	
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label col-md-1"> 传真    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="fax" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							fax:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">	
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label col-md-1"> QQ    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="qq" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isQq:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">	
					<div class="form-group">
						<label class="control-label col-md-1"> 邮政编码    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="zipCode" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isZipCode:true
						</div>
					</div>
				</div>
			</div>
			<div class="row">	
				<div class="col-md-12">
					<div class="form-group">
						<label class="control-label col-md-1"> 身份证号码    </label>
						<div class="col-md-2">
							<input type="text" class="form-control" name="idCardNo" value=""/>
						</div>
						<div class="col-md-9" style="text-align: left;">
							isIdCardNo:true
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
					<div class="col-md-12">
						<div class="form-group">
							<input type="submit" value="验证" class="btn blue btn-sm btn-info">
						</div>
					</div>
			</div>
		</form>
		<br>
		<hr>
</div>
	
<script type="text/javascript">

function validateForms(){
	$('#yy-form-edit').validate({
		rules : {
			org_code : {required : true,maxlength:10,minlength:2},
			email: {required : true,email:true},
			creditcard:{required : true,creditcard:true},
			work_years:{required : true,digits:true,maxlength:2},
			mobile:{required : true,isMobile:true},
			phone:{required : true,isPhone:true},
			tel:{required : true,isTel:true},
			fax:{required : true,fax:true},
			qq:{required : true,isQq:true},
			zipCode:{required : true,isZipCode:true},
			idCardNo:{required : true,isIdCardNo:true}
			
		}
	}); 
}



$(document).ready(function() {
	$('#yy-org-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择业务单元',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/selectOrg?callBackMethod=window.parent.callBackSelectOrg'//iframe的url
		});
	});
	
	$('#yy-dept-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择业务部门',
			shadeClose : false,
			shade : 0.8,
			area : [ '300px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/selectDept?pk_corp=200fad77-9a81-4842-bf34-0411141def0c'//iframe的url
		});
	});
	
	
	$('#yy-person-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择业务人员',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/selectPerson?rootSelectable=true'//iframe的url
		});
	});
	//列表显示方式
	$('#person-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择业务人员',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/listPerson?callBackMethod=window.parent.callBackSelectPersonList&orgId='//iframe的url
		});
	});
	
	$('#supervise-select-btn').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择督导',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/listHeadquarters?callBackMethod=window.parent.callBackSelectSuperviseList'//iframe的url
		});
	});
	
	//选择角色
	$('#yy-role-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择角色',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/listRole'//iframe的url
		});
	});
	
	//发货机构
	$('#yy-sendcorp-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择发货机构',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/listSendCorp?callBackMethod=window.parent.callBackSelectSendCorp&dataMethod=dataSendCorp' //iframe的url
		});
	});
	//检测机构
	$('#yy-checkcorp-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择发货机构',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${pageContext.request.contextPath}/sys/data/listSendCorp?callBackMethod=window.parent.callBackSelectCheckCorp&dataMethod=dataCheckCorp' //iframe的url
		});
	});
	//维修网点
	$('#yy-repairoutlet-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择维修网点',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/listRepairOutlet?callBackMethod=window.parent.callBackSelectRepairOutlet&dataMethod=dataCheckCorp&outletType=' //iframe的url
		});
	});
	
	
	//选择供应商
	$('#yy-supplier-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择供应商',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refSupplier' //iframe的url
		});
	});
	
	//选择仓库
	$('#yy-stock-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择仓库',
			shadeClose : false,
			shade : 0.8,
			area : [ '900px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refStock?orgId=INPUT123-e6f7-4454-b151-538358810023&stockType=LPC' //iframe的url
		});
	});
	
	//选择岗位
	$('#yy-post-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择岗位',
			shadeClose : false,
			shade : 0.8,
			area : [ '900px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refPost'//iframe的url
		});
	});
	
	//选择银行账号
	$('#yy-bankacc-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择银行账号',
			shadeClose : false,
			shade : 0.8,
			area : [ '900px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refBankacc'//iframe的url
		});
	});
	
	//选择故障原因
	$('#yy-failurecause-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择故障原因',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refFailurecause'//iframe的url
		});
	});
	
	//选择故障分类
	$('#yy-failureclass-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择故障分类',
			shadeClose : false,
			shade : 0.8,
			area : [ '300px', '90%' ],
			content : '${pageContext.request.contextPath}/bd/ref/refFailureclass'//iframe的url
		});
	});
	
	
	//枚举类型单选
	$('#yy-enumdata-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择枚举类型',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${ctx}/bd/ref/listEnumSub?callBackMethod=window.parent.callBackSelectSeries&groupcode=ProductSeries'
		});
	});
	
	//枚举类型多选
	$('#yy-enumdatas-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择枚举类型',
			shadeClose : false,
			shade : 0.8,
			area : [ '1000px', '90%' ],
			content : '${ctx}/bd/ref/listEnumSub?callBackMethod=window.parent.callBackEnumes&groupcode=RepairMethod&toPage=ref_enums_main'
		});
	});
	
	
	
	//上级审批网点
	$('#yy-approvalOutlets-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择上级审批网点',
			shadeClose : false,
			shade : 0.8,
			area : [ '800px', '90%' ],
			content : '${ctx}/bd/ref/listOutlet?callBackMethod=window.parent.callBackSelectApprovalCorp&pkCorp='+$("input[name='pk_corp']").val() //iframe的url
		});
	});
	
	//查看流程组
	$("#yy-process-select").on("click",function(){
		//type为2时则查询包括流程项
		layer.open({
			type : 2,
			title : '请选择流程组',
			shadeClose : false,
			shade : 0.8,
			area : [ '300px', '90%' ],
			content : '${ctx}/bd/ref/selProcessGroup?callBackMethod=window.parent.callBackSelectProcess&type=2' //iframe的url
		});
	});
	
	//查看用户
	$("#yy-user-select").on("click",function(){
		//type为2时则查询包括流程项
		layer.open({
			type : 2,
			title : '请选择用户',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/bd/ref/listUser?callBackMethod=window.parent.callBackSelectUser' //iframe的url
		});
	});
	
	//对应的售后专员
	$('#yy-sales-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择人员',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/sys/data/listHeadquarters?callBackMethod=window.parent.callBackSelectSales&orgId=${orgId}', //iframe的url
		});
	});
	
	//产品系列
	$('#yy-productseries-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择产品系列',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/bd/ref/listSeries?callBackMethod=window.parent.callBackSelectProductSeries', //iframe的url
		});
	});
	
	//产品系列
	$('#yy-zmd-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择专卖店',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/bd/ref/listZmd?callBackMethod=window.parent.callBackSelectZmd'//iframe的url
		});
	});
	
	//一级网点
	$('#yy-firstOutlet-select').on('click', function() {
		layer.open({
			type : 2,
			title : '请选择网点',
			shadeClose : false,
			shade : 0.8,
			area : [ '90%', '90%' ],
			content : '${ctx}/bd/ref/listCorp?callBackMethod=window.parent.callBackSelectFist&dataMethod=dataFirstOutlets' //iframe的url
		});
	});
	
	
	YYAddressUtils.setAddress('a037aaef-ca55-11e5-b7f9-5cb9018f5fb4','a03a416b-ca55-11e5-b7f9-5cb9018f5fb4','a03a4bb9-ca55-11e5-b7f9-5cb9018f5fb4','a03a4c35-ca55-11e5-b7f9-5cb9018f5fb4');
	YYAddressUtils.initAddress('yy-country-select','yy-province-select','yy-city-select','yy-district-select');
	//验证 表单
	validateForms();
	
	
	//异常类型start============
	//初始化异常类型数据
	$.ajax({
	       url: '${ctx}/bd/ref/dataSecondAbnormityType',
	       type: 'post',
	       data:{},
	       dataType: 'json',
	       error: function(){
	    	   layer.msg('获取异常类型失败', { time: 3000});
	       },
	       success: function(json){
	    	   $("#firstAbnormityType").empty();
	    	   $("#firstAbnormityType").append("<option value=''></option>");
	    	   if(json.length>0){
	    		   for(var i=0; i<json.length; i++) { 
	    			   $("#firstAbnormityType").append("<option value=" + json[i].uuid + ">" + json[i].name + "</option>");
			       }
	    	   }
	       }
	   });
	$("#firstAbnormityType").change(function(){//异常类型改变
		$("#abnormityTypeSpecification").html("");
		$("#secondAbnormitySpec").val("");
		$.ajax({
		       url: '${ctx}/bd/ref/dataAbnormityTypeByPid',
		       type: 'post',
		       data:{"parentId":$(this).val()},
		       dataType: 'json',
		       error: function(){
		    	   layer.msg('获取异常类型失败', { time: 3000});
		       },
		       success: function(json){
		    	   $("#secondAbnormityType").empty();
		    	   $("#secondAbnormityType").append("<option value=''></option>");
		    	   var tSpecification="";
		    	   if(json.length>0){
		    		   for(var i=0; i<json.length; i++) { 
		    			   $("#secondAbnormityType").append("<option value=" + json[i].uuid + ">" + json[i].name + "</option>");
		    			   tSpecification+="<span id='spec"+json[i].uuid+"'>"+json[i].specification+"</span>";
				       }
		    	   }
		    	   $("#abnormityTypeSpecification").html(tSpecification);
		       }
		   });
	});
	
	
	$("#secondAbnormityType").change(function(){
		$("#secondAbnormitySpec").val($("#spec"+$(this).val()).html());
	});

});

function aa(){
	alert(YYAddressUtils.getAddress(new Array('a037aaef-ca55-11e5-b7f9-5cb9018f5fb4','a03a416b-ca55-11e5-b7f9-5cb9018f5fb4','a03a4bb9-ca55-11e5-b7f9-5cb9018f5fb4','a03a4c35-ca55-11e5-b7f9-5cb9018f5fb4')));
	//初始值时将setAddress 放在initAddress之前
	//YYAddressUtils.setAddress('a037aaef-ca55-11e5-b7f9-5cb9018f5fb4','a03a416b-ca55-11e5-b7f9-5cb9018f5fb4','a03a4bb9-ca55-11e5-b7f9-5cb9018f5fb4','a03a4c35-ca55-11e5-b7f9-5cb9018f5fb4');
	//YYAddressUtils.initAddress('yy-country-select','yy-province-select','yy-city-select','yy-district-select');
}


//选择父节点回调函数
function callBackSelectOrg(selNode) {
	$("#selOrgId").val(selNode.uuid);
	$("#selOrgName").val(selNode.org_name);
}

//选择父节点回调函数
function callBackSelectDept(selNode) {
	//$("input[name='parentid']").val(selNode.id);
	//$("input[name='parentname']").val(selNode.name);
	$("#selDeptId").val(selNode.id);
	$("#selDeptName").val(selNode.name);
}

//列表方式选择任意
function callBackSelectPersonList(selNode){
	$("#selPersonId2").val(selNode.id);
	$("#selPersonName2").val(selNode.name);
}

//选择父节点回调函数
function callBackSelectPerson(personData) {
	$("#selPersonId").val(personData.uuid);
	$("#selPersonName").val(personData.name);
}

function callBackSelectSuperviseList(pData){
	$("#superviseId").val(pData.uuid);
	$("#superviseName").val(pData.name);
}

function callBackSelectRole(personData) {
	$("#roleId").val(personData.uuid);
	$("#roleName").val(personData.name);
}

function callBackSelectSup(supData) {
	$("#supplierId").val(supData.uuid);
	$("#supplierName").val(supData.name);
}

function callBackSelectStock(stockData) {
	$("#stockId").val(stockData.uuid);
	$("#stockName").val(stockData.name);
}

function callBackSelectPost(postData) {
	$("#postId").val(postData.uuid);
	$("#postName").val(postData.name);
}

function callBackSelectBankacc(bankData) {
	$("#bankaccId").val(bankData.uuid);
	$("#bankaccName").val(bankData.facnt_number);
}

function callBackSelectFailurecause(fcData) {
	$("#failurecauseId").val(fcData.uuid);
	$("#failurecauseName").val(fcData.causename);
}

function callBackSelectFailureclass(fcData) {
	$("#failureclassId").val(fcData.id);
	$("#failureclassName").val(fcData.name);
}

//回调检测中心
function callBackSelectSendCorp(data){
	$("#send_corp_id").val(data.uuid);
	$("#send_corp_name").val(data.org_name);
}
//回调检测中心
function callBackSelectCheckCorp(data){
	$("#check_corp_id").val(data.uuid);
	$("#check_corp_name").val(data.org_name);
}
//回调维修网点
function callBackSelectRepairOutlet(data){
	$("#repair_outlet_id").val(data.uuid);
	$("#repair_outlet_name").val(data.org_name);
}

//回调枚举
function callBackSelectSeries(data){
	$("#enumdataid").val(data.uuid);
	$("#enumdataName").val(data.enumdataname);
}


//回调选择网点
function callBackSelectApprovalCorp(data){
	$("#approvalOutletsId").val(data.outletsId);
	$("#approvalOutletsName").val(data.org_name);
}
//回调选择流程组
function callBackSelectProcess(data){
	$("#processId").val(data.id);
	$("#processName").val(data.name);
}
//回调选择用户
function callBackSelectUser(data){
	$("#userId").val(data.uuid);
	$("#userName").val(data.username);
}
//回调选择对应售后专员
function callBackSelectSales(data){
	$("#sales").val(data.uuid);
	$("#salesname").val(data.name);
}
//回调产品系列
function callBackSelectProductSeries(data){
	$("#productSeriesId").val(data.uuid);
	$("#productSeriesName").val(data.name);
}
//回调专卖店
function callBackSelectZmd(data){
	$("#zmdId").val(data.uuid);
	$("#zmdName").val(data.name);
}

//回调一级网点
function callBackSelectFist(data){
	$("#firstOutletId").val(data.id);
	$("#firstOutletName").val(data.name);
}

//回调枚举多选
function callBackEnumes(data){
	var datakey=new Array();
	var dataname=new Array();
	for(var i=0;i<data.length;i++){
		datakey.push(data[i].enumdatakey);
		dataname.push(data[i].enumdataname);
	}
	$("#enumdataIds").val(datakey.join(","));
	$("#enumdataName").val(dataname.join(","));
}
</script>