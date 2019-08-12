package com.king.modules.info.streamLog;

import javax.persistence.Column;
import com.king.frame.entity.BaseEntity;
import com.king.common.annotation.MetaData;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 订单流水日志
 * @author ls2008
 * @date 2019-07-25 17:48:29
 */
@Entity
@Table(name = "yy_stream_order_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StreamOrderLogEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "源id")
	@Column(length = 36)
	private String orderId;

	@MetaData(value = "子源单号")
	@Column(length = 50)
	private String orderSubId;

	@MetaData(value = "流水id")
	@Column(length = 50)
	private String streamId;
	
	@MetaData(value = "目标的流水id")
	@Column(length = 36)
	private String destStreamId;

	@MetaData(value = "实际数量")
	@Column()
	private Long actualAmount;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderSubId() {
		return orderSubId;
	}

	public void setOrderSubId(String orderSubId) {
		this.orderSubId = orderSubId;
	}

	public String getStreamId() {
		return streamId;
	}

	public void setStreamId(String streamId) {
		this.streamId = streamId;
	}

	public String getDestStreamId() {
		return destStreamId;
	}

	public void setDestStreamId(String destStreamId) {
		this.destStreamId = destStreamId;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}
	
}