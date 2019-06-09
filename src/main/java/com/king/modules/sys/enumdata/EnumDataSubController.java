package com.king.modules.sys.enumdata;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.frame.controller.BaseController;

/**   
* 枚举数据控制类
* @author xuechen 
* @date 2015年11月27日 下午2:38:33 
*/
@Controller
@RequestMapping(value="/sys/enumdatasub")
public class EnumDataSubController extends BaseController<EnumDataSubEntity>{
	@RequestMapping(method=RequestMethod.GET)
	public String view(){
		return "";
	} 
}
