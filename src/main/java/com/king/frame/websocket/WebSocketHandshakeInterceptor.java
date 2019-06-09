package com.king.frame.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class WebSocketHandshakeInterceptor extends HttpSessionHandshakeInterceptor {
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler handler,
			Exception ex) {
		System.out.println("After Handshake");
		super.afterHandshake(request, response, handler, ex);
	}

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler handler,
			Map<String, Object> attribute) throws Exception {
		System.out.println("enter the beforeHandshake");
		if (request instanceof ServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest().getSession(false);
			if (session != null) {
				String userName = (String) session.getAttribute("username");
				System.out.println("userName+++++++++++++" + userName);
				attribute.put("username", userName);
			}
		}
		System.out.println("Before Handshake");
		return super.beforeHandshake(request, response, handler, attribute);

	}
}