package com.king.modules.info.order;

import java.util.Date;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.king.common.enums.BillState;
import com.king.common.utils.DateUtil;
import com.king.frame.controller.BaseController;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;

/**
 * 订购
 * @author liusheng
 *
 */
@Controller
@RequestMapping(value = "/info/purchase")
public class PurchaseController extends BaseController<UserEntity> {

	
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
		return "modules/info/purchase/purchase_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_add";
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
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/purchase/purchase_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, UserEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/info/purchase/purchase_detail";
	}


	/**
	 * 成品确认
	 * @param model
	 * @param uuid
	 * @param request
	 * @return
	 */
	@RequestMapping("/setStorageUsed")
	public String setStorageUsed(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_set_storageused";
	}
	
	/**
	 * 材料确认
	 * @param model
	 * @param uuid
	 * @param request
	 * @return
	 */
	@RequestMapping("/setStuffUsed")
	public String setStuffUsed(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_set_stuffused";
	}
	
	@RequestMapping("/setPlan")
	public String setPlan(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("toDay", DateUtil.yearMonthDayDate(new Date()));
		return "modules/info/purchase/purchase_set_plan";
	}
	
	@RequestMapping("/listPlan")
	public String listPlan(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		model.addAttribute("toDay", DateUtil.yearMonthDayDate(new Date()));
		return "modules/info/purchase/purchase_plan_list";
	}
	
	
	@RequestMapping("/listDelivery")
	public String listDelivery(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		return "modules/info/purchase/purchase_delivery_list";
	}
	
	
	
	@RequestMapping("/toProduce")
	public String toProduce(Model model,String uuid,String orderId,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("orderId", orderId);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_set_produce";
	}
	
	@RequestMapping("/toDelivery")
	public String toDelivery(Model model,String uuid,String orderId,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("orderId", orderId);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_set_delivery";
	}
	
	
	@RequestMapping("/toReject")
	public String toReject(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_set_reject";
	}
	
	@RequestMapping("/toSelectStuff")
	public String toSelectStuff(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_stuff_select";
	}
	
	@RequestMapping("/toSelectCustomer")
	public String toSelectCustomer(Model model,String uuid,HttpServletRequest request) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/info/purchase/purchase_customer_select";
	}
	
	
	@RequestMapping("/listStorageProduce")
	public String listStorageProduce(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		model.addAttribute("toDay", DateUtil.yearMonthDayDate(new Date()));
		return "modules/info/purchase/purchase_storageproduce_list";
	}
	
	
	@RequestMapping("/listStorageDelivery")
	public String listStorageDelivery(Model model,String uuid) {
		model.addAttribute("uuid", uuid);
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("curSysDate", System.currentTimeMillis()/1000);
		model.addAttribute("toDay", DateUtil.yearMonthDayDate(new Date()));
		return "modules/info/purchase/purchase_storagedelivery_list";
	}
	
}