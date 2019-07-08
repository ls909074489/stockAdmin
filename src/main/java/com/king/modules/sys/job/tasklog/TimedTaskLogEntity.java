package com.king.modules.sys.job.tasklog;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.king.common.annotation.MetaData;
import com.king.frame.entity.BaseEntity;

/**
* @ClassName: TimedTaskLog  
* @Description: 接口、定时任务是否调用成功日志
* @author WangMin
* @date 2016年3月23日 下午4:57:40
 */
@MetaData(value = "外部接口日志")
@Entity
@Table(name = "yy_timed_task_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class TimedTaskLogEntity extends BaseEntity{

    private static final long serialVersionUID = 1L;
    
    @MetaData(value = "接口名称")
    @Column(length = 50)
    private String  interfacename;
    
    @MetaData(value = "接口地址")
    @Column(length = 200)
    private String  interfaceurl;//接口地址
    
    @MetaData(value = "接口请求方式")
    @Column(length = 20)
    private String  requestmethod;
    
    /**
     * mysql中text类型是可变长度的字符串，最多65535个字符
     * 把字段类型改成MEDIUMTEXT（最多存放16777215个字符）
     * 或者LONGTEXT（最多存放4294967295个字符）
     */
    @MetaData(value = "json返回结果")
    @Column(columnDefinition = "LongText")
    private String  content;
    
    @MetaData(value = "是否成功")
    @Column(nullable = false)
    private Integer result;// 1成功  0失败  -1代表正常结束   2表示网络错误
    
    @MetaData(value = "原因（错误）")
    @Column(length = 200)
    private String  cause;
    
    @MetaData(value = "接口描述")
    @Column(length = 200)
    private String  description;//接口描述
    
    @MetaData(value = "接口执行类")
    @Column(length = 30)
    private String  processclass;
    
    @MetaData(value = "接口执行类")
    @Column(length = 30)
    private String  processbean;
    
    @MetaData(value = "接口执行方法")
    @Column(length = 30)
    private String  processmethod;
    
    @MetaData(value = "保存数据方法")
    @Column(length = 30)
    private String  savedatamethod;
    
    @MetaData(value = "当前第几页 （从第1页开始）")
    private Integer page;  
    
    @MetaData(value = "每页多少行数据")
    private Integer rows;   
    
    @MetaData(value = "开始时间戳")
    private Long   starttime;
    
    @MetaData(value = "结束时间戳")
    private Long   endtime;
    
    @MetaData(value = "备注")
    @Column(length = 255)
    private String  remark;

	public String getInterfaceurl() {
		return interfaceurl;
	}

	public void setInterfaceurl(String interfaceurl) {
		this.interfaceurl = interfaceurl;
	}

	public String getRequestmethod() {
		return requestmethod;
	}

	public void setRequestmethod(String requestmethod) {
		this.requestmethod = requestmethod;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getResult() {
		return result;
	}

	public void setResult(Integer result) {
		this.result = result;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getProcessclass() {
		return processclass;
	}

	public void setProcessclass(String processclass) {
		this.processclass = processclass;
	}

	public String getProcessbean() {
		return processbean;
	}

	public void setProcessbean(String processbean) {
		this.processbean = processbean;
	}

	public String getProcessmethod() {
		return processmethod;
	}

	public void setProcessmethod(String processmethod) {
		this.processmethod = processmethod;
	}

	public String getSavedatamethod() {
		return savedatamethod;
	}

	public void setSavedatamethod(String savedatamethod) {
		this.savedatamethod = savedatamethod;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Long getStarttime() {
		return starttime;
	}

	public void setStarttime(Long starttime) {
		this.starttime = starttime;
	}

	public Long getEndtime() {
		return endtime;
	}

	public void setEndtime(Long endtime) {
		this.endtime = endtime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getInterfacename() {
		return interfacename;
	}

	public void setInterfacename(String interfacename) {
		this.interfacename = interfacename;
	}

}




