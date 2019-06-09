package com.king.modules.sys.rolefuncaction;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.king.common.bean.RoleFuncActionBean;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.func.action.FuncActionEntity;
import com.king.modules.sys.func.action.FuncActionService;
import com.king.modules.sys.rolefunc.RoleFuncEntity;
import com.king.modules.sys.rolefunc.RoleFuncService;

@Component
@Transactional(rollbackFor={Exception.class})
public class RoleFuncActionService extends BaseServiceImpl<RoleFuncActionEntity, String> {

	@Autowired
	private RoleFuncActionDAO dao;
	
	@Autowired
	RoleFuncService roleFuncService;
	
	@Autowired
	FuncActionService funcActionService;
	
	
	@Override
	protected IBaseDAO<RoleFuncActionEntity,String> getDAO() {
		return dao;
	}
	
	//保存角色操作权限
	public void addFuncActions(String roleId, String funcId,
			String[] funcActionIds) throws ServiceException{
		RoleFuncEntity roleFunc = roleFuncService.getByRoleIdAndFuncId(roleId,funcId);
		if(roleFunc==null){
			throw new ServiceException("请先给角色分配功能菜单权限");
		}
		saveRoleFuncActions(roleFunc,funcActionIds);
	}
	
	
	public  void saveRoleFuncActions(RoleFuncEntity roleFunc,
			String[] funcActionIds) throws ServiceException{
		List<RoleFuncActionEntity> selectList=getActionByRoleIdFuncId(roleFunc.getRole().getUuid(),
				roleFunc.getFunc().getUuid());
		
		FuncActionEntity funcAction=null;
		RoleFuncActionEntity entity=null;
		boolean isExit=false;
		List<String> deleList=new ArrayList<String>();
		//删除没有旧的
		if(selectList!=null&&selectList.size()>0){
			for(RoleFuncActionEntity act:selectList){
				isExit=false;
				if(funcActionIds!=null&&funcActionIds.length>0){
					for(String funActionId : funcActionIds){
						if(act.getFuncAction().getUuid().equals(funActionId)){
							isExit=true;
						}
					}
				}
				if(!isExit){
					deleList.add(act.getUuid());
				}
			}
		}	
		
		if(funcActionIds!=null&&funcActionIds.length>0){
			for(String funActionId : funcActionIds){
				isExit=false;
				if(selectList!=null&&selectList.size()>0){
					for(RoleFuncActionEntity act:selectList){
						if(act.getRoleFunc().getUuid().equals(roleFunc.getUuid())&&
								act.getFuncAction().getUuid().equals(funActionId)){
							isExit=true;
						}
					}
				}
				if(!isExit){
					entity = new RoleFuncActionEntity();
					funcAction=new FuncActionEntity();
					funcAction.setUuid(funActionId);
					entity.setFuncAction(funcAction);
					entity.setRoleFunc(roleFunc);
					this.save(entity);
				}
			}
		}
		for(String delId:deleList){//删除action中间表
			dao.delete(delId);
		}
	
	}
	/**
	 * 列出角色没有权限的操作
	 * @param roleId
	 * @param funcId
	 * @return
	 * @throws ServiceException
	 */
//	public List<FuncActionEntity> listNoPermisionAction(String roleId,
//			String funcId) throws ServiceException{
//		return dao.listNoPermisionAction(roleId,funcId);
//	}
//	
	
//	public void addAllFuncActions(List<RoleFuncEntity> roleFuncs) throws ServiceException{
//		List<RoleFuncActionEntity> saveList = new ArrayList<RoleFuncActionEntity>();
//		for(RoleFuncEntity roleFunc : roleFuncs){
//			List<FuncActionEntity> actions = funcActionService.findByFuncId(roleFunc.getFunc().getUuid());
//			for(FuncActionEntity action : actions){
//				RoleFuncActionEntity rfa = new RoleFuncActionEntity();
//				rfa.setRoleFunc(roleFunc);
//				rfa.setFuncAction(action);
//				saveList.add(rfa);
//			}
//		}
//		save(saveList);
//	}
	
	
	/**
	 * 根据角色和菜单获取按钮权限信息
	 * @Title: getActionByRoleIdFuncId 
	 * @author liusheng
	 * @date 2015年12月25日 下午5:19:20 
	 * @param @param roleId
	 * @param @param funcId
	 * @param @return 设定文件 
	 * @return List<RoleFuncActionEntity> 返回类型 
	 * @throws
	 */
	public List<RoleFuncActionEntity> getActionByRoleIdFuncId(String roleId,String funcId){
		return dao.getActionByRoleIdFuncId(roleId,funcId);
	}
	
	/**
	 * 获取角色下的菜单按钮信息
	 * @Title: getRoleFuncActions 
	 * @author liusheng
	 * @date 2015年12月25日 下午5:30:10 
	 * @param @param roleId
	 * @param @param funcId
	 * @param @return 设定文件 
	 * @return List<RoleFuncActionBean> 返回类型 
	 * @throws
	 */
	public List<RoleFuncActionBean> getRoleFuncActions(String roleId,String funcId){
		List<FuncActionEntity> actionList=funcActionService.getFuncActionsByFunId(funcId);
		List<RoleFuncActionBean> result=new ArrayList<RoleFuncActionBean>();
		try {
			RoleFuncActionBean e=null;
			if(actionList!=null&&actionList.size()>0){
				List<RoleFuncActionEntity> selectList=getActionByRoleIdFuncId(roleId, funcId);
				for(FuncActionEntity fae:actionList){
					e=new RoleFuncActionBean();
					e.setActioncode(fae.getActioncode());
					e.setActionname(fae.getActionname());
					e.setUuid(fae.getUuid());
					e.setIsSelect("0");
					if(selectList!=null&&selectList.size()>0){
						for(RoleFuncActionEntity a:selectList){
							if(a.getFuncAction().getUuid().equals(fae.getUuid())){
								e.setIsSelect("1");
								break;
							}
						}
					}
					result.add(e);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 根据角色菜单删除
	 * @Title: deleByRoleFuncId 
	 * @author liusheng
	 * @date 2015年12月29日 上午9:46:11 
	 * @param @param roleFuncId 设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void deleByRoleFuncId(String roleFuncId) {
		dao.deleteByRoleId(roleFuncId);
	}	
	
	
	
}
