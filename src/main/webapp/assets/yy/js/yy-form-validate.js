YYFormValidate = {};
//錯誤
YYFormValidate.errorPlacement = function(e, r) {
	$(r).closest(".form-group").removeClass("has-success").addClass("has-error");
};
//出错时触发
YYFormValidate.highlight = function(e) {
	
};
//通过验证时触发
YYFormValidate.unhighlight = function(e) {
	
};
//正確
YYFormValidate.success = function(e, r) {
     $(r).closest(".form-group").removeClass("has-error");
};
YYFormValidate.cancelValidate=function(){
	$('#yy-form-edit .form-control.error').removeClass('error');
	$('#yy-form-edit label.error').remove();
};