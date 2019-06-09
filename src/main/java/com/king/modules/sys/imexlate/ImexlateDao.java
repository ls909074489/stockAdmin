package com.king.modules.sys.imexlate;


import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.king.frame.dao.IBaseDAO;
import com.king.modules.sys.imexlate.ImexlateEntity;

/**
 * 导入模板dao
 * @ClassName: ImplateDao
 * @author  
 * @date 2016年55月10日 01:13:52
 */
public interface ImexlateDao extends IBaseDAO<ImexlateEntity, String> {
	@Query(" from ImexlateEntity a where a.coding = ?1 and status = 1")
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value = "true") })
	ImexlateEntity findByTemCoding(String coding);
	
	@Query(" from ImexlateEntity a where  a.status = 1")
	List<ImexlateEntity> findByStatus();
}
