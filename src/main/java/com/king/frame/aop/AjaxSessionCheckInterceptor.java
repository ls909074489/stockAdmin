package com.king.frame.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.king.frame.security.ShiroUser;
import com.king.modules.sys.user.UserEntity;

public class AjaxSessionCheckInterceptor extends HandlerInterceptorAdapter {
	private static Logger logger = LoggerFactory.getLogger(AjaxSessionCheckInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		logger.debug(">>> Request Url:" + request.getRequestURI());

		// 如果是ajax请求响应头会有，x-requested-with；
		if (request.getHeader("x-requested-with") != null
				&& request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
			// 判断session里是否有用户信息
			// if (ShiroUser.getCurrentUserEntity() == null) {
			// // 在响应头设置session状态
			// response.setHeader("sessionstatus", "timeout");
			// logger.warn(">>> Session timeout, url:" + request.getRequestURI());
			// return false;
			// }
		}
		
//		System.out.println(request.getContextPath());
//		System.out.println(request.getServletPath());
//		System.out.println(request.getRequestURI());
//		System.out.println(request.getRequestURL());
//		System.out.println(request.getRequestURI());
		String currentUserId=request.getParameter("currentUserId");
		UserEntity user=ShiroUser.getCurrentUserEntity();
		if(user!=null){
			if(!StringUtils.isEmpty(currentUserId)&&!currentUserId.equals(user.getUuid())){
				response.sendRedirect(request.getContextPath()+"/login/loginPage");  
//				request.getRequestDispatcher("/").forward(request, response);
		        return false;
			}
		}
		return true;
	}
}
