package com.king.modules.sys.enumdata;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface EnumDataSubDao extends IBaseDAO<EnumDataSubEntity, String> {
	@Query("from EnumDataSubEntity a where a.enumdata.uuid = ?1 order by showorder asc, enumdatakey")
	List<EnumDataSubEntity> findByGroupId(String groupId);
	
	@Query("from EnumDataSubEntity a where a.enumdata.groupcode = ?1 order by showorder asc, enumdatakey")
	List<EnumDataSubEntity> findByGroupcode(String groupcode);

	@Query("from EnumDataSubEntity a where a.enumdata.groupcode = ?1 and a.enumdatakey=?2")
	List<EnumDataSubEntity> findByGroupcodeAndEnumDataKey(String groupcode, String enumdatakey);
}
