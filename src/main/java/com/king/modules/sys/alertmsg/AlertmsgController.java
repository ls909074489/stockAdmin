package com.king.modules.sys.alertmsg;

import java.util.Map;

import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 提示语controller
 * 
 * @ClassName: AlertmsgController
 * @author
 * @date 2016年19月24日 10:10:52
 */
@Controller
@RequestMapping(value = "/sys/alertmsg")
public class AlertmsgController extends BaseController<AlertmsgEntity> {

	private AlertmsgService getService() {
		return (AlertmsgService) super.baseService;
	}

	/**
	 * 
	 * 提示语
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/alertmsg/alertmsg_main";
	}

	@RequestMapping(value = "/getAlertMsg")
	@ResponseBody
	private ActionResultModel getAlertMsg() {
		ActionResultModel arm = new ActionResultModel();
		try {
			Map map = YYMsg.cacheMap;
			if (map == null||map.size()==0) {
				map = getService().getAlertMsg();
			}
			arm.setRecords(map);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			// e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

}
