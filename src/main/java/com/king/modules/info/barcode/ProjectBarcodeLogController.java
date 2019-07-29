package com.king.modules.info.barcode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.frame.controller.BaseController;

/**
 * 测试111
 * @author ls2008
 * @date 2019-07-29 11:04:14
 */
@Controller
@RequestMapping(value = "/info/barcode")
public class ProjectBarcodeLogController extends BaseController<ProjectBarcodeLogEntity> {

	@Autowired
	private ProjectBarcodeLogService service;

	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2019-07-29 11:04:14
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/toLog")
	public String listView(Model model,String subId) {
		model.addAttribute("subId", subId);
		return "modules/info/barcode/projectinfo_barcode_log";
	}


}