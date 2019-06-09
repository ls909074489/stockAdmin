package com.king.modules.desktop;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/desktop")
public class DesktopController {

	@RequestMapping(method = RequestMethod.GET)
	public String view(Model model) {
		return "/modules/desktop/desktop";
	}

}
