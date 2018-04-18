package com.idle.controller;

import com.idle.service.CategoryService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class CategoryController {
    @Resource
    private CategoryService CategoryService;

}
