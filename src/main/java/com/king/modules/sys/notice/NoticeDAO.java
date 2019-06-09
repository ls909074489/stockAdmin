package com.king.modules.sys.notice;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

public interface NoticeDAO extends IBaseDAO<NoticeEntity, String> {

	@Query("from NoticeEntity a where a.notice_status = '已发布' order by issue_date desc, notice_category desc ")
	List<NoticeEntity> getNoticeList();
}
