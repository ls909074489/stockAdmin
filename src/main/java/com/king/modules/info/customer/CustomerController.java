package com.king.modules.info.customer;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.frame.controller.BaseController;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 客户姓名
 * @author liusheng
 *
 */
@Controller
@RequestMapping(value = "/info/customer")
public class CustomerController extends BaseController<UserEntity> {

	
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
		return "modules/info/customer/customer_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/customer/customer_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/customer/customer_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/customer/customer_detail";
	}
	
	
}