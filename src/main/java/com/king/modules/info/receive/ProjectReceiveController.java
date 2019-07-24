package com.king.modules.info.receive;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 收货
 * @author ls2008
 * @date 2019-07-23 16:59:39
 */
@Controller
@RequestMapping(value = "/info/receive")
public class ProjectReceiveController extends BaseController<ProjectReceiveEntity> {

	@Autowired
	private ProjectReceiveService service;

	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2019-07-23 16:59:39
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/receive/projectreceive_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "404";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "404";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "";
	}
	
	@RequestMapping(value = "/toAppendLog", method = RequestMethod.GET)
	public String subId(Model model, ServletRequest request,String subId) {
		model.addAttribute("subId", subId);
		model.addAttribute("curDate", DateUtil.getDate());
		return "modules/info/receive/project_receive_addlog";
	}

	
	@ResponseBody
	@RequestMapping(value = "/saveReceiveLog")
	public ActionResultModel<ProjectReceiveEntity> saveReceiveLog(Model model, ServletRequest request,ProjectReceiveEntity entity) {
		return service.saveReceiveLog(entity);
	}
	
	
	@RequestMapping(value = "/toViewLog", method = RequestMethod.GET)
	public String toViewLog(Model model, ServletRequest request,String subId) {
		model.addAttribute("subId", subId);
		return "modules/info/receive/project_receive_viewlog";
	}
	
	
	
}