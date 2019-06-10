package com.king.frame.security;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Component;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.utils.Encodes;
import com.king.modules.sys.func.action.FuncActionEntity;
import com.king.modules.sys.user.UserDAO;
import com.king.modules.sys.user.UserEntity;

@Component
@DependsOn({ "userDAO" })
public class ShiroRealm extends AuthorizingRealm implements Serializable {

	private static final long serialVersionUID = 1L;

//	@Autowired
//	protected UserService userService;

	@Autowired
	SecurityConfig securityConfig;
	
	//需要注入userDao，否则 Cannot subclass final class class 
	@Autowired
	private UserDAO userDao;
	@Autowired
	private DbUtilsDAO dbDao;
	/**
	 * 认证回调函数,登录时调用.
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken)
			throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		UserEntity user = null;//userDao.findByLoginname(token.getUsername());
		StringBuffer sql=new StringBuffer();
		sql.append("select u.*,o.org_name orgname from ");
		sql.append("(select t_u.* from yy_user t_u where t_u.status='1' and t_u.loginname='").append(token.getUsername()).append("' ) u ");
		sql.append("left join yy_org o on o.uuid=u.orgid ");
		sql.append("where u.status='1'");
		try {
			List<UserEntity> userList=dbDao.find(UserEntity.class, sql.toString());
			if(userList!=null&&userList.size()>0){
				user=userList.get(0);
			}
		} catch (DAOException e) {
			e.printStackTrace();
		}
		if (user != null) {
			byte[] salt = Encodes.decodeHex(user.getSalt());
			ShiroUser shiroUser = new ShiroUser(user.getUuid(), user);
			
	        // 判断账号是否锁定  
	        if (org.springframework.util.StringUtils.isEmpty(user.getIs_use())||"0".equals(user.getIs_use())) {  
	            // 抛出 账号锁定异常  
	            throw new LockedAccountException();  
	        }  
	          
	        return new SimpleAuthenticationInfo(shiroUser, user.getPassword(), ByteSource.Util.bytes(salt), getName());
		} else {
			throw new UnknownAccountException("系统无法找到用户：" + token.getUsername());
		}
	}

	
	/**
	 * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用.
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
		UserEntity user = shiroUser.getUserEntity();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		// 验证成功后将用户权限信息缓存到认证对象中
		try {
			// 这里没有启用功能
			
			
//			List<RoleEntity> roles = userDao.findRoleByUserId(user.getUuid());
//			for (RoleEntity role : roles) {
//				//info.addRole(role.getRoleCode());
//				info.addRole(role.getUuid());
//			}
			/**************************************************************************/
			/**
			 * shiro的权限验证机制是：like机制。只要具有demo:simple的权限就拥有了demo:simple:*的权限
			 * 所以，要为了达到权限控制的目的，在缓存人员权限的时候，需要在每个权限后面加上:view。表示只有查看权限。
			 * 其他操作权限的控制要根据需要进行配置和添加
			 */
			//菜单权限
//			List<FuncEntity> funcs = userDao.findFuncByUserId(user.getUuid());
//			for (FuncEntity func : funcs) {
//				if(StringUtils.isNotBlank(func.getPermission_code())){
//					info.addStringPermission(func.getPermission_code());
//				}
//					
//			}
			//按钮权限
			List<FuncActionEntity> actionList=new ArrayList<FuncActionEntity>();
			try {
				StringBuilder sql=new StringBuilder();
				sql.append("select fa.* from yy_rolefunc_action rfa ");
				sql.append("left join yy_role_func rf on rf.uuid=rfa.rolefunc_id and 1=1 ");
				sql.append("left join yy_role r on r.uuid=rf.role_id ");
				sql.append("left join yy_userrole ur on ur.role_id=r.uuid ");
				sql.append("left join yy_user u on u.uuid=ur.user_id ");
				sql.append("left join yy_func_action fa on fa.uuid=rfa.func_action_id ");
				sql.append("where u.uuid='").append(user.getUuid()).append("'");
				actionList=dbDao.find(FuncActionEntity.class,sql.toString());
			} catch (DAOException e) {
				e.printStackTrace();
			}
			
			
			for(FuncActionEntity fa:actionList){
				if(StringUtils.isNotBlank(fa.getActioncode())){
					info.addStringPermission(fa.getActioncode());
				}
			}
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return info;
	}

	/**
	 * 设定Password校验的Hash算法与迭代次数.
	 */
	@PostConstruct
	public void initCredentialsMatcher() {
		HashedCredentialsMatcher matcher = new HashedCredentialsMatcher(securityConfig.getHashAlgorithm());
		matcher.setHashIterations(securityConfig.getHashInterations());
		setCredentialsMatcher(matcher);
	}

}
