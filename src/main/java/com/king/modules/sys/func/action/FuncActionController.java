package com.king.modules.sys.func.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.func.FuncService;

@Controller
@RequestMapping(value = "/sys/funcAction")
public class FuncActionController  extends BaseController<FuncActionEntity>{
	
	private FuncActionService getService(){
		return (FuncActionService)super.baseService;
	}
	
	@Autowired
	FuncService funcService;
	
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/saveAll")
	@ResponseBody
	public ActionResultModel save(ServletRequest request, Model model
			,@RequestParam(value = "uuid",required=false) String[] uuid
			,@RequestParam(value = "funcid",required=false) String[] funcid
			,@RequestParam(value = "actioncode",required=false) String[] actioncode
			,@RequestParam(value = "actionname",required=false) String[] actionname
			,@RequestParam(value = "deletePKs",required=false) String[] deletePKs) {
		ActionResultModel arm = new ActionResultModel();
		try {
			List<FuncActionEntity> saveList = this.convertToEntities(uuid,funcid,actioncode,actionname);
			getService().saveAndDelete(saveList,deletePKs);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			e.printStackTrace();
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}catch (Exception e) {
			if(e.getMessage().indexOf("ConstraintViolationException")>0){
				arm.setSuccess(false);
				arm.setMsg("按钮编码已存在");
				e.printStackTrace();
			}else{
				arm.setSuccess(false);
				arm.setMsg(e.getMessage());
				e.printStackTrace();
			}
		}
		return arm;
	}
	private List<FuncActionEntity> convertToEntities(String[] uuid, String[] funcId, String[] actionCode, String[] actionName) throws ServiceException {
		if(actionCode!=null&&actionCode.length>0){
			if(uuid.length!=actionCode.length){
				uuid = new String[actionCode.length];
			}
			List<FuncActionEntity> list = new ArrayList<FuncActionEntity>();
			for(int i=0;i<actionCode.length;i++){
				FuncActionEntity funcAction ;
				if(StringUtils.isNotBlank(uuid[i])){
					funcAction = getService().getOne(uuid[i]);
				}else{
					funcAction = new FuncActionEntity();
				}
				funcAction.setUuid(uuid[i]);
				funcAction.setActioncode(actionCode[i]);
				funcAction.setActionname(actionName[i]);
				FuncEntity func = funcService.getOne(funcId[i]);
				funcAction.setFunc(func);
				list.add(funcAction);
			}
			return list;
		}
		return null;
	}
}
