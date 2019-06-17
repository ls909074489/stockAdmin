package com.king.modules.info.orderinfo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import com.king.frame.controller.BaseController;
import org.springframework.ui.Model;

/**
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Controller
@RequestMapping(value = "/info/orderinfo")
public class OrderInfoController extends BaseController<OrderInfoEntity> {

	@Autowired
	private OrderInfoService service;

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-17 22:38:46
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/orderinfo/orderinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/orderinfo/orderinfo_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, OrderInfoEntity entity) {
		return "modules/info/orderinfo/orderinfo_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, OrderInfoEntity entity) {
		return "modules/info/orderinfo/orderinfo_detail";
	}

}