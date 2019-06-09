package com.king.frame.entity;

/**
 * 树形结构实体接口
 * 
 * @author Kevin
 *
 */
public interface ITreeEntity<T> extends IBaseEntity<T> {

	String getCode();

	String getName();

	String getParentId();

	String getNodepath();

	void setNodepath(String nodepath);

	Boolean getIslast();

	void setIslast(Boolean islast);
}