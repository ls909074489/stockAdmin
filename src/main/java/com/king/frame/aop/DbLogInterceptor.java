package com.king.frame.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.NamedThreadLocal;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.king.frame.security.ShiroUser;
import com.king.modules.sys.user.UserEntity;

public class DbLogInterceptor extends HandlerInterceptorAdapter {

	private NamedThreadLocal<Long> startTimeThreadLocal = new NamedThreadLocal<Long>("StopWatch-StartTime");

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		long beginTime = System.currentTimeMillis();// 1、开始时间
		startTimeThreadLocal.set(beginTime);// 线程绑定变量（该数据只有当前请求的线程可见）
		return true;// 继续流程
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		long endTime = System.currentTimeMillis();// 2、结束时间
		long beginTime = startTimeThreadLocal.get();// 得到线程绑定的局部变量（开始时间）
		long consumeTime = endTime - beginTime;// 3、消耗的时间
		if (consumeTime > 10000) {// 此处认为处理时间超过5000毫秒的请求为慢请求
			UserEntity user = ShiroUser.getCurrentUserEntity();
			if (user != null) {
				// 记录到日志文件
				System.out.println(
						String.format("%s 请求 %s 耗费 %d 毫秒", user.getLoginname(), request.getRequestURI(), consumeTime));
			} else {
				// 记录到日志文件
				System.out.println(String.format("%s 耗费 %d 毫秒", request.getRequestURI(), consumeTime));
			}
		}
	}

}
