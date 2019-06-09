package com.king.modules.sys.data;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.king.common.bean.TreeBaseBean;
import com.king.common.dao.DbUtilsDAO;
import com.king.common.exception.DAOException;

/**
 * 角色service
 * @ClassName: RoleService
 * @author liusheng 
 * @date 2015年12月17日 上午11:00:53
 */
@Service
@Transactional
public class DataService{

	
	
	@Autowired
	private DbUtilsDAO dbDao;
	
	


	public List<TreeBaseBean> dataAllAdmin() {
		List<TreeBaseBean> list=new ArrayList<TreeBaseBean>();
		try {
			StringBuilder sql=new StringBuilder();
			sql.append("select administrativeid id,name,parentid pId from yy_administrative ");
//			sql.append("select woe_id id,name,parent_id pId from places ");
//			sql.append("select id,name,pid pId from t_urbanandruralareas ");
			list=dbDao.find(TreeBaseBean.class,sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}


	/**
	 * 根据pId获取
	 * @Title: dataAdminByPid 
	 * @author liusheng
	 * @date 2016年1月26日 上午10:14:52 
	 * @param @param pId
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> dataAdminByPid(String pId) {
		List<TreeBaseBean> list=new ArrayList<TreeBaseBean>();
		try {
			StringBuilder sql=new StringBuilder();
			//sql.append("select administrativeid id,name,parentid pId from yy_administrative ");
			sql.append("select uuid id,admin_name name,parentid pId from yy_administrative ");
			if(StringUtils.isEmpty(pId)||pId.equals("0")){
				sql.append(" where parentid is null and status=1");
			}else{
				sql.append(" where status=1 and parentid='").append(pId).append("'");
			}
			list=dbDao.find(TreeBaseBean.class,sql.toString());
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 获取国家
	 * @Title: dataCountry 
	 * @author liusheng
	 * @date 2016年1月26日 上午10:14:41 
	 * @param @param pId
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> dataCountry(String pId) {
		return dataAdminByPid(pId);
	}


	/**
	 * 获取省
	 * @Title: dataProvince 
	 * @author liusheng
	 * @date 2016年1月26日 上午10:14:28 
	 * @param @param pId
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> dataProvince(String pId) {
		return dataAdminByPid(pId);
	}



	/**
	 * 获取市
	 * @Title: dataCity 
	 * @author liusheng
	 * @date 2016年1月26日 上午10:13:56 
	 * @param @param pId
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> dataCity(String pId) {
		return dataAdminByPid(pId);
	}


	/**
	 * 获取区
	 * @Title: dataDistrict 
	 * @author liusheng
	 * @date 2016年1月26日 上午10:14:10 
	 * @param @param pId
	 * @param @return 设定文件 
	 * @return List<TreeBaseBean> 返回类型 
	 * @throws
	 */
	public List<TreeBaseBean> dataDistrict(String pId) {
		return dataAdminByPid(pId);
	}
	
}
 