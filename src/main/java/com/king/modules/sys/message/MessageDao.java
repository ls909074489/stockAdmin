package com.king.modules.sys.message;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.king.frame.dao.IBaseDAO;

/**
 * 系统消息dao
 * 
 * @ClassName: MessageDao
 * @author
 * @date 2016年38月28日 10:10:34
 */
public interface MessageDao extends IBaseDAO<MessageEntity, String> {

	@Query("from MessageEntity a where a.isdeal='0' and a.msgtype = ?1 and a.receiver=?2 order by a.isnew ,a.sendtime desc")
	List<MessageEntity> getMessageType(String msgtype, String userid);

	@Query("from MessageEntity a where (a.isnew='0' or a.isdeal='0') and a.receiver=?1 order by a.isnew ,a.sendtime desc")
	List<MessageEntity> getMessageByReceiver(String userid);

	@Query("from MessageEntity a where a.isdeal='0' and a.billtype=?1 and a.billid=?2 and a.flowid=?3")
	List<MessageEntity> findMessageByBillidAndFlowid(String billtype, String billid, String flowid);

	@Query("from MessageEntity a where a.msgtype=?1 and a.billtype=?2 and a.billid=?3 order by a.isnew ,a.sendtime desc")
	List<MessageEntity> getMessageByBillid(String msgtype, String billtype, String billid);

	// Page<MessageEntity> findByMsgtypeAndReceiver(String msgtype,String receiver, Pageable page);
}
