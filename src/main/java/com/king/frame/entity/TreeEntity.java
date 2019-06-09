package com.king.frame.entity;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import org.apache.poi.ss.formula.functions.T;

import com.king.common.annotation.MetaData;

@MappedSuperclass
public class TreeEntity extends BaseEntity implements ITreeEntity<T> {
	private static final long serialVersionUID = 1L;

	@MetaData("节点路径")
	@Column(length = 500)
	private String nodepath;

	public String getNodepath() {
		return nodepath;
	}

	public void setNodepath(String nodepath) {
		this.nodepath = nodepath;
	}

	@Override
	public String getCode() {
		return null;
	}

	@Override
	public String getName() {
		return null;
	}

	@Override
	public String getParentId() {
		return null;
	}

	@Override
	public Boolean getIslast() {
		return null;
	}

	@Override
	public void setIslast(Boolean islast) {

	}

}
