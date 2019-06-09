package com.king.modules.sys.imexlate;


import java.util.List;

import javax.persistence.QueryHint;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import com.king.frame.dao.IBaseDAO;
import com.king.modules.sys.imexlate.ImexlateSubEntity;

/**
 * 导入子表dao
 * @ClassName: ImplateSubDao
 * @author  
 * @date 2016年59月10日 07:19:05
 */
public interface ImexlateSubDao extends IBaseDAO<ImexlateSubEntity, String> {
	
	@Query(" from ImexlateSubEntity a where a.implate.coding = ?1 and status = 1 order by exportCellNum")
	@QueryHints({ @QueryHint(name = "org.hibernate.cacheable", value = "true") })
	List<ImexlateSubEntity> findByTemCoding(String coding);
	
	@Query(" from ImexlateSubEntity a where a.implate.uuid = ?1 and status = 1 ")
	List<ImexlateSubEntity> findByTemUuid(String uuid);

	
	@Query(" from ImexlateSubEntity a where status = 1 order by a.implate.uuid,exportCellNum")
	List<ImexlateSubEntity> findAllByStatus();
}
