package com.king.modules.info.device;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;
import com.king.modules.sys.org.OrgEntity;
import com.king.modules.sys.user.UserEntity;

/**
 * 设备信息
 * @author ls2008
 * @date 2017-11-17 23:22:24
 */
@Entity
@Table(name = "yy_device")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class DeviceInfoEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "名称")
	@Column(length = 250)
	private String name;

	@MetaData(value = "所属厂站")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "station_id",nullable=true)
	private OrgEntity station;
	
//	@MetaData(value = "厂商ID")
//	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
//	@JoinColumn(name = "supplier_id",nullable=true)
//	private SupplierEntity supplier;
	
	
	@MetaData(value = "通道ID")
	@Column(length = 36)
	private String cid;
	
	@MetaData(value = "创建用户ID")
	@ManyToOne(cascade=CascadeType.REFRESH,optional = true)
	@JoinColumn(name = "userid",nullable=true)
	private UserEntity user;
	
	@MetaData(value = "类型ID")
	@Column(length = 36)
	private String tid;
	
	@MetaData(value = "示意图")
	@Column(length = 250)
	private String sketch;
	
	@MetaData(value = "示意图地址")
	@Column(length = 250)
	private String sketchUrl;
	
	@MetaData(value = "条码")
	@Column(length = 50)
	private String barcode;
	@MetaData(value = "条码路径")
	@Column(length = 250)
	private String barcodeUrl;
	
	@MetaData(value = "参数")
	@Column(length = 50)
	private String argument;
	
	@MetaData(value = "应用类型")
	@Column(length = 50)
	private String applicate;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@MetaData(value = "出厂时间")
	@Column()
	private Date factoryDate;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+08:00")
	@MetaData(value = "安装时间")
	@Column()
	private Date setupDate;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@MetaData(value = "运营时间")
	@Column()
	private Date valiDate;
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	@MetaData(value = "录入时间")
	@Column()
	private Date writeTime;
	
	
	@MetaData(value = "设备装备")
	@Column(length = 2)
	private String deviceStatus;
	
	@MetaData(value = "备注")
	@Column(length = 250)
	private String context;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public UserEntity getUser() {
		return user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getSketch() {
		return sketch;
	}

	public void setSketch(String sketch) {
		this.sketch = sketch;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public String getArgument() {
		return argument;
	}

	public void setArgument(String argument) {
		this.argument = argument;
	}

	public String getApplicate() {
		return applicate;
	}

	public void setApplicate(String applicate) {
		this.applicate = applicate;
	}

	public Date getFactoryDate() {
		return factoryDate;
	}

	public void setFactoryDate(Date factoryDate) {
		this.factoryDate = factoryDate;
	}

	public Date getSetupDate() {
		return setupDate;
	}

	public void setSetupDate(Date setupDate) {
		this.setupDate = setupDate;
	}

	public Date getValiDate() {
		return valiDate;
	}

	public void setValiDate(Date valiDate) {
		this.valiDate = valiDate;
	}

	public Date getWriteTime() {
		return writeTime;
	}

	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public String getDeviceStatus() {
		return deviceStatus;
	}

	public void setDeviceStatus(String deviceStatus) {
		this.deviceStatus = deviceStatus;
	}

	public String getSketchUrl() {
		return sketchUrl;
	}

	public void setSketchUrl(String sketchUrl) {
		this.sketchUrl = sketchUrl;
	}

	public OrgEntity getStation() {
		return station;
	}

	public void setStation(OrgEntity station) {
		this.station = station;
	}

	public String getBarcodeUrl() {
		return barcodeUrl;
	}

	public void setBarcodeUrl(String barcodeUrl) {
		this.barcodeUrl = barcodeUrl;
	}
	
}