package com.ldu.service;

import com.ldu.pojo.Goods;

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
     * @param goodId
     */
    void downGood(Integer goodId);

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
     * @param id
     */
    void deleteGoodsByPrimaryKey(Integer id);

    /**
     * 获取所有商品信息
     */
    List<Goods> getAllGoods();

    List<Goods> searchGoods(String name, String describle);


    /**
     * 通过商品分类获取商品信息
     */
    List<Goods> getGoodsByCatelog(Integer id,String name,String describle);

    /**
     * 根据分类id,并进行时间排序,获取前limit个结果
     * @param catelogId
     * @param limit
     * @return
     */
    List<Goods> getGoodsByCatelogOrderByDate(Integer catelogId,Integer limit);

    /**
     * 根据用户的id，查询出该用户的所有闲置
     * @param user_id
     * @return
     */
    List<Goods> getGoodsByUserId(Integer user_id);

    /**
     * 根据种类id，查询出所有闲置，带一张图片
     * @param catlogId
     * @return
     */
    List<Goods> getGoodsListByCatlogId(Integer catlogId);

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