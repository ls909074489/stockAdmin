package com.king.modules.sys.imexlate;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

import net.sf.json.JSONObject;

/**
 * 导入模板controller
 * 
 * @ClassName: ImplateController
 * @author
 * @date 2016年3月10日 01:13:52
 */
@Controller
@RequestMapping(value = "/sys/imexlate")
public class ImexlateController extends BaseController<ImexlateEntity> {

	private ImexlateService getService() {
		return (ImexlateService) super.baseService;
	}

	/**
	 * 下载模板
	 * 
	 * @param response
	 * @param coding
	 */
	// @SuppressWarnings("rawtypes")
	@RequestMapping(value = "/uploadTem")
	@ResponseBody
	public ActionResultModel<ImexlateEntity> uploadTem(HttpServletResponse response, String coding,
			HttpServletRequest request) {
		ActionResultModel<ImexlateEntity> am = new ActionResultModel<ImexlateEntity>();

		ImexlateEntity imex = getService().findByTemCoding(coding);
		if (imex == null) {
			am.setSuccess(false);
			am.setMsg("模板不存在");
			// throw new ServiceException("模板不存在");
		} else {
			String path = getService()
					.getWinLinux(getService().getWinLinux(request.getServletContext().getRealPath("/"))
							+ getService().getExcelTempalePath() + "/" + imex.getExportFileName() + ".xlsx");
			File imexFile = new File(path);
			if (!imexFile.exists()) {
				// getService().generateTemplate(coding,
				// getService().getWinLinux(request.getServletContext().getRealPath("/"))
				// + getService().getExcelTempalePath());
				getService().generateTemplate(imex,
						getService().getWinLinux(request.getServletContext().getRealPath("/"))
								+ getService().getExcelTempalePath());
			}
			am.setMsg(path);
			am.setRecords(imex);
			am.setSuccess(true);
		}
		return am;
	}

	/**
	 * 生成模板
	 * 
	 * @param uuid
	 * @return boolean
	 */
	@RequestMapping(value = "/generate")
	@ResponseBody
	public String generateTemplate(String coding, HttpServletRequest request) {
		String path = getService().getWinLinux(request.getServletContext().getRealPath("/"))
				+ getService().getExcelTempalePath();
		getService().creFile(path);
		// return getService().generateTemplate(coding, path);
		ImexlateEntity imex = getService().findByTemCoding(coding);
		return getService().generateTemplate(imex, path);// edit by ls2008
	}


	/**
	 * 文件导出前数据处理
	 * 
	 * @param request
	 * @param response
	 * @param coding
	 * @return
	 *//*
		 * @RequestMapping(value = "/export")
		 * 
		 * @ResponseBody public String exportTest(HttpServletRequest request,HttpServletResponse response,String
		 * coding,@RequestParam(value = "pks[]",required=false) String[] pks){ List<Map<String, Object>> listMap =
		 * getService().exportSer(); String filePath = getService().writtenfile(request,response,listMap, coding);
		 * 
		 * return filePath; }
		 */
	/**
	 * 文件导入测试
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/import")
	@ResponseBody
	public String importTest(String filePath, String coding) {
		List<Map<String, Object>> listMap = getService().importData(filePath, coding);
		if (listMap != null && listMap.size() > 0) {

		} else {
			return "error";
		}
		return "success";
	}

	/**
	 * 导入文件上传
	 * 
	 * @param request
	 * @return 文件地址
	 */
	@RequestMapping(value = "/conport")
	@ResponseBody
	public ActionResultModel<ImexlateEntity> addwithsub(HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("UTF-8");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile file = multipartRequest.getFile("file");
		ActionResultModel<ImexlateEntity> arm = new ActionResultModel<ImexlateEntity>();
		String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."),
				file.getOriginalFilename().length());

		if (file.getSize() < 0) {
			arm.setMsg("文件为空");
			arm.setSuccess(false);
		} else if (!suffix.equals(".xlsx") && !suffix.equals(".xls")) {
			arm.setMsg("文件格式不正确,请下载导入模板");
			arm.setSuccess(false);
		} else {
			String path = getService().copyFile(request, file);
			if (path != null) {
				arm.setMsg(path);
				arm.setSuccess(true);
			} else {
				arm.setMsg("文件导入失败,请重试...");
				arm.setSuccess(false);
			}
		}
		return arm;
	}

	/**
	 * 导入弹出框
	 * 
	 * @param model
	 * @param callBackMethod
	 * @return
	 */
	@RequestMapping(value = "/importPage")
	public String selectConditionsTable(Model model, String callBackMethod) {
		model.addAttribute("callBackMethod", callBackMethod);
		return "modules/sys/imexlate/imexlate_uploadfile";
	}

	/**
	 * 
	 * @Title: 导入模板 @author @date 2016年3月10日 01:13:52 @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view(Model model) {

		return "modules/sys/imexlate/imexlate_main";
	}

	@RequestMapping(value = "/addwithsub")
	@ResponseBody
	public ActionResultModel<ImexlateEntity> addwithsub(ServletRequest request, Model model, @Valid ImexlateEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ImexlateEntity> arm = new ActionResultModel<ImexlateEntity>();
		try {
			List<ImexlateSubEntity> subList = this.convertToEntities(subArrs);
			entity = getService().saveSelfAndSubList(entity, subList, deletePKs);
			arm.setRecords(entity);
			// getService().setChildStartCellNum(entity);
			String path = getService().getWinLinux(request.getServletContext().getRealPath("/"))
					+ getService().getExcelTempalePath();
			// getService().generateTemplate(entity.getCoding(), path);
			getService().generateTemplate(entity, path);// edit by ls2008
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	@RequestMapping(value = "/updatewithsub")
	@ResponseBody
	public ActionResultModel<ImexlateEntity> update(ServletRequest request, Model model, @Valid @ModelAttribute("preloadEntity") ImexlateEntity entity,
			@RequestParam(value = "subList[]", required = false) String[] subArrs,
			@RequestParam(value = "deletePKs[]", required = false) String[] deletePKs) {
		ActionResultModel<ImexlateEntity> arm = new ActionResultModel<ImexlateEntity>();
		try {
			List<ImexlateSubEntity> subList = this.convertToEntities(subArrs);
			entity = getService().saveSelfAndSubList(entity, subList, deletePKs);

			String path = getService().getWinLinux(request.getServletContext().getRealPath("/"))
					+ getService().getExcelTempalePath();
			if (!"0".equals(entity.getIscreate())) {
				getService().generateTemplate(entity, path);// edit by ls2008
			}
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

	private List<ImexlateSubEntity> convertToEntities(String[] paramArr) {
		List<ImexlateSubEntity> returnList = new ArrayList<ImexlateSubEntity>();
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
			ImexlateSubEntity obj = (ImexlateSubEntity) JSONObject.toBean(jsonObject, ImexlateSubEntity.class);
			returnList.add(obj);
		}
		return returnList;
	}
}
