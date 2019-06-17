package com.king.modules.info.stockinfo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import com.king.frame.controller.BaseController;
import org.springframework.ui.Model;

/**
 * 仓库
 * @author null
 * @date 2019-06-17 21:24:38
 */
@Controller
@RequestMapping(value = "/info/stockinfo")
public class StockInfoController extends BaseController<StockInfoEntity> {

	@Autowired
	private StockInfoService service;

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-17 21:24:38
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/stockinfo/stockinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/stockinfo/stockinfo_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, StockInfoEntity entity) {
		return "modules/info/stockinfo/stockinfo_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, StockInfoEntity entity) {
		return "modules/info/stockinfo/stockinfo_detail";
	}

}