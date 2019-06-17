package com.king.modules.info.orderinfo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
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
 * 订单
 * @author null
 * @date 2019-06-17 22:38:46
 */
@Entity
@Table(name = "yy_order_info")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class OrderInfoEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "订单类型")
	@Column(length = 10)
	private String orderType;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@MetaData(value = "实际到货时间")
	@Column()
	private Date actualArriveTime;

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@MetaData(value = "预计到货时间")
	@Column()
	private Date planArriveTime;

	@MetaData(value = "订单编码")
	@Column(length = 50)
	private String code;

	@MetaData(value = "实际数量")
	@Column()
	private Long actualAmount;

	@MetaData(value = "订单名称")
	@Column(length = 100)
	private String name;

	@MetaData(value = "备注")
	@Column(length = 250)
	private String memo;

	@MetaData(value = "备注")
	@Column()
	private Long memo;

	@MetaData(value = "计划数量")
	@Column()
	private Long planAmount;

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public Date getActualArriveTime() {
		return actualArriveTime;
	}

	public void setActualArriveTime(Date actualArriveTime) {
		this.actualArriveTime = actualArriveTime;
	}

	public Date getPlanArriveTime() {
		return planArriveTime;
	}

	public void setPlanArriveTime(Date planArriveTime) {
		this.planArriveTime = planArriveTime;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Long getMemo() {
		return memo;
	}

	public void setMemo(Long memo) {
		this.memo = memo;
	}

	public Long getPlanAmount() {
		return planAmount;
	}

	public void setPlanAmount(Long planAmount) {
		this.planAmount = planAmount;
	}

}