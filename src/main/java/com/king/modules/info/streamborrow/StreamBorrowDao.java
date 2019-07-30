package com.king.modules.info.streamborrow;

import com.king.frame.dao.IBaseDAO;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * 挪料
 * @author ls2008
 * @date 2019-07-30 16:02:33
 */
@Repository
public interface StreamBorrowDao extends IBaseDAO<StreamBorrowEntity,String> {

	
	@Query("from StreamBorrowEntity where projectTo.uid=? and billState =? and status=1 order by createtime")
	List<StreamBorrowEntity> findBorrowByToProject(String projectToId,String billState);

}