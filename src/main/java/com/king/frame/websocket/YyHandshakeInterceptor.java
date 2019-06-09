package com.king.frame.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.king.frame.security.ShiroUser;

public class YyHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attribute) throws Exception {
		// System.out.println("Before Handshake");
		// System.out.println("enter the beforeHandshake");
		if (request instanceof ServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest().getSession(false);
			if (session != null) {
				// String userName = (String) session.getAttribute(YyConstants.SESSION_USERNAME);
				// System.out.println("userName+++++++++++++" + userName);
				// attribute.put(YyConstants.WEBSOCKET_USERNAME, userName);
				ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
				if (user != null) {
					// attribute.put(YyConstants.WEBSOCKET_USERNAME, user.getSchool().getUuid());
				}
			}
		}

		return super.beforeHandshake(request, response, wsHandler, attribute);
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		// System.out.println("After Handshake");
		super.afterHandshake(request, response, wsHandler, ex);
	}

}
