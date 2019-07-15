package com.king.modules.info.material;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.king.frame.dao.IBaseDAO;

/**
 * 物料
 * @author null
 * @date 2019-06-16 15:53:34
 */
@Repository
public interface MaterialDao extends IBaseDAO<MaterialEntity,String> {

	
	/**
	 * 根据code查询
	 * @param codeList
	 * @return
	 */
	@Query("FROM MaterialEntity o WHERE o.code in ?1")
	List<MaterialEntity> findByCodes(List<String> codeList);
}