package com.idle.service;

import com.idle.pojo.Collection;

import java.util.List;

public interface CollectionService {

    /**
     * 获取所有商品信息
     */
    List<Collection> getCollectionsByUserId(Integer userId);
    /**
     * 获取用户是否收藏了某件物品
     */
    List<Collection> getCollectionByUserIdAndGoodsId(Integer userId,Integer goodsId);

    Integer addCollectionByUserIdAndGoodsId(Integer userId,Integer goodsId);

    Integer deleteCollectionByUserIdAndGoodsId(Integer userId,Integer goodsId);
}
