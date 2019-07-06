package com.king.modules.info.projectinfo;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.SuperController;
import com.king.modules.info.material.MaterialEntity;

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
		return "modules/info/projectinfo/projectinfo_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
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
			MaterialEntity material = new MaterialEntity();
			material.setUuid(obj.getMaterialId());
			obj.setMaterial(material);
			returnList.add(obj);
		}
		return returnList;
	}
}