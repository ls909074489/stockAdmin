package com.king.frame.websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class YyWebSocketHandler extends TextWebSocketHandler {

	// 创建一个集合存放websocketsession
	private static final ArrayList<WebSocketSession> users;

	static {
		users = new ArrayList<>();
	}

	/**
	 * 连接以创建以后执行的方法
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.add(session);
		String userName = (String) session.getAttributes().get(YyConstants.WEBSOCKET_USERNAME);
		// System.out.println("userNmae" + userName);
		if (userName != null) {
			// 查询未读消息
			// int count = webSocketService.getUnReadNews((String)
			// session.getAttributes().get(Constants.WEBSOCKET_USERNAME));
			// session.sendMessage(new TextMessage(count + ""));
		}
	}

	/**
	 * 接收客户端发送过来的消息
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		super.handleTextMessage(session, message);
		TextMessage returnMessage = new TextMessage(message.getPayload() + "连接正常");
		session.sendMessage(returnMessage);
	}

	/**
	 * 传输错误时触发
	 */
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		if (session.isOpen()) {
			session.close();
		}
		users.remove(session);
	}

	/**
	 * 连接关闭时触发
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		users.remove(session);
	}

	@Override
	public boolean supportsPartialMessages() {
		return false;
	}

	/**
	 * 给所有在线用户发送消息
	 * 
	 * @param message
	 */
	public void sendMessageToUsers(TextMessage message) throws ServiceException {
		for (WebSocketSession user : users) {
			try {
				if (user.isOpen()) {
					user.sendMessage(message);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 给某个用户发送消息
	 * 
	 * @param userName
	 * @param message
	 */
	public void sendMessageToUser(String userid, TextMessage message) throws ServiceException {
		try {
			for (WebSocketSession user : users) {
				if (userid.equals(user.getAttributes().get(YyConstants.WEBSOCKET_USERNAME))) {
					try {
						if (user.isOpen()) {
							user.sendMessage(message);
						}
					} catch (IOException e) {
						e.printStackTrace();
					}
					// break;
				}
			}
		} catch (Exception e) {
			// 消息发送失败,屏蔽掉信息
			System.out.println("消息推动失败。。。。。。。。。。");
		}

	}
	
	public List<WebSocketSession> getAllSession(){
		return users;
	}

}