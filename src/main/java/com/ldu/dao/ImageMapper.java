package com.ldu.dao;

import com.ldu.pojo.Image;

import java.util.List;

public interface ImageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Image record);

    int insertSelective(Image record);

    Image selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Image record);

    int updateByPrimaryKeyWithBLOBs(Image record);

    int updateByPrimaryKey(Image record);

    int deleteImagesByGoodsPrimaryKey(String goodsId);

    List<Image> selectByGoodsPrimaryKey(String goodsId);
}