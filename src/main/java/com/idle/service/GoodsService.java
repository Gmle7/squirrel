package com.idle.service;

import com.idle.pojo.Goods;
import com.idle.util.UserGrid;

import java.util.List;

public interface GoodsService {
    /**
     * 发布商品
     * @param goods
     * @param duration 允许上架时长
     */
    int addGood(Goods goods , Integer duration);

    /**
     * 下架商品
     * @param goodsId
     */
    void downGood(Integer goodsId);

    /**
     * 通过主键获取商品
     * @param goodsId
     * @return
     */
    Goods getGoodsByPrimaryKey(Integer goodsId);

    /**
     * 更新商品信息
     * @param goods
     */
    void updateGoodsByPrimaryKeyWithBLOBs(int goodsId ,Goods goods);

    /**
     * 通过主键删除商品
     * @param goodsId
     */
    void deleteGoodsByPrimaryKey(Integer goodsId);

    /**
     * 获取所有商品信息
     */
    List<Goods> getAllGoods();

    UserGrid<Goods> searchGoods(String goodsName, String description, int pageNum, int pageSize);


    /**
     * 通过商品分类获取商品信息
     */
    UserGrid<Goods> getGoodsByCategoryId(Integer categoryId,int pageNum, int pageSize);

    /**
     * 根据分类id,并进行时间排序,获取前limit个结果
     * @param categoryId
     * @param limit
     * @return
     */
    List<Goods> getGoodsByCategoryOrderByDate(Integer categoryId,Integer limit);

    /**
     * 根据用户的id，查询出该用户的所有闲置
     * @param user_id
     * @return
     */
    List<Goods> getGoodsByUserId(Integer user_id);

    /**
     * 根据种类id，查询出所有闲置，带一张图片
     * @param categoryId
     * @return
     */
    List<Goods> getGoodsListByCategoryId(Integer categoryId);

    /**
     * 查出一共有多少件商品
     * @return
     */
    int getGoodsNum();

    /**
     * goods分页
     * @param pageNum
     * @param pageSize
     * @return
     */
    List<Goods> getGoodsPage(int pageNum,int pageSize);

}