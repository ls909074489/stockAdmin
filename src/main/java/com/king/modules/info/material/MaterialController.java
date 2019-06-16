package com.king.modules.info.material;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.sys.param.ParameterUtil;

/**
 * 物料
 * @author null
 * @date 2019-06-16 15:53:34
 */
@Controller
@RequestMapping(value = "/info/material")
public class MaterialController extends BaseController<MaterialEntity> {

	@Autowired
	private MaterialService service;

	//重写要根据主表id查询否则返回空
	@Override
	protected ActionResultModel<MaterialEntity> doQuery(ServletRequest request) {
		return super.doQuery(request);
	}
	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-16 15:53:34
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("materialImportTemplatePath",
				"/exceltemplate/物料导入.xlsx"));
		return "modules/info/material/material_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/material/material_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, MaterialEntity entity) {
		return "modules/info/material/material_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, MaterialEntity entity) {
		return "modules/info/material/material_detail";
	}

	
	@RequestMapping(value = "/import")
	@ResponseBody
	public ActionResultModel<MaterialEntity> importExcel(MultipartHttpServletRequest request,HttpServletResponse response) {
		ActionResultModel<MaterialEntity> arm = new ActionResultModel<MaterialEntity>();
		try {
			response.setCharacterEncoding("UTF-8");
			MultipartFile file = request.getFile("attachment");
			arm = service.importExcel(file);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;     
	}
}