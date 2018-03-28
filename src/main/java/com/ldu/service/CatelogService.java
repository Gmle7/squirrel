package com.ldu.service;

import com.ldu.pojo.Catelog;
import com.ldu.pojo.Goods;

import java.util.List;

/**
 * Created by lenovo on 2017/5/9.
 */
public interface CatelogService {
    List<Catelog> getAllCatelog();
    int getCount(Catelog catelog);
    Catelog selectByPrimaryKey(Integer id);
    int updateByPrimaryKey(Catelog record);
    int updateCatelogNum(Integer id,Integer number);
}
