package com.king.frame.security;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.king.modules.sys.log.LogLoginEntity;
import com.king.modules.sys.log.LogLoginService;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserDAO;
import com.king.modules.sys.user.UserEntity;

/**
 * 自定义的登录验证拦截器
 * 
 */
@Component
public class MyFormAuthenticationFilter extends FormAuthenticationFilter {

	@Autowired
	private LogLoginService logLoginService;

	@Autowired
	private UserDAO userDao;

	protected boolean onAccessDenied(ServletRequest request, ServletResponse response, Object mappedValue)
			throws Exception {
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		// 取出页面的验证码
		String randomcode = httpServletRequest.getParameter("validatecode");

		// 从session取出验证码
		HttpSession session = httpServletRequest.getSession();

		// 取出验证码
		String validateCode = (String) session.getAttribute("validateCode");
		// 验证码是否页面的验证码，验证码是否为空
		if (randomcode != null && validateCode != null && !randomcode.equals(validateCode)) {
			httpServletRequest.setAttribute("shiroLoginFailure", "ValidateCodeError");
			return true;
		}

		String userName = getUsername(request);
		UserEntity user = userDao.findByLoginname(userName);
		if (user != null && user.getLoginFailCount() != null
				&& user.getLoginFailCount() > ParameterUtil.getIntParamValue("LoginFailCount", 20)) {
			request.setAttribute("shiroLoginFailure", "RetryLimitException");
			// // userService.setUseByName(userName, "0");//禁用该用户
			userDao.setUseByName(userName, "0");
			// 拒绝访问，不再校验账号和密码
			return true;
		}
		return super.onAccessDenied(request, response, mappedValue);
	}

	@Override
	protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request,
			ServletResponse response) throws Exception {

		UsernamePasswordToken userToken = (UsernamePasswordToken) token;
		UserEntity user = userDao.findByLoginname(userToken.getUsername());

		LogLoginEntity log = new LogLoginEntity();
		log.setIsSuc("1");
		log.setIsValid("1");
		log.setRequestIp(getRemoteHost((HttpServletRequest) request));
		log.setUserAgent(((HttpServletRequest) request).getHeader("user-agent"));
		log.setLoginname(userToken.getUsername());
		log.setUserName(user.getUsername());
		log.setUserId(user.getUuid());
		log.setOrgid(user.getOrgid());
		log.setDeptid(user.getDeptid());
		logLoginService.save(log);

		user.setLast_ip(request.getRemoteAddr());// 设置最后登录ip
		user.setLast_time(new Date());// 设置最后登录时间
		user.setLoginFailCount(0l);// 登录成功后设置为0
		userDao.save(user);
		
		WebUtils.getAndClearSavedRequest(request);
		WebUtils.redirectToSavedRequest(request, response, "/");
		return false;
		// return super.onLoginSuccess(token, subject, request, response);
	}

	/**
	 * 获取ip
	 * 
	 * @param request
	 * @return
	 */
	private String getRemoteHost(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip.equals("0:0:0:0:0:0:0:1") ? "127.0.0.1" : ip;
	}

	@Override
	protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request,
			ServletResponse response) {
		UsernamePasswordToken userToken = (UsernamePasswordToken) token;
		LogLoginEntity log = new LogLoginEntity();
		log.setIsSuc("0");
		log.setIsValid("0");
		log.setRequestIp(request.getRemoteAddr());
		log.setUserAgent(((HttpServletRequest) request).getHeader("user-agent"));
		log.setUserName(userToken.getUsername());
		logLoginService.save(log);
		UserEntity user = userDao.findByLoginname(userToken.getUsername());
		if (user != null) {// 记录登录失败次数
			Long loginFailCount = user.getLoginFailCount();
			if (loginFailCount != null) {
				loginFailCount = loginFailCount + 1;
			} else {
				loginFailCount = 1l;
			}
			user.setLoginFailCount(loginFailCount);
			userDao.save(user);
		}
		return super.onLoginFailure(token, e, request, response);
	}

}