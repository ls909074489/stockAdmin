YYAddressUtils = {};
var _countrySelId='0',_provinceSelId='0',_citySelId='0',_districtSelId='0';
var isBindCouChange=false,isBindProChange=false,isBindCityChange=false,isBindDisChange=false;

YYAddressUtils.setAddress = function(countrySelId,provinceSelId,citySelId,districtSelId) {
	if(countrySelId!=null&&countrySelId!=''&&typeof(countrySelId) != "undefined"){
		_countrySelId=countrySelId;
	}else{
		_countrySelId='0';
	}
	if(provinceSelId!=null&&provinceSelId!=''&&typeof(provinceSelId) != "undefined"){
		_provinceSelId=provinceSelId;
	}else{
		_provinceSelId='0';
	}
	if(citySelId!=null&&citySelId!=''&&typeof(citySelId) != "undefined"){
		_citySelId=citySelId;
	}else{
		citySelId='0';
	}
	if(districtSelId!=null&&districtSelId!=''&&typeof(districtSelId) != "undefined"){
		_districtSelId=districtSelId;
	}else{
		_districtSelId='0';
	}
};

YYAddressUtils.initAddress = function(countrySelId,provinceSelId,citySelId,districtSelId) {
   $("#"+provinceSelId).empty();
   $("#"+citySelId).empty();
   $("#"+districtSelId).empty();
	$.ajax({
	       url: projectPath+"/sys/data/dataCountry",
	       type: 'post',
	       data:{'pId':0},//'roleId':getRoleId()
	       dataType: 'json',
	       error: function(){
	    	   layer.msg('获取数据失败', {
	    	        time: 3000
	    	    });
	       },
	       success: function(json){
	    	   $("#"+countrySelId).empty();
	    	   var pId;
	    	   //$("#"+countrySelId).append("<option value=''>-请选择-</option>");
	    	   for (var i = 0; i < json.length; i++) {
	    		   if(i==0){
	    			   pId=json[i].id;//设置国家第一个默认值
	    		   }
                   $("#"+countrySelId).append("<option value=" + json[i].id + ">" + json[i].name + "</option>");
               }
	    	   //选中国家
	    	   if(_countrySelId!='0'){
	    		   $("#"+countrySelId).val(_countrySelId);
	    	   }
	    	   
	    	   //初始化省
	    	   YYAddressUtils.initProvince(countrySelId,provinceSelId,citySelId,districtSelId,pId);
	    	 
	    	   if(!isBindCouChange){
	    		   isBindCouChange=true;
	    		 //绑定onchange方法
		    	   $("#"+countrySelId).change(function(){
		    		   $("#"+provinceSelId).empty();
		    		   $("#"+citySelId).empty();
		    		   $("#"+districtSelId).empty();
		    		   YYAddressUtils.initProvince(countrySelId,provinceSelId,citySelId,districtSelId,$(this).val());
		    	   });
	    	   }
	       }
	   });
};

YYAddressUtils.initProvince = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	$.ajax({
	       url: projectPath+"/sys/data/dataProvince",
	       type: 'post',
	       data:{'pId':pId},
	       dataType: 'json',
	       error: function(){
	    	   layer.msg('获取数据失败', {
	    	        time: 3000
	    	    });
	       },
	       success: function(json){
	    	   $("#"+provinceSelId).empty();
	    	   $("#"+provinceSelId).append("<option value=''></option>");
	    	   for (var i = 0; i < json.length; i++) {
                   $("#"+provinceSelId).append("<option value=" + json[i].id + ">" + json[i].name + "</option>");
               }
	    	   //选中省
	    	   if(_provinceSelId!='0'){
	    		   $("#"+provinceSelId).val(_provinceSelId);
	    		   //初始化省
		    	   YYAddressUtils.initCity(countrySelId,provinceSelId,citySelId,districtSelId,_provinceSelId);
	    	   }
	    	   
	    	   if(!isBindProChange){
	    		   isBindProChange=true;
	    		   //绑定onchange方法
		    	   $("#"+provinceSelId).change(function(){
		    		   $("#"+citySelId).empty();
		    		   $("#"+districtSelId).empty();
		    		   _citySelId='0';
		    		   _districtSelId='0';
		    		   YYAddressUtils.initCity(countrySelId,provinceSelId,citySelId,districtSelId,$(this).val());
		    	   });
	    	   }
	       }
	   });
};

YYAddressUtils.initCity = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	$.ajax({
	       url: projectPath+"/sys/data/dataCity",
	       type: 'post',
	       data:{'pId':pId},
	       dataType: 'json',
	       error: function(){
	    	   layer.msg('获取数据失败', {
	    	        time: 3000
	    	    });
	       },
	       success: function(json){
	    	   $("#"+citySelId).empty();
	    	   $("#"+citySelId).append("<option value=''></option>");
	    	   for (var i = 0; i < json.length; i++) {
                   $("#"+citySelId).append("<option value=" + json[i].id + ">" + json[i].name + "</option>");
               }
	    	   //选中市
	    	   if(_citySelId!='0'){
	    		   $("#"+citySelId).val(_citySelId);
	    		   //初始化区
		    	   YYAddressUtils.initDistrict(countrySelId,provinceSelId,citySelId,districtSelId,_citySelId);
	    	   }
	    	
	    	   if(!isBindCityChange){
	    		   isBindCityChange=true;
	    		   //绑定onchange方法
		    	   $("#"+citySelId).change(function(){
		    		   $("#"+districtSelId).empty();
		    		   _districtSelId='0';
		    		   YYAddressUtils.initDistrict(countrySelId,provinceSelId,citySelId,districtSelId,$(this).val());
		    	   });
	    	   }
	       }
	   });
};


YYAddressUtils.initDistrict = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	$.ajax({
	       url: projectPath+"/sys/data/dataDistrict",
	       type: 'post',
	       data:{'pId':pId},
	       dataType: 'json',
	       error: function(){
	    	   layer.msg('获取数据失败', {
	    	        time: 3000
	    	    });
	       },
	       success: function(json){
	    	   $("#"+districtSelId).empty();
	    	   $("#"+districtSelId).append("<option value=''></option>");
	    	   for (var i = 0; i < json.length; i++) {
                   $("#"+districtSelId).append("<option value=" + json[i].id + ">" + json[i].name + "</option>");
               }
	    	   //选中市
	    	   if(_districtSelId!='0'){
	    		   $("#"+districtSelId).val(_districtSelId);
	    	   }
	       }
	   });
};


