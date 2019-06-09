package com.king.modules.sys.user;

import java.util.List;

import javax.servlet.ServletRequest;
import javax.validation.Valid;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.role.RoleEntity;
import com.king.modules.sys.role.RoleService;
@Controller
@RequestMapping(value = "/userProfile")
public class UserProfileController extends BaseController<UserEntity> {
	
	
	@Autowired
	private RoleService roleService;//角色service
	
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "frame/user_profile";
	}
	
	
	@RequestMapping(value = "/current")
	@ResponseBody
	public ActionResultModel<UserEntity> currentUser() {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try{
		UserEntity  entity = ShiroUser.getCurrentUserEntity();
		List<RoleEntity> objList=roleService.findSelRole(entity.getUuid());
		String roleNames="";
		if(objList!=null&&objList.size()>0){
			for(RoleEntity role:objList){
				roleNames+=role.getName()+"、";
			}
		}
		if(roleNames.lastIndexOf("、")>0){
			roleNames=roleNames.substring(0, roleNames.lastIndexOf("、"));
		}
		entity.setUserrole(roleNames);
		arm.setRecords(entity);
		arm.setSuccess(true);
	} catch (ServiceException e) {
		// e.printStackTrace();
		arm.setSuccess(false);
		arm.setMsg(e.getMessage());
	}
	return arm;
	
	}
	

	/**
	 * 更新
	 * 
	 * @param entity
	 * @return
	 */
	@RequestMapping(value = "/update")
	@ResponseBody
	public ActionResultModel<UserEntity> update(ServletRequest request, Model model,
			@Valid @ModelAttribute("preloadEntity") UserEntity entity) {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			entity = baseService.save(entity);
			//需要重新赋值
			UserEntity user=ShiroUser.getCurrentUserEntity();
			entity.setOrgname(user.getOrgname());
			entity.setDeptname(user.getDeptname());
			entity.setOrgid(user.getOrgid());
			arm.setRecords(entity);
			arm.setSuccess(true);
			ShiroUser.updateCurrentUserEntity(entity);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

}
