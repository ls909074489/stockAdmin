package com.king.common.exception;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.king.common.utils.Constants;

public class MyExceptionHandler implements HandlerExceptionResolver {

	private static Logger logger = LoggerFactory.getLogger(MyExceptionHandler.class);

	public static String getTrace(Throwable t) {
		StringWriter stringWriter = new StringWriter();
		PrintWriter writer = new PrintWriter(stringWriter);
		t.printStackTrace(writer);
		StringBuffer buffer = stringWriter.getBuffer();
		return buffer.toString();
	}

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception e) {
		logger.error(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + getTrace(e));
		ModelAndView mv = new ModelAndView();
		MappingJackson2JsonView view = new MappingJackson2JsonView();
		mv.setView(view);
		mv.addObject("success", false);
		if (e instanceof ServiceException) {
			mv.addObject("msg", e.getMessage());
		}if (e instanceof org.hibernate.service.spi.ServiceException) {
			mv.addObject("msg", e.getMessage());
		} else if (e instanceof DataIntegrityViolationException) {
			mv.addObject("msg", Constants.getConstraintMsg(e.getMessage()));
		} else {
			mv.addObject("msg", "操作失败，请联系管理员");
		}
		return mv;
	}

}
