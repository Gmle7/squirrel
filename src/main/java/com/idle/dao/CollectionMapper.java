package com.idle.dao;

import com.idle.pojo.Collection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CollectionMapper {
    int deleteByPrimaryKey(Integer collectionId);

    int insert(Collection record);

    int insertSelective(Collection record);

    Collection selectByPrimaryKey(Integer collectionId);

    int updateByPrimaryKeySelective(Collection record);

    int updateByPrimaryKey(Collection record);

    List<Collection> getCollectionsByUserId(Integer userId);

    List<Collection> getCollectionByUserIdAndGoodsId(@Param("userId")Integer userId,@Param("goodsId") Integer goodsId);

    int addCollectionByUserIdAndGoodsId(@Param("userId")Integer userId,@Param("goodsId") Integer goodsId);

    int deleteCollectionByUserIdAndGoodsId(@Param("userId")Integer userId,@Param("goodsId") Integer goodsId);
}