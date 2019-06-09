package com.king.modules.sys.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.transaction.Transactional;

import org.apache.commons.lang.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.common.utils.Constants;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.controller.BaseController;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.security.SecurityConfig;
import com.king.frame.security.ShiroUser;
import com.king.frame.service.BaseServiceImpl;
import com.king.frame.utils.Digests;
import com.king.frame.utils.Encodes;
import com.king.frame.utils.RequestUtil;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.func.action.FuncActionEntity;
import com.king.modules.sys.org.OrgRef;
import com.king.modules.sys.param.ParameterUtil;
import com.king.modules.sys.role.RoleEntity;
import com.king.modules.sys.role.RoleService;
import com.king.modules.sys.userrole.UserRoleService;

@Service
@Transactional
public class UserService extends BaseServiceImpl<UserEntity, String> {

	@Autowired
	private UserDAO dao;
	@Autowired
	SecurityConfig securityConfig;
	@Autowired
	private DbUtilsDAO dbDao;
	@Autowired
	private UserRoleService userRoleService;
	@Autowired
	private RoleService roleService;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}

	@Override
	public void beforeAdd(UserEntity entity) throws ServiceException {
		this.entryptPassword(entity);
	}

	@Override
	public void afterSave(UserEntity newEntity) throws ServiceException {
		// 如果是关联用户类型
		Integer usertype = newEntity.getUsertype();
		if (!org.springframework.util.StringUtils.isEmpty(usertype)) {
			List<RoleEntity> roleList = roleService.findSelRole(newEntity.getUuid());
			boolean hasRole = false;
			if (roleList != null && roleList.size() > 0) {
				hasRole = true;
			}
			if (usertype == 3) {// 教师
				boolean hasDefaultRole = false;
				String teacherRole = ParameterUtil.getParamValue("TeacherRoleId",
						"9c356a49-de60-45c2-befe-a197c68e4f1f");
				if (hasRole) {
					for (RoleEntity r : roleList) {
						if (r.getUuid().equals(teacherRole)) {
							hasDefaultRole = true;
						}
					}
				}
				if (!hasDefaultRole) {
					userRoleService.selecRoleUser(teacherRole, newEntity.getUuid());
				}
			} else if (usertype == 4) {// 学生
				boolean hasDefaultRole = false;
				String studentRole = ParameterUtil.getParamValue("StudentRoleId",
						"785014b7-2363-4481-b260-7ffca1cb8394");
				if (hasRole) {
					for (RoleEntity r : roleList) {
						if (r.getUuid().equals(studentRole)) {
							hasDefaultRole = true;
						}
					}
				}
				if (!hasDefaultRole) {
					userRoleService.selecRoleUser(studentRole, newEntity.getUuid());
				}
			}
		}

	}

	@Override
	public void beforeUpdate(UserEntity entity) throws ServiceException {
	}

	/**
	 * 保存用户，在保存之前进行密码加密
	 */
	@Override
	public UserEntity save(UserEntity entity) throws ServiceException {
		if (StringUtils.isEmpty(entity.getOrgid())) {
			// throw new ServiceException("用户的业务单元不能为空.");
			entity.setOrg(null);
		}
		try {
			return super.save(entity);
		} catch (org.hibernate.service.spi.ServiceException e) {
			String msg = e.getMessage();
			if (msg.indexOf("loginname") > 0) {
				throw new ServiceException("登录账号重复");
			} else {
				throw new ServiceException(e.getMessage());
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}

	/**
	 * 对密码进行加密
	 */
	public void entryptPassword(UserEntity user) {
		byte[] salt = null;
		if (securityConfig.isSaltEnable()) {
			salt = Digests.generateSalt(securityConfig.getSaltSize());
			user.setSalt(Encodes.encodeHex(salt));
		}

		String plainpassword = user.getPlainpassword();
		if (StringUtils.isEmpty(StringUtils.trim(plainpassword))) {
			plainpassword = ParameterUtil.getParamValue(Constants.ParamCode.DEFAULT_PWD,
					securityConfig.getPlainpassword());
		}

		// if (user.getPassword() != null && !"".equals(user.getPassword())) {
		// plainpassword = StringUtils.trim(user.getPassword());
		// }
		// 加密次数
		int hashInterations = securityConfig.getHashInterations();
		user.setPlainpassword(plainpassword);
		byte[] hashPassword = null;
		hashPassword = Digests.sha1(user.getPlainpassword().getBytes(), salt, hashInterations);
		user.setPassword(Encodes.encodeHex(hashPassword));
	}

	@Override
	public Iterable<UserEntity> save(Iterable<UserEntity> entities) throws ServiceException {
		return super.save(entities);
	}

	/**
	 * 根据登录名获取用户对象
	 * 
	 * @param loginName
	 * @return
	 * @throws ServiceException
	 */
	public UserEntity findByLoginname(String loginName) throws ServiceException {
		return dao.findByLoginname(loginName);
	}

	/**
	 * 根据用户的id查询该用户的角色
	 * 
	 * @param userUuid
	 * @return
	 * @throws ServiceException
	 */
	public List<RoleEntity> getUserRoles(String userUuid) throws ServiceException {
		return dao.findRoleByUserId(userUuid);
	}

	/**
	 * 根据用户id查询用户的功能菜单
	 * 
	 * @param userUuid
	 * @return
	 * @throws ServiceException
	 */
	public List<FuncEntity> getUserFunc(String userUuid) throws ServiceException {
		return dao.findFuncByUserId(userUuid);
	}

	/**
	 * 根据用户id获取用户所在角色的菜单绑定的按钮权限
	 * 
	 * @param userUuid
	 * @return
	 * @throws ServiceException
	 */
	public List<FuncActionEntity> getUserFuncAction(String userUuid) throws ServiceException {
		List<FuncActionEntity> list = new ArrayList<FuncActionEntity>();
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("select fa.* from yy_rolefunc_action rfa ");
			sql.append("left join yy_role_func rf on rf.uuid=rfa.rolefunc_id and 1=1 ");
			sql.append("left join yy_role r on r.uuid=rf.role_id ");
			sql.append("left join yy_userrole ur on ur.role_id=r.uuid ");
			sql.append("left join yy_user u on u.uuid=ur.user_id ");
			sql.append("left join yy_func_action fa on fa.uuid=rfa.func_action_id ");
			sql.append("where u.uuid='").append(userUuid).append("'");
			list = dbDao.find(FuncActionEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	public ActionResultModel<UserEntity> deleUser(String[] pks) {
		ActionResultModel<UserEntity> result = new ActionResultModel<UserEntity>();
		try {
			// 删除用户和角色的中间表
			userRoleService.deleteByUserId(pks);
			doDelete(pks);
			result.setMsg("操作成功!");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败!");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}



	/**
	 * 根据单元的id查询user
	 * 
	 * @param pkCorp
	 * @return
	 */
	public List<UserEntity> findByOrgId(String pkCorp) {
		return dao.findByOrgId(pkCorp);
	}

	public String entryptPassword(String plainPassword, String saltStr) {
		if (StringUtils.isBlank(plainPassword)) {
			return "";
		}
		byte[] salt = null;
		if (securityConfig.isSaltEnable()) {
			salt = Encodes.decodeHex(saltStr);
		}
		int times = securityConfig.getHashInterations();

		byte[] hashPassword = null;
		hashPassword = Digests.sha1(plainPassword.getBytes(), salt, times);
		return Encodes.encodeHex(hashPassword);
	}

	/**
	 * 修改用户密码
	 * 
	 * @author Kevin
	 * @param pk
	 *            用户主键（UUID）
	 * @throws ServiceException
	 */
	public void changePwd(String pk, String oldpassword, String newpassword) throws ServiceException {
		UserEntity user = this.getOne(pk);
		String oldPasswordEntry = entryptPassword(oldpassword, user.getSalt());
		if (!oldPasswordEntry.equals(user.getPassword())) {
			throw new ServiceException("原密码错误！");
		} else {
			if (newpassword.equals(ParameterUtil.getParamValue(Constants.ParamCode.DEFAULT_PWD, "Csc@2016"))) {
				throw new ServiceException("新密码不能与默认密码相同！");
			}
			String newPasswordEntry = entryptPassword(newpassword, user.getSalt());
			if (newPasswordEntry.equals(user.getPassword())) {
				throw new ServiceException("新密码不能与原密码相同！");
			}
			try {
				user.setPlainpassword(newpassword);
				this.entryptPassword(user);
				user.setChangepwd((user.getChangepwd() == null ? 0 : user.getChangepwd()) + 1);
				user = save(user);

				// 需要重新赋值
				// 修改shiro的user 需要更新修改密码次数
				UserEntity oldUser = ShiroUser.getCurrentUserEntity();
				user.setOrgname(oldUser.getOrgname());
				user.setDeptname(oldUser.getDeptname());
				user.setOrgid(oldUser.getOrgid());
				ShiroUser.updateCurrentUserEntity(user);
			} catch (ServiceException e) {
				throw new ServiceException(e.getMessage());
			}
		}
	}

	/**
	 * 重置密码 @Title: resetpwd @author liusheng @date 2016年3月4日 下午4:37:59 @param @param userId @param @return 设定文件 @return
	 * ActionResultModel<UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> resetpwd(String userId) {
		ActionResultModel<UserEntity> result = new ActionResultModel<UserEntity>();
		try {
			UserEntity entity = getOne(userId);
			entity.setPlainpassword(
					ParameterUtil.getParamValue(Constants.ParamCode.DEFAULT_PWD, securityConfig.getPlainpassword()));// 重置密码
			this.entryptPassword(entity);
			this.save(entity);
			result.setMsg("操作成功!");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败!");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 启用和禁用用户 @Title: setuse @author liusheng @date 2016年3月7日 上午10:47:39 @param @param userId @param @param
	 * is_use @param @return 设定文件 @return ActionResultModel<UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> setuse(String userId, String is_use) {
		ActionResultModel<UserEntity> result = new ActionResultModel<UserEntity>();
		try {
			UserEntity entity = getOne(userId);
			entity.setIs_use(is_use);
			if (!org.springframework.util.StringUtils.isEmpty(is_use) && "1".equals(is_use)) {
				// 启用后设置为登录日志为有效
				// logLoginService.setIsValid(entity.getLoginname());
				entity.setLoginFailCount(0l);
			}
			this.save(entity);
			result.setMsg("操作成功!");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败!");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 根据用户名禁用和启用 @Title: setUseFalse @author liusheng @date 2016年3月29日 上午11:49:32 @param @param
	 * loginName @param @return 设定文件 @return ActionResultModel<UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> setUseByName(String loginName, String is_use) {
		ActionResultModel<UserEntity> result = new ActionResultModel<UserEntity>();
		try {
			/*
			 * UserEntity user=dao.findByLoginname(userName); user.setIs_use(is_use); this.save(user);
			 */
			dao.setUseByName(loginName, is_use);
			result.setMsg("操作成功!");
			result.setSuccess(true);
		} catch (Exception e) {
			result.setMsg("操作失败!");
			result.setSuccess(false);
			e.printStackTrace();
		}
		return result;
	}

	public List<UserEntity> queryUserAll() {
		return dao.queryUserAll();
	}

	/**
	 * 用户列表 @Title: queryUser @author liusheng @date 2016年4月19日 下午3:58:36 @param @return 设定文件 @return ActionResultModel
	 * <UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> queryUser() {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			List<UserEntity> list = getUserBySql();
			arm.setRecords(list);
			arm.setTotal(list.size());
			arm.setTotalPages(1);
			arm.setSuccess(true);
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 分页查询 @Title: queryUserByPage @author liusheng @date 2016年7月15日 下午5:34:31 @param @param request @param @return
	 * 设定文件 @return ActionResultModel<UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> queryUserByPage(ServletRequest request) {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		String loginname = request.getParameter("search_loginname");
		String username = request.getParameter("search_username");
		String jobnumber = request.getParameter("search_jobnumber");
		String usertype = request.getParameter("search_usertype");
		try {
			int pageIndex = 0;
			int pageSize = RequestUtil.getIntParameter(request, BaseController.PARAM_NAME_PAGESIZE,
					BaseController.DEFAULT_PARAM_PAGESIZE);
			if (RequestUtil.hasParameter(request, BaseController.PARAM_NAME_PAGESIZE)) {
				// 并且pageSize>0
				if (pageSize > 0) {
					int startIdx = RequestUtil.getIntParameter(request, BaseController.PARAM_NAME_STARTINDEX, 0);
					pageIndex = startIdx / pageSize;
				}
			}

			StringBuffer sql = new StringBuffer();
			sql.append("select u.*,o.org_name orgname from yy_user u ");
			sql.append("left join yy_org o on o.uuid=u.orgid ");
			sql.append("where u.status='1' ");
			if (!org.springframework.util.StringUtils.isEmpty(loginname)) {
				sql.append("and u.loginname like '%").append(loginname).append("%' ");
			}
			if (!org.springframework.util.StringUtils.isEmpty(username)) {
				sql.append("and u.username like '%").append(username).append("%' ");
			}
			if (!org.springframework.util.StringUtils.isEmpty(jobnumber)) {
				sql.append("and u.jobnumber like '%").append(jobnumber).append("%' ");
			}
			if (!org.springframework.util.StringUtils.isEmpty(usertype)) {
				sql.append("and u.usertype = '").append(usertype).append("' ");
			}

			String orderBy = request.getParameter("orderby");
			if (!StringUtils.isEmpty(orderBy)) {
				if (orderBy.contains("orgname")) {
					sql.append("order by o.org_name ").append(orderBy.replace("orgname@", " "));
				} else if (orderBy.contains("personname")) {
					sql.append("order by p.name ").append(orderBy.replace("personname@", " "));
				} else {
					sql.append("order by u.").append(orderBy.replace("@", " "));
				}
			} else {
				sql.append("order by u.ts DESC");
			}
			List<UserEntity> list = new ArrayList<UserEntity>();
			List<UserEntity> allList = new ArrayList<UserEntity>();
			try {
				allList = dbDao.find(UserEntity.class, sql.toString());
				if (pageSize > 0) {
					list = dbDao.findPage(UserEntity.class, sql.toString(), pageIndex*pageSize, pageSize);
					arm.setRecords(list);
				} else {
					arm.setRecords(allList);
				}
				arm.setTotal(allList.size());
				arm.setPageNumber(pageIndex);
				// Map<String, Object> map=dbDao.findFirst("select count(uuid) ucount from ("+sql.toString()+") t");
				// arm.setTotalPages(1);
				// arm.setPageNumber(data.getNumber());
				arm.setSuccess(true);
			} catch (DAOException e) {
				e.printStackTrace();
			}
		} catch (ServiceException e) {
			arm.setSuccess(false);
			arm.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 根据sql查询用户列表 @Title: getUserBySql @author liusheng @date 2016年4月19日 下午4:01:37 @param @return 设定文件 @return List
	 * <UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> getUserBySql() {
		List<UserEntity> list = new ArrayList<UserEntity>();
		StringBuffer sql = new StringBuffer();
		sql.append("select u.*,o.org_name orgname from yy_user u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where u.status='1' order by u.modifytime DESC");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 根据角色获取选入的用户 @Title: findUserByRoleId @author liusheng @date 2016年4月26日 下午7:39:58 @param @param
	 * roleId @param @param user @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findUserByRoleId(String roleId, UserEntity user) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from yy_userrole ur ");
		sql.append("left join yy_user u on u.uuid=ur.user_id ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where ur.role_id='").append(roleId).append("' ");
		if (!StringUtils.isEmpty(user.getLoginname())) {
			sql.append("and u.loginname like '%").append(user.getLoginname()).append("%' ");
		}
		if (!StringUtils.isEmpty(user.getUsername())) {
			sql.append("and u.username like '%").append(user.getUsername()).append("%' ");
		}
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<UserEntity> findAllByUserByRoleId(String roleId, UserEntity user) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from (select * from yy_user t_u where not exists(");
		sql.append("select * from yy_userrole ur where ur.role_id='").append(roleId).append("'");
		sql.append(" and ur.user_id=t_u.uuid) and t_u.status=1) u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 获取流程组下面未选择的用户 @Title: findProcessUnSelUser @author liusheng @date 2016年4月26日 下午7:48:32 @param @param
	 * groupId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findProcessUnSelUser(String groupId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"select u.*,o.org_name orgname from (select t_u.* from yy_user t_u where not exists");
		sql.append("(select * from act_id_membership ur where ur.group_id_='");
		sql.append(groupId).append("' and ur.user_id_=t_u.uuid)  and t_u.status=1 ) u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where u.status='1' order by u.modifytime DESC");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 获取流程组下面已选入的用户 @Title: findProcessSelUser @author liusheng @date 2016年4月26日 下午7:49:41 @param @param
	 * groupId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findProcessSelUser(String groupId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"select u.*,o.org_name orgname from (select * from act_id_membership where group_id_='");
		sql.append(groupId).append("') aim ");
		sql.append("left join yy_user u on u.uuid=aim.user_id_ ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where u.status='1' order by u.modifytime DESC");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 根据流程项获取选中的用户 @Title: findUserByProcessItemId @author liusheng @date 2016年5月10日 下午5:20:59 @param @param
	 * itemId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findUserByProcessItemId(String itemId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from yy_process_item_user ur ");
		sql.append("left join yy_user u on u.uuid=ur.user_id ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where ur.item_id='").append(itemId).append("' ");
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 根据流程项获取可选的用户 @Title: findAllUserByItemId @author liusheng @date 2016年5月10日 下午5:30:31 @param @param
	 * itemId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findAllUserByItemId(String itemId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from (select * from yy_user t_u where not exists(");
		sql.append("select * from yy_process_item_user ur where ur.item_id='").append(itemId).append("'");
		sql.append(" and ur.user_id=t_u.uuid) and t_u.status=1) u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 根据流程用户组id获取 @Title: findByProcessUserGroupId @author liusheng @date 2016年5月17日 上午11:05:44 @param @param
	 * groupId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findByProcessUserGroupId(String groupId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from yy_process_usergroup_relation ur ");
		sql.append("left join yy_user u on u.uuid=ur.user_id ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where ur.usergroup_id='").append(groupId).append("' ");
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 根据流程组的id获取能选择的用户列表 @Title: findAllProcessUserGroupId @author liusheng @date 2016年5月17日 上午11:12:49 @param @param
	 * groupId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findAllProcessUserGroupId(String groupId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*,o.org_name orgname from (select * from yy_user t_u where not exists(");
		sql.append("select * from yy_process_usergroup_relation ur where ur.usergroup_id='").append(groupId)
				.append("'");
		sql.append(" and ur.user_id=t_u.uuid) and t_u.status=1) u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("order by u.modifytime");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * 新增用户 @Title: addUser @author liusheng @date 2016年6月12日 下午3:08:52 @param @param entity @param @return 设定文件 @return
	 * ActionResultModel<UserEntity> 返回类型 @throws
	 */
	public ActionResultModel<UserEntity> addUser(UserEntity entity) {
		ActionResultModel<UserEntity> arm = new ActionResultModel<UserEntity>();
		try {
			if (StringUtils.isEmpty(entity.getLoginname())) {
				entity.setLoginname(entity.getJobnumber());// 默认学生号作为登录账号
			}
			entity.setOrg(new OrgRef(entity.getOrgid()));
			entity = doAdd(entity);
			arm.setRecords(entity);
			arm.setSuccess(true);
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
	 * 获取选入的派单人用户 @Title: findSelSendUser @author liusheng @date 2016年6月28日 下午9:25:45 @param @param
	 * groupId @param @return 设定文件 @return List<UserEntity> 返回类型 @throws
	 */
	public List<UserEntity> findSelSendUser(String groupId) {
		List<UserEntity> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder();
		sql.append("select u.*  from cs_send_user_relation ur ");
		sql.append("left join yy_user u on u.uuid=ur.user_id ");
		// sql.append("left join yy_org o on o.uuid=u.orgid "); ,o.org_name orgname
		sql.append("where ur.senduser_id='").append(groupId).append("' ");
		sql.append("order by d.code");
		try {
			list = dbDao.find(UserEntity.class, sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}


}
