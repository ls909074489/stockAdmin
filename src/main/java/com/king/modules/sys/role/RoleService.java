package com.king.modules.sys.role;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.king.common.bean.JsonBaseBean;
import com.king.common.bean.TreeBaseBean;
import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.common.utils.Constants;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.rolefunc.RoleFuncEntity;
import com.king.modules.sys.rolefunc.RoleFuncService;
import com.king.modules.sys.rolefuncaction.RoleFuncActionService;
import com.king.modules.sys.rolegroup.RoleGroupEntity;
import com.king.modules.sys.rolegroup.RoleGroupService;
import com.king.modules.sys.user.UserEntity;
import com.king.modules.sys.user.UserService;
import com.king.modules.sys.userrole.UserRoleService;

/**
 * 角色service
 * @ClassName: RoleService
 * @author liusheng 
 * @date 2015年12月17日 上午11:00:53
 */
@Service
@Transactional
public class RoleService extends BaseServiceImpl<RoleEntity, String>{

	@Autowired
	private RoleDao dao;
	
//	@Autowired
//	private RoleFuncDAO roleFuncDao;
	
	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private RoleFuncService roleFuncservice;
	@Autowired
	private RoleFuncActionService roleFuncActionService;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private RoleGroupService groupService;//角色组service
	@Autowired
	@Lazy
	private UserService userService;
	
	@Override
	protected IBaseDAO<RoleEntity, String> getDAO() {
		return dao;
	}
	
	/**
	 * 添加参数信息
	 */
	@Override
	public RoleEntity save(RoleEntity entity)throws ServiceException{
		return super.save(entity);
		
	}

	/**
	 * 保存角色权限
	 * @Title: savePermission 
	 * @author liusheng
	 * @date 2015年12月17日 下午1:59:17 
	 * @param @param checkedIds
	 * @param @return 设定文件 
	 * @return JsonBaseBean 返回类型 
	 * @throws
	 */
	public JsonBaseBean savePermission(String roleId,String checkedIds) {
		JsonBaseBean json=new JsonBaseBean();
		try {
			/*RoleEntity role =get(roleId);
			Map<String, RoleFuncEntity> map=new HashMap<String, RoleFuncEntity>();
			Set<RoleFuncEntity> roleFuncs = role.getRoleFuncs();
			for (RoleFuncEntity rf : roleFuncs){
				String permissionId = rf.getFunc().getUuid();
				map.put(permissionId, rf);
				updRolePermission(rf,Constants.PERSISTENCE_DELETE_STATUS);//先标志为删除
			}
			if (null!=checkedIds&&!"".equals(checkedIds)){
				String[] ids=checkedIds.split(",");
				FuncEntity func=null;
				for (String id : ids){
					RoleFuncEntity rolePermission = map.get(id);
					if (rolePermission!=null){
						updRolePermission(rolePermission,Constants.PERSISTENCE_NOMAL_STATUS);
					}else {
						rolePermission=new RoleFuncEntity();
						rolePermission.setStatus(Constants.PERSISTENCE_NOMAL_STATUS);
						func=new FuncEntity();
						func.setUuid(id);
						rolePermission.setFunc(func);
						rolePermission.setRole(role);
						roleFuncDao.save(rolePermission);
					}
				}
			}*/
			List<RoleFuncEntity> roleFuncList = roleFuncservice.getSelectFuncs(roleId);
			List<RoleFuncEntity> deleteList = new ArrayList<RoleFuncEntity>();
			List<String> addList = new ArrayList<String>();
			
			String[] ids=checkedIds.split(",");
			//找出需要删除的
			for(RoleFuncEntity roleFunc : roleFuncList){
				boolean found = false;
				if(ids!=null&&ids.length>0){
					for(String funcId:ids){
						if(roleFunc.getFunc().getUuid().equals(funcId)){
							found=true;
							break;
						}
					}
					if(!found){
						deleteList.add(roleFunc);
					}
				}
			}
			//找出需要添加的
			if(ids!=null&&ids.length>0){
				for(String funcId:ids){
					boolean found = false;
					for(RoleFuncEntity roleFunc : roleFuncList){
						if(roleFunc.getFunc().getUuid().equals(funcId)){
							found=true;
							break;
						}
					}
					if(!found){
						addList.add(funcId);
					}
				}
			}
			if(deleteList.size()>0){
//				roleFuncservice.delete(deleteList);
				for(RoleFuncEntity rf:deleteList){
					roleFuncActionService.deleByRoleFuncId(rf.getUuid());
					roleFuncservice.delete(rf.getUuid());
				}
			}
			if(addList.size()>0){
				roleFuncservice.save(roleId, addList);
			}
			json.setFlag(Constants.JSON_SUC);
		} catch (Exception e) {
			json.setFlag(Constants.JSON_FAIL);
			e.printStackTrace();
		}
		return json;
	}
	
//	private void updRolePermission(RoleFuncEntity rf,Integer status){
//		rf.setStatus(status);
//		roleFuncservice.save(rf);
//	}

	/**
	 * 获取角色能选择的权限
	 * @Title: getRoleFuncs 
	 * @author liusheng
	 * @date 2015年12月17日 下午4:53:02 
	 * @param @return 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> getRoleFuncs(String roleId) {
		List<FuncEntity> list=roleFuncservice.getRoleFuncs();
		List<RoleFuncEntity> rfList=roleFuncservice.getSelectFuncs(roleId);
		List<TreeBaseBean> treeList=new ArrayList<TreeBaseBean>();
		TreeBaseBean treeBean=null;
		boolean checked=false;
		boolean open=false;
		 for(FuncEntity o:list){
			 checked=false;
			 open=false;
			 for(RoleFuncEntity rf:rfList){
				 if(rf.getFunc().getUuid().equals(o.getUuid())){
					 checked=true;
					 open=true;
					 break;
				 }
			 }
			 treeBean=new TreeBaseBean(o.getUuid(), o.getName(), o.getParentId(),checked,open);
			 treeBean.setTitle(o.getName());
			 treeList.add(treeBean);
		 }
		 return treeList;
	}

	
	public List<RoleEntity> searchGroupRoles(String groupId) {
		List<RoleEntity> list=new ArrayList<RoleEntity>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select * from yy_role r where r.rolegroup_id='").append(groupId).append("'");
			list=dbDao.find(RoleEntity.class,sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 获取角色下的用户列表
	 * @Title: findUserByRoleId 
	 * @author liusheng
	 * @date 2015年12月24日 下午12:32:52 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<UserEntity> 返回类型 
	 * @throws
	 */
	public List<UserEntity> findUserByRoleId(String roleId) {
		return dao.findUserByRoleId(roleId);
	}
	
	/**
	 * 获取角色下的用户列表
	 * @Title: findUserByRoleId 
	 * @author liusheng
	 * @date 2015年12月24日 下午12:32:52 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<UserEntity> 返回类型 
	 * @throws
	 */
	public List<UserEntity> findUserByRoleId(String roleId,UserEntity user) {
		List<UserEntity> list=new ArrayList<UserEntity>();
		try {
			list=userService.findUserByRoleId(roleId,user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 获取可选中的用户列表
	 * @Title: findAllUserByRoleId 
	 * @author liusheng
	 * @date 2016年1月13日 下午3:46:37 
	 * @param @param roleId
	 * @param @param user
	 * @param @return 设定文件 
	 * @return List<UserEntity> 返回类型 
	 * @throws
	 */
	public List<UserEntity> findAllUserByRoleId(String roleId,UserEntity user) {
		List<UserEntity> list=new ArrayList<UserEntity>();
//		try {
//			StringBuilder sql=new StringBuilder();
//			sql.append("select u.*,ur.uuid userrole from yy_user u ");
//			sql.append("left join yy_userrole ur on u.uuid=ur.user_id ");
//			sql.append("and ur.role_id='").append(roleId).append("' where u.status='1' ");
//			if(!StringUtils.isEmpty(user.getLoginname())){
//				sql.append("and u.loginname like '%").append(user.getLoginname()).append("%' ");
//			}
//			if(!StringUtils.isEmpty(user.getUsername())){
//				sql.append("and u.username like '%").append(user.getUsername()).append("%' ");
//			}
//			sql.append("order by u.modifytime");
//			list=dbDao.find(UserEntity.class,sql.toString());
//		} catch (DAOException e) {
//			e.printStackTrace();
//		}
		
		try {
			list=userService.findAllByUserByRoleId(roleId,user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<FuncEntity> findFuncByRoleId(String roleId) {
		return roleFuncservice.findFuncByRoleId(roleId);
	}

	/**
	 * 删除角色
	 * @Title: delRole 
	 * @author liusheng
	 * @date 2015年12月29日 上午9:54:00 
	 * @param @param roleId 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void delRole(String roleId) {
		List<RoleFuncEntity> roleFuncList=roleFuncservice.findByRoleId(roleId);
		if(roleFuncList!=null&&roleFuncList.size()>0){
			for(RoleFuncEntity rf:roleFuncList){
				roleFuncActionService.deleByRoleFuncId(rf.getUuid());//删除角色菜单按钮表
			}
		}
		roleFuncservice.deleteByRoleId(roleId);//删除角色菜单表
		userRoleService.deleteByRoleId(roleId);//删除用户角色表
		dao.delete(roleId);//删除用户表
	}

	public void deleteByUserId(String[] userIds) throws ServiceException{
		userRoleService.deleteByUserId(userIds);
	}

	/**
	 * 根据角色编码获取角色
	 * @param roleCode
	 * @return
	 */
	public RoleEntity findByCode(String roleCode) {
		RoleEntity role=null;
		List<RoleEntity> list=dao.findByCode(roleCode);
		if(list!=null&&list.size()>0){
			role=list.get(0);
		}
		return role;
	}
	
	/**
	 * 根据角色组的编号获取角色
	 * @param groupCode
	 * @return
	 */
	public List<RoleEntity> findRoleByGroupCode(String groupCode) {
		RoleGroupEntity group=groupService.getGroupByCode(groupCode);
		List<RoleEntity> list=null;
		if(group!=null&&group.getUuid()!=null){
			list=searchGroupRoles(group.getUuid());
		}
		return list;
	}

	/**
	 * 获取角色列表并返回是否选入
	 * @Title: findAllAndSel 
	 * @author LiuSheng
	 * @date 2016年3月7日 下午8:27:26 
	 * @param @return 设定文件 
	 * @return List<RoleEntity> 返回类型 
	 * @throws
	 */
	public List<RoleEntity> findAllAndSel(String userId) {
		List<RoleEntity> list=new ArrayList<RoleEntity>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select rg.rolegroup_name roleGroupName,ur.uuid urUuid,r.* from yy_role r ");
			sql.append("left join yy_rolegroup rg on rg.uuid=r.rolegroup_id "); 
			sql.append("left join yy_userrole ur on ur.role_id=r.uuid and ur.user_id='").append(userId).append("'");
			sql.append("where r.`status`=1 ");
			sql.append("order by r.rolegroup_id");
			list=dbDao.find(RoleEntity.class,sql.toString());
			if(list!=null&&list.size()>0){
				RoleGroupEntity rolegroup=null;
				for(RoleEntity role:list){
					rolegroup=new RoleGroupEntity();
					rolegroup.setRolegroup_name(role.getRoleGroupName());
					role.setRolegroup(rolegroup);
				}
			}
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 查询用户选择的角色
	 * @Title: findSelRole 
	 * @author liusheng
	 * @date 2016年3月18日 下午5:48:01 
	 * @param @param userId
	 * @param @return 设定文件 
	 * @return List<RoleEntity> 返回类型 
	 * @throws
	 */
	public List<RoleEntity> findSelRole(String userId) {
		List<RoleEntity> list=new ArrayList<RoleEntity>();
//		try {
//			StringBuilder sql=new StringBuilder();
//			sql.append("select rg.rolegroup_name roleGroupName,ur.uuid urUuid,r.* from yy_userrole ur");
//			sql.append("left join yy_role r on r.uuid=ur.role_id ");
//			sql.append("left join yy_rolegroup rg on rg.uuid=r.rolegroup_id  ");
//			sql.append("where ur.user_id='").append(userId).append("'");
//			list=dbDao.find(RoleEntity.class,sql.toString());
//			if(list!=null&&list.size()>0){
//				RoleGroupEntity rolegroup=null;
//				for(RoleEntity role:list){
//					rolegroup=new RoleGroupEntity();
//					rolegroup.setRolegroup_name(role.getRoleGroupName());
//					role.setRolegroup(rolegroup);
//				}
//			}
//		} catch (DAOException e) {
//			e.printStackTrace();
//		}
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select rg.rolegroup_name roleGroupName,t_r.* from (select r.* from yy_role r where exists (select * from yy_userrole ur where ");
			sql.append("ur.user_id='").append(userId).append("' and ur.role_id=r.uuid)) t_r ");
			sql.append("left join yy_rolegroup rg on rg.uuid= t_r.rolegroup_id ");
			sql.append("order by rg.rolegroup_code,t_r.rolegroup_id desc");
			list=dbDao.find(RoleEntity.class,sql.toString());
			if(list!=null&&list.size()>0){
				RoleGroupEntity rolegroup=null;
				for(RoleEntity role:list){
					rolegroup=new RoleGroupEntity();
					rolegroup.setRolegroup_name(role.getRoleGroupName());
					role.setRolegroup(rolegroup);
				}
			}
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 用户没有选择的角色
	 * @Title: findUnSelRole 
	 * @author liusheng
	 * @date 2016年3月18日 下午6:10:16 
	 * @param @param userId
	 * @param @return 设定文件 
	 * @return List<RoleEntity> 返回类型 
	 * @throws
	 */
	public List<RoleEntity> findUnSelRole(String userId) {
		List<RoleEntity> list=new ArrayList<RoleEntity>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select rg.rolegroup_name roleGroupName,t_r.* from (select r.* from yy_role r where not exists (select * from yy_userrole ur where ");
			sql.append("ur.user_id='").append(userId).append("' and ur.role_id=r.uuid)) t_r ");
			sql.append("left join yy_rolegroup rg on rg.uuid= t_r.rolegroup_id ");
			sql.append("order by rg.rolegroup_code,t_r.rolegroup_id desc");
			list=dbDao.find(RoleEntity.class,sql.toString());
			if(list!=null&&list.size()>0){
				RoleGroupEntity rolegroup=null;
				for(RoleEntity role:list){
					rolegroup=new RoleGroupEntity();
					rolegroup.setRolegroup_name(role.getRoleGroupName());
					role.setRolegroup(rolegroup);
				}
			}
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}
	


	/**
	 * 获取角色列表
	 * @Title: dataPersonList 
	 * @author liusheng
	 * @date 2016年1月28日 下午7:00:36 
	 * @param @param obj
	 * @param @return 设定文件 
	 * @return List<RoleEntity> 返回类型 
	 * @throws
	 */
//	public List<RoleEntity> dataRoleList(RoleEntity obj) {
//		List<RoleEntity> list=new ArrayList<RoleEntity>();
//		try {
//			StringBuilder sql=new StringBuilder();
//			sql.append("select rg.rolegroup_name roleGroupName,r.* from yy_role  ");
//			sql.append("left join yy_rolegroup rg on rg.uuid=r.rolegroup_id ");
//			sql.append("where r.`status`=1 order by r.rolegroup_id");
//			list=dbDao.find(RoleEntity.class,sql.toString());
//		} catch (DAOException e) {
//			e.printStackTrace();
//		}
//		return list;
//	}

	
}
 