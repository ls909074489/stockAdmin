package com.king.modules.sys.message;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

@MetaData(value = "Message信息")
@Entity
@Table(name = "yy_message")
@DynamicInsert
@DynamicUpdate
public class MessageEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "消息类型", comments = "1：审批消息，2：业务消息，3：预警消息，4：系统消息，5：个人消息")
	@Column
	private String msgtype;

	@MetaData(value = "消息标题")
	@Column
	private String title;

	@MetaData(value = "消息内容")
	@Column
	private String content;

	@MetaData(value = "单据类型")
	@Column
	private String billtype;

	@MetaData(value = "单据id")
	@Column
	private String billid;

	@MetaData(value = "URL链接")
	@Column
	private String link;

	@MetaData(value = "接收者")
	@Column
	private String receiver;

	@MetaData(value = "接收人名称")
	@Column
	private String receivername;

	@MetaData(value = "发送者")
	@Column
	private String sender;

	@MetaData(value = "发送人")
	@Column
	private String sendername;

	@MetaData(value = "发送时间")
	@Column
	private Date sendtime;

	@MetaData(value = "流程节点id")
	@Column
	private String flowid;

	@MetaData(value = "流程节点name")
	@Column
	private String flowname;

	@MetaData(value = "是否已读,0代表新的消息")
	@Column
	private String isnew = "0";

	@MetaData(value = "读取时间")
	@Column
	private Date receivetime;

	@MetaData(value = "是否办理，0代表未办理")
	@Column
	private String isdeal = "0";

	@MetaData(value = "办理结果")
	@Column
	private String dealresult;

	@MetaData(value = "办理时间")
	@Column
	private Date dealtime;

	// 意见
	@MetaData(value = "意见")
	@Column(length = 2000)
	private String suggestion;
	
	
	
	@MetaData(value = "打开方式   0：在首页弹出框    1：重新打开tab")
	@Column(name="open_type",length=2)
	private String openType = "0";
	@MetaData(value = "打开方式为1时：需要打开的tab的名称")
	@Column(name="tab_name",length=20)
	private String tabName;
	@MetaData(value = "打开方式为1时：需要打开的tab的data-index的值，即相应的菜单id")
	@Column(name="tab_data_index",length=50)
	private String tabDataIndex;
	
	@MetaData(value = "厂站的id")
	@Column(length = 36)
	private String orgid;
	
	
	

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getIsnew() {
		return isnew;
	}

	public void setIsnew(String isnew) {
		this.isnew = isnew;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getSendtime() {
		return sendtime;
	}

	public void setSendtime(Date sendtime) {
		this.sendtime = sendtime;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getReceivetime() {
		return receivetime;
	}

	public void setReceivetime(Date receivetime) {
		this.receivetime = receivetime;
	}

	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}

	public String getIsdeal() {
		return isdeal;
	}

	public void setIsdeal(String isdeal) {
		this.isdeal = isdeal;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date getDealtime() {
		return dealtime;
	}

	public void setDealtime(Date dealtime) {
		this.dealtime = dealtime;
	}

	public String getBillid() {
		return billid;
	}

	public void setBillid(String billid) {
		this.billid = billid;
	}

	public String getBilltype() {
		return billtype;
	}

	public void setBilltype(String billtype) {
		this.billtype = billtype;
	}

	public String getFlowid() {
		return flowid;
	}

	public void setFlowid(String flowid) {
		this.flowid = flowid;
	}

	public String getSuggestion() {
		return suggestion;
	}

	public void setSuggestion(String suggestion) {
		this.suggestion = suggestion;
	}

	public String getFlowname() {
		return flowname;
	}

	public void setFlowname(String flowname) {
		this.flowname = flowname;
	}

	public String getReceivername() {
		return receivername;
	}

	public void setReceivername(String receivername) {
		this.receivername = receivername;
	}

	public String getSendername() {
		return sendername;
	}

	public void setSendername(String sendername) {
		this.sendername = sendername;
	}

	public String getDealresult() {
		return dealresult;
	}

	public void setDealresult(String dealresult) {
		this.dealresult = dealresult;
	}

	public String getOpenType() {
		return openType;
	}

	public void setOpenType(String openType) {
		this.openType = openType;
	}

	public String getTabDataIndex() {
		return tabDataIndex;
	}

	public void setTabDataIndex(String tabDataIndex) {
		this.tabDataIndex = tabDataIndex;
	}

	public String getTabName() {
		return tabName;
	}

	public void setTabName(String tabName) {
		this.tabName = tabName;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	
}
