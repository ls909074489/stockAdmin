YYFormUtils = {};
/**
 * 清空表单
 */
YYFormUtils.clearForm = function(formid) {
	$(':input', '#' + formid).not(':button, :submit, :reset, .yy-input').each(
		function() {
			if(typeof($(this).attr("class"))!='undefined'){
				if(!($(this).attr("class").indexOf("no-clear")>-1)){
					$(this).val('');
					$(this).removeAttr('checked');
					$(this).removeAttr('selected');
				}
			}else{
				$(this).val('');
				$(this).removeAttr('checked');
				$(this).removeAttr('selected');
			}
	})
};
/**
 * 清空查询区域
 */
YYFormUtils.clearQueryForm = function(formid) {
	$(':input', '#' + formid).not(':button, :submit, :reset, .yy-input').each(
			function() {
				if(typeof($(this).attr("class"))!='undefined'){
					if(!($(this).attr("class").indexOf("no-clear")>-1)){
						$(this).val('');
						$(this).removeAttr('checked');
						$(this).removeAttr('selected');
					}
				}else{
					$(this).val('');
					$(this).removeAttr('checked');
					$(this).removeAttr('selected');
				}
			})
};
/**
 * 锁定表单，使编辑框变为只读
 */
YYFormUtils.lockForm = function(formid) {
	if (formid == null) {
		$(".yy-form-edit").find("input:not([type='checkbox']),textarea").prop(
				"readonly", true);
		// $(".yy-form-edit").find("input[type='checkbox']").prop("disabled",
		// true);
		$(".yy-form-edit").find("select").prop("disabled", true);
		$(".yy-form-edit").find(".yy-btn-ref").hide();
		YYFormUtils.setCheckBox("yy-form-edit", 'view');
		YYFormUtils.setCheckBox('yy-form-detail', 'view');
	} else {
		$("#" + formid).find("input:not([type='checkbox']),textarea").prop(
				"readonly", true);
		// $("#"+formid).find("input[type='checkbox']").prop("disabled", true);
		$("#" + formid).find("select").prop("disabled", true);
		$("#" + formid).find(".yy-btn-ref").hide();
		$("#" + formid).has(".yy-input-date").removeClass("yy-input-date");
		YYFormUtils.setCheckBox(formid, 'view');
	}
	
	disableWdate();// 日期不可选 edit by liusheng
	disableRef();// 日期可选 edit by liusheng
	
	$(".required-tip").removeClass("required");// 设置在查看页面不要红色提示必填样式 edit by
												// liusheng
};

	// 如果想在查看时仍可以选择，则重写该方法，方法体可以为空即可 add by liusheng
	function disableWdate(){
		$("form[id='yy-form-edit'] .Wdate").attr("disabled","disabled");// 日期控件在查看不能选择
																		// add
																		// by
																		// liusheng
		
	}
	// 如果想在查看时仍可以选择，则重写该方法，方法体可以为空即可 add by liusheng
	function disableRef(){
		$("form[id='yy-form-edit'] .btn.btn-default.btn-ref").attr("disabled","disabled")// 参考弹出框不可选
																							// add
																							// by
																							// liusheng
	}
	
	
/**
 * 解锁表单，使编辑框变为可编辑
 */
YYFormUtils.unlockForm = function(formid) {
	if (formid == null) {
		$(".yy-form-edit").find("input:not([type='checkbox']),textarea").not(
				".yy-sys-input").prop("readonly", false);
		// $(".yy-form-edit").find("input[type='checkbox']").not(".yy-sys-input").prop("disabled",
		// false);
		$(".yy-form-edit").find("select").not(".yy-sys-input").prop(
				"disabled", false);
		$(".yy-form-edit").find(".yy-btn-ref").show();
		YYFormUtils.setCheckBox("yy-form-edit", 'edit');
	} else {
		$("#" + formid).find("input:not([type='checkbox']),textarea").not(
				".yy-sys-input").prop("readonly", false);
		// $("#"+formid).find("input[type='checkbox']").not(".yy-sys-input").prop("disabled",
		// false);
		$("#" + formid).find("select").not(".yy-sys-input").prop("disabled",
				false);
		$("#" + formid).find(".yy-btn-ref").show();
		YYFormUtils.setCheckBox(formid, 'edit');
	}
	
	enableWdate();// 日期可选 edit by liusheng
	ensableRef();// 参考可选 edit by liusheng
	
	$(".required-tip").addClass("required");// 设置在编辑页面不要红色必填的样式 edit by liusheng
};

// 如果想在查看时仍可以选择，则重写该方法，方法体可以为空即可 add by liusheng
function enableWdate(){
	$(".Wdate").attr("disabled",false);// 日期控件可选 add by liusheng
	$(".Wdate").removeAttr("disabled");// 日期控件可选 add by liusheng
}
// 如果想在查看时仍可以选择，则重写该方法，方法体可以为空即可 add by liusheng
function ensableRef(){
	$(".btn.btn-default.btn-ref").attr("disabled",false);
	$(".btn.btn-default.btn-ref").removeAttr("disabled");
}

/**
 * 设置checkbox未选中的默认值
 */
YYFormUtils.setCheckBoxNotCheckedValue = function(form, defaultValue) {
	if (typeof (defaultValue) == "undefined")
		defaultValue = "0";
	var checkbox = $("#" + form + " input:checkbox");
	checkbox.each(function(i) {
		if (this.value == null || this.value == '' || this.value == 'on'
				|| this.value == 'off') {
			if (this.checked) {
				this.value = '1';
			} else {
				this.value = defaultValue;
				this.checked = true;
			}
		}
	});
}
/**
 * 切换到编辑或者查看页面时，设置checkbox的值和样式
 */
YYFormUtils.setCheckBox = function(formId, mod) {
	var checkbox = $("#" + formId + " input:checkbox");
	checkbox.each(function(i) {
		if (this.value == "true" || this.value == "on" || this.value == 1) {
			this.checked = true;
		} else {
			this.checked = false;
		}
	});
}
