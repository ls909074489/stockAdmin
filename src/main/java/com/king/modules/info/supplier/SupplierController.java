package com.king.modules.info.supplier;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.ServletRequest;
import org.springframework.stereotype.Controller;
import com.king.frame.controller.BaseController;
import org.springframework.ui.Model;

/**
 * 供应商
 * @author null
 * @date 2019-06-17 21:31:03
 */
@Controller
@RequestMapping(value = "/info/supplier")
public class SupplierController extends BaseController<SupplierEntity> {

	@Autowired
	private SupplierService service;

	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-17 21:31:03
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/supplier/supplier_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/supplier/supplier_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, SupplierEntity entity) {
		return "modules/info/supplier/supplier_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, SupplierEntity entity) {
		return "modules/info/supplier/supplier_detail";
	}

}