package com.idle.service;

import com.idle.pojo.Category;

import java.util.List;

public interface CategoryService {
    List<Category> getAllCategory();
    int getCount(Category category);
    Category selectByPrimaryKey(Integer id);
    int updateByPrimaryKey(Category record);
    int updateCategoryNum(Integer id,Integer number);
    int updateCategoryNum2(Integer id);
}
