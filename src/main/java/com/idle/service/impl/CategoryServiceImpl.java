package com.idle.service.impl;

import com.idle.dao.CategoryMapper;
import com.idle.pojo.Category;
import com.idle.service.CategoryService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

    @Resource
    private CategoryMapper categoryMapper;

    public int getCount(Category category) {
        int count = categoryMapper.getCount(category);
        return count;
    }
    public List<Category> getAllCategory() {
        List<Category> categories = categoryMapper.getAllCategory();
        return categories;
    }
    public Category selectByPrimaryKey(Integer categoryId){
        Category category = categoryMapper.selectByPrimaryKey(categoryId);
        return category;
    }
    public int updateByPrimaryKey(Category category) {
        return  categoryMapper.updateByPrimaryKey(category);
    }

    public int updateCategoryNum(Integer categoryId,Integer number) {
        return categoryMapper.updateCategoryNum(categoryId,number);
    }

    public int updateCategoryNum2(Integer categoryId) {
        return categoryMapper.updateCategoryNum2(categoryId);
    }
}
