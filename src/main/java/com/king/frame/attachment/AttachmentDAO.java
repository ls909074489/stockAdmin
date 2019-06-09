package com.king.frame.attachment;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/*
*	版权信息 (c) RAP 保留所有权利.
*
*	维护记录
*	新建： RAP Codegen
*   修改：
*/
/**
 * 附件库 DAO类
 * @author RAP Team
 *
 */
 
public interface AttachmentDAO extends IBaseDAO<AttachmentEntity, String> {
	@Modifying
	@Query("delete from AttachmentEntity att where att.entityUuid = ?1")
	int deleteByEntityUuid(String entityUuid);
	
	@Query("from AttachmentEntity att where att.entityUuid = ?1")
	List<AttachmentEntity> findByEntityUuid(String entityUuid);
	
	@Query("from AttachmentEntity att where att.entityUuid = ?1 and att.entityType = ?2 ")
	List<AttachmentEntity> findByEntityUuidAndEntityType(String entityUuid,
			String entityType);

	@Query("from AttachmentEntity att where att.entityUuid in ?1 and att.entityType = ?2 ")
	List<AttachmentEntity> findByEntityUuidAndEntityType(String[] pks, String entityType);
}
