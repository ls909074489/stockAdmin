package com.king.frame.attachment;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/*
/**
 * 附件库 控制类
 *
 */

@Controller
@RequestMapping(value = "/frame/attachment")
public class AttachmentController extends BaseController<AttachmentEntity> {

	public static final String FILE_NAME = "attachment[]";

	@Autowired
	private AttachmentService service;

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "sys/attachment/view";
	}

	@RequestMapping(value = "/widget")
	public String widget() {
		return "sys/attachment/widget";
	}

	@RequestMapping(value = "/list")
	public String list(Model model, HttpServletRequest request, @RequestParam(value = "entityType") String entityType,
			@RequestParam(value = "entityUuid") String entityUuid) {
		model.addAttribute("entityType", entityType);
		model.addAttribute("entityUuid", entityUuid);
		model.addAttribute("editAble", true);
		return "modules/sys/attachment/attachment_main";
	}

	@RequestMapping(value = "/view")
	public String viewAtta(Model model, HttpServletRequest request,
			@RequestParam(value = "entityType") String entityType,
			@RequestParam(value = "entityUuid") String entityUuid) {
		model.addAttribute("entityType", entityType);
		model.addAttribute("entityUuid", entityUuid);
		model.addAttribute("editAble", false);
		return "modules/sys/attachment/attachment_main";
	}

	@RequestMapping(value = "/filelist")
	public String filelist(Model model, HttpServletRequest request,
			@RequestParam(value = "entityType") String entityType, @RequestParam(value = "editAble") String editAble,
			@RequestParam(value = "entityUuid") String entityUuid) {

		model.addAttribute("entityType", entityType);
		model.addAttribute("entityUuid", entityUuid);

		if (!StringUtils.isEmpty(editAble) && "1".equals(editAble)) {
			model.addAttribute("editAble", true);
		} else {
			model.addAttribute("editAble", false);
		}
		return "modules/sys/upfile/upfile";
	}

	@RequestMapping(value = "/widgetlistCombo")
	public String widgetlistCombo() {
		return "sys/attachment/widget_list_combo";
	}

	@RequestMapping(value = "/upload")
	public String upload(Model model, @RequestParam(value = "entityType") String entityType,
			@RequestParam(value = "entityUuid") String entityUuid, @RequestParam(value = "maxFiles") String maxFiles,
			@RequestParam(value = "uploadUrl") String uploadUrl) {

		model.addAttribute("entityType", entityType);
		model.addAttribute("entityUuid", entityUuid);
		model.addAttribute("maxFiles", maxFiles);
		model.addAttribute("uploadUrl", uploadUrl);
		return "frame/attachment/attachment_upload";
	}

	/**
	 * 新增
	 * 
	 * @param
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addFiles")
	@ResponseBody
	private ActionResultModel add(MultipartHttpServletRequest request, AttachmentEntity attachment) {

		ActionResultModel arm = new ActionResultModel();
		List<MultipartFile> files = request.getFiles(FILE_NAME);
		try {
			List<AttachmentEntity> list = service.save(files, attachment);
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addAndDelFiles")
	@ResponseBody
	private ActionResultModel addAndDelFiles(MultipartHttpServletRequest request, AttachmentEntity attachment,
			@RequestParam(value = "deleteFiles[]", required = false) String[] deleteFilePKs) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		List<MultipartFile> files = request.getFiles(FILE_NAME);
		try {
			List<AttachmentEntity> list = service.save(files, attachment);
			if (deleteFilePKs != null && deleteFilePKs.length > 0) {
				service.delete(deleteFilePKs);
			}
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	
	
	/**
	 * 上传包括备注，和分类信息
	 * @Title: addAndDelFilesClass 
	 * @author liusheng
	 * @date 2016年7月13日 下午4:27:50 
	 * @param @param request
	 * @param @param attachment
	 * @param @param deleteFilePKs
	 * @param @param fileId
	 * @param @param fileClass
	 * @param @param fileMemo
	 * @param @return 设定文件 
	 * @return ActionResultModel 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/addAndDelFilesClass")
	@ResponseBody
	private ActionResultModel<AttachmentEntity> addAndDelFilesClass(MultipartHttpServletRequest request, AttachmentEntity attachment,
			@RequestParam(value = "deleteFiles[]", required = false) String[] deleteFilePKs,
			@RequestParam(value = "fileIds[]", required = false) String []fileIds,
			@RequestParam(value = "fileClasses[]", required = false) String []fileClasses,
			@RequestParam(value = "fileMemoes[]", required = false) String []fileMemoes) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		List<MultipartFile> files = request.getFiles(FILE_NAME);
		try {
			List<AttachmentEntity> list = service.save(files, attachment,deleteFilePKs,fileIds,fileClasses,fileMemoes);
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}
	


	/**
	 * 根据entityUuid删除附件信息
	 * @date 2013-12-9 下午6:43:56
	 * @param entityUuid
	 * @return
	 */
	@RequestMapping(value = "/deleteByEntityUuid")
	@ResponseBody
	private ActionResultModel<AttachmentEntity> deleteByEntityUuid(String entityUuid) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		try {
			service.deleteByEntityUuid(entityUuid);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}

		return arm;
	}

	/**
	 * 附件下载
	 * @date 2013-12-17 上午10:49:18
	 */
	@RequestMapping(value = "/download")
	@ResponseBody
	private void download(HttpServletRequest request, HttpServletResponse response, String pk) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		try {
			service.downLoad(request, response, pk);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * 下载所有的文件
	 * @Title: downloadAllFiles 
	 * @author liusheng
	 * @date 2017年8月16日 下午8:04:02 
	 * @param @param request
	 * @param @param response
	 * @param @param entityUuid 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "/downloadAllFiles")
	@ResponseBody
	private void downloadAllFiles(HttpServletRequest request, HttpServletResponse response, String entityUuid,String entityType) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		try {
			service.downloadAllFiles(request, response, entityUuid,entityType);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
	}
	

	/**
	 * 文件下载
	 * 
	 * @param filePath
	 * @param response
	 * @return
	 */
	@RequestMapping("/download2")
	public String download(@RequestParam String filePath, HttpServletResponse response) {
		File file = new File(filePath);
		InputStream inputStream;
		try {
			inputStream = new FileInputStream(filePath);
			response.reset();
			response.setContentType("application/octet-stream;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
			OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
			byte data[] = new byte[1024];
			while (inputStream.read(data, 0, 1024) >= 0) {
				outputStream.write(data);
			}
			outputStream.flush();
			outputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 显示图片附件类型
	 * @date 2013-12-17 下午11:14:10
	 * @param response
	 * @param pk
	 */
	@RequestMapping(value = "/showImg")
	@ResponseBody
	private void showImg(HttpServletResponse response, String pk) {
		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		try {
			service.showImg(response, pk);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value = "/downloadForms")
	@ResponseBody
	private void downloadForms(HttpServletRequest request, HttpServletResponse response, String pk) {

		ActionResultModel<AttachmentEntity> arm = new ActionResultModel<AttachmentEntity>();
		try {
			service.downLoadFiles(request, response, pk);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
	}
}
