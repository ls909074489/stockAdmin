package com.king.modules.info.sample;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.king.common.enums.BillState;
import com.king.frame.controller.BaseController;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 样品controller
 * @author liusheng
 *
 */
@Controller
@RequestMapping(value = "/info/sample")
public class SampleController extends BaseController<UserEntity> {

	
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
		return "modules/info/sample/sample_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		return "modules/info/sample/sample_add";
	}
	
	@RequestMapping(value = "/onDetail", method = RequestMethod.GET)
	public String onDetail(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_DETAIL);
		return detailView(model, request, null);
	}
	
	@RequestMapping(value = "/onEdit", method = RequestMethod.GET)
	public String onEdit(Model model, ServletRequest request,
			@RequestParam(value = "uuid", required = true) String uuid) {
		UserEntity userEntity = ShiroUser.getCurrentUserEntity();
		OrgEntity orgEntity = ShiroUser.getCurrentOrgEntity();
		model.addAttribute("user", userEntity);// 用户
		model.addAttribute("org", orgEntity);// 组织
		model.addAttribute(OPENSTATE, BillState.OPENSTATE_EDIT);
		return editView(model, request, null);
	}

	@Override
	public String editView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/sample/sample_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/sample/sample_detail";
	}


	
	@RequestMapping("/setPrice")
	public String setPrice(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/sample/sample_set_price";
	}
	
	@RequestMapping("/setPlanTime")
	public String setPlanTime(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/sample/sample_set_plantime";
	}
	
	
	@RequestMapping("/setSendInfo")
	public String setSendInfo(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/sample/sample_set_sendinfo";
	}
	
	@RequestMapping("/toFeedBack")
	public String toFeedBack(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/sample/sample_set_feedback";
	}
	
	@RequestMapping("/toFinalPrice")
	public String toFinalPrice(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/sample/sample_set_finalprice";
	}
}