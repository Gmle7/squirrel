package com.idle.service.impl;

import com.idle.dao.CollectionMapper;
import com.idle.pojo.Collection;
import com.idle.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("collectionService")
public class CollectionServiceImpl implements CollectionService {

    @Autowired
    private CollectionMapper collectionMapper;
    @Override
    public List<Collection> getCollectionsByUserId(Integer userId) {
        return collectionMapper.getCollectionsByUserId(userId);
    }

    @Override
    public List<Collection> getCollectionByUserIdAndGoodsId(Integer userId, Integer goodsId) {
        return collectionMapper.getCollectionByUserIdAndGoodsId(userId,goodsId);
    }

    @Override
    public Integer addCollectionByUserIdAndGoodsId(Integer userId, Integer goodsId) {
        return collectionMapper.addCollectionByUserIdAndGoodsId(userId,goodsId);
    }

    @Override
    public Integer deleteCollectionByUserIdAndGoodsId(Integer userId, Integer goodsId) {
        return collectionMapper.deleteCollectionByUserIdAndGoodsId(userId,goodsId);
    }
}
