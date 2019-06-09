package com.king.frame.entity;

/**
 * 单据-实体对象接口类，如果需要审计的数据对象，要实现该接口
 * 
 * @author Kevin
 *
 */
public interface ISuperEntity<T> extends IBaseEntity<T> {

	public Integer getBillstatus();

	public String getBillcode();

	public void setBillcode(String billcode);

	public String getBilltype();

	public void setBilltype(String billtype);

}