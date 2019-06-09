package com.king.modules.sys.imexlate;

import java.util.List;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.king.frame.dao.IBaseDAO;
import com.king.frame.service.BaseServiceImpl;
import com.king.modules.sys.imexlate.ImexlateSubDao;


/**
 * 导入子表service
 * @ClassName: ImplateSubService
 * @author  
 * @date 2016年59月10日 07:19:05
 */
@Service
@Transactional
public class ImexlateSubService extends BaseServiceImpl<ImexlateSubEntity, String> {

	@Autowired
	private ImexlateSubDao dao;
	
	@Autowired
	private  EntityManager em;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected IBaseDAO getDAO() {
		return dao;
	}
	
	public List<ImexlateSubEntity> findByTemUuid(String uuid){
		return dao.findByTemUuid(uuid);
	}
	public List<ImexlateSubEntity> findByTemCoding(String coding){
		return dao.findByTemCoding(coding);
	}
	
	public void deleteByUuids(String[] uuids){
		for(String id:uuids){
			ImexlateSubEntity im = dao.findByUuid(id);
			em.remove(im);
			//dao.save(im);
		}
	}
	
	/**
	 * 
	 * @Title: findAllByStatus 
	 * @author liusheng
	 * @date 2016年8月30日 上午11:25:31 
	 * @param @return 设定文件 
	 * @return List<ImexlateSubEntity> 返回类型 
	 * @throws
	 */
	public List<ImexlateSubEntity> findAllByStatus(){
		return dao.findAllByStatus();
	}
}
