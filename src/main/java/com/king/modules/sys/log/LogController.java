package com.king.modules.sys.log;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.frame.controller.BaseController;

@Controller
@RequestMapping(value = "/sys/log")
public class LogController extends BaseController<LogEntity> {
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/log/log_main";
	}

	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public String page() {

		return "modules/sys/log/log_main_page";
	}

}
