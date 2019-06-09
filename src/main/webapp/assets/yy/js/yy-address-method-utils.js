YYAddressUtils = {};
var _countrySelId='0',_provinceSelId='0',_citySelId='0',_districtSelId='0';
var isBindCouChange=false,isBindProChange=false,isBindCityChange=false,isBindDisChange=false;
//var adminArr=localStorage.getItem("yy-adminis-arr");
var t_adminArr=localStorage.getItem("yy-adminis-arr");
var adminObj = JSON.parse(t_adminArr);
var adminArr;
if(adminObj!=null&&adminObj.adminArr!=null){
	adminArr=adminObj.adminArr;
}
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

   $("#"+countrySelId).empty();
   var pId;
   if(adminArr!=null){
	   for (var i = 0; i < adminArr.length; i++) {
		   if(i==0){
			   pId='a037aaef-ca55-11e5-b7f9-5cb9018f5fb4';//adminArr[i].id;//设置国家第一个默认值
		   }
		   if(adminArr[i].id=='a037aaef-ca55-11e5-b7f9-5cb9018f5fb4'){
			   $("#"+countrySelId).append("<option value=" + adminArr[i].id + ">" + adminArr[i].name + "</option>");
		   }
	   }
   }

   //选中国家
//   if(_countrySelId!='0'){
//	   $("#"+countrySelId).val(_countrySelId);
//   }
   $("#"+countrySelId).val(countrySelId);
   
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
};

YYAddressUtils.initProvince = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	   $("#"+provinceSelId).empty();
	   $("#"+provinceSelId).append("<option value=''></option>");
	   for (var i = 0; i < adminArr.length; i++) {
		   if(adminArr[i].pid==pId){
			   $("#"+provinceSelId).append("<option value=" + adminArr[i].id + ">" + adminArr[i].name + "</option>"); 
		   }
       }
	   $("#"+provinceSelId).val(provinceSelId);
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
};

YYAddressUtils.initCity = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	   $("#"+citySelId).empty();
	   $("#"+citySelId).append("<option value=''></option>");
	   for (var i = 0; i < adminArr.length; i++) {
		   if(adminArr[i].pid==pId){
			   $("#"+citySelId).append("<option value=" + adminArr[i].id + ">" + adminArr[i].name + "</option>");
		   }
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
};


YYAddressUtils.initDistrict = function(countrySelId,provinceSelId,citySelId,districtSelId,pId) {
	   $("#"+districtSelId).empty();
	   $("#"+districtSelId).append("<option value=''></option>");
	   for (var i = 0; i < adminArr.length; i++) {
		   if(adminArr[i].pid==pId){
			   $("#"+districtSelId).append("<option value=" + adminArr[i].id + ">" + adminArr[i].name + "</option>");
		   }
       }
	   //选中市
	   if(_districtSelId!='0'){
		   $("#"+districtSelId).val(_districtSelId);
	   }
};

//获取地址名称字符串
YYAddressUtils.getAddress=function(idArr){
			var t_addressStr="";
		   if(idArr!=null){
			   for(var i=0;i<idArr.length;i++){
				   for (var j = 0; j < adminArr.length; j++) {
					   if(adminArr[j].id==idArr[i]){
						   t_addressStr+=adminArr[j].name;
						   break;
					   }
				   }
			   }
		   }
		   return t_addressStr;
};