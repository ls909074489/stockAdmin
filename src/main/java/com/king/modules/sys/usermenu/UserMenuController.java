package com.king.modules.sys.usermenu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.security.ShiroUser;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.user.UserService;

/**
 * 快捷菜单controller
 * 
 * @ClassName: UserMenuController
 * @author
 * @date 2016年42月27日 07:19:23
 */
@Controller
@RequestMapping(value = "/sys/usermenu")
public class UserMenuController extends BaseController<UserMenuEntity> {

	@Autowired
	UserService userService;

	private UserMenuService getService() {
		return (UserMenuService) super.baseService;
	}

	/**
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "csc/bd/usermenu/usermenu_main";
	}

	/**
	 * 添加用户自定义菜单
	 */
	@ResponseBody
	@RequestMapping(value = "/addUserMenu")
	public ActionResultModel<UserMenuEntity> addUserMenu(@RequestParam(value = "funcid") String funcid) {
		ActionResultModel<UserMenuEntity> arm = new ActionResultModel<UserMenuEntity>();
		try {

			UserEntity user = ShiroUser.getCurrentUserEntity();
			// List functreeList = userService.getUserFunc(user.getUuid());
			UserMenuEntity entity = getService().addUserMenu(funcid, user.getUuid());
			arm.setRecords(entity);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("添加失败");
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 添加用户自定义菜单
	 */
	@ResponseBody
	@RequestMapping(value = "/queryUserMenu")
	public ActionResultModel<UserMenuEntity> queryUserMenu() {
		ActionResultModel<UserMenuEntity> arm = new ActionResultModel<UserMenuEntity>();
		try {
			UserEntity user = ShiroUser.getCurrentUserEntity();
			// 判断权限
			List<UserMenuEntity> lists = getService().queryUserMenu(user.getUuid());
			List<UserMenuEntity> newlists = new ArrayList<UserMenuEntity>();

			if (lists.size() > 0) {
				List<FuncEntity> functreeList = userService.getUserFunc(user.getUuid());
				Map<String, FuncEntity> funcMap = new HashMap<String, FuncEntity>();
				for (FuncEntity funcEntity : functreeList) {
					funcMap.put(funcEntity.getUuid(), funcEntity);
				}
				int userMenuNum = ParameterUtil.getIntParamValue("UserMenuNum", 6);
				for (UserMenuEntity entity : lists) {
					if (funcMap.containsKey(entity.getFuncid())) {
						String url = funcMap.get(entity.getFuncid()).getFunc_url();
						if (!StringUtils.isEmpty(url)) {
							entity.setFuncurl(url);
						} else {
							entity.setFuncurl("");
						}
						if (StringUtils.isEmpty(entity.getFuncname())) {
							entity.setFuncname(funcMap.get(entity.getFuncid()).getFunc_name());
						}
						newlists.add(entity);

						if (newlists.size() >= userMenuNum) {
							break;
						}
					} else {
						getService().delete(entity);
					}
				}
			}

			arm.setRecords(newlists);
			arm.setSuccess(true);
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("添加失败");
			e.printStackTrace();
		}
		return arm;
	}

}
