package com.king.modules.sys.rolegroup;

import java.util.List;

import javax.servlet.ServletRequest;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.TreeController;
import com.king.frame.tree.TreeNode;
import com.king.frame.tree.TreeUtils;
@Controller
@RequestMapping(value = "/sys/roleGroup")
public class RoleGroupController extends TreeController<RoleGroupEntity> {
	private RoleGroupService getService() {
		return (RoleGroupService) super.baseService;
	}
	@Autowired
	protected RoleGroupService roleGroupService;

	@RequestMapping(method = RequestMethod.GET)
	public String view() {
		return "modules/sys/roleGroup/rolegroup_main";
	}

	@RequestMapping(value = "/selectRoleGroup")
	public String selectFunc() {
		return "modules/sys/roleGroup/rolegroup_select";
	}

//	@RequestMapping(value = "/selectIcon")
//	public String selectIcon() {
//		return "modules/sys/roleGroup/rolegroup_icons";
//	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getTreeNodes")
	@ResponseBody
	private ActionResultModel<TreeNode> getTreeNodes(ServletRequest request,
			@RequestParam(value = "node", defaultValue = "") String pid) {
		ActionResultModel<TreeNode> arm = new ActionResultModel<TreeNode>();
		try {
			List<RoleGroupEntity> list = getService().findByParentId(pid);// <FuncEntity>
			List allList = (List) getService().findAll(new Sort(Sort.Direction.ASC, "nodepath"));// (ITreeEntity)
																									// list.get(0),
			TreeNode tree = TreeUtils.getTreeNode(list.get(0), allList);
			arm.setRecords(tree);
			arm.setTotal(0);
			arm.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			arm.setMsg(e.getMessage());
		}
		return arm;
	}
	
	/**
	 * 删除角色组
	 * @Title: delete 
	 * @author liusheng
	 * @date 2016年1月13日 下午6:04:31 
	 * @param @param request
	 * @param @param model
	 * @param @param pks
	 * @param @return 设定文件 
	 * @return ActionResultModel 返回类型 
	 * @throws
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/delRoleGroup")
	@ResponseBody
	public ActionResultModel delete(ServletRequest request, Model model, String pks) {
		ActionResultModel arm = new ActionResultModel();
		try {
			arm=roleGroupService.deleteRoleGroup(pks);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
		}
		return arm;
	}

	/**
	 * 保存
	 */
	@Override
	public ActionResultModel<RoleGroupEntity> add(ServletRequest request, Model model, RoleGroupEntity entity) {
		List<RoleGroupEntity> result = (List<RoleGroupEntity>) getService().findByParentId(entity.getParentid());
		if(result!=null&&result.size()>0){
			for (RoleGroupEntity a : result) {
				if(a.getRolegroup_name().equals(entity.getRolegroup_name())){
					ActionResultModel<RoleGroupEntity> arm=new ActionResultModel<RoleGroupEntity>();
					arm.setSuccess(false);
					arm.setMsg("同级下已添加"+entity.getRolegroup_name());
					return arm;
				}
			}
		}
		return super.add(request, model, entity);
	}

	/**
	 * 更新
	 */
	@Override
	public ActionResultModel<RoleGroupEntity> update(ServletRequest request, Model model, RoleGroupEntity entity) {
		List<RoleGroupEntity> result = (List<RoleGroupEntity>) getService()
				.findByParentId(entity.getParentid());
		if(result!=null&&result.size()>0){
			for (RoleGroupEntity a : result) {
				if(a.getRolegroup_name().equals(entity.getRolegroup_name())&&!a.getUuid().equals(entity.getUuid())){
					ActionResultModel<RoleGroupEntity> arm=new ActionResultModel<RoleGroupEntity>();
					arm.setSuccess(false);
					arm.setMsg("同级下已添加"+entity.getRolegroup_name());
					return arm;
				}
			}
		}
		return super.update(request, model, entity);
	}
	
	
	
}
