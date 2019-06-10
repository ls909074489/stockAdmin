package com.king.modules.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.king.common.utils.Constants;
import com.king.common.utils.MD5;
import com.king.common.utils.RandomUtil;
import com.king.frame.security.ShiroUser;
import com.king.frame.tree.TreeNode;
import com.king.frame.tree.TreeUtils;
import com.king.modules.sys.enumdata.EnumDataSubEntity;
import com.king.modules.sys.enumdata.EnumDataUtils;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.func.FuncService;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.user.UserService;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)，
 * 
 * 真正登录的POST请求由Filter完成,
 * 
 */
@Controller
public class HomeController {

	private static final String USER_FUNCS = "USERFUNCS";

	@Autowired
	FuncService funcService;

	@Autowired
	UserService userService;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String view(Model model,HttpServletRequest request) {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		if (user != null) {
			List<TreeNode> tree = null;

			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(); 
			tree = (List<TreeNode>) session.getAttribute(USER_FUNCS);
			if (tree == null || tree.size() == 0) {
				List functreeList = userService.getUserFunc(user.getUuid());
				tree = TreeUtils.getTreeNodes(functreeList);
				subject.getSession().setAttribute(USER_FUNCS, tree);
				subject.getSession().setAttribute("userid", user.getUuid());
			}

			model.addAttribute("functreeList", tree);
			// model.addAttribute("countModule", getCount(tree));
			model.addAttribute("user", user);
			model.addAttribute("yy_logo_imge", ParameterUtil.getParamValue("yy_logo_imge", ""));
			model.addAttribute("yy_logo_title", ParameterUtil.getParamValue("yy_logo_title", ""));
			model.addAttribute("yy_footer_title", ParameterUtil.getParamValue("yy_footer_title", "2015 © 版权所有."));
			model.addAttribute("systitle", ParameterUtil.getParamValue("yy_title", "后台管理系统"));

			HttpSession httpSession = request.getSession(true);
			OrgEntity station=(OrgEntity) httpSession.getAttribute(Constants.CURRENTSTATION);
			String hasSelStation="0";//是否选择了当前的厂商
			if(station!=null&&!StringUtils.isEmpty(station.getUuid())){
				hasSelStation="1";
				model.addAttribute("currentStation", station);
			}
			model.addAttribute("hasSelStation", hasSelStation);
		}
		model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
		if(user.getUsertype()!=null&&user.getUsertype()==2){//用户类型为管理
			return "frame/yy_main";
		}else{
			List<EnumDataSubEntity> topMenus=EnumDataUtils.getEnumSubList("CommonMenus");
			model.addAttribute("apiurl", ParameterUtil.getParamValue("apiurl", "http://app.weishiao.com:8080/qjb"));
			model.addAttribute("topMenus", topMenus);
			String apiUserType=user.getApiUserType();
			if(StringUtils.isEmpty(apiUserType)){
				apiUserType="1";
			}
			EnumDataSubEntity indexEnum=topMenus.get(0);
			for(EnumDataSubEntity sub:topMenus){
				String []arr=sub.getDescription().split(",");
				for(String s:arr){
					if(s.equals(apiUserType)){
						indexEnum=sub;
						break;
					}
				}
			}
			model.addAttribute("indexEnum", indexEnum);
			return "frame/yy_main_topmenu";
		}
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/api/home", method = RequestMethod.GET)
	public String apiHome(Model model,HttpServletRequest request) {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		if (user != null) {
			String sysId = "";
			if ("".equals(sysId)) {
				sysId = "2c90e4d74917c191014917c3cf1d0000";
			}

			List<TreeNode> tree = null;

			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(); 
			tree = (List<TreeNode>) session.getAttribute(USER_FUNCS);
			if (tree == null || tree.size() == 0) {
				List functreeList = userService.getUserFunc(user.getUuid());
				tree = TreeUtils.getTreeNodes(functreeList);
				subject.getSession().setAttribute(USER_FUNCS, tree);
				subject.getSession().setAttribute("userid", user.getUuid());
			}

			FuncEntity funcEntity = funcService.getOne(sysId);
			model.addAttribute("functreeList", tree);
			// model.addAttribute("countModule", getCount(tree));
			model.addAttribute("user", user);
			model.addAttribute("yy_logo_imge", ParameterUtil.getParamValue("yy_logo_imge", ""));
			model.addAttribute("yy_logo_title", ParameterUtil.getParamValue("yy_logo_title", ""));
			model.addAttribute("yy_footer_title", ParameterUtil.getParamValue("yy_footer_title", "2015 © 版权所有."));
			model.addAttribute("systitle", funcEntity.getFunc_name());

			HttpSession httpSession = request.getSession(true);
			OrgEntity station=(OrgEntity) httpSession.getAttribute(Constants.CURRENTSTATION);
			String hasSelStation="0";//是否选择了当前的厂商
			if(station!=null&&!StringUtils.isEmpty(station.getUuid())){
				hasSelStation="1";
				model.addAttribute("currentStation", station);
			}
			model.addAttribute("hasSelStation", hasSelStation);
		}
		List<EnumDataSubEntity> topMenus=EnumDataUtils.getEnumSubList("CommonMenus");
		model.addAttribute("topMenus", topMenus);
		return "frame/yy_main_topmenu";
	}

	@RequestMapping("/admin")
	public String admin(Model model, HttpServletRequest request) {
		UserEntity user = ShiroUser.getCurrentUserEntity();
		if (user != null) {
			return "redirect:/";
		}
		// 验证码
		String rcode = RandomUtil.getString(6);
		// 将生成的验证码存入session
		HttpSession session = request.getSession(true);
		session.setAttribute("validateCode", MD5.MD5Encode(MD5.MD5Encode(rcode)));
		model.addAttribute("rcode", rcode);
		return "login2";
	}
}
