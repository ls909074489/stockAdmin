package com.king.modules.info.stock;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.common.utils.DateUtil;
import com.king.frame.controller.BaseController;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 仓库
 * @author liusheng
 *
 */
@Controller
@RequestMapping(value = "/info/stock")
public class StockController extends BaseController<UserEntity> {

	
	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2017-11-18 20:44:23
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		return "modules/info/stock/stock_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/stock/stock_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/stock/stock_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/stock/stock_detail";
	}


	
	@RequestMapping("/setPlan")
	public String setPlan(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("toDay", DateUtil.yearMonthDayDate(new Date()));
		return "modules/info/stock/stock_set_plan";
	}
	
	@RequestMapping("/listPlan")
	public String listPlan(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		return "modules/info/stock/stock_plan_list";
	}
	
	
	@RequestMapping("/listDelivery")
	public String listDelivery(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		return "modules/info/stock/stock_delivery_list";
	}
	
	
	
	@RequestMapping("/toProduce")
	public String toProduce(Model model,String uuid,String orderId,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("orderId", orderId);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/stock/stock_set_produce";
	}
	
	@RequestMapping("/toDelivery")
	public String toDelivery(Model model,String uuid,String orderId,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("orderId", orderId);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/stock/stock_set_delivery";
	}
	
}