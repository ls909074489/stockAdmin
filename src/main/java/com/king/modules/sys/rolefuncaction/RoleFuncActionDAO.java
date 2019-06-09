package com.king.modules.sys.rolefuncaction;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface RoleFuncActionDAO extends IBaseDAO<RoleFuncActionEntity, String> {


	
	/**
	 *  根据角色和菜单获取按钮权限信息
	 * @Title: getActionByRoleIdFuncId 
	 * @author liusheng
	 * @date 2015年12月25日 下午5:20:05 
	 * @param @param roleId
	 * @param @param funcId
	 * @param @return 设定文件 
	 * @return List<RoleFuncActionEntity> 返回类型 
	 * @throws
	 */
	@Query("select r from RoleFuncActionEntity r where r.roleFunc.role.uuid=?1 and r.funcAction.func.uuid=?2")
	List<RoleFuncActionEntity> getActionByRoleIdFuncId(String roleId,String funcId);
	
	/**
	 * 根据角色菜单删除
	 * @Title: deleteByRoleId 
	 * @author liusheng
	 * @date 2015年12月29日 上午9:52:58 
	 * @param @param roleFuncId 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	@Modifying
	//@Transactional(readOnly = false)
	@Query("delete from RoleFuncActionEntity rfa where rfa.roleFunc.uuid = ?1")
	void deleteByRoleId(String roleFuncId);
		
}
