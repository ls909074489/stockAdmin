package com.king.frame.controller;

import java.util.ArrayList;
import java.util.List;

public class ActionResultModel<T> {
	// recordsFiltered is the total number of records in the data set after filtering
	private long recordsFiltered = 0;
	// total number
	private long recordsTotal = 0;
	private long total = 0;
	private long totalPages = 1;
	private long pageNumber = 1;

	private List<T> records;
	private boolean success;
	private String msg;

	public ActionResultModel() {

	}

	public ActionResultModel(List<T> list) {
		this.records = list;
		this.recordsFiltered = list.size();
		this.total = list.size();
	}

	public ActionResultModel(List<T> list, long recordsFiltered, long recordsTotal, long total) {
		this.records = list;
		this.recordsFiltered = recordsFiltered;
		this.recordsTotal = recordsTotal;
		this.total = total;
	}

	public ActionResultModel(boolean success, String msg) {
		this.success = success;
		this.msg = msg;
	}

	public long getRecordsFiltered() {
		return recordsFiltered;
	}

	public void setRecordsFiltered(long recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}

	public long getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(long totalPages) {
		this.totalPages = totalPages;
	}

	public long getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(long pageNumber) {
		this.pageNumber = pageNumber;
	}

	public List<T> getRecords() {
		return records;
	}

	public void setRecords(List<T> records) {
		this.records = records;
	}

	public void setRecords(T record) {
		List<T> l = new ArrayList<T>();
		l.add(record);
		this.records = l;
		this.recordsFiltered = 1;
		this.recordsTotal = 1;
		this.total = 1;
	}

	public long getRecordsTotal() {
		return recordsTotal;
	}

	public void setRecordsTotal(long recordsTotal) {
		this.recordsTotal = recordsTotal;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
		this.recordsFiltered = total;
		this.recordsTotal = total;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
