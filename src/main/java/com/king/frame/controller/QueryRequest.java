package com.king.frame.controller;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

/**
 * 查询请求对象封装，
 * 
 * @author Kevin
 * 
 */
public class QueryRequest<T> {
	private PageRequest pageRequest;
	private Sort sort;
	private Specification<T> specification;

	public PageRequest getPageRequest() {
		return pageRequest;
	}

	public void setPageRequest(PageRequest pageRequest) {
		this.pageRequest = pageRequest;
	}

	public Sort getSort() {
		return sort;
	}

	public void setSort(Sort sort) {
		this.sort = sort;
	}

	public Specification<T> getSpecification() {
		return specification;
	}

	public void setSpecification(Specification<T> spec) {
		this.specification = spec;
	}
}
