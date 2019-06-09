package com.king.modules.sys.func.action;

import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;

@Component
@Transactional
public class FuncActionService extends BaseServiceImpl<FuncActionEntity, String> {
	@Autowired
	FuncActionDao dao;
	@Override
	protected IBaseDAO<FuncActionEntity, String> getDAO() {
		// TODO Auto-generated method stub
		return dao;
	}
	public void saveAndDelete(List<FuncActionEntity> saveList,String[] deletePKs) throws ServiceException {
		if(saveList!=null){
			super.save(saveList);
		}
		if(deletePKs!=null){
			super.delete(deletePKs);
		}
	}
	
	
	/**
	 * 根据菜单id获取下面的按钮权限
	 * @Title: getFuncActionsByFunId 
	 * @author liusheng
	 * @date 2015年12月25日 下午5:04:06 
	 * @param @param funId
	 * @param @return 设定文件 
	 * @return List<FuncActionEntity> 返回类型 
	 * @throws
	 */
	public List<FuncActionEntity> getFuncActionsByFunId(String funId){
		return dao.getFuncActionsByFunId(funId);
	}
	
	
	/**
	 * 根据菜单id删除
	 * @Title: delByFuncId 
	 * @author liusheng
	 * @date 2016年6月6日 下午7:26:55 
	 * @param @param funcId 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void delByFuncId(String funcId) {
		dao.delByFuncId(funcId);
	}
}
