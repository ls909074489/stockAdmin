package com.king.modules.sys.tabconstr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.service.spi.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;
import com.king.frame.controller.ActionResultModel;
import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.param.ParameterUtil;
/**
 * 表的外键信息
 * @ClassName: LogLoginService
 * @author liusheng
 * @date 2016年3月29日 上午9:15:10
 */
@Service
@Transactional
public class TableConstraintsService extends BaseServiceImpl<TableConstraintsEntity, String> {
	@Autowired
	private TableConstraintsDAO dao;
	@Autowired
	private DbUtilsDAO dbDao;

	@SuppressWarnings({ "unchecked", "rawtypes" })	
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}
	
	//外键map
	public static Map<String, TableConstraintsEntity> constraintsMap;

	static {
		constraintsMap = new HashMap<String, TableConstraintsEntity>();
	}

		
		


	@Override
	public void afterDelete(TableConstraintsEntity entity) throws ServiceException {
		constraintsMap.remove(entity.getConstraintName());
		super.afterDelete(entity);
	}


	@Override
	public void afterSave(TableConstraintsEntity newEntity) throws ServiceException {
		//修改缓存的外键map
		constraintsMap.put(newEntity.getConstraintName(), newEntity);
		super.afterSave(newEntity);
	}


	/**
	 * 拉取外键信息
	 * @Title: extractConst 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:05:57 
	 * @param @return 设定文件 
	 * @return ActionResultModel<TableConstraintsEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<TableConstraintsEntity> extractConst(){
		ActionResultModel<TableConstraintsEntity> arm=new ActionResultModel<TableConstraintsEntity>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select CONSTRAINT_SCHEMA constraintSchema,CONSTRAINT_NAME constraintName,TABLE_NAME tableName,COLUMN_NAME columnName,");
			sql.append("REFERENCED_TABLE_NAME referencedTableName,REFERENCED_COLUMN_NAME referencedColumnName from INFORMATION_SCHEMA.KEY_COLUMN_USAGE ");
			sql.append("where CONSTRAINT_NAME<>'PRIMARY' ");
			sql.append("and CONSTRAINT_SCHEMA='").append(ParameterUtil.getParamValue("SCHEMA", "stock_admin")).append("'");
			List<TableConstraintsEntity> list=dbDao.find(TableConstraintsEntity.class,sql.toString());
			List<TableConstraintsEntity> oldList=(List<TableConstraintsEntity>) findAll();
			int newCount=0;
			if(oldList!=null){
				for(TableConstraintsEntity newObj:list){
					if(checkIsNew(newObj,oldList)){
						newCount++;
					}
				}
			}
			arm.setSuccess(true);
			arm.setMsg(newCount+"");
		} catch (DAOException e) {
			arm.setSuccess(false);
			arm.setMsg("获取外键信息失败!");
			e.printStackTrace();
		}
		return arm;
	}
	
	/***
	 * 保存外键
	 * @Title: saveConst 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:49:04 
	 * @param @return 设定文件 
	 * @return ActionResultModel<TableConstraintsEntity> 返回类型 
	 * @throws
	 */
	public ActionResultModel<TableConstraintsEntity> saveConst(){
		ActionResultModel<TableConstraintsEntity> arm=new ActionResultModel<TableConstraintsEntity>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select CONSTRAINT_SCHEMA constraintSchema,CONSTRAINT_NAME constraintName,TABLE_NAME tableName,COLUMN_NAME columnName,");
			sql.append("REFERENCED_TABLE_NAME referencedTableName,REFERENCED_COLUMN_NAME referencedColumnName from INFORMATION_SCHEMA.KEY_COLUMN_USAGE ");
			sql.append("where CONSTRAINT_NAME<>'PRIMARY' ");
			sql.append("and CONSTRAINT_SCHEMA='").append(ParameterUtil.getParamValue("SCHEMA", "zsdx")).append("'");
			List<TableConstraintsEntity> list=dbDao.find(TableConstraintsEntity.class,sql.toString());
			List<TableConstraintsEntity> oldList=(List<TableConstraintsEntity>) findAll();
			
			List<TableConstraintsEntity> addList=new ArrayList<TableConstraintsEntity>();
			int newCount=0;
			if(oldList!=null){
				for(TableConstraintsEntity newObj:list){
					if(checkIsNew(newObj,oldList)){
						newCount++;
						addList.add(newObj);
					}
				}
			}
			doAdd(addList);
			arm.setSuccess(true);
			arm.setMsg(newCount+"");
		} catch (DAOException e) {
			arm.setSuccess(false);
			arm.setMsg("保存外键信息失败!");
			e.printStackTrace();
		}
		return arm;
	}

	/**
	 * 判断是否新增的外键
	 * @Title: checkIsNew 
	 * @author liusheng
	 * @date 2016年6月17日 下午4:40:15 
	 * @param @param old
	 * @param @param list 设定文件 
	 * @return boolean 返回类型 
	 * @throws
	 */
	private boolean checkIsNew(TableConstraintsEntity old, List<TableConstraintsEntity> list) {
		for(TableConstraintsEntity obj:list){
			//判断同一个数据库，同一个外键是否相同的
			if(/*obj.getConstraintSchema().equals(old.getConstraintSchema())&&*/
			   obj.getConstraintName().equals(old.getConstraintName())&&obj.getColumnName().equals(old.getColumnName())){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 初始化外键值
	 * @Title: intiConstraintsMap 
	 * @author liusheng
	 * @date 2016年6月20日 下午2:09:17 
	 * @param  设定文件 
	 * @return void 返回类型 
	 * @throws
	 */
	public void intiConstraintsMap(){
		if(constraintsMap==null||constraintsMap.size()==0){
			List<TableConstraintsEntity> list=(List<TableConstraintsEntity>) findAll();
			for(TableConstraintsEntity cons:list){
				constraintsMap.put(cons.getConstraintName(), cons);
			}
		}
	}

	/**
	 * 返回外键关联提示信息
	 * @Title: getMsgByExceptionMsg 
	 * @author liusheng
	 * @date 2016年6月20日 下午5:23:50 
	 * @param @param errmsg
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	public String getMsgByExceptionMsg(String errmsg) {
		String msg="存在关联不能删除";
		if(errmsg.contains("constraint")){
			int start=errmsg.indexOf("CONSTRAINT `");
			int end=errmsg.indexOf("` FOREIGN KEY");
			if(start>0&&end>0&&end>start){
				String fkName=errmsg.substring(errmsg.indexOf("CONSTRAINT `")+12,errmsg.indexOf("` FOREIGN KEY"));
				intiConstraintsMap();
				TableConstraintsEntity consObj=constraintsMap.get(fkName);
				if(consObj!=null&&!StringUtils.isEmpty(consObj.getTableNameDes())){
					msg=consObj.getTableNameDes()+"已关联";
				}
			}
			
//			String fkName=getFkname(errmsg);
//			intiConstraintsMap();
//			TableConstraintsEntity consObj=constraintsMap.get(fkName);
//			if(consObj!=null&&!StringUtils.isEmpty(consObj.getTableNameDes())){
//				msg="已关联"+consObj.getTableNameDes();
//			}
		}else{
			msg=errmsg;
		}
		return msg;
		
	}
	
	/**
	 * 截取外键名
	 * @Title: getFkname 
	 * @author liusheng
	 * @date 2016年6月20日 下午7:41:31 
	 * @param @param errmsg
	 * @param @return 设定文件 
	 * @return String 返回类型 
	 * @throws
	 */
	public static String getFkname(String errmsg){
		String fkName="";
//		int start=errmsg.indexOf("CONSTRAINT `");
//		int end=errmsg.indexOf("` FOREIGN KEY");
//		if(start>0&&end>0&&end>start){
//			fkName=errmsg.substring(errmsg.indexOf("CONSTRAINT `")+12,errmsg.indexOf("` FOREIGN KEY"));
//		}
		fkName= errmsg.substring(errmsg.indexOf("constraint [")+12, errmsg.indexOf("]; nested"));
		return fkName;
	}
}
