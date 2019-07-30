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
 * 测试111
 * @author ls2008
 * @date 2019-07-25 17:48:29
 */
@Entity
@Table(name = "yy_stream_log")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StreamLogEntity extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@MetaData(value = "源id")
	@Column(length = 36)
	private String projectId;

	@MetaData(value = "子源单号")
	@Column(length = 50)
	private String projectSubId;

	@MetaData(value = "流水id")
	@Column(length = 50)
	private String streamId;

	@MetaData(value = "实际数量")
	@Column()
	private Long actualAmount;

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectSubId() {
		return projectSubId;
	}

	public void setProjectSubId(String projectSubId) {
		this.projectSubId = projectSubId;
	}

	public String getStreamId() {
		return streamId;
	}

	public void setStreamId(String streamId) {
		this.streamId = streamId;
	}

	public Long getActualAmount() {
		return actualAmount;
	}

	public void setActualAmount(Long actualAmount) {
		this.actualAmount = actualAmount;
	}

}