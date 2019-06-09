package com.king.common.utils;


/** 分页工具类
 * @author WangMin 
 */
public class PagingUtil {
    private Integer page;   // 当前第几页 （从第1页开始）
    private Integer rows;   // 每页多少行数据
    private String  sort;   // 排序字段
    private String  order;  // 排序规则
    private Long    startTime;// 开始时间戳
    private Long    endTime;  // 结束时间戳
    private String  searchKey; //搜索字段
                            
    public PagingUtil() {
        
    }

    /**
     * 设置分页工具类
     * @param pageUtil
     * @param page
     * @param rows
     */
    public void setPageRows(){
        if(this.getPage()==null||this.getPage()<0){
            this.setPage(1);//page从1 开始
        }
        if(this.getRows()==null||this.getRows()<1){
            this.setRows(5);//默认一页五条
        }
    }
    
    public Long getStartTime() {
        return startTime;
    }

    public void setStartTime(Long startTime) {
        this.startTime = startTime;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }

    public String getSearchKey() {
        return searchKey;
    }

    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }

    public String getSort() {
        return sort;
    }
    
    public void setSort(String sort) {
        this.sort = sort;
    }
    
    public String getOrder() {
        return order;
    }
    
    public void setOrder(String order) {
        this.order = order;
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
    
}

