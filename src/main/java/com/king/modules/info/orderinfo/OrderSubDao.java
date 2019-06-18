package com.king.modules.info.orderinfo;


import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 
 * @author liusheng
 *
 */
public interface OrderSubDao extends IBaseDAO<OrderSubEntity, String> {

	
	@Query("from OrderSubEntity ur where ur.main.uuid = ?1")
	List<OrderSubEntity> findByMain(String mainId);

}
