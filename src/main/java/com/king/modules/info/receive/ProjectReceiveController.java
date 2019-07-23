package com.king.modules.info.receive;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
		return "modules/info/receive/projectreceive_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "modules/info/receive/projectreceive_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "modules/info/receive/projectreceive_detail";
	}

}