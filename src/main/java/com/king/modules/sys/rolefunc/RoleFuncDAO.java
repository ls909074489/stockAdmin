package com.king.modules.sys.rolefunc;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;
import com.king.modules.sys.func.FuncEntity;

public interface RoleFuncDAO extends IBaseDAO<RoleFuncEntity, String> {
	@Modifying
	//@Transactional(readOnly = false)
	@Query("delete from RoleFuncEntity rf where rf.role.uuid = ?1")
	public void deleteByRoleId(String roleId);
	
	@Query("from RoleFuncEntity rf where rf.func.uuid = ?1")
	public List<RoleFuncEntity> findByFuncUuid(String funcId);

	@Query("from RoleFuncEntity rf where rf.role.uuid=?1 and rf.func.uuid = ?2")
	public RoleFuncEntity getByRoleIdAndFuncId(String roleId, String funcId);

	@Query("from RoleFuncEntity rf where rf.role.uuid = ?1")
	public List<RoleFuncEntity> findByRoleId(String roleId);
	
	
	/**
	 * 
	 * @Title: getRoleFuncs 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:28:52 
	 * @param @return 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	@Query("from FuncEntity f where f.status=1 and f.usestatus='1' order by f.func_code")
	List<FuncEntity> getRoleFuncs();

	/**
	 * 
	 * @Title: getSelectFuncs 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:28:57 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<RoleFuncEntity> 返回类型 
	 * @throws
	 */
	@Query("from RoleFuncEntity a where a.role.uuid=?1 and a.status=1")
	List<RoleFuncEntity> getSelectFuncs(String roleId);

	
	/**
	 * 
	 * @Title: findFuncByRoleId 
	 * @author liusheng
	 * @date 2016年1月16日 下午5:29:01 
	 * @param @param roleId
	 * @param @return 设定文件 
	 * @return List<FuncEntity> 返回类型 
	 * @throws
	 */
	@Query("select f from FuncEntity f, RoleFuncEntity rf " +
			   "where f.uuid = rf.func.uuid and rf.role.uuid = ?1 and rf.status=1" +
			   "order by f.func_code")
	List<FuncEntity> findFuncByRoleId(String roleId);
}
