package com.king.frame.controller;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/sys/ref")
public class RefController {

	/**
	 * 选择厂商
	 * @Title: refSelect 
	 * @author liusheng
	 * @date 2017年11月18日 下午10:12:30 
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refSupperlierSel")
	public String refSupperlierSel(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		return "modules/ref/supplier_ref_select";
	}
	
	/**
	 * 选择间隔
	 * @Title: refIntervallierSel 
	 * @author liusheng
	 * @date 2017年11月19日 下午7:37:23 
	 * @param @param model
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refIntervallierSel")
	public String refIntervallierSel(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		return "modules/ref/interval_ref_select";
	}
	
	
	/**
	 * 厂站信息
	 * @Title: refStationSel 
	 * @author liusheng
	 * @date 2017年11月20日 下午4:28:41 
	 * @param @param model
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refStationSel")
	public String refStationSel(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		return "modules/ref/station_ref_select";
	}
	
	
	/**
	 * 选择用户
	 * @Title: refUserSel 
	 * @author liusheng
	 * @date 2017年11月19日 下午7:37:52 
	 * @param @param model
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refUserSel")
	public String refUserSel(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		return "modules/ref/user_ref_select";
	}
	
	/**
	 * 选择设备
	 * @Title: refDeviceSel 
	 * @author liusheng
	 * @date 2017年11月25日 下午12:29:17 
	 * @param @param model
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refDeviceSel")
	public String refDeviceSel(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		model.addAttribute("sid",request.getParameter("sid"));
		return "modules/ref/device_ref_select";
	}
	
	/**
	 * 选择用户组
	 * @Title: refUserGroup 
	 * @author liusheng
	 * @date 2017年12月16日 下午9:08:36 
	 * @param @param model
	 * @param @param request
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/refUserGroup")
	public String refUserGroup(Model model, ServletRequest request) {
		model.addAttribute("callBackMethod",request.getParameter("callBackMethod"));
		return "modules/ref/usergroup_ref_select";
	}
	
	
	@RequestMapping("/refMaterial")
	public String refMaterial(Model model, String callBackMethod,ServletRequest request) {
		model.addAttribute("callBackMethod",callBackMethod);
		return "modules/ref/material_ref_select";
	}
	
	
	@RequestMapping("/refProjectInfo")
	public String refProjectInfo(Model model, String callBackMethod,ServletRequest request) {
		model.addAttribute("callBackMethod",callBackMethod);
		return "modules/ref/projectinfo_ref_select";
	}
}