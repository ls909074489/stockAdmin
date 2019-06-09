package com.king.modules.sys.rolegroup;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.TreeServiceImpl;
import com.king.modules.sys.role.RoleEntity;
import com.king.modules.sys.role.RoleService;

@Component
@Transactional
public class RoleGroupService extends TreeServiceImpl<RoleGroupEntity, String> {
	
	@Autowired
	private RoleGroupDAO dao;
	
	@Autowired
	@Lazy
	private RoleService roleService;

	@Override
	protected IBaseDAO<RoleGroupEntity, String> getDAO() {
		return dao;
	}
	
	public ActionResultModel<RoleGroupEntity> deleteRoleGroup(String pk) throws ServiceException {
		ActionResultModel<RoleGroupEntity> arm = new ActionResultModel<RoleGroupEntity>();
		RoleGroupEntity entity = this.getOne(pk);
		if (entity.getSys() != null && entity.getSys()) {
			//throw new ServiceException("不能删除系统角色组");
			arm.setMsg("不能删除系统角色组");
			arm.setSuccess(false);
		} else{
			if(isExist(entity.getUuid())){
				//throw new ServiceException("角色组【" + entity.getName() + "】已经存在子角色组，请先删除子角色组");
				arm.setMsg("角色组【" + entity.getName() + "】已经存在子角色组，请先删除子角色组");
				arm.setSuccess(false);
			}else{
				if(isAssRole(entity.getUuid())){
					arm.setMsg("角色组【" + entity.getName() + "】已经存在角色，请先删除角色");
					arm.setSuccess(false);
				}else {
					try {
						this.delete(entity);
						arm.setMsg("操作成功!");
						arm.setSuccess(true);
					} catch (Exception e) {
						arm.setMsg("操作失败!");
						arm.setSuccess(false);
						e.printStackTrace();
					}
				}
			}
			
		}
		return arm;
	}
	
	/**
	 * 
	 *TODO 当前角色组中是否存在子角色组
	 *@date  2014-1-3 下午12:42:28
	 *@param parentId
	 *@return
	 *@throws ServiceException
	 */
	public boolean isExist (String parentId) throws ServiceException {
		boolean flag = false;
		List<RoleGroupEntity> lists = this.findByParentId(parentId);
		if (lists != null && lists.size() > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 
	 *TODO 当前角色组中是否分配角色
	 *@date  2014-1-3 上午10:32:26
	 *@param roleGroupId
	 *@return
	 */
	public boolean isAssRole(String roleGroupId) {
		boolean flag = false;
//		List<RoleEntity> roles = roleDao.findByRoleGroupId(roleGroupId);
		List<RoleEntity> roles = roleService.searchGroupRoles(roleGroupId);
		if(roles != null && roles.size() > 0) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 获取第一级节点
	 * 
	 * @return
	 */
	public List<RoleGroupEntity> getFirstLevel() {
		return dao.getFirstLevel();
	}
	
	/**
	 * 根据父节点ID获取子节点，如果传入null或者空字符串，则返回第一级节点
	 * 
	 * @param parentId
	 * @return
	 */
	public List<RoleGroupEntity> findByParentId(String parentId) {
		if (StringUtils.isBlank(parentId)) {
			return getFirstLevel();
		}
		return dao.findByParentId(parentId);
	}
	

	/**
	 * 
	 * @param userID
	 * @param sysId
	 * @return
	 * @throws ServiceException
	 */
	public List<RoleGroupEntity> getUserFuncList(String userID, String sysId) throws ServiceException {
		RoleGroupEntity entity = this.getOne(sysId);
		List<RoleGroupEntity> list = dao.findByUuidNotAndNodepathLikeOrderByNodepathAsc(sysId,
				"%" + entity.getNodepath() + "%");
		return list;
	}
	
	
	/**
	 * 根据角色组编码查询
	 * @param code
	 * @return
	 */
	public RoleGroupEntity getGroupByCode(String code){
		RoleGroupEntity group=null;
		List<RoleGroupEntity> list=  dao.getGroupByCode(code);
		if(list!=null&&list.size()>0){
			group=list.get(0);
		}
		return group;
	}

}
