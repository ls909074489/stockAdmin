var YYUI= {};
var pageLayout;

YYUI.setUIDefault = function() {
	YYUI.setEditor();
	YYUI.setStyle();
	YYUI.setUIAction("yy-table-list");
	YYUI.setUIAction("yy-table-sublist");
}

YYUI.setEditor = function() {
	YYUI.setEnumField();
	//YYUI.setEnumTextField();
}

YYUI.setUIAction = function(tableID) {
	var table = jQuery('#'+tableID);
	table.find('.group-checkable').change(function () {
	    var set = jQuery(this).attr("data-set");
	    var checked = jQuery(this).is(":checked");
	    jQuery(set).each(function () {
	        if (checked) {
	            $(this).prop("checked", true);
	            $(this).parents('tr').addClass("active");
	        } else {
	            $(this).prop("checked", false);
	            $(this).parents('tr').removeClass("active");
	        }
	    });
	    //jQuery.uniform.update(set);
	});

	table.on('change', 'tbody tr .checkboxes', function () {
	    $(this).parents('tr').toggleClass("active");
	});
}

/**
 * 设置枚举数据列表 applyObj适用范围，不设表示整个页面
 */
YYUI.setEnumField = function(applyObj) {
	var map = YYDataUtils.getEnumMap();
	var selectArray = new Array();
	if(applyObj==null){
		selectArray = $("select.yy-input-enumdata");
	}else{
		selectArray = $("select.yy-input-enumdata",applyObj);
	}
	$(selectArray).each(function() {
		var grpcode = $(this).attr("data-enum-group");
		var grpvalue = $(this).attr("data-enum-value");
		if($(this).find('option').length == 0){
			var select = "<option value=''>&nbsp;</option>";
			
			var enumdatas = map[grpcode];
			if(enumdatas){
				if(grpvalue!=null && grpvalue!=''){
					for (i = 0; i < enumdatas.length; i++) {
						if(grpvalue.indexOf(enumdatas[i].enumdatakey) > -1 ){
							select = select + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
						}
					}
				}else{
					for (i = 0; i < enumdatas.length; i++) {
						select = select + "<option value='" + enumdatas[i].enumdatakey + "'>" + enumdatas[i].enumdataname + "</option>";
					}
				}
				
			}
			$(this).append(select);
		}
	});
	
	//键值一样 start========edit by liusheng=========================
	var selectArray2 = new Array();
	if(applyObj==null){
		selectArray2 = $("select.yy-input-enumdata-kv");
	}else{
		selectArray2 = $("select.yy-input-enumdata-kv",applyObj);
	}
	$(selectArray2).each(function() {
		var grpcode = $(this).attr("data-enum-group");
		if($(this).find('option').length == 0){
			var select = "<option value=''>&nbsp;</option>";
			var enumdatas = map[grpcode];
			if(enumdatas){
				for (i = 0; i < enumdatas.length; i++) {
					select = select + "<option value='" + enumdatas[i].enumdataname + "'>" + enumdatas[i].enumdataname + "</option>";
				}
			}
			$(this).append(select);
		}
	});
	//键值一样 end=============edit by liusheng====================
}

YYUI.setStyle = function() {
	$(".yy-toolbar button").addClass("btn btn-sm btn-info");
	$(".yy-searchbar button").addClass("btn btn-sm btn-info");
	$(".yy-table").addClass("table table-striped table-bordered table-hover");
	$(".yy-table-x").addClass("table-striped table-bordered table-hover");

	//$("textarea,select").addClass("form-control");
	//$("input:not(:radio)").not(".rap-table-checkbox").not(".group-checkable").addClass("form-control");
	/*
	$("td.rap-td-checkbox-label").bind("click",function(){
		var checkbox = $(this).next("td").find("input[type='checkbox']")[0];
		if(checkbox.checked)
			checkbox.checked=false;
		else
			checkbox.checked=true;
	});
	*/
	//设置checkbox样式
	/*
	$("input[type='checkbox']").not(".make-switch").each(function(){
		alert(123);
		if(!$(this).next().hasClass('lbl')){
			$(this).after('<span class="lbl"></span>');
		}
		if(!$(this).parent().is("label")){
			var label = document.createElement("label");
			var parent = $(this).parent();
			var span = $(this).next()[0];
			$(label).prependTo(parent);
			$(label).append(this);
			$(label).append(span);
		}
	});
	*/
}

/**
 * 切换到编辑视图
 */
YYUI.setEditMode= function() {
	//viewMode = this.VIEW_MODE_EDIT;
	/*$('#yy-page-area-list').hide();
	$('#yy-page-area-detail').hide();
	$('#yy-page-area-edit').show();*/
	
	if(!$('#yy-page-list').hasClass("hide")){
		$('#yy-page-list').addClass("hide");
	}
	if(!$('#yy-page-detail').hasClass("hide")){
		$('#yy-page-detail').addClass("hide");
	}
	if($('#yy-page-edit').hasClass("hide")){
		$('#yy-page-edit').removeClass("hide");
	}
	if($('#yy-page-sublist').hasClass("hide")){
		$('#yy-page-sublist').removeClass("hide");
	}
	if(pageLayout){
		pageLayout.hide("west");
	}
	
	YYFormUtils.unlockForm();
}

/**
 * 为视图设置布局
 * 
 * @returns
 */
this.setBodyLayout = function() {
	pageLayout = $("body").layout({
		applyDefaultStyles : true,
		west : {
			size : 250
		}
	});
	return pageLayout;
}

this.getPageLayout = function(){
	return pageLayout;
}
/**
 * 切换到列表视图
 */
YYUI.setListMode= function() {
	//viewMode = this.VIEW_MODE_LIST;
	/*$('#yy-page-area-list').show();
	$('#yy-page-area-detail').hide();
	$('#yy-page-area-edit').hide();*/
	
	if($('#yy-page-list').hasClass("hide")){
		$('#yy-page-list').removeClass("hide");
	}
	if(!$('#yy-page-edit').hasClass("hide")){
		$('#yy-page-edit').addClass("hide");
	}
	if(!$('#yy-page-detail').hasClass("hide")){
		$('#yy-page-detail').addClass("hide");
	}
	if(!$('#yy-page-sublist').hasClass("hide")){
		$('#yy-page-sublist').addClass("hide");
	}
	
	if(pageLayout){
		pageLayout.show("west");
	}
	
	YYFormUtils.lockForm();
	YYFormUtils.lockForm('yy-form-detail');
}

/**
 *  切换到查看视图
 */
YYUI.setDetailMode = function() {
	/*viewMode = this.VIEW_MODE_DETAIL;*/
	/*$('#rap-page-area-list').hide();
	$('#rap-page-area-detail').show();
	$('#rap-page-area-edit').hide();*/
	
	if(!$('#yy-page-list').hasClass("hide")){
		$('#yy-page-list').addClass("hide");
	}
	if(!$('#yy-page-edit').hasClass("hide")){
		$('#yy-page-edit').addClass("hide");
	}
	if($('#yy-page-detail').hasClass("hide")){
		$('#yy-page-detail').removeClass("hide");
	}
	if($('#yy-page-sublist').hasClass("hide")){
		$('#yy-page-sublist').removeClass("hide");
	}
	if(pageLayout){
		pageLayout.hide("west");
	}
	
	YYFormUtils.lockForm();
	YYFormUtils.lockForm('yy-form-detail');
}


/*
 * 成功，正确的提示信息
 * content 提示内容
 */
YYUI.succMsg=function(content){
	layer.msg(content, {icon: 1});
}
/*
 * 失败，错误的提示信息
 * content 提示内容
 */
YYUI.failMsg=function(content){
	layer.msg(content, {icon: 2});
}
/*
 * 阻止，帮助的提示信息
 * content 提示内容
 */
YYUI.promMsg=function(content){
	layer.msg(content, {icon: 0});
}

/*
 * 提示框，并设置弹出时间
 */
YYUI.promMsg=function(content,time){
	 layer.msg(content, {
		 icon: 0,time: time
	    });
}
/**
 * alert提示框
 */
YYUI.promAlert=function(content,time){
	 layer.alert(content, {
		 icon: 0,time: time
	    });
}
