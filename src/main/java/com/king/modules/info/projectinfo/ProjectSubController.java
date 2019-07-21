package com.king.modules.info.projectinfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.Json;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.controller.QueryRequest;
import com.king.frame.security.ShiroUser;
import com.king.modules.info.approve.ApproveUserEntity;
import com.king.modules.info.approve.ApproveUserService;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;

/**
 * 
 * @ClassName: OrderSubController
 * @author liusheng
 * @date 2017年11月21日 下午5:50:47
 */
@Controller
@RequestMapping(value = "/info/projectinfoSub")
public class ProjectSubController extends BaseController<ProjectSubEntity> {

	@Autowired
	private ProjectSubService projectSubService;
	@Autowired
	private ApproveUserService approveUserService;

	@RequestMapping("/detailList")
	public String detailList(Model model,String sourceBillId) {
		List<EnumDataSubEntity> subList = EnumDataUtils.getEnumSubList("barCodeExtract");
		if(subList==null){
			subList = new ArrayList<>();
		}
		model.addAttribute("subList", Json.toJson(subList));
		model.addAttribute("sourceBillId", sourceBillId);
		return "modules/info/projectinfo/projectinfo_detail_list";
	}
	
	
	@RequestMapping(value = "/dataDetail")
	@ResponseBody
	public ActionResultModel<ProjectSubEntity> dataWarning(ServletRequest request) {
		Map<String, Object> addParam = new HashMap<String, Object>();
		addParam.put("EQ_stock.uuid", request.getParameter("stockId"));
		addParam.put("EQ_material.uuid", request.getParameter("materialId"));
		QueryRequest<ProjectSubEntity> qr = getQueryRequest(request, addParam);
		ActionResultModel<ProjectSubEntity> arm =  execQuery(qr, baseService);
		List<ProjectSubEntity> subList = arm.getRecords();
		if(CollectionUtils.isEmpty(subList)){
			return arm;
		}
		for(ProjectSubEntity sub : subList){
			if(StringUtils.isEmpty(sub.getBarcode())){
				sub.setCheckStatus(ProjectSubEntity.checkStatus_init);
			}else if(sub.getBarcode().contains(sub.getMaterial().getHwcode())){
				sub.setCheckStatus(ProjectSubEntity.checkStatus_pass);
			}else{
				sub.setCheckStatus(ProjectSubEntity.checkStatus_error);
			}
		}
		return arm;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/updateBarcode")
	public ActionResultModel<ProjectSubEntity> updateBarcode(ServletRequest request,String subId,String newBarcode) {
		boolean hasPri = approveUserService.checkIsApproveUser(ShiroUser.getCurrentUserEntity(), ApproveUserEntity.PROJECTINFO_TYPE);
		if(!hasPri){
			ActionResultModel<ProjectSubEntity> arm = new ActionResultModel<ProjectSubEntity>();
			arm.setSuccess(false);
			arm.setMsg("您不是审核用户，不能进行操作.");
			return arm;
		}
		return projectSubService.updateBarcode(newBarcode,subId);
	}
	
}
