package com.king.modules.sys.message;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.security.ShiroUser;

/**
 * 系统消息controller
 * 
 * @ClassName: MessageController
 * @author
 * @date 2016年38月28日 10:10:34
 */
@Controller
@RequestMapping(value = "/sys/message")
public class MessageController extends BaseController<MessageEntity> {

	private MessageService getService() {
		return (MessageService) super.baseService;
	}

	/**
	 * 视图
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/message/message_main";
	}

	@RequestMapping(value = "showMoreMsg")
	public String showMoreMsg() {
		return "modules/sys/message/message_show_user";
	}

	/**
	 * 此处添加查询参数,用Map替代null,格式：LIKE_loginName=aa key和value都是String类型的。 addParam.put("LIKE_loginName", "aa");
	 * addParam.put("EQ_validDate", "2014-10-01");
	 * 
	 * @return
	 */
	public Map<String, Object> addSearchParam(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_receiver", ShiroUser.getCurrentUserEntity().getUuid());
		
		return addParam;
	}

	@RequestMapping(value = "/getMessageByType")
	@ResponseBody
	public ActionResultModel<MessageEntity> getMessageByType(Model model,
			@RequestParam(value = "msgtype") String msgtype) {
		ActionResultModel<MessageEntity> arm = new ActionResultModel<MessageEntity>();
		try {
			// 待办消息
			List<MessageEntity> list = getService().getMessageType(msgtype);
			int limitAmt = 100;
			if (list.size() >= limitAmt) {
				list.subList(0, limitAmt);
			}
			arm.setRecords(list);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	@RequestMapping(value = "/getMessages")
	@ResponseBody
	public ActionResultModel<MessageEntity> getMessages(Model model) {
		ActionResultModel<MessageEntity> arm = new ActionResultModel<MessageEntity>();
		try {
			// 待办消息
			List<MessageEntity> list = getService().getMessages();
			int limitAmt = 100;
			if (list.size() >= limitAmt) {
				list.subList(0, limitAmt);
			}
			arm.setRecords(list);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 视图
	 */
	@RequestMapping(value = "/msgShow", method = RequestMethod.GET)
	public String msgShow(ServletRequest request, Model model) {
		model.addAttribute("billtype", request.getParameter("billtype"));
		model.addAttribute("billid", request.getParameter("billid"));
		return "modules/sys/message/message_show";
	}

	@RequestMapping(value = "/getMessageByBillid")
	@ResponseBody
	public ActionResultModel<MessageEntity> getMessageByBillid(Model model,
			@RequestParam(value = "billtype") String billtype, @RequestParam(value = "billid") String billid) {
		ActionResultModel<MessageEntity> arm = new ActionResultModel<MessageEntity>();
		try {
			// 待办消息
			List<MessageEntity> list = getService().getMessageByBillid("1", billtype, billid);
			int limitAmt = 100;
			if (list.size() >= limitAmt) {
				list.subList(0, limitAmt);
			}
			arm.setRecords(list);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	@RequestMapping(value = "/setNoticeIsnew")
	@ResponseBody
	public ActionResultModel<MessageEntity> setNoticeIsnew(Model model, @RequestParam(value = "uuid") String uuid) {
		ActionResultModel<MessageEntity> arm = new ActionResultModel<MessageEntity>();
		try {

			MessageEntity messageEntity = getService().getOne(uuid);
			if (messageEntity == null) {
				arm.setMsg("已经有人处理了待办工作");
			} else {
				getService().setNoticeIsnew(messageEntity);
			}
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	
	
	@RequestMapping(value = "/msgList", method = RequestMethod.GET)
	public String msgList(ServletRequest request, Model model) {
		model.addAttribute("msgtype", request.getParameter("msgtype"));
		model.addAttribute("billid", request.getParameter("billid"));
		model.addAttribute("billtype", request.getParameter("billtype"));
		return "modules/sys/message/message_history";
	}

	
	@RequestMapping(value = "/dataMessage")
	@ResponseBody
	public ActionResultModel<MessageEntity> dataMessage(Model model,@RequestParam(value = "msgtype") String msgtype,
			@RequestParam(value = "billtype") String billtype, @RequestParam(value = "billid") String billid) {
		ActionResultModel<MessageEntity> arm = new ActionResultModel<MessageEntity>();
		try {
			// 待办消息
			List<MessageEntity> list = getService().getMessageByBillid(msgtype, billtype, billid);
			int limitAmt = 100;
			if (list.size() >= limitAmt) {
				list.subList(0, limitAmt);
			}
			arm.setRecords(list);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
}
