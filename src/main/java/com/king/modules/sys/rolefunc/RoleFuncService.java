package com.king.modules.sys.rolefunc;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.func.FuncEntity;
import com.king.modules.sys.role.RoleEntity;

@Component
@Transactional(rollbackFor={Exception.class})
public class RoleFuncService extends BaseServiceImpl<RoleFuncEntity, String> {

	@Autowired
	private RoleFuncDAO dao;

//	@Autowired
//	private RoleFuncActionService roleFuncActionService;
	
	@Override
	protected IBaseDAO<RoleFuncEntity,String> getDAO() {
		return dao;
	}
	
	public void deleteByRoleId(String roleId) throws ServiceException{
		dao.deleteByRoleId(roleId);
	}
	
	public void save(String roleId, String[] funcIds) throws ServiceException{
		List<RoleFuncEntity> entities = new ArrayList<RoleFuncEntity>();
		for(String uuid : funcIds){
			RoleFuncEntity entity = createNewRoleFunc(roleId,uuid);
			entities.add(entity);
		}
		entities = (List<RoleFuncEntity>)dao.save(entities);
//		roleFuncActionService.addAllFuncActions(entities);
	}
	public void save(String roleId, List<String> funcIds) throws ServiceException{
		if(funcIds!=null&&funcIds.size()>0){
			List<RoleFuncEntity> entities = new ArrayList<RoleFuncEntity>();
			for(String uuid : funcIds){
				if(!StringUtils.isEmpty(uuid)){
					RoleFuncEntity entity = createNewRoleFunc(roleId,uuid);
					entities.add(entity);
				}
			}
			if(entities!=null&&entities.size()>0){
				entities = (List<RoleFuncEntity>)dao.save(entities);
			}
//			roleFuncActionService.addAllFuncActions(entities);
		}
	}
	public RoleFuncEntity createNewRoleFunc(String roleId, String funcId) throws ServiceException{
			RoleFuncEntity entity = new RoleFuncEntity();
			
			RoleEntity role = new RoleEntity();
			role.setUuid(roleId);
			FuncEntity func = new FuncEntity();
			func.setUuid(funcId);
			
			entity.setRole(role);
			entity.setFunc(func);
			
			return entity;
	}

	public List<RoleFuncEntity> findByFuncUuid(String funcId) throws ServiceException{
		return this.dao.findByFuncUuid(funcId);
	}

	public RoleFuncEntity getByRoleIdAndFuncId(String roleId, String funcId) throws ServiceException{
		return dao.getByRoleIdAndFuncId(roleId,funcId);
	}

	public List<RoleFuncEntity> findByRoleId(String roleId) throws ServiceException{
		return this.dao.findByRoleId(roleId);
	}

	/**
	 * 
	 * @Title: getSelectFuncs 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:30:19 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<RoleFuncEntity> 返回类型 
	 * @throws
	 */
	public List<RoleFuncEntity> getSelectFuncs(String roleId) {
		return this.dao.getSelectFuncs(roleId);
	}

	/**
	 * 
	 * @Title: getRoleFuncs 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:33:32 
	 * @param @return 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	public List<FuncEntity> getRoleFuncs() {
		return this.dao.getRoleFuncs();
	}

	/**
	 * 
	 * @Title: findFuncByRoleId 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:34:15 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	public List<FuncEntity> findFuncByRoleId(String roleId) {
		return this.dao.findFuncByRoleId(roleId);
	}
}
