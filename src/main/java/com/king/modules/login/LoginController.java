package com.king.modules.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.MD5;
import com.king.common.utils.RandomUtil;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.user.UserEntity;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，
 * 
 * 真正登录的POST请求由Filter完成,
 * 
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@RequestMapping(method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest request) {
		return view(model, request);
	}

	@RequestMapping(method = RequestMethod.POST)
	public String fail(Model model, HttpServletRequest request,
			@RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName) {
		// model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, userName);

		// 如果登录失败从request中获取认证异常信息，shrioLoginFailure就是shiro异常类的全限定名
		String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");

		// 根据shrio返回的异常路径判断，抛出指定异常信息
		if (exceptionClassName != null) {
			// 未知账号
			/*if ("ValidateCodeError".equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "滑动验证失败，请重试");
			} else*/ if ("RetryLimitException".equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "您的账号被锁定，请与管理员联系！"); // 找不到用户名
			} else if (LockedAccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "您的账号被锁定，请与管理员联系！");
			} else if (DisabledAccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "您的账号被锁定，请与管理员联系！");
			} else if (AccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "用户名或密码错误"); // 由于帐户问题而抛出的异常
			} else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "用户名或密码错误"); // 尝试使用与实际不匹配的凭据(s)进行身份验证时抛出
			} else if (AuthenticationException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "用户名或密码错误"); // 在身份验证过程中出现错误而抛出的一般异常
			} else if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
				model.addAttribute("errorMsg", "用户名或密码错误"); // 找不到用户名
			} else {
				model.addAttribute("errorMsg", "登录失败，未知错误");
			}
		}
		return view(model, request);
	}

	public String view(Model model, HttpServletRequest request) {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		if (user != null) {
			return "redirect:/";
		}
		// 验证码
		String rcode = RandomUtil.getString(6);
		// 将生成的验证码存入session
		HttpSession session = request.getSession(true);
		session.setAttribute("validateCode", MD5.MD5Encode(MD5.MD5Encode(rcode)));
		model.addAttribute("rcode", rcode);
		model.addAttribute("loginFlag", request.getParameter("loginFlag"));
		return "login";
	}
	
	/**
	 * 获取验证码
	 * @author yy-team
	 * @param request
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/getValidateVode", method = RequestMethod.POST)
	@ResponseBody
	public String getValidateVode(HttpServletRequest request, HttpServletResponse resp) {
		int rom = (int) (Math.random() * (9999 - 1000)) + 1000;
		// 将生成的验证码存入session
		HttpSession session = request.getSession(true);
		session.setAttribute("validateCode", String.valueOf(rom));
		return String.valueOf(rom);
	}
	
}
