package com.king.frame.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

public class MessageUtils {

	@Autowired
	private static MessageSource messageSource;

	/**
	 * 根据消息键和参数 获取消息 委托给spring messageSource
	 *
	 * @param code
	 *            消息键
	 * @param args
	 *            参数
	 * @return
	 */
	public static String message(String code, Object... args) {
		if (messageSource == null) {
			// messageSource = SpringUtils.getBean(MessageSource.class);
			messageSource = SpringUtils.getBean("messageSource");
		}
		return messageSource.getMessage(code, args, null);
	}

}
