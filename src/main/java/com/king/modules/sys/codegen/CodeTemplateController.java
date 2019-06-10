package com.king.modules.sys.codegen;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.frame.controller.BaseController;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 物料类型controller
 * @ClassName: CodeTemplateController
 * @author  
 * @date 2019年52月10日 03:15:55
 */
@Controller
@RequestMapping(value = "/sys/codeTemplate")
public class CodeTemplateController extends BaseController<CodeTemplateEntity> {

	@Autowired
	private CodeTemplateService codetemplateService;

	/**
	 * 
	 * @Title: 物料类型
	 * @author 
	 * @date 2019年52月10日 03:15:55
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/codetemplate/codetemplate_main";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		return "modules/sys/codetemplate/codetemplate_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, CodeTemplateEntity entity) {
		model.addAttribute("apiuploadUrl", ParameterUtil.getParamValue("apiuploadUrl", "http://app.weishiao.com:8080/localserv/uploadFile"));
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/sys/codetemplate/codetemplate_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, CodeTemplateEntity entity) {
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		model.addAttribute("uuid", request.getParameter("uuid"));
		return "modules/sys/codetemplate/codetemplate_detail";
	}
	
}
