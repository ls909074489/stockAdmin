package com.king.modules.info.receive;

import java.util.ArrayList;

import javax.servlet.ServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.common.utils.Constants;
import com.king.common.utils.DateUtil;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.info.stockstream.StockStreamEntity;

/**
 * 收货
 * @author ls2008
 * @date 2019-07-23 16:59:39
 */
@Controller
@RequestMapping(value = "/info/receive")
public class ProjectReceiveController extends BaseController<ProjectReceiveEntity> {

	@Autowired
	private ProjectReceiveService service;

	/**
	 * 
	 * @Title: listView
	 * @author ls2008
	 * @date 2019-07-23 16:59:39
	 * @param @param model
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	@RequestMapping("/list")
	public String listView(Model model) {
		return "modules/info/receive/projectreceive_list";
	}

	@Override
	public String addView(Model model, ServletRequest request) {
		return "404";
	}

	@Override
	public String editView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "404";
	}

	@Override
	public String detailView(Model model, ServletRequest request, ProjectReceiveEntity entity) {
		return "";
	}
	
	@RequestMapping(value = "/toAppendLog", method = RequestMethod.GET)
	public String subId(Model model, ServletRequest request,String subId) {
		model.addAttribute("subId", subId);
		model.addAttribute("curDate", DateUtil.getDate());
		return "modules/info/receive/project_receive_addlog";
	}

	/**
	 * 
	 * @param model
	 * @param request
	 * @param entity
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/saveReceiveLog")
	public ActionResultModel<StockStreamEntity> saveReceiveLog(Model model, ServletRequest request,ProjectReceiveEntity entity) {
		ActionResultModel<StockStreamEntity> arm = new ActionResultModel<StockStreamEntity>();
		arm.setSuccess(true);
		try {
			if(entity.getReceiveAmount()==null||entity.getReceiveAmount()==0){
				arm.setMsg("收货数量不能为空");
				arm.setSuccess(false);
				return arm;
			}
			arm =  service.saveReceiveLog(entity);
			arm.setRecords(new ArrayList<StockStreamEntity>());
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(Constants.getConstraintMsg(e.getMessage()));
		}catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		
		return arm;
	}
	
	
	@RequestMapping(value = "/toViewLog", method = RequestMethod.GET)
	public String toViewLog(Model model, ServletRequest request,String subId) {
		model.addAttribute("subId", subId);
		return "modules/info/receive/project_receive_viewlog";
	}
	
	
	/**
	 * 检查收货数量
	 * @param model
	 * @param request
	 * @param entity
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/checkReceiveCount")
	public ActionResultModel<ProjectReceiveEntity> checkReceiveCount(ServletRequest request,String subId,Long receiveAmount) {
		return  service.checkReceiveCount(subId,receiveAmount);
	}
}