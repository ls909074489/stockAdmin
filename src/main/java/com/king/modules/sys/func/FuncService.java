package com.king.modules.sys.func;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.TreeServiceImpl;
import com.king.modules.sys.func.action.FuncActionEntity;
import com.king.modules.sys.func.action.FuncActionService;

@Component
@Transactional
public class FuncService extends TreeServiceImpl<FuncEntity, String> {

	@Autowired
	private FuncDAO dao;

	 @Autowired
	 private FuncActionService funcActionService;

	@Override
	protected IBaseDAO<FuncEntity, String> getDAO() {
		return dao;
	}

	
	
	
	@Override
	public void doDisabled(String pk) throws ServiceException {
		try {
			FuncEntity entity = this.getOne(pk);
			entity.setUsestatus("0");
			this.getDAO().save(entity);
			afterDisabled(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}




	@Override
	public void doEnabled(String pk) throws ServiceException {
		try {
			FuncEntity entity = this.getOne(pk);
			entity.setUsestatus("1");
			this.getDAO().save(entity);
			afterEnabled(entity);
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException(e.getMessage());
		}
	}




	/**
	 * 获取第一级节点
	 * 
	 * @return
	 */
	public List<FuncEntity> getFirstLevel() {
		return dao.getFirstLevel();
	}

	/**
	 * 根据父节点ID获取子节点，如果传入null或者空字符串，则返回第一级节点
	 * 
	 * @param parentId
	 * @return
	 */
	public List<FuncEntity> findByParentId(String parentId) {
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
	public List<FuncEntity> getUserFuncList(String userID, String sysId) throws ServiceException {
		FuncEntity entity = this.getOne(sysId);
		List<FuncEntity> list = dao.findByUuidNotAndNodepathLikeOrderByNodepathAsc(sysId,
				"%" + entity.getNodepath() + "%");
		return list;
	}



	/**
	 * 保存
	 * @Title: saveSelfAndSubList 
	 * @author liusheng
	 * @date 2016年5月21日 下午5:45:23 
	 * @param @param entity
	 * @param @param subList
	 * @param @param deletePKs
	 * @param @return 设定文件 
	 * @return ActionResultModel<FuncEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<FuncEntity> saveSelfAndSubList(FuncEntity entity,
			List<FuncActionEntity> subList, String[] deletePKs) {
		ActionResultModel<FuncEntity> arm = new ActionResultModel<FuncEntity>();
			//删除子表一数据
			if(deletePKs!=null&&deletePKs.length>0){
				funcActionService.delete(deletePKs);
			}
			FuncEntity savedEntity = null;
			//保存自身数据
			savedEntity = this.save(entity);
			//保存子表数据
			for(FuncActionEntity sub:subList){
				sub.setFunc(savedEntity);
			}
			funcActionService.save(subList);
			arm.setRecords(savedEntity);
			arm.setSuccess(true);
			return arm;
	}



	/**
	 * 删除菜单
	 * @Title: deleFunc 
	 * @author liusheng
	 * @date 2016年6月6日 下午7:25:14 
	 * @param @param pks
	 * @param @return 设定文件 
	 * @return ActionResultModel<FuncEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<FuncEntity> deleFunc(String[] pks)  throws ServiceException{
		ActionResultModel<FuncEntity> arm = new ActionResultModel<FuncEntity>();
		try {
			for(String funcId:pks){
				//删除按钮
				funcActionService.delByFuncId(funcId);
			}
			doDelete(pks);
			arm.setSuccess(true);
		} catch (DataIntegrityViolationException e) {// edit by ls2008
			arm.setSuccess(false);
			arm.setMsg("存在关联不能删除");
			//e.printStackTrace();
			throw new ServiceException("存在关联不能删除");
		} catch (ServiceException e) {
			arm.setSuccess(false);
			String errMsg=e.getMessage();
			if(errMsg!=null&&errMsg.contains("constraint")){
				arm.setMsg("存在关联不能删除");
				throw new ServiceException("存在关联不能删除");
			}else{
				arm.setMsg(e.getMessage());
				throw e;
			}
			//e.printStackTrace();
		}
		return arm;
	}
	

}
