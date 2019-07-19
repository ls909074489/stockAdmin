package com.king.modules.info.projectinfo;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.SuperController;
import com.king.frame.utils.RequestUtil;
import com.king.modules.info.material.MaterialBaseEntity;
import com.king.modules.info.stockinfo.StockBaseEntity;
import com.king.modules.sys.param.ParameterUtil;
import net.sf.json.JSONObject;

/**
 * 项目
 * @author null
 * @date 2019-06-19 21:25:24
 */
@Controller
@RequestMapping(value = "/info/projectinfo")
public class ProjectInfoController extends SuperController<ProjectInfoEntity> {

	@Autowired
	private ProjectInfoService service;
	@Autowired
	private ProjectSubService subService;
	
	/**
	 * 
	 * @Title: listView
	 * @author null
	 * @date 2019-06-19 21:25:24
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("projectInfoImpTemplate", "/template/项目单导入模板.xlsx"));
		return "modules/info/projectinfo/projectinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
		return "modules/info/projectinfo/projectinfo_add";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectInfoEntity entity) {
		return "modules/info/projectinfo/projectinfo_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectInfoEntity entity) {
		return "modules/info/projectinfo/projectinfo_detail";
	}

	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel addwithsub(ServletRequest request, Model model, @Valid ProjectInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		List<ProjectSubEntity> subList = this.convertToEntities(subArrs);
		try {
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		}catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updatewithsub")
	@ResponseBody
	public ActionResultModel update(ServletRequest request, Model model, @Valid @ModelAttribute("preloadEntity") ProjectInfoEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		arm.setSuccess(true);
		List<ProjectSubEntity> subList = this.convertToEntities(subArrs);
		try {
			StockBaseEntity stock = new StockBaseEntity();
			stock.setUuid(entity.getStockId());
			entity.setStock(stock);
			arm = subService.saveSelfAndSubList(entity, subList, deletePKs);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("保存失败");
			e.printStackTrace();
		}
		return arm;
	}

	private List<ProjectSubEntity> convertToEntities(String[] paramArr) {
		List<ProjectSubEntity> returnList = new ArrayList<ProjectSubEntity>();
		if (paramArr == null || paramArr.length == 0)
			return returnList;
		for (String data : paramArr) {
			JSONObject jsonObject = new JSONObject();
			String[] properties = data.split("&");
			for (String property : properties) {
				String[] nameAndValue = property.split("=");
				if (nameAndValue.length == 2) {
					try {
						nameAndValue[0] = URLDecoder.decode(nameAndValue[0], "UTF-8");
						nameAndValue[1] = URLDecoder.decode(nameAndValue[1], "UTF-8");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					jsonObject.put(nameAndValue[0], nameAndValue[1]);
				}
			}
			ProjectSubEntity obj = (ProjectSubEntity) JSONObject.toBean(jsonObject,
					ProjectSubEntity.class);
			MaterialBaseEntity material = new MaterialBaseEntity();
			material.setUuid(obj.getMaterialId());
			obj.setMaterial(material);
			returnList.add(obj);
		}
		return returnList;
	}
	
	

	/**
	 * 跳到导入页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("/toImport")
	public String toImport(Model model) {
		model.addAttribute("templatePath", ParameterUtil.getParamValue("projectInfoImpTemplate", "/template/项目单导入模板.xlsx"));
		model.addAttribute("defaultStockName",ParameterUtil.getParamValue("defaultStockName"));
		model.addAttribute("defaultStock",ParameterUtil.getParamValue("defaultStock"));
		return "modules/info/projectinfo/projectinfo_import_page";
	}



	@ResponseBody
	@RequestMapping(value = "/import")
	public ActionResultModel<ProjectInfoEntity> importExcel(MultipartHttpServletRequest request,ProjectInfoEntity projectInfo,
			HttpServletResponse response) {
		ActionResultModel<ProjectInfoEntity> arm = new ActionResultModel<ProjectInfoEntity>();
		try {
			response.setCharacterEncoding("UTF-8");
			MultipartFile file = request.getFile("attachment");
			arm = subService.importExcel(file, projectInfo);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
	
	@RequestMapping(value = "/select2Query")
	@ResponseBody
	public ActionResultModel<ProjectInfoVo> select2Query(String codeOrName) {
		return service.select2Query(codeOrName);
	}
	
	
	
	
	/**
	 * 导出
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/exportQuery")
	public void exportQuery(HttpServletRequest request, HttpServletResponse response) {
		ActionResultModel<ProjectInfoEntity> arm=new ActionResultModel<ProjectInfoEntity>();
		OutputStream os = null;
		Workbook wb = null;
		try {
			os = response.getOutputStream();// 取得输出流   
	        response.reset();// 清空输出流   
	        response.setContentType("application/octet-stream; charset=utf-8");
			String explorerType = RequestUtil.getExplorerType((HttpServletRequest)request);
			
			arm= doQuery(request);
			
			List<ProjectInfoEntity> resultList = arm.getRecords();
			
			if (explorerType == null || explorerType.contains("IE")) {// IE
				response.setHeader("Content-Disposition",
				"attachment; filename=\"" + RequestUtil.encode(("项目单信息"),"utf-8")+".xlsx" + "\"");
			} else {// fireFox/Chrome
				response.setHeader("Content-Disposition",
						"attachment; filename=" + new String(("项目单信息").getBytes("utf-8"), "ISO8859-1")+".xlsx");
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