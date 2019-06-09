package com.king.modules.sys.func.action;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface FuncActionDao  extends IBaseDAO<FuncActionEntity, String>{
	

	/**
	 * 根据菜单id获取下面的按钮权限
	 * @Title: getFuncActionsByFunId 
	 * @author liusheng
	 * @date 2015年12月25日 下午5:05:09 
	 * @param @param funId
	 * @param @return 设定文件 
	 * @return List<FuncActionEntity> 返回类型 
	 * @throws
	 */
	@Query("select f from FuncActionEntity f where f.func.uuid = ?1 and f.status=1")
	List<FuncActionEntity> getFuncActionsByFunId(String funId);

	/**
	 * 根据菜单id删除
	 * @Title: delByFuncId 
	 * @author liusheng
	 * @date 2016年6月6日 下午7:27:27 
	 * @param @param funcId 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	@Modifying
	@Query("delete from FuncActionEntity f where f.func.uuid = ?1")
	public void delByFuncId(String funcId);

}
