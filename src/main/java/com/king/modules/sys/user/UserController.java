package com.king.modules.sys.user;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletRequest;

import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.security.SecurityConfig;
import com.king.frame.security.ShiroUser;

@Controller
@RequestMapping(value = "/sys/user")
public class UserController extends BaseController<UserEntity> {
	@Autowired
	SecurityConfig securityConfig;
	private static final String YearMonthDay = "yyyy-MM-dd";

	private UserService getService() {
		return (UserService) super.baseService;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String view(Model model) {
		SimpleDateFormat sdf = new SimpleDateFormat(YearMonthDay);
		model.addAttribute("nowDate", sdf.format(new Date()));
		return "modules/sys/user/user_main";
	}

	/**
	 * 重写用户管理列表查询方法
	 */
	@Override
	public ActionResultModel<UserEntity> query(ServletRequest request, Model model) {
		return getService().queryUserByPage(request);
	}

	@RequestMapping(value = "/pwd", method = RequestMethod.GET)
	public String viewChangePwd(Model model) {
		return "modules/sys/user/user_changepwd";
	}

	/**
	 * 服务器端分页 @Title: page @author liusheng @date 2016年3月22日 上午11:14:59 @param @return 设定文件 @return String 返回类型 @throws
	 */
	// @RequestMapping(value = "/page", method = RequestMethod.GET)
	// public String page() {
	//
	// return "modules/sys/user/user_main_page";
	// }

	/**
	 * 异步返回分页数据 @Title: pageQuery @author liusheng @date 2016年3月22日 上午11:15:06 @param @param request @param @param
	 * userParm @param @return 设定文件 @return ActionResultModel<UserEntity> 返回类型 @throws
	 */
	// @ResponseBody
	// @RequestMapping(value = "/page_query")
	// public ActionResultModel<UserEntity> pageQuery(ServletRequest request, String userParm) {
	// Map<String, String> map = new HashMap<String, String>();
	// try {
	// if (!StringUtils.isEmpty(userParm)) {
	// userParm = URLDecoder.decode(userParm, "UTF-8");
	// System.out.println(userParm);
	// map.put("LIKE_username", "%" + userParm + "%");
	// }
	// } catch (UnsupportedEncodingException e) {
	// e.printStackTrace();
	// }
	// ActionResultModel<UserEntity> pageData = doQuery(request);
	// // return new PageResult<UserEntity>(draw, pageData.getRecordsTotal(),
	// // pageData.getRecordsFiltered(), pageData.getRecords());
	// return pageData;
	// }

	/**
	 * 删除用户 @Title: deleUser @author liusheng @date 2016年1月13日 下午7:35:37 @param @param request @param @param
	 * model @param @param pks @param @return 设定文件 @return ActionResultModel 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/deleUser")
	public ActionResultModel<UserEntity> deleUser(@RequestParam(value = "pks") String[] pks) {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			arm = getService().deleUser(pks);
		} catch (DataIntegrityViolationException e) {
			arm.setSuccess(false);
			arm.setMsg("存在关联，不能删除");
			e.printStackTrace();
		} catch (ConstraintViolationException e) {
			arm.setSuccess(false);
			arm.setMsg("删除失败");
			e.printStackTrace();
		} catch (Exception e) {
			arm.setSuccess(false);
			arm.setMsg("删除失败");
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 保存用户
	 */
	@Override
	public ActionResultModel<UserEntity> add(ServletRequest request, Model model, UserEntity entity) {
		// return getService().addUser(entity);
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			arm = getService().addUser(entity);
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

	/**
	 * 修改用户
	 */
	// @Override
	// public ActionResultModel<UserEntity> update(ServletRequest request, Model model, UserEntity entity) {
	//// return getService().updateUser(entity);
	// return super.doUpdate(request, model, entity);
	// }

	/**
	 * 选择业务单元树方式 @Title: selectOrgTree @author liusheng @date 2016年2月18日 下午7:19:02 @param @param model @param @param
	 * callBackMethod @param @param userId @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/selectOrgTree")
	public String selectOrgTree(Model model, String callBackMethod, String userId) {
		model.addAttribute("callBackMethod", callBackMethod);
		model.addAttribute("userId", userId);
		return "modules/sys/data/org_select_tree";
	}


	/**
	 * 重置密码 @Title: resetpwd @author liusheng @date 2016年3月4日 下午4:36:35 @param @param userId @param @return 设定文件 @return
	 * ActionResultModel<UserEntity> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/resetpwd")
	public ActionResultModel<UserEntity> resetpwd(@RequestParam(value = "userId") String userId) {
		return getService().resetpwd(userId);
	}

	/**
	 * 修改密码
	 * 
	 * @param oldpassword
	 * @param newpassword
	 * @return
	 */
	@RequestMapping(value = "/changepwd")
	@ResponseBody
	private ActionResultModel<UserEntity> changePwd(@RequestParam String oldpassword, @RequestParam String newpassword) {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		UserEntity user = ShiroUser.getCurrentUserEntity();
		try {
			getService().changePwd(user.getUuid(), oldpassword, newpassword);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 启用和禁用用户 @Title: setuse @author liusheng @date 2016年3月7日 上午10:44:11 @param @param userId @param @return
	 * 设定文件 @return ActionResultModel<UserEntity> 返回类型 @throws
	 */
	@ResponseBody
	@RequestMapping(value = "/setIsuse")
	public ActionResultModel<UserEntity> setuse(@RequestParam(value = "userId") String userId,
			@RequestParam(value = "is_use") String is_use) {

		return getService().setuse(userId, is_use);
	}

	/**
	 * 选择角色页面 @Title: listRole @author liusheng @date 2016年3月18日 下午5:39:23 @param @param model @param @param
	 * callBackMethod @param @param selUserId @param @return 设定文件 @return String 返回类型 @throws
	 */
	@RequestMapping(value = "/listRole")
	public String listRole(Model model, String callBackMethod, String selUserId) {
		model.addAttribute("callBackMethod", callBackMethod);
		model.addAttribute("selUserId", selUserId);
		return "modules/sys/user/user_role_select";
	}

}
