package com.king.modules.info.supplier;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.utils.RequestUtil;
import com.king.modules.sys.param.ParameterUtil;

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
		model.addAttribute("templatePath", ParameterUtil.getParamValue("supplierImportTemplatePath",
				"/exceltemplate/厂商导入.xlsx"));
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

	
	@RequestMapping(value = "/import")
	@ResponseBody
	public ActionResultModel<SupplierEntity> importExcel(MultipartHttpServletRequest request,HttpServletResponse response) {
		ActionResultModel<SupplierEntity> arm = new ActionResultModel<SupplierEntity>();
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
	
	
	/**
	 * 导出
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/exportQuery")
	public void exportQuery(HttpServletRequest request, HttpServletResponse response) {
		ActionResultModel<SupplierEntity> arm=new ActionResultModel<SupplierEntity>();
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流   
	        response.reset();// 清空输出流   
	        response.setContentType("application/octet-stream; charset=utf-8");
			String explorerType = RequestUtil.getExplorerType((HttpServletRequest)request);
			
			arm= doQuery(request);
			
			List<SupplierEntity> resultList = arm.getRecords();
			
			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition",
				"attachment; filename=\"" + RequestUtil.encode(("物料信息"),"utf-8")+".xlsx" + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition",
						"attachment; filename=" + new String(("物料信息").getBytes("utf-8"), "ISO8859-1")+".xlsx");
			}
	        response.setContentType("application/msexcel");// 定义输出类型 
			wb = new SXSSFWorkbook(100);
			service.changeToStatisCells(resultList, wb);
			wb.write(os);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}finally{
			try {
				if(wb!=null){
					wb.close();
				}
				if(os!=null){
					os.close();// 关闭流
				}
			} catch (IOException e) {
				e.printStackTrace();
			} 
		} 
	}
}