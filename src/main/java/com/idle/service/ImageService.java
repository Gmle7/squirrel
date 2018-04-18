package com.idle.service;

import com.idle.pojo.Image;

import java.util.List;

public interface ImageService {
    int insert(Image record);
    /**
     * 通过商品id获取该商品的图片
     * @param goodsId
     * @return
     */
    List<Image> getImagesByGoodsPrimaryKey(Integer goodsId);

    /**
     * 通过商品Id删除商品
     * @param goodsId
     * @return
     */
    int deleteImagesByGoodsPrimaryKey(Integer goodsId);
}