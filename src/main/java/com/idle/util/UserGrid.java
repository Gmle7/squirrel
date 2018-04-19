package com.idle.util;

import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * 用户分页查询工具类
 * Created by lenovo on 2017/5/14.
 */
public class UserGrid<T> {

    private int current;//当前页面号
    private int rowCount;//每页行数
    private int total;//总行数
    private List<T> rows;

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
