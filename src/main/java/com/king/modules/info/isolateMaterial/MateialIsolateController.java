package com.king.modules.info.isolateMaterial;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.frame.controller.BaseController;

/**
 * 
 * @author lenovo
 *
 */
@Controller
@RequestMapping(value = "/info/isolateMaterial")
public class MateialIsolateController extends BaseController<MateialIsolateEntity> {

	@Autowired
	private MateialIsolateService service;

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-07-17 21:13:46
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/isolatematerial/isolatematerial_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/isolatematerial/isolatematerial_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, MateialIsolateEntity entity) {
		return "modules/info/isolatematerial/isolatematerial_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, MateialIsolateEntity entity) {
		return "modules/info/isolatematerial/isolatematerial_detail";
	}

}