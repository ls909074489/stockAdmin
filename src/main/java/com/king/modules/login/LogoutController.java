package com.king.modules.login;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，
 * 
 * 真正登录的POST请求由Filter完成,
 * 
 */
@Controller
@RequestMapping(value = "/logout")
public class LogoutController {

	@RequestMapping(method = RequestMethod.GET)
	public String view(Model model) {
		// return "redirect:/";
		Subject subject = SecurityUtils.getSubject();
		subject.logout();
		return "admin";
	}
}
