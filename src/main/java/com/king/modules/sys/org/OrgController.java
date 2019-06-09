package com.king.modules.sys.org;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.TreeController;
import com.king.frame.security.ShiroUser;

@Controller
@RequestMapping(value = "/sys/org")
public class OrgController extends TreeController<OrgEntity> {

	private OrgService getService() {
		return (OrgService) super.baseService;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/org/org_main";
	}

	@RequestMapping(value = "/orgView", method = RequestMethod.GET)
	private String orgView(Model model) {
		// 获取当前用户信息
		// UserEntity userEntity = ShiroUser.getCurrentUserEntity();
		// 获取当前用户的说登录的组织信息
		OrgEntity orgEntity = ShiroUser.getCurrentOrgEntity();
		model.addAttribute("entity", orgEntity);
		return "modules/sys/org/org_view";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/findByWhere")
	@ResponseBody
	public ActionResultModel findByWhere(ServletRequest request, Model model,
			@RequestParam(value = "where", required = false) String where) {
		ActionResultModel arm = new ActionResultModel();
		try {
			List<OrgEntity> list = getService().findByWhere(where);
			arm.setRecords(list);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	@RequestMapping(value = "/addOrg")
	@ResponseBody
	public ActionResultModel<OrgEntity> addOrg(MultipartHttpServletRequest request, Model model, @Valid OrgEntity entity) {
		ActionResultModel<OrgEntity> arm = new ActionResultModel<OrgEntity>();
		try {
			List<MultipartFile> files = request.getFiles("attachment[]");
			entity = getService().addOrg(entity,files);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	@RequestMapping(value = "/updateOrg")
	@ResponseBody
	public ActionResultModel<OrgEntity> updateOrg(MultipartHttpServletRequest request, Model model,
			@Valid OrgEntity entity) {
		ActionResultModel<OrgEntity> arm = new ActionResultModel<OrgEntity>();
		try {
			List<MultipartFile> files = request.getFiles("attachment[]");
			entity = getService().updateOrg(entity,files);
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			String msg = e.getMessage();
			if (msg.contains("constraint")) {
				arm.setMsg(e.getMessage());
			} else {
				arm.setMsg(e.getMessage());
			}
			e.printStackTrace();
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

}