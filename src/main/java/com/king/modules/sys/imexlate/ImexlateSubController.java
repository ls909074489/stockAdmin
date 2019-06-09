package com.king.modules.sys.imexlate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.frame.controller.BaseController;

/**
 * 导入子表controller
 * 
 * @ClassName: ImplateSubController
 * @author
 * @date 2016年59月10日 07:19:05
 */
@Controller
@RequestMapping(value = "/sys/implateSub")
public class ImexlateSubController extends BaseController<ImexlateSubEntity> {

	/**
	 * 
	 * @Title: 导入子表 @author @date 2016年59月10日 07:19:05 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "";
	}

}
