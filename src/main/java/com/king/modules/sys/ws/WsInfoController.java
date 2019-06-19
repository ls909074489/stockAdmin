package com.king.modules.sys.ws;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.websocket.YyWebSocketHandler;
import com.king.modules.info.device.DeviceInfoService;

/**
 * 设备信息
 * 
 * @author ls2008
 * @date 2017-11-17 23:22:24
 */
@Controller
@RequestMapping(value = "/sys/ws")
public class WsInfoController {

	@Autowired
	private YyWebSocketHandler webSocketHandler;
	@Autowired
	private DeviceInfoService deviceInfoService;
	
	/**
	 * 
	 * @Title: listView 
	 * @author liusheng
	 * @date 2017年11月18日 上午10:27:19 
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(ServletRequest request,Model model) {
		System.out.println("list>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		
//		webSocketHandler.sendMessageToUser("5bd60c1d-ffb3-46de-84ae-9d996d007e9f", new TextMessage("发送消息》》》》》》》》》》》》》》》》》》》"));
		
//		for(int i=0;i<1000;i++){
//			new Thread(new Runnable() {
//				@Override
//				public void run() {
//					deviceInfoService.testLock();
//				}
//			}).start();
//		}
		
		System.out.println("end>>>>>>>>>>>>>>>>>>>");
		return "modules/sys/ws/ws_list";
	}
	
	
	@ResponseBody
	@RequestMapping("/getAllSession")
	public ActionResultModel<String> getAllSession(ServletRequest request,Model model) {
		List<WebSocketSession>  sessionList = webSocketHandler.getAllSession();
		List<String> sessionIdList = new ArrayList<>();
		for(WebSocketSession session:sessionList){
			sessionIdList.add(session.getPrincipal().getName());
		}
		return new ActionResultModel<>(true, String.join(",", sessionIdList));
	}
	
	@ResponseBody
	@RequestMapping("/sendMessageToUser")
	public ActionResultModel<String> sendMessageToUser(ServletRequest request,String userid,String message) {
		webSocketHandler.sendMessageToUser(userid, new TextMessage(message));
		return new ActionResultModel<String>(true, "suc");
	}
	
	@ResponseBody
	@RequestMapping("/sendMessageToUsers")
	public ActionResultModel<String> sendMessageToUsers(ServletRequest request,String userid,String message) {
		webSocketHandler.sendMessageToUsers(new TextMessage(message));
		return new ActionResultModel<String>(true, "suc");
	}
}