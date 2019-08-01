package com.king.modules.info.apply;

import javax.servlet.ServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;

/**
 * 申请消息
 * @author null
 * @date 2019-07-17 21:13:46
 */
@Controller
@RequestMapping(value = "/info/apply")
public class ProjectApplyController extends BaseController<ProjectApplyEntity> {

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
		return "modules/info/apply/projectapply_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "modules/info/apply/projectapply_edit";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectApplyEntity entity) {
		return "modules/info/apply/projectapply_edit";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectApplyEntity entity) {
		return "modules/info/apply/projectapply_detail";
	}

	
	@Override
	public ActionResultModel<ProjectApplyEntity> add(ServletRequest request, Model model, ProjectApplyEntity entity) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<ProjectApplyEntity> doAdd(ServletRequest request, Model model,
			ProjectApplyEntity entity) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<ProjectApplyEntity> update(ServletRequest request, Model model, ProjectApplyEntity entity) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<ProjectApplyEntity> doUpdate(ServletRequest request, Model model,
			ProjectApplyEntity entity) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}

	@Override
	protected ActionResultModel<ProjectApplyEntity> doDelete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}

	@Override
	public ActionResultModel<ProjectApplyEntity> delete(ServletRequest request, Model model, String[] pks) {
		return new ActionResultModel<ProjectApplyEntity>(false, "不允许操作");
	}
}