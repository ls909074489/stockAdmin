package com.king.modules.login;

import java.util.Arrays;
import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.king.common.exception.ServiceException;
import com.king.common.utils.MD5;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserDAO;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.user.UserService;

/**
 * 模拟登陆
 */
@Controller
@RequestMapping(value = "/sso")
public class SSOController {

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private UserService userService;

	/**
	 * 外系统登录用
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String view(Model model, ServletRequest request) {
		String username = request.getParameter("userName");
		String time = request.getParameter("time");
		String token = request.getParameter("token");
		String randomNum = request.getParameter("randomNum");
		try {
			boolean flag = checkSSO(token, randomNum, time, username);
			if (!flag) {
				model.addAttribute("msg", "授权验证不通过");
				return "redirect:/sso/403.jsp";
			}
		} catch (ServiceException e) {
			model.addAttribute("msg", e.getMessage());
			return "redirect:/sso/403.jsp";
		}

		UserEntity user = ShiroUser.getCurrentUserEntity();
		Subject subject = SecurityUtils.getSubject();
		if (user != null && username.equals(user.getLoginname())) {
			return "redirect:/";
		} else {
			subject.logout();
		}

		try {
			user = userDAO.findByLoginname(username);
			if (user == null || user.getPassword() == null) {
				model.addAttribute("msg", "找不到用户");
				return "redirect:/sso/403.jsp";
			}
			UsernamePasswordToken yytoken = new UsernamePasswordToken(username, user.getPassword());
			yytoken.setRememberMe(true);
			subject.login(yytoken);
			return "redirect:/";
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
			return "redirect:/sso/403.jsp";
		}

	}
	
	
	@RequestMapping(value = "/apiLogin", method = RequestMethod.POST)
	public String apiLogin(RedirectAttributes model, HttpServletRequest  request) {
		String username = request.getParameter("loginUserName");
		String password = request.getParameter("loginPwd");
		request.setAttribute("apiUserType", request.getParameter("apiUserType"));
		request.setAttribute("realName", request.getParameter("realName"));
		if(StringUtils.isEmpty(username)||StringUtils.isEmpty(password)){
			model.addFlashAttribute("ssoLoginMsg", "用户名或密码不能为空");
			return "redirect:/login";
		}

		UserEntity user = ShiroUser.getCurrentUserEntity();
		Subject subject = SecurityUtils.getSubject();
		if (user != null && username.equals(user.getLoginname())) {
			model.addFlashAttribute("apiUserName", username);
			model.addFlashAttribute("apiPassword", password);
//			return "redirect:/api/home";
			return "redirect:/";
		} else {
			subject.logout();
		}

		try {
			user = userDAO.findByLoginname(username);
			if (user == null || user.getPassword() == null) {
//				model.addFlashAttribute("ssoLoginMsg", "找不到用户");
//				return "redirect:/login";
				UserEntity entity=new UserEntity();
				entity.setLoginname(username);
				entity.setUsername(username);
				entity.setUsertype(1);
				entity.setPlainpassword(password);
				userService.addUser(entity);
				user=entity;
			}
			UsernamePasswordToken yytoken = new UsernamePasswordToken(username, user.getPassword());
			yytoken.setRememberMe(false);
			subject.login(yytoken);
			model.addFlashAttribute("apiUserName", username);
			model.addFlashAttribute("apiPassword", password);
//			return "redirect:/api/home";
			return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
			model.addFlashAttribute("ssoLoginMsg", e.getMessage());
			return "redirect:/login";
		}

	}

	/**
	 * 验证请求合法性
	 */
	private boolean checkSSO(String token, String randomNum, String time, String username) throws ServiceException {
		// 判空
		if (StringUtils.isBlank(username)) {
			throw new ServiceException("用户名不可为空");
		}
		// 判空
		if (StringUtils.isBlank(randomNum) || StringUtils.isBlank(token) || StringUtils.isBlank(time)) {
			throw new ServiceException("参数传递不可为空");
		}
		// 判断时间戳
		Long longTime = new Long(time);
		Date date = new Date();
		if (longTime < (date.getTime() - (1000L * 1000L)) || longTime > (date.getTime() + (1000L * 1000L))) {
			throw new ServiceException("登陆超时");
		}

		String key = ParameterUtil.getParamValue("sso_key");
		if (StringUtils.isBlank(key)) {
			throw new ServiceException("获取不到认证的key");
		}

		key = MD5.MD5Encode(key);
		String[] arr = { time, randomNum, key };
		Arrays.sort(arr);// 排序
		StringBuffer temp = new StringBuffer();
		for (int i = 0; i < arr.length; i++) {
			temp.append(arr[i]);
		}
		boolean flag = token.equals(MD5.MD5Encode(temp.toString()));
		return flag;
	}

}
