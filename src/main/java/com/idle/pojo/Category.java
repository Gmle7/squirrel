package com.idle.pojo;

public class Category {
    private Integer categoryId;

    private String categoryName;

    private Integer number;

    private Byte categoryStatus;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Byte getCategoryStatus() {
        return categoryStatus;
    }

    public void setCategoryStatus(Byte categoryStatus) {
        this.categoryStatus = categoryStatus;
    }
}